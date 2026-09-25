from __future__ import annotations

import base64
import copy
import gzip
import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
GOLD2 = WORK / "gold2.mdxml"
SOURCE = WORK / "architecture_xmi_ready_v1.json"
UPWARD = PIPELINE_WORK / "upward_port_inference_v1.json"
PROJECTION = PIPELINE_WORK / "hierarchical_connection_projection_v1.json"
PLAN = PIPELINE_WORK / "ibd_generation_plan_v1.json"
HUMAN_NAMES = PIPELINE_WORK / "interface_human_name_map.json"
KINDS = PIPELINE_WORK / "hierarchical_connector_kind_v2.json"
OUTPUT = WORK / "Rail_MBSE_Gold2_Integrated_4235_5111_Probe_v2.mdxml"
MANIFEST = PIPELINE_WORK / "integrated_probe_v2_manifest.json"
ICD_ROWS = PIPELINE_WORK / "integrated_probe_icd_4235_5111_v2.json"

CONNECTION_ID = "CG-002543DBE0F9A7FBC2A3FDD3"
CONTEXT = "__SYSTEM_CONTEXT__"
CONTEXT_XMI = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE"
MODEL_XMI = "XMI-MODEL-RAIL-MBSE-GOLD2-INTEGRATED-4235-5111-PROBE-V2"
MODEL_NAME = "Rail_MBSE_Gold2_Integrated_4235_5111_Probe_v2"
PRODUCT_CODES = ["4000", "4200", "4230", "4235", "5000", "5100", "5110", "5111"]
OWNER_ORDER = ["4230", "4200", "4000", CONTEXT, "5000", "5100", "5110"]


def sid(prefix: str, seed: str, length: int = 24) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def uuidish(seed: str) -> str:
    value = hashlib.sha1(seed.encode("utf-8")).hexdigest()[:32]
    return f"{value[:8]}-{value[8:12]}-{value[12:16]}-{value[16:20]}-{value[20:]}"


def local(value: str) -> str:
    return value.rsplit("}", 1)[-1]


def attr(element: ET.Element | None, name: str) -> str | None:
    if element is None:
        return None
    return next((value for key, value in element.attrib.items() if local(key) == name), None)


def set_attr(element: ET.Element, name: str, value: str) -> None:
    for key in list(element.attrib):
        if local(key) == name:
            element.set(key, value)
            return
    element.set(name, value)


def child(element: ET.Element, name: str) -> ET.Element:
    return next(entry for entry in element if local(entry.tag) == name)


def child_ref(element: ET.Element, name: str) -> str | None:
    target = next((entry for entry in element if local(entry.tag) == name), None)
    return attr(target, "idref") if target is not None else element.get(name)


def model_ref(element: ET.Element) -> str | None:
    return child_ref(element, "elementID")


def set_model_ref(element: ET.Element, reference: str) -> None:
    set_attr(child(element, "elementID"), "idref", reference)


def replace_references(root: ET.Element, mapping: dict[str, str]) -> None:
    for element in root.iter():
        for key, value in list(element.attrib.items()):
            if value in mapping:
                element.set(key, mapping[value])
        if element.text and element.text.strip() in mapping:
            prefix = element.text[: len(element.text) - len(element.text.lstrip())]
            suffix = element.text[len(element.text.rstrip()) :]
            element.text = prefix + mapping[element.text.strip()] + suffix


def clone_reid(element: ET.Element, seed: str) -> tuple[ET.Element, dict[str, str]]:
    clone = copy.deepcopy(element)
    mapping: dict[str, str] = {}
    for index, entry in enumerate(clone.iter(), 1):
        identifier = attr(entry, "id")
        if identifier:
            mapping[identifier] = "_MDV2_" + hashlib.sha1(f"{seed}|{index}".encode("utf-8")).hexdigest()[:24].upper()
    replace_references(clone, mapping)
    return clone, mapping


class SemanticBuilder:
    def __init__(self) -> None:
        self.data = json.loads(SOURCE.read_text(encoding="utf-8"))
        self.upward = json.loads(UPWARD.read_text(encoding="utf-8"))
        self.projection = json.loads(PROJECTION.read_text(encoding="utf-8"))
        self.plan = json.loads(PLAN.read_text(encoding="utf-8"))
        self.human_names = json.loads(HUMAN_NAMES.read_text(encoding="utf-8"))
        self.kinds = json.loads(KINDS.read_text(encoding="utf-8"))
        self.products = {entry["id"]: entry for entry in self.data["products"]}
        self.items = {entry["item_code"]: entry for entry in self.data["items"]}
        self.interfaces = {entry["interface_instance_id"]: entry for entry in self.data["interfaces"]}
        self.promoted = {entry["promoted_port_id"]: entry for entry in self.upward["promoted_ports"]}
        self.kind_by_segment = {entry["segment_id"]: entry for entry in self.kinds["records"]}
        self.trace_segments = {
            entry["owner_block"]: entry
            for entry in self.projection["segments"]
            if entry["derived_from_connection_id"] == CONNECTION_ID
        }
        assert set(self.trace_segments) == set(OWNER_ORDER)
        self.trace_connection = next(entry for entry in self.data["connections"] if entry["connection_id"] == CONNECTION_ID)
        self.plan_by_owner = {entry["owner_block"]: entry for entry in self.plan["diagrams"]}
        self.plan_parts = {
            (diagram["owner_block"], part["product_id"]): part
            for diagram in self.plan["diagrams"]
            for part in diagram["direct_parts"]
        }
        self.ib_records = {
            entry["interface_block_id"]: entry
            for entry in self.human_names["interface_blocks"]
            if entry["item_code"] == "ITM-MEA-005"
        }
        assert len(self.ib_records) == 2
        self.apps: list[ET.Element] = []
        self.product_elements: dict[str, ET.Element] = {}
        self.part_records: dict[tuple[str, str], dict] = {}
        self.port_records: dict[str, dict] = {}
        self.connector_records: dict[str, dict] = {}
        self.icd_rows: list[dict] = []
        self.XMI = "http://www.omg.org/spec/XMI/20131001"
        self.UML = "http://www.omg.org/spec/UML/20131001"
        self.SYSML = "http://www.omg.org/spec/SysML/20181001/SysML"
        ET.register_namespace("xmi", self.XMI)
        ET.register_namespace("uml", self.UML)
        ET.register_namespace("sysml", self.SYSML)
        self.qx = lambda name: f"{{{self.XMI}}}{name}"
        self.qu = lambda name: f"{{{self.UML}}}{name}"
        self.qs = lambda name: f"{{{self.SYSML}}}{name}"

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

    def comment(self, parent: ET.Element, identifier: str, body: str, annotated: str | None = None) -> ET.Element:
        element = ET.SubElement(parent, "ownedComment")
        self.xtype(element, "Comment")
        self.xid(element, identifier)
        element.set("body", body)
        if annotated:
            ref = ET.SubElement(element, "annotatedElement")
            ref.set(self.qx("idref"), annotated)
        return element

    def application(self, tag: str, identifier: str, **values: str) -> None:
        element = ET.Element(self.qs(tag))
        self.xid(element, identifier)
        for key, value in values.items():
            if value is not None:
                element.set(key, value)
        self.apps.append(element)

    def string_property(self, owner: ET.Element, identifier: str, name: str, value: str) -> ET.Element:
        prop = ET.SubElement(owner, "ownedAttribute")
        self.xtype(prop, "Property")
        self.xid(prop, identifier)
        prop.set("name", name)
        type_ref = ET.SubElement(prop, "type")
        type_ref.set("href", "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String")
        default = ET.SubElement(prop, "defaultValue")
        self.xtype(default, "LiteralString")
        self.xid(default, sid("XMI-DEFAULT", identifier))
        default.set("value", value)
        return prop

    def add_part(self, owner_code: str, child_code: str) -> None:
        owner = self.context if owner_code == CONTEXT else self.product_elements[owner_code]
        plan_part = self.plan_parts[(owner_code, child_code)]
        identifier = plan_part["part_xmi_id"]
        name = self.products[child_code]["name"]
        association_id = sid("XMI-ASSOCIATION-COMPOSITION", f"{owner_code}|{child_code}")
        prop = ET.SubElement(owner, "ownedAttribute")
        self.xtype(prop, "Property")
        self.xid(prop, identifier)
        prop.set("name", name)
        prop.set("type", self.products[child_code]["xmi_id"])
        prop.set("visibility", "public")
        prop.set("aggregation", "composite")
        prop.set("association", association_id)
        self.comment(
            prop,
            sid("XMI-COMMENT-PART-METADATA", identifier),
            json.dumps({"part_code": child_code, "child_product_code": child_code}, ensure_ascii=False, sort_keys=True),
            identifier,
        )
        self.application("PartProperty", sid("XMI-APP-PARTPROPERTY", identifier), base_Property=identifier)
        association = self.packaged(self.model, "Association", association_id)
        for member in (identifier, sid("XMI-ASSOCIATION-END", association_id)):
            ref = ET.SubElement(association, "memberEnd")
            ref.set(self.qx("idref"), member)
        end = ET.SubElement(association, "ownedEnd")
        self.xtype(end, "Property")
        self.xid(end, sid("XMI-ASSOCIATION-END", association_id))
        end.set("visibility", "public")
        end.set("type", CONTEXT_XMI if owner_code == CONTEXT else self.products[owner_code]["xmi_id"])
        end.set("association", association_id)
        self.part_records[(owner_code, child_code)] = {
            "id": identifier,
            "name": name,
            "child_code": child_code,
            "type": self.products[child_code]["xmi_id"],
        }

    def trace_port_specs(self) -> list[dict]:
        specs: dict[str, dict] = {}
        for owner in OWNER_ORDER:
            segment = self.trace_segments[owner]
            for endpoint in (segment["source_endpoint"], segment["target_endpoint"]):
                port_id = endpoint["port_id"]
                if port_id in self.promoted:
                    source = self.promoted[port_id]
                    owner_code = source["owner_product_code"]
                    direction = source["effective_direction"]
                    specs[source["xmi_id"]] = {
                        **source,
                        "owner_code": owner_code,
                        "direction": direction,
                        "raw_port": False,
                        "port_id": source["promoted_port_id"],
                    }
                else:
                    source = next(entry for entry in self.data["interfaces"] if entry["port_id"] == port_id)
                    direction = {"输入": "in", "输出": "out", "双向物理": "inout"}[source["direction"]]
                    ib = next(entry for entry in self.ib_records.values() if entry["effective_direction"] == direction)
                    specs[source["xmi_id"]] = {
                        **source,
                        "owner_code": source["owner_product_id"],
                        "direction": direction,
                        "raw_port": True,
                        "item_code": source["item_id"],
                        "interface_block_id": ib["interface_block_id"],
                    }
        for spec in specs.values():
            spec["name"] = "高压线路电压输出" if spec["direction"] == "out" else "高压线路电压输入"
        assert len(specs) == 8
        return sorted(specs.values(), key=lambda entry: (PRODUCT_CODES.index(entry["owner_code"]), entry["xmi_id"]))

    def build(self) -> tuple[ET.Element, ET.Element, list[ET.Element]]:
        root = ET.Element(self.qx("XMI"))
        self.model = ET.SubElement(root, self.qu("Model"))
        self.xtype(self.model, "Model")
        self.xid(self.model, MODEL_XMI)
        self.model.set("name", MODEL_NAME)
        profile = ET.SubElement(self.model, "profileApplication")
        self.xtype(profile, "ProfileApplication")
        self.xid(profile, "XMI-PROFILEAPPLICATION-SYSML17-INTEGRATED-PROBE-V2")
        applied = ET.SubElement(profile, "appliedProfile")
        applied.set("href", "http://www.omg.org/spec/SysML/20181001/SysML.xmi#SysML")
        extension = ET.SubElement(applied, self.qx("Extension"))
        extension.set("extender", "MagicDraw UML 2022x")
        reference = ET.SubElement(extension, "referenceExtension")
        reference.set("referentPath", "SysML")
        reference.set("referentType", "Profile")
        reference.set("originalID", "_11_5EAPbeta_be00301_1147434586638_637562_1900")

        product_library = self.packaged(self.model, "Package", "XMI-PACKAGE-01-PRODUCT-DEFINITION", "01_产品定义")
        power_domain = self.packaged(product_library, "Package", "XMI-PACKAGE-DOMAIN-4000", "主供电产品域")
        traction_domain = self.packaged(product_library, "Package", "XMI-PACKAGE-DOMAIN-5000", "牵引产品域")
        interface_pkg = self.packaged(self.model, "Package", "XMI-PACKAGE-02-INTERFACES", "02_接口定义")
        interface_blocks_pkg = self.packaged(interface_pkg, "Package", "XMI-PACKAGE-INTERFACEBLOCKS", "InterfaceBlocks")
        signals_pkg = self.packaged(interface_pkg, "Package", "XMI-PACKAGE-SIGNALS", "Signals")
        reference_pkg = self.packaged(self.model, "Package", "XMI-PACKAGE-04-REFERENCE-ARCHITECTURE", "04_参考架构")
        icd_pkg = self.packaged(self.model, "Package", "XMI-PACKAGE-08-ICD", "08_ICD")
        trace_pkg = self.packaged(icd_pkg, "Package", "XMI-PACKAGE-ICD-4235-5111-TRACE", "ICD_4235_5111_Trace")

        for code in PRODUCT_CODES:
            product = self.products[code]
            domain = power_domain if code.startswith("4") else traction_domain
            block = self.packaged(domain, "Class", product["xmi_id"], f"{code} {product['name']}")
            self.product_elements[code] = block
            self.application("Block", sid("XMI-APP-BLOCK", product["xmi_id"]), base_Class=product["xmi_id"])
            self.string_property(block, sid("XMI-PRODUCT-CODE", code), "product_code", code)

        self.context = self.packaged(reference_pkg, "Class", CONTEXT_XMI, "Rail_MBSE_TractionBrake_Context")
        self.application("Block", sid("XMI-APP-BLOCK", CONTEXT_XMI), base_Class=CONTEXT_XMI)
        self.string_property(self.context, sid("XMI-PRODUCT-CODE", CONTEXT), "product_code", "SYSTEM_CONTEXT")

        self.add_part(CONTEXT, "4000")
        self.add_part(CONTEXT, "5000")
        for owner, child_code in (("4000", "4200"), ("4200", "4230"), ("4230", "4235"), ("5000", "5100"), ("5100", "5110"), ("5110", "5111")):
            self.add_part(owner, child_code)

        signal = self.packaged(signals_pkg, "Signal", "XMI-ITEM-ITM-MEA-005", "高压线路电压")
        self.comment(signal, sid("XMI-COMMENT-ITEM", "ITM-MEA-005"), "item_code=ITM-MEA-005; datatype=Real; unit=V")

        for ib_id, record in sorted(self.ib_records.items()):
            ib = self.packaged(interface_blocks_pkg, "Class", ib_id, record["name_cn"])
            self.application("InterfaceBlock", sid("XMI-APP-INTERFACEBLOCK", ib_id), base_Class=ib_id)
            flow = ET.SubElement(ib, "ownedAttribute")
            self.xtype(flow, "Property")
            self.xid(flow, record["flow_property_id"])
            flow.set("name", "高压线路电压")
            flow.set("type", "XMI-ITEM-ITM-MEA-005")
            self.application(
                "FlowProperty",
                sid("XMI-APP-FLOWPROPERTY", record["flow_property_id"]),
                base_Property=record["flow_property_id"],
                direction=record["effective_direction"],
            )
            for metadata in record["metadata_properties"]:
                self.string_property(ib, metadata["xmi_id"], metadata["name"], metadata["value"])

        for spec in self.trace_port_specs():
            owner = self.product_elements[spec["owner_code"]]
            port = ET.SubElement(owner, "ownedAttribute")
            self.xtype(port, "Port")
            self.xid(port, spec["xmi_id"])
            port.set("name", spec["name"])
            port.set("type", spec["interface_block_id"])
            port.set("visibility", "public")
            port.set("aggregation", "composite")
            port.set("isService", "false")
            trace = {
                "product_code": spec["owner_code"],
                "port_id": spec["port_id"],
                "interface_type_code": "IF-MEA-005",
                "item_code": "ITM-MEA-005",
                "port_type_code": "PT-MEA-005",
                "direction_code": spec["direction"].upper(),
                "port_origin": "RAW_LEAF" if spec["raw_port"] else "DERIVED_UPWARD",
                "raw_port": spec["raw_port"],
                "derived": not spec["raw_port"],
                "derived_from_connection_id": CONNECTION_ID,
                "derived_from_leaf_port_id": (
                    spec.get("source_leaf_port_id") if not spec["raw_port"] else spec["port_id"]
                ),
                "promotion_depth": spec.get("promotion_depth", 0),
            }
            self.comment(port, sid("XMI-COMMENT-PORT-METADATA", spec["xmi_id"]), json.dumps(trace, ensure_ascii=False, sort_keys=True), spec["xmi_id"])
            self.application("ProxyPort", sid("XMI-APP-PROXYPORT", spec["xmi_id"]), base_Port=spec["xmi_id"])
            self.port_records[spec["xmi_id"]] = {**spec, "metadata": trace}

        for owner in OWNER_ORDER:
            segment = self.trace_segments[owner]
            kind_record = self.kind_by_segment[segment["segment_id"]]
            owner_element = self.context if owner == CONTEXT else self.product_elements[owner]
            connector = ET.SubElement(owner_element, "ownedConnector")
            self.xtype(connector, "Connector")
            self.xid(connector, segment["xmi_id"])
            connector.set("name", f"高压线路电压_{kind_record['connector_kind']}_{owner if owner != CONTEXT else 'Context'}")
            end_ids = []
            endpoint_rows = []
            for side, endpoint in (("A", segment["source_endpoint"]), ("B", segment["target_endpoint"])):
                end = ET.SubElement(connector, "end")
                self.xtype(end, "ConnectorEnd")
                end_id = sid("XMI-HEND", f"{segment['segment_id']}|{side}")
                self.xid(end, end_id)
                end.set("role", endpoint["port_xmi_id"])
                part = None
                if endpoint["kind"] == "PART_PORT":
                    part = self.part_records[(owner, endpoint["element"])]
                    end.set("partWithPort", part["id"])
                end_ids.append(end_id)
                endpoint_rows.append((endpoint, part))

            connector_metadata = {
                "connector_kind": kind_record["connector_kind"],
                "owner_block_code": "SYSTEM_CONTEXT" if owner == CONTEXT else owner,
                "derived_from_connection_id": CONNECTION_ID,
                "derived_segment_id": segment["segment_id"],
                "item_code": "ITM-MEA-005",
                "global_flow": "4235 → 5111",
                "simulation_boundary": False,
                "simulink_binding_status": "NOT_MAPPED",
            }
            self.comment(connector, sid("XMI-COMMENT-CONNECTOR-METADATA", segment["segment_id"]), json.dumps(connector_metadata, ensure_ascii=False, sort_keys=True), segment["xmi_id"])
            info_id = f"XMI-{segment['information_flow_id']}"
            itemflow_id = f"XMI-{segment['item_flow_id']}"
            info = self.packaged(trace_pkg, "InformationFlow", info_id, "高压线路电压")
            for tag, ref_id in (
                ("conveyed", "XMI-ITEM-ITM-MEA-005"),
                ("informationSource", segment["source_port_xmi_id"]),
                ("informationTarget", segment["target_port_xmi_id"]),
                ("realizingConnector", segment["xmi_id"]),
            ):
                ref = ET.SubElement(info, tag)
                ref.set(self.qx("idref"), ref_id)
            self.application("ItemFlow", itemflow_id, base_InformationFlow=info_id)
            self.connector_records[segment["xmi_id"]] = {
                "segment": segment,
                "kind": kind_record["connector_kind"],
                "end_ids": end_ids,
                "information_flow_id": info_id,
                "item_flow_id": itemflow_id,
            }

            source_endpoint, source_part = endpoint_rows[0]
            target_endpoint, target_part = endpoint_rows[1]
            source_product = self.products[source_endpoint["element"]]
            target_product = self.products[target_endpoint["element"]]
            source_port = self.port_records[source_endpoint["port_xmi_id"]]
            target_port = self.port_records[target_endpoint["port_xmi_id"]]
            self.icd_rows.append(
                {
                    "Connector Name": connector.get("name"),
                    "Connector Kind": kind_record["connector_kind"],
                    "Owner Block Name": "Rail_MBSE_TractionBrake_Context" if owner == CONTEXT else self.products[owner]["name"],
                    "Owner Block Code": "SYSTEM_CONTEXT" if owner == CONTEXT else owner,
                    "Part A Name": source_part["name"] if source_part else "[frame]",
                    "Part A Block Name": source_product["name"],
                    "Part A Block Code": source_endpoint["element"],
                    "Port A Name": source_port["name"],
                    "Port A Direction": source_port["direction"],
                    "Item Flow": "高压线路电压",
                    "Conveyed Signal Name": "高压线路电压",
                    "Signal Code": "ITM-MEA-005",
                    "Signal Data Type": "Real",
                    "Unit": "V",
                    "Global Flow Direction": "4235 → 5111",
                    "Port B Name": target_port["name"],
                    "Port B Direction": target_port["direction"],
                    "Part B Name": target_part["name"] if target_part else "[frame]",
                    "Part B Block Name": target_product["name"],
                    "Part B Block Code": target_endpoint["element"],
                    "Original Connection ID": CONNECTION_ID,
                    "Derived Segment ID": segment["segment_id"],
                    "Simulation Boundary": False,
                    "Simulink Binding Status": "NOT_MAPPED",
                    "Connector XMI ID": segment["xmi_id"],
                    "InformationFlow XMI ID": info_id,
                    "ItemFlow XMI ID": itemflow_id,
                }
            )

        self.comment(
            trace_pkg,
            "XMI-COMMENT-ICD-4235-5111-SCHEMA",
            json.dumps({"table": "ICD_4235_5111_Trace", "element_type": "Connector", "rows": 7, "itemflow_query": "InformationFlow.realizingConnector -> ItemFlow"}, ensure_ascii=False, sort_keys=True),
        )
        for application in sorted(self.apps, key=lambda entry: attr(entry, "id") or ""):
            root.append(application)
        return root, self.model, self.apps


class NativeBuilder:
    def __init__(self) -> None:
        self.semantic = SemanticBuilder()
        self.standard_root, self.model, self.apps = self.semantic.build()
        self.model_ids = {attr(entry, "id"): entry for entry in self.model.iter() if attr(entry, "id")}
        self.gold_root = ET.parse(GOLD2).getroot()
        gold_model = next(entry for entry in self.gold_root if local(entry.tag) == "Model")
        self.old_model_id = attr(gold_model, "id")
        self.old_model_name = gold_model.get("name")
        project_parts = [
            entry
            for entry in self.gold_root.iter()
            if local(entry.tag) == "filePart" and entry.get("type") == "BINARY" and (entry.get("name") or "").startswith("PROJECT-")
        ]
        assert len(project_parts) == 1
        self.old_project = project_parts[0].get("name")
        self.new_project = "PROJECT-" + uuidish("RAIL-MBSE-GOLD2-INTEGRATED-4235-5111-PROBE-V2")
        self.gold_diagrams = [entry for entry in gold_model.iter() if local(entry.tag) == "ownedDiagram"]
        self.old_diagram_resources = {
            next(entry for entry in diagram.iter() if local(entry.tag) == "binaryObject").get("streamContentID")
            for diagram in self.gold_diagrams
        }
        context_diagram = next(
            diagram
            for diagram in self.gold_diagrams
            if diagram.get("context")
            and next(entry for entry in diagram.iter() if local(entry.tag) == "DiagramRepresentationObject").get("type")
            == "SysML Internal Block Diagram"
            and self._gold_id_name(diagram.get("context")) == "Model"
        )
        context_resource_id = next(entry for entry in context_diagram.iter() if local(entry.tag) == "binaryObject").get("streamContentID")
        context_resource = next(
            entry for entry in self.gold_root.iter() if local(entry.tag) == "filePart" and entry.get("name") == context_resource_id
        )
        self.gold_presentation = next(entry for entry in context_resource if local(entry.tag) == "mdOwnedViews")
        self.gold_frame = next(entry for entry in self.gold_presentation if entry.get("elementClass") == "DiagramFrame")
        self.gold_parts = [entry for entry in self.gold_presentation if entry.get("elementClass") == "Part"]
        assert len(self.gold_parts) == 2
        self.gold_ports = [next(entry for entry in part.iter() if entry.get("elementClass") == "Port") for part in self.gold_parts]
        self.gold_connector = next(entry for entry in self.gold_presentation if entry.get("elementClass") == "Connector")
        self.gold_styles = next(entry for entry in self.gold_presentation if local(entry.tag) == "symbolStyles")
        context_owner = next(entry for entry in gold_model.iter() if attr(entry, "id") == context_diagram.get("context"))
        self.gold_diagram_extension = next(
            entry for entry in context_owner if local(entry.tag) == "Extension" and any(local(child.tag) == "ownedDiagram" for child in entry.iter())
        )
        self.resources: list[dict] = []
        self.diagram_info_apps: list[str] = []

    def _gold_id_name(self, identifier: str | None) -> str | None:
        return next((entry.get("name") for entry in self.gold_root.iter() if attr(entry, "id") == identifier), None)

    def port_direction(self, port_id: str) -> str:
        return self.semantic.port_records[port_id]["direction"]

    def build_port_symbol(self, port_id: str, x: int, y: int, side: str, seed: str) -> tuple[ET.Element, str, tuple[int, int]]:
        template = self.gold_ports[0] if side == "RIGHT" else self.gold_ports[1]
        symbol, _mapping = clone_reid(template, f"{seed}|PORT|{port_id}")
        set_model_ref(symbol, port_id)
        symbol_id = attr(symbol, "id")
        child(symbol, "geometry").text = f"{x}, {y}, 15, 15"
        set_attr(child(symbol, "edge"), "value", "1" if side == "RIGHT" else "3")
        textboxes = [entry for entry in symbol.iter() if entry.get("elementClass") == "TextBox"]
        if textboxes:
            text = next((entry for entry in textboxes[0] if local(entry.tag) == "text"), None)
            if text is not None:
                text.text = self.semantic.port_records[port_id]["name"]
            child(textboxes[0], "geometry").text = f"{x + 18 if side == 'RIGHT' else max(5, x - 180)}, {y - 1}, 175, 12"
        return symbol, symbol_id, (x + 7, y + 7)

    def build_part_symbol(self, part_id: str, port_ids: list[str], x: int, y: int, seed: str, side: str) -> tuple[ET.Element, dict[str, tuple[str, tuple[int, int]]]]:
        symbol, _mapping = clone_reid(self.gold_parts[0], f"{seed}|PART|{part_id}")
        set_model_ref(symbol, part_id)
        owned = child(symbol, "mdOwnedViews")
        for existing in list(owned):
            owned.remove(existing)
        height = max(100, 52 + len(port_ids) * 28)
        child(symbol, "geometry").text = f"{x}, {y}, 320, {height}"
        port_map = {}
        for index, port_id in enumerate(port_ids):
            px = x + 305 if side == "RIGHT" else x
            py = y + 36 + index * 28
            port_symbol, port_symbol_id, center = self.build_port_symbol(port_id, px, py, side, seed)
            owned.append(port_symbol)
            port_map[port_id] = (port_symbol_id, center)
        return symbol, port_map

    def connector_end_ids(self, connector_id: str) -> list[str]:
        connector = self.model_ids[connector_id]
        return [attr(entry, "id") for entry in connector if attr(entry, "type") == "uml:ConnectorEnd"]

    def build_connector_symbol(self, connector_id: str, source: tuple[str, tuple[int, int]], target: tuple[str, tuple[int, int]], seed: str) -> ET.Element:
        symbol, _mapping = clone_reid(self.gold_connector, f"{seed}|CONNECTOR|{connector_id}")
        set_model_ref(symbol, connector_id)
        set_attr(child(symbol, "linkFirstEndID"), "idref", target[0])
        set_attr(child(symbol, "linkSecondEndID"), "idref", source[0])
        sx, sy = source[1]
        tx, ty = target[1]
        mid = (sx + tx) // 2
        child(symbol, "geometry").text = f"{tx}, {ty}; {mid}, {ty}; {mid}, {sy}; {sx}, {sy}; "
        owned = child(symbol, "mdOwnedViews")
        end_symbols = [entry for entry in owned if entry.get("elementClass") == "ConnectorEnd"]
        end_ids = self.connector_end_ids(connector_id)
        assert len(end_symbols) == len(end_ids) == 2
        set_model_ref(end_symbols[0], end_ids[1])
        set_model_ref(end_symbols[1], end_ids[0])
        child(end_symbols[0], "geometry").text = f"{tx - 10}, {ty - 5}, 10, 10"
        child(end_symbols[1], "geometry").text = f"{sx}, {sy - 5}, 10, 10"
        compartments = [entry for entry in symbol if local(entry.tag) == "compartment"]
        assert compartments
        set_attr(compartments[0], "value", "XMI-ITEM-ITM-MEA-005")
        label = next(entry for entry in owned if entry.get("elementClass") == "TextBox")
        next(entry for entry in label if local(entry.tag) == "text").text = "高压线路电压"
        child(label, "geometry").text = f"{mid + 5}, {(sy + ty) // 2 + 8}, 120, 12"
        return symbol

    def diagram_specs(self) -> list[dict]:
        specs = []
        for owner in OWNER_ORDER:
            plan = self.semantic.plan_by_owner[owner]
            segment = self.semantic.trace_segments[owner]
            part_elements = []
            part_ports: dict[str, list[str]] = defaultdict(list)
            frame_ports = []
            for endpoint in (segment["source_endpoint"], segment["target_endpoint"]):
                if endpoint["kind"] == "PART_PORT":
                    part = self.semantic.part_records[(owner, endpoint["element"])]
                    if part not in part_elements:
                        part_elements.append(part)
                    part_ports[part["id"]].append(endpoint["port_xmi_id"])
                elif endpoint["kind"] == "FRAME_PORT":
                    frame_ports.append(endpoint["port_xmi_id"])
            specs.append(
                {
                    "diagram_id": plan["diagram_id"],
                    "diagram_xmi_id": plan["diagram_xmi_id"],
                    "name": plan["name"],
                    "owner": owner,
                    "owner_xmi_id": CONTEXT_XMI if owner == CONTEXT else self.semantic.products[owner]["xmi_id"],
                    "parts": part_elements,
                    "part_ports": dict(part_ports),
                    "frame_ports": frame_ports,
                    "segment": segment,
                }
            )
        return specs

    def create_resource(self, diagram: dict) -> tuple[str, bytes, list[str]]:
        seed = diagram["diagram_id"]
        resource_id = "BINARY-" + uuidish(f"RAIL-MBSE-INTEGRATED-PROBE-V2|{seed}")
        root = ET.Element("mdOwnedViews")
        frame, _mapping = clone_reid(self.gold_frame, f"{seed}|FRAME")
        set_model_ref(frame, diagram["diagram_xmi_id"])
        child(frame, "geometry").text = "5, 5, 1400, 800"
        root.append(frame)
        segment = diagram["segment"]
        port_map: dict[str, tuple[str, tuple[int, int]]] = {}
        for part in diagram["parts"]:
            endpoint_is_source = segment["source_endpoint"]["element"] == part["child_code"]
            side = "RIGHT" if endpoint_is_source else "LEFT"
            x = 120 if endpoint_is_source else 960
            symbol, ports = self.build_part_symbol(part["id"], diagram["part_ports"][part["id"]], x, 300, seed, side)
            root.append(symbol)
            port_map.update(ports)
        for port_id in diagram["frame_ports"]:
            direction = self.port_direction(port_id)
            side = "RIGHT" if direction == "out" else "LEFT"
            x = 1380 if side == "RIGHT" else 5
            symbol, symbol_id, center = self.build_port_symbol(port_id, x, 340, side, seed)
            root.append(symbol)
            port_map[port_id] = (symbol_id, center)
        source = port_map[segment["source_port_xmi_id"]]
        target = port_map[segment["target_port_xmi_id"]]
        connector = self.build_connector_symbol(segment["xmi_id"], source, target, seed)
        root.append(connector)
        styles, style_map = clone_reid(self.gold_styles, f"{seed}|STYLES")
        root.append(styles)
        replace_references(root, style_map)
        used = {
            *(part["id"] for part in diagram["parts"]),
            *port_map.keys(),
            segment["xmi_id"],
            *self.connector_end_ids(segment["xmi_id"]),
        }
        ET.indent(root, space="\t")
        resource_xml = ET.tostring(root, encoding="unicode", short_empty_elements=True)
        resource_xml = re.sub(r"\s+xmlns:xmi=['\"]http://www.omg.org/spec/XMI/20131001['\"]", "", resource_xml, count=1)
        resource_bytes = b"<?xml version='1.0' encoding='UTF-8'?>\n" + resource_xml.encode("utf-8")
        return resource_id, resource_bytes, sorted(used)

    def attach_diagram(self, diagram: dict, resource_id: str, resource_bytes: bytes, used: list[str]) -> None:
        owner = self.model_ids[diagram["owner_xmi_id"]]
        extension, _mapping = clone_reid(self.gold_diagram_extension, f"{diagram['diagram_id']}|MODEL")
        owned = next(entry for entry in extension.iter() if local(entry.tag) == "ownedDiagram")
        set_attr(owned, "id", diagram["diagram_xmi_id"])
        owned.set("name", diagram["name"])
        owned.set("context", diagram["owner_xmi_id"])
        owned.set("ownerOfDiagram", diagram["owner_xmi_id"])
        representation = next(entry for entry in extension.iter() if local(entry.tag) == "DiagramRepresentationObject")
        representation.set("ID", sid("MDREP", diagram["diagram_id"]))
        representation.set("type", "SysML Internal Block Diagram")
        representation.set("umlType", "Internal Block Diagram")
        contents = next(entry for entry in representation if local(entry.tag) == "diagramContents")
        contents.set("contentHash", hashlib.sha1(resource_bytes).hexdigest())
        next(entry for entry in contents if local(entry.tag) == "binaryObject").set("streamContentID", resource_id)
        for entry in list(contents):
            if local(entry.tag) in {"usedObjects", "usedElements"}:
                contents.remove(entry)
        for reference in used:
            obj = ET.SubElement(contents, "usedObjects")
            obj.set("href", f"#{reference}")
        for reference in used:
            element = ET.SubElement(contents, "usedElements")
            element.text = reference
        owner.append(extension)
        self.diagram_info_apps.append(
            f"\t<MagicDraw_Profile:DiagramInfo xmi:id='{sid('XMI-APP-DIAGRAMINFO', diagram['diagram_id'])}' "
            f"base_Diagram='{diagram['diagram_xmi_id']}' Creation_date='2026/9/10 12:00' "
            "Modification_date='2026/9/10 12:00' Author='Rail MBSE deterministic converter' "
            "Last_modified_by='Rail MBSE deterministic converter'/>"
        )

    @staticmethod
    def encoded_project(project_id: str) -> str:
        return "PROJECT$h" + project_id.removeprefix("PROJECT-").replace("-", "$h")

    @staticmethod
    def replace_binary_filepart(text: str, name: str, decoded: str) -> str:
        encoded = base64.b64encode(gzip.compress(decoded.encode("iso-8859-1"), mtime=0)).decode("ascii")
        result, count = re.subn(
            rf"(<filePart name='{re.escape(name)}' type='BINARY'>).*?(</filePart>)",
            rf"\g<1>{encoded}\2",
            text,
            count=1,
            flags=re.DOTALL,
        )
        if count != 1:
            raise AssertionError(f"Could not update {name}")
        return result

    def tail_sections(self, resource_ids: list[str]) -> tuple[str, str, str]:
        gold = GOLD2.read_text(encoding="utf-8")
        model_start = gold.index("\t<uml:Model")
        model_end = gold.index("\n\t</uml:Model>", model_start) + len("\n\t</uml:Model>")
        first_app = min(
            position
            for marker in ("\n\t<sysml:", "\n\t<MD_Customization", "\n\t<MagicDraw_Profile")
            if (position := gold.find(marker, model_end)) >= 0
        )
        tail_start = gold.index("\n\t<xmi:Extension extender='MagicDraw UML 2022x'>", first_app)
        prefix = gold[:model_start]
        registry = gold[model_end:first_app]
        tail = gold[tail_start : gold.rindex("</xmi:XMI>")]
        for resource_id in self.old_diagram_resources:
            tail = re.sub(
                rf"\s*<xmi:Extension extender='MagicDraw UML 2022x'>\s*<filePart name='{re.escape(resource_id)}'.*?</filePart>\s*</xmi:Extension>",
                "",
                tail,
                count=1,
                flags=re.DOTALL,
            )
        old_encoded = self.encoded_project(self.old_project)
        new_encoded = self.encoded_project(self.new_project)
        replacements = {
            self.old_project: self.new_project,
            old_encoded: new_encoded,
            self.old_model_id: MODEL_XMI,
        }
        for old, new in replacements.items():
            prefix = prefix.replace(old, new)
            registry = registry.replace(old, new)
            tail = tail.replace(old, new)
        tail = tail.replace(
            f"xmi:id='{MODEL_XMI}' ID='{MODEL_XMI}' name='{self.old_model_name}'",
            f"xmi:id='{MODEL_XMI}' ID='{MODEL_XMI}' name='{MODEL_NAME}'",
        )
        binaries = "#\r\n#Rail MBSE Integrated Probe v2\r\ncom.nomagic.magicdraw.uml_model.model=" + ",".join(resource_ids) + "\r\n"
        tail = self.replace_binary_filepart(tail, "Binaries.properties", binaries)

        records_part = next(entry for entry in self.gold_root.iter() if local(entry.tag) == "filePart" and entry.get("name") == "Records.properties")
        old_records = gzip.decompress(base64.b64decode((records_part.text or "").strip())).decode("iso-8859-1")
        record_lines = []
        for line in old_records.replace("\r\n", "\n").replace("\r", "\n").split("\n"):
            if not line or line.startswith("#"):
                continue
            key = line.split("=", 1)[0]
            if key in self.old_diagram_resources:
                continue
            line = line.replace(self.old_project, self.new_project).replace(old_encoded, new_encoded)
            record_lines.append(line)
        record_lines.extend(f"{resource_id}={resource_id}" for resource_id in resource_ids)
        records = "#Compatibility entry\r\n#Rail MBSE Integrated Probe v2\r\n" + "\r\n".join(record_lines) + "\r\n"
        tail = self.replace_binary_filepart(tail, "Records.properties", records)
        return prefix, registry, tail

    def build(self) -> tuple[bytes, dict]:
        for diagram in self.diagram_specs():
            resource_id, resource_bytes, used = self.create_resource(diagram)
            self.attach_diagram(diagram, resource_id, resource_bytes, used)
            self.resources.append({"id": resource_id, "bytes": resource_bytes, "diagram": diagram, "used": used})
        ET.indent(self.model, space="  ")
        model_xml = ET.tostring(self.model, encoding="unicode", short_empty_elements=True)
        apps_xml = ["\t" + ET.tostring(app, encoding="unicode", short_empty_elements=True) for app in self.apps]
        apps_xml.extend(self.diagram_info_apps)
        resource_ids = [entry["id"] for entry in self.resources]
        prefix, registry, tail = self.tail_sections(resource_ids)
        resource_sections = []
        for resource in self.resources:
            body = resource["bytes"].decode("utf-8").split("\n", 1)[1]
            resource_sections.append(
                "\t<xmi:Extension extender='MagicDraw UML 2022x'>\n"
                f"\t\t<filePart name='{resource['id']}' type='XML' header='&lt;?xml version=&#39;1.0&#39; encoding=&#39;UTF-8&#39;?&gt;'>\n"
                f"{body}\n"
                "\t\t</filePart>\n"
                "\t</xmi:Extension>"
            )
        result = (
            prefix
            + "\t"
            + model_xml
            + "\n"
            + registry
            + "\n".join(apps_xml)
            + "\n"
            + "\n".join(resource_sections)
            + "\n"
            + tail.lstrip("\n")
            + "\n</xmi:XMI>\n"
        )
        data = result.encode("utf-8")
        manifest = {
            "manifest_id": "RAIL-MBSE-GOLD2-INTEGRATED-4235-5111-PROBE-V2",
            "generation_mode": "NATIVE_MDXML",
            "gold2_read_only_sha256": hashlib.sha256(GOLD2.read_bytes()).hexdigest(),
            "output": str(OUTPUT),
            "sha256": hashlib.sha256(data).hexdigest(),
            "project_id": self.new_project,
            "model_id": MODEL_XMI,
            "counts": {
                "product_blocks": 8,
                "context_blocks": 1,
                "packages": 9,
                "part_properties": len(self.semantic.part_records),
                "proxy_ports": len(self.semantic.port_records),
                "raw_ports": sum(entry["raw_port"] for entry in self.semantic.port_records.values()),
                "promoted_ports": sum(not entry["raw_port"] for entry in self.semantic.port_records.values()),
                "interface_blocks": len(self.semantic.ib_records),
                "flow_properties": len(self.semantic.ib_records),
                "connectors": len(self.semantic.connector_records),
                "information_flows": len(self.semantic.connector_records),
                "item_flows": len(self.semantic.connector_records),
                "ibds": len(self.resources),
                "icd_rows": len(self.semantic.icd_rows),
            },
            "resources": [
                {
                    "diagram": entry["diagram"]["name"],
                    "resource_id": entry["id"],
                    "sha1": hashlib.sha1(entry["bytes"]).hexdigest(),
                    "used_model_elements": len(entry["used"]),
                }
                for entry in self.resources
            ],
            "independent_information_flow_path_count": 0,
            "byte_deterministic": True,
        }
        return data, manifest


def build_bytes() -> tuple[bytes, dict, list[dict]]:
    builder = NativeBuilder()
    data, manifest = builder.build()
    return data, manifest, builder.semantic.icd_rows


def main() -> None:
    first, manifest, rows = build_bytes()
    second, second_manifest, second_rows = build_bytes()
    if first != second or manifest != second_manifest or rows != second_rows:
        raise AssertionError("Integrated Probe generation is not byte deterministic")
    OUTPUT.write_bytes(first)
    MANIFEST.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    ICD_ROWS.write_text(
        json.dumps({"table": "ICD_4235_5111_Trace", "element_type": "Connector", "row_count": len(rows), "rows": rows}, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(json.dumps({"output": str(OUTPUT), "sha256": manifest["sha256"], "counts": manifest["counts"], "deterministic": True}, ensure_ascii=False))


if __name__ == "__main__":
    main()
