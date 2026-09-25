from __future__ import annotations

import copy
import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK_DIR = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
SOURCE_JSON = WORK_DIR / "architecture_xmi_ready_v1.json"
CONTRACT_JSON = PIPELINE_WORK / "sysml17_mapping_contract.json"

XMI = "https://www.omg.org/spec/XMI/20131001"
UML = "https://www.omg.org/spec/UML/20161101"
SYSML = "https://www.omg.org/spec/SysML/20240101"
XSI = "https://www.w3.org/2001/XMLSchema-instance"

ET.register_namespace("xmi", XMI)
ET.register_namespace("uml", UML)
ET.register_namespace("SysML", SYSML)
ET.register_namespace("xsi", XSI)


def q(namespace: str, local: str) -> str:
    return f"{{{namespace}}}{local}"


def xid(element: ET.Element, value: str) -> None:
    element.set(q(XMI, "id"), value)


def xtype(element: ET.Element, value: str) -> None:
    element.set(q(XMI, "type"), value)


def stable_id(prefix: str, seed: str, length: int = 18) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def safe_name(value: str) -> str:
    value = re.sub(r"[^0-9A-Za-z_]+", "_", value).strip("_")
    return value or "Element"


def packaged(parent: ET.Element, uml_type: str, identifier: str, name: str | None = None, **attributes: str) -> ET.Element:
    element = ET.SubElement(parent, "packagedElement")
    xtype(element, f"uml:{uml_type}")
    xid(element, identifier)
    if name is not None:
        element.set("name", name)
    for key, value in attributes.items():
        if value is not None:
            element.set(key, value)
    return element


def owned_comment(parent: ET.Element, identifier: str, body: str, annotated: str | None = None) -> ET.Element:
    element = ET.SubElement(parent, "ownedComment")
    xtype(element, "uml:Comment")
    xid(element, identifier)
    element.set("body", body)
    if annotated:
        element.set("annotatedElement", annotated)
    return element


class XMIBuilder:
    def __init__(self, architecture: dict, contract: dict, probe: bool = False):
        self.data = architecture
        self.contract = contract
        self.probe = probe
        self.apps: list[ET.Element] = []
        self.product_elements: dict[str, ET.Element] = {}
        self.item_elements: dict[str, ET.Element] = {}
        self.port_elements: dict[str, ET.Element] = {}
        self.port_by_instance = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
        self.port_xmi_by_instance = {i["interface_instance_id"]: i["xmi_id"] for i in architecture["interfaces"]}
        self.product_by_id = {p["id"]: p for p in architecture["products"]}
        self.parent: dict[str, str] = {}
        self.part_ids: dict[tuple[str, str], str] = {}
        self.interface_definitions: dict[tuple[str, str], dict] = {}
        self.boundary_property_ids: dict[str, str] = {}
        self.function_elements: dict[str, ET.Element] = {}
        self.stats: dict[str, int | str | bool] = {}

    def add_app(self, name: str, identifier: str, **attributes: str) -> ET.Element:
        app = ET.Element(q(SYSML, name))
        xid(app, identifier)
        reference_fields = {
            "base_Class", "base_Port", "base_Property", "base_InformationFlow",
            "base_Abstraction", "base_DirectedRelationship", "base_ConnectorEnd",
            "base_Element", "itemProperty", "original", "propertyPath",
        }
        for key, value in attributes.items():
            if value is not None and value != "":
                if key in reference_fields:
                    values = value.split() if key == "propertyPath" else [value]
                    for reference in values:
                        child = ET.SubElement(app, key)
                        child.set(q(XMI, "idref"), reference)
                else:
                    app.set(key, value)
        self.apps.append(app)
        return app

    def build_packages(self, model: ET.Element) -> None:
        package_names = [
            "01_Structure", "02_Interfaces", "03_Behavior", "04_Connections",
            "05_Allocations", "06_Verification",
        ]
        self.packages = {
            name: packaged(model, "Package", f"XMI-PACKAGE-{name}", name)
            for name in package_names
        }
        structure_names = [
            "RollingStockMechanical", "MainPowerSupply", "Traction", "PneumaticBrake",
            "TrainControl", "DriverInterface", "ExternalSystems", "RegenerativeStorage",
        ]
        self.structure_packages = {
            name: packaged(self.packages["01_Structure"], "Package", f"XMI-PACKAGE-STRUCTURE-{name}", name)
            for name in structure_names
        }
        self.packages["InterfaceBlocks"] = packaged(
            self.packages["02_Interfaces"], "Package", "XMI-PACKAGE-INTERFACEBLOCKS", "InterfaceBlocks"
        )
        self.packages["Signals"] = packaged(
            self.packages["02_Interfaces"], "Package", "XMI-PACKAGE-SIGNALS", "Signals"
        )
        self.packages["DataTypes"] = packaged(
            self.packages["02_Interfaces"], "Package", "XMI-PACKAGE-DATATYPES", "DataTypes"
        )
        self.packages["PhysicalItems"] = packaged(
            self.packages["02_Interfaces"], "Package", "XMI-PACKAGE-PHYSICALITEMS", "PhysicalItems"
        )
        self.packages["LeafFunctions"] = packaged(
            self.packages["03_Behavior"], "Package", "XMI-PACKAGE-LEAFFUNCTIONS", "LeafFunctions"
        )
        self.packages["AggregatedFunctions"] = packaged(
            self.packages["03_Behavior"], "Package", "XMI-PACKAGE-AGGFUNCTIONS", "AggregatedFunctions"
        )
        self.packages["FunctionInterfaceTrace"] = packaged(
            self.packages["03_Behavior"], "Package", "XMI-PACKAGE-FUNCTIONINTERFACETRACE", "FunctionInterfaceTrace"
        )
        self.packages["ItemFlows"] = packaged(
            self.packages["04_Connections"], "Package", "XMI-PACKAGE-ITEMFLOWS", "ItemFlows"
        )
        self.packages["PhysicalNetworks"] = packaged(
            self.packages["04_Connections"], "Package", "XMI-PACKAGE-PHYSICALNETWORKS", "PhysicalNetworks"
        )

    def build_profile_application(self, model: ET.Element) -> None:
        application = ET.SubElement(model, "profileApplication")
        xtype(application, "uml:ProfileApplication")
        xid(application, "XMI-PROFILEAPPLICATION-SYSML17")
        applied = ET.SubElement(application, "appliedProfile")
        applied.set("href", self.contract["profile_application"]["local_href_from_work_output"])

    def build_context(self) -> None:
        self.context_id = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE"
        self.context = packaged(
            self.packages["01_Structure"], "Class", self.context_id, "Rail_MBSE_TractionBrake_Context"
        )
        self.add_app("Block", "XMI-APP-BLOCK-SYSTEM-CONTEXT", base_Class=self.context_id, isEncapsulated="true")

    def root_product(self, code: str) -> str:
        current = code
        while self.product_by_id[current].get("parent_id") in self.product_by_id:
            current = self.product_by_id[current]["parent_id"]
        return current

    def product_package(self, code: str) -> ET.Element:
        mapping = {
            "3000": "RollingStockMechanical", "4000": "MainPowerSupply", "5000": "Traction",
            "7000": "PneumaticBrake", "8000": "TrainControl", "D000": "DriverInterface",
            "E000": "ExternalSystems", "X000": "RegenerativeStorage",
        }
        root = self.root_product(code)
        return self.structure_packages.get(mapping.get(root, "ExternalSystems"), self.structure_packages["ExternalSystems"])

    def build_products(self) -> None:
        for product in sorted(self.data["products"], key=lambda x: x["id"]):
            element = packaged(self.product_package(product["id"]), "Class", product["xmi_id"], product["name"])
            self.product_elements[product["id"]] = element
            self.add_app(
                "Block", stable_id("XMI-APP-BLOCK", product["id"]),
                base_Class=product["xmi_id"], isEncapsulated="false",
            )

    def add_part(self, owner_id: str, child_id: str, owner_element: ET.Element, composite: bool = True) -> str:
        identifier = stable_id("XMI-PART", f"{owner_id}::{child_id}")
        child = self.product_by_id[child_id]
        prop = ET.SubElement(owner_element, "ownedAttribute")
        xtype(prop, "uml:Property")
        xid(prop, identifier)
        prop.set("name", f"part_{safe_name(child_id)}")
        prop.set("aggregation", "composite" if composite else "none")
        prop.set("type", child["xmi_id"])
        self.part_ids[(owner_id, child_id)] = identifier
        return identifier

    def build_compositions(self) -> None:
        for product in sorted(self.data["products"], key=lambda x: x["id"]):
            parent_id = product.get("parent_id")
            if parent_id in self.product_elements:
                self.parent[product["id"]] = parent_id
                self.add_part(parent_id, product["id"], self.product_elements[parent_id])
            elif not self.probe:
                self.parent[product["id"]] = "__CONTEXT__"
                self.add_part("__CONTEXT__", product["id"], self.context)
            else:
                self.parent[product["id"]] = "__CONTEXT__"

    def build_items(self) -> None:
        signal_items = {
            interface["item_id"] for interface in self.data["interfaces"]
            if interface["direction"] in {"输入", "输出"}
        }
        for item in sorted(self.data["items"], key=lambda x: x["item_code"]):
            is_signal = item["item_code"] in signal_items or not item["item_code"].startswith("ITM-PHY-")
            uml_type = "Signal" if is_signal else "DataType"
            package = self.packages["Signals"] if is_signal else self.packages["PhysicalItems"]
            element = packaged(package, uml_type, item["xmi_id"], item["name_cn"])
            self.item_elements[item["item_code"]] = element
            definition = item.get("semantic_definition") or item.get("name_en") or item["name_cn"]
            owned_comment(element, stable_id("XMI-COMMENT-ITEM", item["item_code"]), definition)

    def build_interface_definitions(self) -> None:
        grouped: dict[tuple[str, str], list[dict]] = defaultdict(list)
        for interface in self.data["interfaces"]:
            grouped[(interface["interface_type_id"], interface["item_id"])].append(interface)
        for key in sorted(grouped):
            interface_type_id, item_id = key
            records = grouped[key]
            directions = {r["direction"] for r in records}
            physical = directions == {"双向物理"}
            if not physical and not directions <= {"输入", "输出"}:
                raise ValueError(f"Unsupported frozen direction set for {key}: {directions}")
            seed = f"{interface_type_id}::{item_id}"
            class_id = stable_id("XMI-IB", seed)
            app_id = stable_id("XMI-APP-INTERFACEBLOCK", seed)
            flow_id = stable_id("XMI-FLOWPROPERTY", seed)
            name = f"IB_{safe_name(interface_type_id)}_{safe_name(item_id)}"
            element = packaged(self.packages["InterfaceBlocks"], "Class", class_id, name)
            flow = ET.SubElement(element, "ownedAttribute")
            xtype(flow, "uml:Property")
            xid(flow, flow_id)
            flow.set("name", f"flow_{safe_name(item_id)}")
            flow.set("type", next(i["xmi_id"] for i in self.data["items"] if i["item_code"] == item_id))
            direction = "inout" if physical else "out"
            self.add_app("InterfaceBlock", app_id, base_Class=class_id, isEncapsulated="false")
            self.add_app(
                "FlowProperty", stable_id("XMI-APP-FLOWPROPERTY", seed),
                base_Property=flow_id, direction=direction,
            )
            definition = {
                "canonical_class_id": class_id,
                "canonical_app_id": app_id,
                "canonical_flow_id": flow_id,
                "physical": physical,
                "conjugated_class_id": None,
            }
            if not physical:
                conj_class_id = stable_id("XMI-IB-CONJ", seed)
                conj = packaged(self.packages["InterfaceBlocks"], "Class", conj_class_id, f"~{name}")
                self.add_app(
                    "tildeInterfaceBlock", stable_id("XMI-APP-TILDEINTERFACEBLOCK", seed),
                    base_Class=conj_class_id, isEncapsulated="false", original=app_id,
                )
                definition["conjugated_class_id"] = conj_class_id
            self.interface_definitions[key] = definition

    def build_ports(self) -> None:
        for interface in sorted(self.data["interfaces"], key=lambda x: x["interface_instance_id"]):
            owner = self.product_elements[interface["owner_product_id"]]
            definition = self.interface_definitions[(interface["interface_type_id"], interface["item_id"])]
            port_type = definition["canonical_class_id"]
            if interface["direction"] == "输入":
                port_type = definition["conjugated_class_id"]
            port = ET.SubElement(owner, "ownedAttribute")
            xtype(port, "uml:Port")
            xid(port, interface["xmi_id"])
            port.set("name", interface["name"])
            port.set("type", port_type)
            port.set("isConjugated", "false")
            port.set("isBehavior", "false")
            port.set("isService", "false")
            self.port_elements[interface["interface_instance_id"]] = port
            self.add_app(
                "ProxyPort", stable_id("XMI-APP-PROXYPORT", interface["interface_instance_id"]),
                base_Port=interface["xmi_id"],
            )

    def build_external_boundaries(self) -> None:
        for boundary in sorted(self.data.get("external_boundaries", []), key=lambda x: x["boundary_id"]):
            element = packaged(
                self.structure_packages["ExternalSystems"], "Class", boundary["xmi_id"], boundary["name"]
            )
            self.add_app(
                "Block", stable_id("XMI-APP-BLOCK-BOUNDARY", boundary["boundary_id"]),
                base_Class=boundary["xmi_id"], isEncapsulated="false",
            )
            prop_id = stable_id("XMI-BOUNDARY-REFERENCE", boundary["boundary_id"])
            prop = ET.SubElement(self.context, "ownedAttribute")
            xtype(prop, "uml:Property")
            xid(prop, prop_id)
            prop.set("name", f"boundary_{safe_name(boundary['boundary_id'])}")
            prop.set("type", boundary["xmi_id"])
            prop.set("aggregation", "none")
            self.boundary_property_ids[boundary["boundary_id"]] = prop_id

    def path_from_owner(self, owner_id: str, product_id: str) -> list[str]:
        if owner_id == product_id:
            return []
        chain = []
        current = product_id
        while current != owner_id:
            chain.append(current)
            current = self.parent.get(current)
            if current is None:
                raise ValueError(f"No composition path from {owner_id} to {product_id}")
        chain.reverse()
        result = []
        parent = owner_id
        for child in chain:
            result.append(self.part_ids[(parent, child)])
            parent = child
        return result

    def ancestor_chain(self, product_id: str) -> list[str]:
        result = [product_id]
        current = product_id
        while current != "__CONTEXT__":
            current = self.parent.get(current, "__CONTEXT__")
            result.append(current)
        return result

    def lca(self, products: list[str], force_context: bool = False) -> str:
        if force_context:
            return "__CONTEXT__"
        chains = [self.ancestor_chain(p) for p in products]
        for candidate in chains[0]:
            if all(candidate in chain for chain in chains[1:]):
                return candidate
        return "__CONTEXT__"

    def owner_element(self, owner_id: str) -> ET.Element:
        return self.context if owner_id == "__CONTEXT__" else self.product_elements[owner_id]

    def connector_end(self, connector: ET.Element, connector_id: str, index: int, owner_id: str,
                      product_id: str | None, port_id: str | None, boundary_id: str | None = None) -> str:
        end_id = stable_id("XMI-CONNECTOREND", f"{connector_id}::{index}")
        end = ET.SubElement(connector, "end")
        xtype(end, "uml:ConnectorEnd")
        xid(end, end_id)
        if boundary_id:
            end.set("role", self.boundary_property_ids[boundary_id])
            return end_id
        assert product_id and port_id
        end.set("role", self.port_xmi_by_instance[port_id])
        path = self.path_from_owner(owner_id, product_id)
        if path:
            end.set("partWithPort", path[-1])
        if len(path) > 1:
            self.add_app(
                "NestedConnectorEnd", stable_id("XMI-APP-NESTEDEND", end_id),
                base_Element=end_id, base_ConnectorEnd=end_id, propertyPath=" ".join(path),
            )
        return end_id

    def build_connections(self) -> None:
        for connection in sorted(self.data["connections"], key=lambda x: x["connection_id"]):
            source_product = connection["source_product_id"]
            target_product = connection.get("target_product_id")
            boundary_id = connection.get("target_boundary_id")
            owner_id = self.lca(
                [x for x in (source_product, target_product) if x], force_context=bool(boundary_id)
            )
            owner = self.owner_element(owner_id)
            connector = ET.SubElement(owner, "ownedConnector")
            xtype(connector, "uml:Connector")
            xid(connector, connection["xmi_id"])
            connector.set("name", connection["connection_id"])
            self.connector_end(
                connector, connection["xmi_id"], 1, owner_id,
                source_product, connection["source_interface_id"],
            )
            self.connector_end(
                connector, connection["xmi_id"], 2, owner_id,
                target_product, connection.get("target_interface_id"), boundary_id,
            )
            if connection["mode"] == "SIGNAL":
                info_id = stable_id("XMI-INFORMATIONFLOW", connection["connection_id"])
                info = packaged(self.packages["ItemFlows"], "InformationFlow", info_id, f"IF_{connection['connection_id']}")
                info.set("informationSource", self.port_xmi_by_instance[connection["source_interface_id"]])
                info.set("informationTarget", self.port_xmi_by_instance[connection["target_interface_id"]])
                item_xmi = next(i["xmi_id"] for i in self.data["items"] if i["item_code"] == connection["item_id"])
                info.set("conveyed", item_xmi)
                info.set("realizingConnector", connection["xmi_id"])
                definition = self.interface_definitions[(connection["interface_type_id"], connection["item_id"])]
                self.add_app(
                    "ItemFlow", stable_id("XMI-APP-ITEMFLOW", connection["connection_id"]),
                    base_InformationFlow=info_id, itemProperty=definition["canonical_flow_id"],
                )

    def build_physical_nets(self) -> None:
        for net in sorted(self.data["physical_nets"], key=lambda x: x["net_id"]):
            products = [member["product_id"] for member in net["members"]]
            owner_id = self.lca(products)
            owner = self.owner_element(owner_id)
            connector = ET.SubElement(owner, "ownedConnector")
            xtype(connector, "uml:Connector")
            xid(connector, net["xmi_id"])
            connector.set("name", net["net_id"])
            owned_comment(
                connector, stable_id("XMI-COMMENT-NET", net["net_id"]),
                f"Standard n-ary Connector preserving shared PhysicalNet {net['net_id']} ({net['item_id']}); modeling artifact, not Product.",
            )
            for index, member in enumerate(sorted(net["members"], key=lambda x: (x["product_id"], x["interface_id"])), 1):
                self.connector_end(
                    connector, net["xmi_id"], index, owner_id,
                    member["product_id"], member["interface_id"],
                )

    def build_functions(self) -> None:
        mappings_by_function: dict[str, list[dict]] = defaultdict(list)
        for mapping in self.data["function_interface_mappings"]:
            mappings_by_function[mapping["function_id"]].append(mapping)
        direction_map = {
            "CONSUMES": "in", "MONITORS": "in", "PRODUCES": "out",
            "CONTROLS": "out", "EXCHANGES": "inout",
        }
        for function in sorted(self.data["functions"], key=lambda x: x["function_id"]):
            package = self.packages["LeafFunctions"] if function["level"] == 4 else self.packages["AggregatedFunctions"]
            activity = packaged(package, "Activity", function["xmi_id"], function["name_cn"])
            self.function_elements[function["function_id"]] = activity
            owned_comment(
                activity, stable_id("XMI-COMMENT-FUNCTION", function["function_id"]), function["description"]
            )
            for mapping in sorted(mappings_by_function.get(function["function_id"], []), key=lambda x: x["mapping_id"]):
                interface = self.port_by_instance[mapping["interface_instance_id"]]
                parameter = ET.SubElement(activity, "ownedParameter")
                xtype(parameter, "uml:Parameter")
                xid(parameter, mapping["xmi_id"])
                parameter.set("name", f"{mapping['usage_role']}__{safe_name(interface['port_id'])}")
                parameter.set("direction", direction_map[mapping["usage_role"]])
                item_xmi = next(i["xmi_id"] for i in self.data["items"] if i["item_code"] == interface["item_id"])
                parameter.set("type", item_xmi)
                dep_id = stable_id("XMI-FIMAP-DEPENDENCY", mapping["mapping_id"])
                dep = packaged(
                    self.packages["FunctionInterfaceTrace"], "Dependency", dep_id,
                    f"{mapping['usage_role']}::{mapping['mapping_id']}",
                )
                dep.set("client", mapping["xmi_id"])
                dep.set("supplier", interface["xmi_id"])

    def build_allocations(self) -> None:
        for allocation in sorted(self.data["allocations"], key=lambda x: x["allocation_id"]):
            abstraction = packaged(
                self.packages["05_Allocations"], "Abstraction", allocation["xmi_id"], allocation["allocation_id"]
            )
            abstraction.set("client", self.function_elements[allocation["function_id"]].get(q(XMI, "id")))
            abstraction.set("supplier", self.product_by_id[allocation["product_id"]]["xmi_id"])
            self.add_app(
                "Allocate", stable_id("XMI-APP-ALLOCATE", allocation["allocation_id"]),
                base_DirectedRelationship=allocation["xmi_id"], base_Abstraction=allocation["xmi_id"],
            )

    def build_voltage_anchors(self) -> None:
        net_by_id = {n["net_id"]: n for n in self.data["physical_nets"]}
        for anchor in sorted(self.data.get("verification_anchors", []), key=lambda x: x["anchor_id"]):
            if anchor["target_type"] == "INTERFACE":
                target = self.port_xmi_by_instance[anchor["interface_id"]]
            else:
                target = net_by_id[anchor["physical_net_id"]]["xmi_id"]
            owned_comment(
                self.packages["06_Verification"], stable_id("XMI-VOLTAGE-ANCHOR", anchor["anchor_id"]),
                f"VoltageAnchor::{anchor['anchor_id']}::{anchor['status']}", target,
            )

    def build(self) -> tuple[bytes, dict]:
        root = ET.Element(q(XMI, "XMI"))
        documentation = ET.SubElement(root, q(XMI, "Documentation"))
        documentation.set("exporter", "Rail MBSE deterministic SysML 1.7 converter")
        documentation.set("exporterVersion", "1.0")
        model = ET.SubElement(root, q(UML, "Model"))
        xid(model, "XMI-MODEL-RAIL-MBSE-TRACTIONBRAKE" + ("-PROBE" if self.probe else ""))
        model.set("name", "Rail_MBSE_TractionBrake" + ("_Probe" if self.probe else ""))
        self.build_profile_application(model)
        self.build_packages(model)
        self.build_context()
        self.build_products()
        self.build_compositions()
        self.build_items()
        self.build_interface_definitions()
        self.build_ports()
        self.build_external_boundaries()
        self.build_connections()
        self.build_physical_nets()
        self.build_functions()
        self.build_allocations()
        self.build_voltage_anchors()
        root.extend(self.apps)
        ET.indent(root, space="  ")
        payload = ET.tostring(root, encoding="utf-8", xml_declaration=True, short_empty_elements=True) + b"\n"
        stats = {
            "products": len(self.data["products"]),
            "items": len(self.data["items"]),
            "ports": len(self.data["interfaces"]),
            "connections": len(self.data["connections"]),
            "signal_item_flows": sum(c["mode"] == "SIGNAL" for c in self.data["connections"]),
            "physical_nets": len(self.data["physical_nets"]),
            "activities": len(self.data["functions"]),
            "allocations": len(self.data["allocations"]),
            "function_interface_mappings": len(self.data["function_interface_mappings"]),
            "canonical_interface_blocks": len(self.interface_definitions),
            "conjugated_interface_blocks": sum(not x["physical"] for x in self.interface_definitions.values()),
            "flow_properties": len(self.interface_definitions),
            "uml_connectors_total": len(self.data["connections"]) + len(self.data["physical_nets"]),
        }
        return payload, stats


def build_probe_fixture(full: dict) -> dict:
    signal = next(c for c in full["connections"] if c["mode"] == "SIGNAL")
    product_ids = [signal["source_product_id"], signal["target_product_id"]]
    products = [copy.deepcopy(next(p for p in full["products"] if p["id"] == code)) for code in product_ids]
    products[0]["parent_id"] = None
    products[1]["parent_id"] = products[0]["id"]
    interface_ids = [signal["source_interface_id"], signal["target_interface_id"]]
    interfaces = [copy.deepcopy(next(i for i in full["interfaces"] if i["interface_instance_id"] == ident)) for ident in interface_ids]
    item = copy.deepcopy(next(i for i in full["items"] if i["item_code"] == signal["item_id"]))
    function = copy.deepcopy(next((f for f in full["functions"] if f["allocated_product_id"] == product_ids[0]), full["functions"][0]))
    function["allocated_product_id"] = product_ids[0]
    function["level"] = 4
    allocation = copy.deepcopy(next((a for a in full["allocations"] if a["function_id"] == function["function_id"]), full["allocations"][0]))
    allocation["function_id"] = function["function_id"]
    allocation["product_id"] = product_ids[0]
    return {
        "metadata": full["metadata"], "profile": full["profile"],
        "products": products, "items": [item], "interfaces": interfaces,
        "external_boundaries": [], "physical_nets": [], "connections": [copy.deepcopy(signal)],
        "functions": [function], "allocations": [allocation],
        "function_interface_mappings": [], "verification_anchors": [],
    }


def build_outputs() -> dict:
    source = json.loads(SOURCE_JSON.read_text(encoding="utf-8"))
    contract = json.loads(CONTRACT_JSON.read_text(encoding="utf-8"))
    probe_data = build_probe_fixture(source)
    probe_bytes_a, probe_stats = XMIBuilder(probe_data, contract, probe=True).build()
    probe_bytes_b, _ = XMIBuilder(probe_data, contract, probe=True).build()
    full_bytes_a, full_stats = XMIBuilder(source, contract, probe=False).build()
    full_bytes_b, _ = XMIBuilder(source, contract, probe=False).build()
    if probe_bytes_a != probe_bytes_b or full_bytes_a != full_bytes_b:
        raise AssertionError("XMI generation is not byte deterministic")
    probe_path = WORK_DIR / "Rail_MBSE_SysML17_probe.xmi"
    full_path = WORK_DIR / "Rail_MBSE_SysML17_v1.xmi"
    probe_path.write_bytes(probe_bytes_a)
    full_path.write_bytes(full_bytes_a)
    manifest = {
        "source": str(SOURCE_JSON),
        "source_sha256": hashlib.sha256(SOURCE_JSON.read_bytes()).hexdigest(),
        "probe": {"path": str(probe_path), "sha256": hashlib.sha256(probe_bytes_a).hexdigest(), "stats": probe_stats},
        "full": {"path": str(full_path), "sha256": hashlib.sha256(full_bytes_a).hexdigest(), "stats": full_stats},
        "probe_byte_deterministic": probe_bytes_a == probe_bytes_b,
        "full_byte_deterministic": full_bytes_a == full_bytes_b,
    }
    manifest_path = PIPELINE_WORK / "xmi_build_manifest.json"
    manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return manifest


def main() -> None:
    PIPELINE_WORK.mkdir(parents=True, exist_ok=True)
    manifest = build_outputs()
    print(f"Probe: {manifest['probe']['path']}")
    print(f"Full: {manifest['full']['path']}")
    print(f"Full SHA256: {manifest['full']['sha256']}")


if __name__ == "__main__":
    main()
