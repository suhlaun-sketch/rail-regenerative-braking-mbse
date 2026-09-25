from __future__ import annotations

import hashlib
import json
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
SOURCE = WORK / "architecture_xmi_ready_v1.json"
UPWARD = PIPELINE_WORK / "upward_port_inference_v1.json"
PROJECTION = PIPELINE_WORK / "hierarchical_connection_projection_v1.json"
PLAN = PIPELINE_WORK / "ibd_generation_plan_v1.json"
DIRECTIONS = PIPELINE_WORK / "port_direction_resolution.json"
HUMAN_NAMES = PIPELINE_WORK / "interface_human_name_map.json"
ITEMFLOW_MAP = PIPELINE_WORK / "itemflow_mapping_contract_v2.json"
COMPATIBILITY = PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json"
OUTPUT = WORK / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.xmi"
MANIFEST = PIPELINE_WORK / "full_upward_model_manifest_v1.json"

CONTEXT = "__SYSTEM_CONTEXT__"
CONTEXT_XMI = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE"
MODEL_XMI = "XMI-MODEL-RAIL-MBSE-FULL-UPWARD-IBD-V1"


def sid(prefix: str, seed: str, length: int = 24) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


class FullModelBuilder:
    def __init__(self, data: dict, upward: dict, projection: dict, plan: dict, directions: dict, names: dict, itemflow_map: dict, compatibility: dict):
        ns = compatibility["namespace_separation"]
        self.XMI = ns["xmi_xml_namespace"]
        self.UML = ns["uml_xml_namespace"]
        self.SYSML = ns["sysml_stereotype_namespace"]
        ET.register_namespace("xmi", self.XMI)
        ET.register_namespace("uml", self.UML)
        ET.register_namespace("sysml", self.SYSML)
        self.qx = lambda name: f"{{{self.XMI}}}{name}"
        self.qu = lambda name: f"{{{self.UML}}}{name}"
        self.qs = lambda name: f"{{{self.SYSML}}}{name}"
        self.data = data
        self.upward = upward
        self.projection = projection
        self.plan = plan
        self.compatibility = compatibility
        self.products = {p["id"]: p for p in data["products"]}
        self.items = {i["item_code"]: i for i in data["items"]}
        self.interfaces = {i["interface_instance_id"]: i for i in data["interfaces"]}
        self.direction_records = directions["records"]
        self.direction_by_interface = {r["interface_instance_id"]: r for r in self.direction_records}
        self.ib_names = {r["interface_block_id"]: r for r in names["interface_blocks"]}
        self.itemflow_by_connection = {r["connection_id"]: r for r in itemflow_map["mappings"]}
        self.promoted = {p["promoted_port_id"]: p for p in upward["promoted_ports"]}
        self.segments = {s["segment_id"]: s for s in projection["segments"]}
        self.net_projections = {n["projection_id"]: n for n in projection["physical_net_projections"]}
        self.plan_by_owner = {d["owner_block"]: d for d in plan["diagrams"]}
        self.product_elements: dict[str, ET.Element] = {}
        self.item_elements: dict[str, ET.Element] = {}
        self.port_elements: dict[str, ET.Element] = {}
        self.part_ids: dict[tuple[str, str], str] = {}
        self.boundary_ref_ids: dict[str, str] = {}
        self.boundary_ports: dict[tuple[str, str], str] = {}
        self.net_ref_ids: dict[tuple[str, str], str] = {}
        self.net_junction_ports: dict[tuple[str, int], str] = {}
        self.net_connector_ids: list[str] = []
        self.apps: list[ET.Element] = []
        self.signal_items = {c["item_id"] for c in data["connections"] if c["mode"] == "SIGNAL"}

    def xid(self, element: ET.Element, identifier: str) -> None:
        element.set(self.qx("id"), identifier)

    def xtype(self, element: ET.Element, uml_type: str) -> None:
        element.set(self.qx("type"), f"uml:{uml_type}")

    def packaged(self, parent: ET.Element, uml_type: str, identifier: str, name: str | None = None) -> ET.Element:
        element = ET.SubElement(parent, "packagedElement")
        self.xtype(element, uml_type)
        self.xid(element, identifier)
        if name is not None:
            element.set("name", name)
        return element

    def comment(self, parent: ET.Element, identifier: str, body: str) -> None:
        comment = ET.SubElement(parent, "ownedComment")
        self.xtype(comment, "Comment")
        self.xid(comment, identifier)
        comment.set("body", body)

    def app(self, name: str, identifier: str, **attributes: str) -> None:
        element = ET.Element(self.qs(name))
        self.xid(element, identifier)
        for key, value in attributes.items():
            if value is not None:
                element.set(key, value)
        self.apps.append(element)

    def port(self, owner: ET.Element, identifier: str, name: str, interface_block: str, trace: dict) -> ET.Element:
        element = ET.SubElement(owner, "ownedAttribute")
        self.xtype(element, "Port")
        self.xid(element, identifier)
        element.set("name", name)
        element.set("type", interface_block)
        element.set("isService", "false")
        self.comment(element, sid("XMI-COMMENT-PORT-TRACE", identifier), json.dumps(trace, ensure_ascii=False, sort_keys=True, separators=(",", ":")))
        self.app("ProxyPort", sid("XMI-APP-PROXYPORT", identifier), base_Port=identifier)
        self.port_elements[identifier] = element
        return element

    def add_part(self, owner: ET.Element, identifier: str, name: str, type_id: str, aggregation: str = "composite") -> None:
        prop = ET.SubElement(owner, "ownedAttribute")
        self.xtype(prop, "Property")
        self.xid(prop, identifier)
        prop.set("name", name)
        prop.set("type", type_id)
        prop.set("aggregation", aggregation)
        lower = ET.SubElement(prop, "lowerValue")
        self.xtype(lower, "LiteralInteger")
        self.xid(lower, sid("XMI-LOWER", identifier))
        lower.set("value", "1")
        upper = ET.SubElement(prop, "upperValue")
        self.xtype(upper, "LiteralUnlimitedNatural")
        self.xid(upper, sid("XMI-UPPER", identifier))
        upper.set("value", "1")

    def ref_child(self, parent: ET.Element, name: str, reference: str) -> None:
        child = ET.SubElement(parent, name)
        child.set(self.qx("idref"), reference)

    def build_packages(self, model: ET.Element) -> None:
        top_names = ["01_ProductLibrary", "02_Interfaces", "03_Behavior", "04_ReferenceArchitecture", "05_Connections", "06_Allocations", "07_Verification"]
        self.packages = {name: self.packaged(model, "Package", f"XMI-PACKAGE-{name.replace('_', '-').upper()}", name) for name in top_names}
        roots = {p["id"]: p["name"] for p in self.data["products"] if not p.get("parent_id")}
        self.product_packages = {
            code: self.packaged(self.packages["01_ProductLibrary"], "Package", f"XMI-PACKAGE-PRODUCT-{code}", f"{code}_{name}")
            for code, name in sorted(roots.items())
        }
        self.interface_blocks_pkg = self.packaged(self.packages["02_Interfaces"], "Package", "XMI-PACKAGE-INTERFACEBLOCKS", "InterfaceBlocks")
        self.signals_pkg = self.packaged(self.packages["02_Interfaces"], "Package", "XMI-PACKAGE-SIGNALS", "Signals")
        self.physical_items_pkg = self.packaged(self.packages["02_Interfaces"], "Package", "XMI-PACKAGE-PHYSICALITEMS", "PhysicalItems")
        self.leaf_functions_pkg = self.packaged(self.packages["03_Behavior"], "Package", "XMI-PACKAGE-LEAFFUNCTIONS", "LeafFunctions")
        self.agg_functions_pkg = self.packaged(self.packages["03_Behavior"], "Package", "XMI-PACKAGE-AGGFUNCTIONS", "AggregatedFunctions")
        self.function_trace_pkg = self.packaged(self.packages["03_Behavior"], "Package", "XMI-PACKAGE-FUNCTION-INTERFACE-TRACE", "FunctionInterfaceTrace")
        self.final_connection_pkg = self.packaged(self.packages["05_Connections"], "Package", "XMI-PACKAGE-FINAL-CONNECTIONS", "FinalConnectionTrace")
        self.hierarchical_flow_pkg = self.packaged(self.packages["05_Connections"], "Package", "XMI-PACKAGE-HIERARCHICAL-FLOWS", "HierarchicalItemFlows")
        self.physical_net_pkg = self.packaged(self.packages["05_Connections"], "Package", "XMI-PACKAGE-PHYSICAL-NETS", "PhysicalNetworks")

    def root_code(self, code: str) -> str:
        cursor = code
        while self.products[cursor].get("parent_id"):
            cursor = self.products[cursor]["parent_id"]
        return cursor

    def build_products(self) -> None:
        for product in sorted(self.data["products"], key=lambda p: p["id"]):
            owner_pkg = self.product_packages[self.root_code(product["id"])]
            element = self.packaged(owner_pkg, "Class", product["xmi_id"], product["name"])
            self.product_elements[product["id"]] = element
            self.app("Block", sid("XMI-APP-BLOCK", product["xmi_id"]), base_Class=product["xmi_id"])
            code_prop = ET.SubElement(element, "ownedAttribute")
            self.xtype(code_prop, "Property")
            self.xid(code_prop, sid("XMI-PRODUCT-CODE", product["id"]))
            code_prop.set("name", "product_code")
            type_ref = ET.SubElement(code_prop, "type")
            type_ref.set("href", "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String")
            default = ET.SubElement(code_prop, "defaultValue")
            self.xtype(default, "LiteralString")
            self.xid(default, sid("XMI-PRODUCT-CODE-VALUE", product["id"]))
            default.set("value", product["id"])

    def build_context_and_composition(self) -> None:
        self.context = self.packaged(self.packages["04_ReferenceArchitecture"], "Class", CONTEXT_XMI, "Rail_MBSE_TractionBrake_Context")
        self.app("Block", sid("XMI-APP-BLOCK", CONTEXT_XMI), base_Class=CONTEXT_XMI)
        for diagram in self.plan["diagrams"]:
            owner_code = diagram["owner_block"]
            owner = self.context if owner_code == CONTEXT else self.product_elements[owner_code]
            for part in diagram["direct_parts"]:
                self.add_part(owner, part["part_xmi_id"], part["name"], part["product_xmi_id"], "composite")
                self.part_ids[(owner_code, part["product_id"])] = part["part_xmi_id"]

        boundary_ids = sorted({c["target_boundary_id"] for c in self.data["connections"] if c.get("target_boundary_id")})
        self.boundary_elements = {}
        for boundary in boundary_ids:
            block_id = f"XMI-EXTERNAL-{boundary}"
            block = self.packaged(self.packages["04_ReferenceArchitecture"], "Class", block_id, boundary.replace("BOUNDARY-", ""))
            self.boundary_elements[boundary] = block
            self.app("Block", sid("XMI-APP-BLOCK", block_id), base_Class=block_id)
            ref_id = f"XMI-{sid('HREF', boundary)}"
            self.add_part(self.context, ref_id, f"ref_{boundary}", block_id, "none")
            self.boundary_ref_ids[boundary] = ref_id

    def build_items(self) -> None:
        for item in sorted(self.data["items"], key=lambda i: i["item_code"]):
            uml_type = "Signal" if item["item_code"] in self.signal_items else "DataType"
            package = self.signals_pkg if uml_type == "Signal" else self.physical_items_pkg
            element = self.packaged(package, uml_type, item["xmi_id"], item["name_cn"])
            self.item_elements[item["item_code"]] = element
            self.comment(element, sid("XMI-COMMENT-ITEM", item["item_code"]), f"item_code={item['item_code']}; {item['semantic_definition']}")

    def build_interface_blocks(self) -> None:
        for ib_id, info in sorted(self.ib_names.items()):
            ib = self.packaged(self.interface_blocks_pkg, "Class", ib_id, info["name_cn"])
            self.app("InterfaceBlock", sid("XMI-APP-INTERFACEBLOCK", ib_id), base_Class=ib_id)
            flow = ET.SubElement(ib, "ownedAttribute")
            self.xtype(flow, "Property")
            self.xid(flow, info["flow_property_id"])
            flow.set("name", info["canonical_item_name_cn"])
            flow.set("type", self.items[info["item_code"]]["xmi_id"])
            self.app("FlowProperty", sid("XMI-APP-FLOWPROPERTY", info["flow_property_id"]), base_Property=info["flow_property_id"], direction=info["effective_direction"])
            for metadata in info["metadata_properties"]:
                prop = ET.SubElement(ib, "ownedAttribute")
                self.xtype(prop, "Property")
                self.xid(prop, metadata["xmi_id"])
                prop.set("name", metadata["name"])
                type_ref = ET.SubElement(prop, "type")
                type_ref.set("href", metadata["uml_type_href"])
                default = ET.SubElement(prop, "defaultValue")
                self.xtype(default, "LiteralString")
                self.xid(default, metadata["default_value_xmi_id"])
                default.set("value", metadata["value"])

    def build_ports(self) -> None:
        for interface in sorted(self.data["interfaces"], key=lambda i: i["interface_instance_id"]):
            resolution = self.direction_by_interface[interface["interface_instance_id"]]
            self.port(
                self.product_elements[interface["owner_product_id"]], interface["xmi_id"], interface["name"], resolution["interface_block_id"],
                {"port_id": interface["port_id"], "interface_instance_id": interface["interface_instance_id"], "raw_port": True, "item_code": interface["item_id"]},
            )
        for promoted in sorted(self.promoted.values(), key=lambda p: p["promoted_port_id"]):
            self.port(
                self.product_elements[promoted["owner_product_code"]], promoted["xmi_id"], promoted["name"], promoted["interface_block_id"], promoted,
            )
        for connection in sorted(self.data["connections"], key=lambda c: c["connection_id"]):
            boundary = connection.get("target_boundary_id")
            if not boundary:
                continue
            raw = self.interfaces[connection["source_interface_id"]]
            resolution = self.direction_by_interface[raw["interface_instance_id"]]
            boundary_port_seed = f"{boundary}|{connection['connection_id']}"
            port_id = f"XMI-{sid('BPORT', boundary_port_seed)}"
            self.port(
                self.boundary_elements[boundary], port_id, f"{self.items[connection['item_id']]['name_cn']}接口", resolution["interface_block_id"],
                {"port_origin": "DERIVED_BOUNDARY", "derived_from_connection_id": connection["connection_id"], "item_code": connection["item_id"]},
            )
            self.boundary_ports[(boundary, connection["connection_id"])] = port_id

    def part_path(self, ancestor: str, descendant: str) -> list[str]:
        chain = []
        cursor = descendant
        while cursor != ancestor:
            parent = self.products[cursor].get("parent_id") or CONTEXT
            chain.append((parent, cursor))
            cursor = parent
        chain.reverse()
        return [self.part_ids[pair] for pair in chain]

    def connector_end(self, connector: ET.Element, identifier: str, role: str, part: str | None = None, path: list[str] | None = None) -> None:
        end = ET.SubElement(connector, "end")
        self.xtype(end, "ConnectorEnd")
        self.xid(end, identifier)
        end.set("role", role)
        if part:
            end.set("partWithPort", part)
        if path and len(path) > 1:
            self.app("NestedConnectorEnd", sid("XMI-APP-NESTEDEND", identifier), base_ConnectorEnd=identifier, propertyPath=" ".join(path))

    def original_connectors(self) -> None:
        trace_by_connection = {c["original_connection_id"]: c for c in self.upward["connections"]}
        for connection in sorted(self.data["connections"], key=lambda c: c["connection_id"]):
            trace = trace_by_connection[connection["connection_id"]]
            lca = trace["lca"]
            owner = self.context if lca == CONTEXT else self.product_elements[lca]
            connector = ET.SubElement(owner, "ownedConnector")
            self.xtype(connector, "Connector")
            self.xid(connector, connection["xmi_id"])
            self.comment(connector, sid("XMI-COMMENT-FINAL-CONNECTION", connection["connection_id"]), f"Final Connection={connection['connection_id']}; mode={connection['mode']}; item={connection['item_id']}")
            source_interface = self.interfaces[connection["source_interface_id"]]
            source_path = self.part_path(lca, connection["source_product_id"])
            self.connector_end(connector, sid("XMI-FINAL-END", connection["connection_id"] + "|S"), source_interface["xmi_id"], source_path[-1], source_path)
            if connection.get("target_product_id"):
                target_interface = self.interfaces[connection["target_interface_id"]]
                target_path = self.part_path(lca, connection["target_product_id"])
                self.connector_end(connector, sid("XMI-FINAL-END", connection["connection_id"] + "|T"), target_interface["xmi_id"], target_path[-1], target_path)
            else:
                boundary = connection["target_boundary_id"]
                self.connector_end(connector, sid("XMI-FINAL-END", connection["connection_id"] + "|T"), self.boundary_ports[(boundary, connection["connection_id"])], self.boundary_ref_ids[boundary], [self.boundary_ref_ids[boundary]])
            if connection["mode"] == "SIGNAL":
                mapping = self.itemflow_by_connection[connection["connection_id"]]
                info = self.packaged(self.final_connection_pkg, "InformationFlow", mapping["information_flow_xmi_id"], self.items[connection["item_id"]]["name_cn"])
                self.ref_child(info, "conveyed", self.items[connection["item_id"]]["xmi_id"])
                self.ref_child(info, "informationSource", source_interface["xmi_id"])
                self.ref_child(info, "informationTarget", self.interfaces[connection["target_interface_id"]]["xmi_id"])
                self.ref_child(info, "realizingConnector", connection["xmi_id"])
                self.app("ItemFlow", mapping["item_flow_application_xmi_id"], base_InformationFlow=mapping["information_flow_xmi_id"])

    def segment_endpoint(self, segment: dict, endpoint: dict) -> tuple[str, str | None]:
        role = endpoint["port_xmi_id"]
        if endpoint["kind"] == "FRAME_PORT":
            return role, None
        if endpoint["kind"] == "BOUNDARY_PORT":
            return role, self.boundary_ref_ids[endpoint["element"]]
        return role, self.part_ids[(segment["owner_block"], endpoint["element"])]

    def hierarchical_connectors(self) -> None:
        for segment in sorted(self.segments.values(), key=lambda s: s["segment_id"]):
            owner = self.context if segment["owner_block"] == CONTEXT else self.product_elements[segment["owner_block"]]
            connector = ET.SubElement(owner, "ownedConnector")
            self.xtype(connector, "Connector")
            self.xid(connector, segment["xmi_id"])
            self.comment(connector, sid("XMI-COMMENT-HCONN", segment["segment_id"]), f"derived_from_connection_id={segment['derived_from_connection_id']}; item_code={segment['item_code']}")
            for side, endpoint in (("S", segment["source_endpoint"]), ("T", segment["target_endpoint"])):
                role, part = self.segment_endpoint(segment, endpoint)
                self.connector_end(connector, sid("XMI-HEND", segment["segment_id"] + "|" + side), role, part)
            if segment["mode"] == "SIGNAL":
                info_id = f"XMI-{segment['information_flow_id']}"
                itemflow_id = f"XMI-{segment['item_flow_id']}"
                info = self.packaged(self.hierarchical_flow_pkg, "InformationFlow", info_id, self.items[segment["item_code"]]["name_cn"])
                self.ref_child(info, "conveyed", self.items[segment["item_code"]]["xmi_id"])
                self.ref_child(info, "informationSource", segment["source_port_xmi_id"])
                self.ref_child(info, "informationTarget", segment["target_port_xmi_id"])
                self.ref_child(info, "realizingConnector", segment["xmi_id"])
                self.app("ItemFlow", itemflow_id, base_InformationFlow=info_id)

    def inout_interface_block_for_item(self, item_code: str) -> str:
        records = [r for r in self.direction_records if r["canonical_item_id"] == item_code and r["effective_port_direction"] == "inout"]
        if not records:
            raise AssertionError(f"No inout InterfaceBlock for PhysicalNet item {item_code}")
        return sorted(records, key=lambda r: r["interface_block_id"])[0]["interface_block_id"]

    def build_physical_nets(self) -> None:
        net_blocks = {}
        for net in sorted(self.data["physical_nets"], key=lambda n: n["net_id"]):
            block = self.packaged(self.physical_net_pkg, "Class", net["xmi_id"], net["name"])
            net_blocks[net["net_id"]] = block
            self.app("Block", sid("XMI-APP-BLOCK", net["xmi_id"]), base_Class=net["xmi_id"])
            self.comment(block, sid("XMI-COMMENT-NET", net["net_id"]), f"PhysicalNet={net['net_id']}; item={net['item_id']}; member_count={len(net['members'])}; modeling_artifact=true")

        for projection in sorted(self.net_projections.values(), key=lambda n: n["projection_id"]):
            owner_code = projection["owner_block"]
            owner = self.context if owner_code == CONTEXT else self.product_elements[owner_code]
            net = next(n for n in self.data["physical_nets"] if n["net_id"] == projection["derived_from_net_id"])
            ref_id = f"XMI-{sid('HNETREF', projection['projection_id'])}"
            self.add_part(owner, ref_id, f"net_{net['net_id']}", net["xmi_id"], "none")
            self.net_ref_ids[(owner_code, projection["projection_id"])] = ref_id
            ib_id = self.inout_interface_block_for_item(net["item_id"])
            for index, endpoint in enumerate(projection["members"], 1):
                junction_port = f"XMI-{sid('HNETPORT', projection['projection_id'] + '|' + str(index))}"
                self.port(net_blocks[net["net_id"]], junction_port, f"{self.items[net['item_id']]['name_cn']}网络端口{index}", ib_id, {"derived_from_net_id": net["net_id"], "projection_id": projection["projection_id"], "member_index": index})
                self.net_junction_ports[(projection["projection_id"], index)] = junction_port
                connector_id = f"XMI-{sid('HNETCONN', projection['projection_id'] + '|' + str(index))}"
                connector = ET.SubElement(owner, "ownedConnector")
                self.xtype(connector, "Connector")
                self.xid(connector, connector_id)
                self.comment(connector, sid("XMI-COMMENT-HNETCONN", connector_id), f"derived_from_net_id={net['net_id']}; projection_id={projection['projection_id']}; pairwise_clique=false")
                member_role = endpoint["port_xmi_id"]
                member_part = None if endpoint["kind"] == "FRAME_PORT" else self.part_ids[(owner_code, endpoint["element"])]
                self.connector_end(connector, sid("XMI-HNET-END", connector_id + "|M"), member_role, member_part)
                self.connector_end(connector, sid("XMI-HNET-END", connector_id + "|N"), junction_port, ref_id)
                self.net_connector_ids.append(connector_id)

    def build_functions(self) -> None:
        function_elements = {}
        for function in sorted(self.data["functions"], key=lambda f: f["function_id"]):
            package = self.leaf_functions_pkg if function["level"] == 4 or not function.get("aggregated_from_functions") else self.agg_functions_pkg
            element = self.packaged(package, "Activity", function["xmi_id"], function["name_cn"])
            function_elements[function["function_id"]] = element
            self.comment(element, sid("XMI-COMMENT-FUNCTION", function["function_id"]), function["description"])
        direction_map = {"CONSUMES": "in", "MONITORS": "in", "PRODUCES": "out", "CONTROLS": "out", "EXCHANGES": "inout"}
        for mapping in sorted(self.data["function_interface_mappings"], key=lambda m: m["mapping_id"]):
            interface = self.interfaces[mapping["interface_instance_id"]]
            parameter = ET.SubElement(function_elements[mapping["function_id"]], "ownedParameter")
            self.xtype(parameter, "Parameter")
            self.xid(parameter, mapping["xmi_id"])
            parameter.set("name", interface["name"])
            parameter.set("direction", direction_map[mapping["usage_role"]])
            parameter.set("type", self.items[interface["item_id"]]["xmi_id"])
            self.comment(parameter, sid("XMI-COMMENT-FIMAP", mapping["mapping_id"]), f"mapping_id={mapping['mapping_id']}; interface_instance_id={mapping['interface_instance_id']}; usage_role={mapping['usage_role']}")
        for allocation in sorted(self.data["allocations"], key=lambda a: a["allocation_id"]):
            element = self.packaged(self.packages["06_Allocations"], "Abstraction", allocation["xmi_id"], allocation["allocation_id"])
            element.set("client", next(f["xmi_id"] for f in self.data["functions"] if f["function_id"] == allocation["function_id"]))
            element.set("supplier", self.products[allocation["product_id"]]["xmi_id"])
            self.app("Allocate", sid("XMI-APP-ALLOCATE", allocation["allocation_id"]), base_Abstraction=allocation["xmi_id"])

    def build_verification(self) -> None:
        for anchor in self.data["verification_anchors"]:
            comment = self.packaged(self.packages["07_Verification"], "Comment", sid("XMI-VOLTAGE-ANCHOR", anchor["anchor_id"]), anchor["anchor_id"])
            comment.set("body", json.dumps(anchor, ensure_ascii=False, sort_keys=True, separators=(",", ":")))
            target = self.interfaces[anchor["interface_id"]]["xmi_id"] if anchor["target_type"] == "INTERFACE" else next(n["xmi_id"] for n in self.data["physical_nets"] if n["net_id"] == anchor["physical_net_id"])
            self.ref_child(comment, "annotatedElement", target)

    def build(self) -> ET.Element:
        root = ET.Element(self.qx("XMI"))
        model = ET.SubElement(root, self.qu("Model"))
        self.xtype(model, "Model")
        self.xid(model, MODEL_XMI)
        model.set("name", "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1")
        profile = ET.SubElement(model, "profileApplication")
        self.xtype(profile, "ProfileApplication")
        self.xid(profile, "XMI-PROFILEAPPLICATION-SYSML17-FULL-UPWARD-V1")
        applied = ET.SubElement(profile, "appliedProfile")
        applied.set("href", self.compatibility["profile_resolution_strategy"]["applied_profile_href"])
        self.build_packages(model)
        self.build_products()
        self.build_context_and_composition()
        self.build_items()
        self.build_interface_blocks()
        self.build_ports()
        self.original_connectors()
        self.hierarchical_connectors()
        self.build_physical_nets()
        self.build_functions()
        self.build_verification()
        for app in sorted(self.apps, key=lambda e: e.get(self.qx("id"))):
            root.append(app)
        return root


def load_builder() -> FullModelBuilder:
    return FullModelBuilder(
        json.loads(SOURCE.read_text(encoding="utf-8")),
        json.loads(UPWARD.read_text(encoding="utf-8")),
        json.loads(PROJECTION.read_text(encoding="utf-8")),
        json.loads(PLAN.read_text(encoding="utf-8")),
        json.loads(DIRECTIONS.read_text(encoding="utf-8")),
        json.loads(HUMAN_NAMES.read_text(encoding="utf-8")),
        json.loads(ITEMFLOW_MAP.read_text(encoding="utf-8")),
        json.loads(COMPATIBILITY.read_text(encoding="utf-8")),
    )


def build_bytes() -> tuple[bytes, dict]:
    builder = load_builder()
    root = builder.build()
    ET.indent(root, space="  ")
    data = ET.tostring(root, encoding="utf-8", xml_declaration=True, short_empty_elements=True) + b"\n"
    manifest = {
        "manifest_id": "RAIL-MBSE-FULL-UPWARD-MODEL-V1",
        "output": str(OUTPUT),
        "sha256": hashlib.sha256(data).hexdigest(),
        "counts": {
            "product_blocks": len(builder.products),
            "raw_ports": len(builder.data["interfaces"]),
            "promoted_ports": len(builder.promoted),
            "final_connections": len(builder.data["connections"]),
            "hierarchical_segments": len(builder.segments),
            "physical_nets": len(builder.data["physical_nets"]),
            "physical_net_projection_connectors": len(builder.net_connector_ids),
            "functions": len(builder.data["functions"]),
            "allocations": len(builder.data["allocations"]),
            "function_interface": len(builder.data["function_interface_mappings"]),
            "voltage_anchors": len(builder.data["verification_anchors"]),
        },
        "byte_deterministic": True,
    }
    return data, manifest


def main() -> None:
    first, manifest = build_bytes()
    second, manifest_second = build_bytes()
    if first != second or manifest != manifest_second:
        raise AssertionError("Full upward semantic XMI is not byte deterministic")
    OUTPUT.write_bytes(first)
    MANIFEST.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(manifest, ensure_ascii=False))


if __name__ == "__main__":
    main()
