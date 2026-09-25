from __future__ import annotations

import hashlib
import json
import re
import xml.etree.ElementTree as ET
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK_DIR = ROOT / "work"
PIPELINE_WORK = PIPELINE_DIR / "work"
SOURCE = WORK_DIR / "architecture_xmi_ready_v1.json"
COMPATIBILITY = PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json"
DIRECTIONS = PIPELINE_WORK / "port_direction_resolution.json"
OUTPUT = WORK_DIR / "Rail_MBSE_SysML17_structure_probe_v4.xmi"
MANIFEST = PIPELINE_WORK / "structure_probe_v4_manifest.json"

PROBE_PRODUCTS = ("4000", "4200", "4230", "4235", "5000", "5100", "5110", "5111", "5112", "5113")
PARENTS = {
    "4000": "__CONTEXT__",
    "4200": "4000",
    "4230": "4200",
    "4235": "4230",
    "5000": "__CONTEXT__",
    "5100": "5000",
    "5110": "5100",
    "5111": "5110",
    "5112": "5110",
    "5113": "5110",
}
CONTEXT_ID = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE-STRUCTURE-PROBE-V4"


def stable_id(prefix: str, seed: str, length: int = 18) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def safe_name(value: str) -> str:
    return re.sub(r"[^0-9A-Za-z_]+", "_", value).strip("_") or "Element"


class StructureProbeBuilder:
    def __init__(self, architecture: dict, compatibility: dict, direction_data: dict):
        ns = compatibility["namespace_separation"]
        self.XMI = ns["xmi_xml_namespace"]
        self.UML = ns["uml_xml_namespace"]
        self.SYSML = ns["sysml_stereotype_namespace"]
        ET.register_namespace("xmi", self.XMI)
        ET.register_namespace("uml", self.UML)
        ET.register_namespace("sysml", self.SYSML)
        self.qx = lambda local: f"{{{self.XMI}}}{local}"
        self.qu = lambda local: f"{{{self.UML}}}{local}"
        self.qs = lambda local: f"{{{self.SYSML}}}{local}"
        self.data = architecture
        self.compatibility = compatibility
        self.products = {p["id"]: p for p in architecture["products"]}
        self.interfaces = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
        self.items = {i["item_code"]: i for i in architecture["items"]}
        self.direction_by_interface = {r["interface_instance_id"]: r for r in direction_data["records"]}
        self.product_elements: dict[str, ET.Element] = {}
        self.part_ids: dict[tuple[str, str], str] = {}
        self.apps: list[ET.Element] = []

    def xid(self, element: ET.Element, identifier: str) -> None:
        element.set(self.qx("id"), identifier)

    def xtype(self, element: ET.Element, uml_type: str) -> None:
        element.set(self.qx("type"), f"uml:{uml_type}")

    def packaged(self, parent: ET.Element, uml_type: str, identifier: str, name: str) -> ET.Element:
        element = ET.SubElement(parent, "packagedElement")
        self.xtype(element, uml_type)
        self.xid(element, identifier)
        element.set("name", name)
        return element

    def stereotype(self, name: str, identifier: str, **references: str) -> None:
        application = ET.Element(self.qs(name))
        self.xid(application, identifier)
        for key, value in references.items():
            application.set(key, value)
        self.apps.append(application)

    def add_part(self, owner_code: str, child_code: str, owner: ET.Element) -> str:
        part_id = stable_id("XMI-PART", f"STRUCTURE-PROBE-V4::{owner_code}::{child_code}")
        prop = ET.SubElement(owner, "ownedAttribute")
        self.xtype(prop, "Property")
        self.xid(prop, part_id)
        prop.set("name", f"part_{child_code}")
        prop.set("type", self.products[child_code]["xmi_id"])
        prop.set("aggregation", "composite")
        lower = ET.SubElement(prop, "lowerValue")
        self.xtype(lower, "LiteralInteger")
        self.xid(lower, stable_id("XMI-LOWER", part_id))
        lower.set("value", "1")
        upper = ET.SubElement(prop, "upperValue")
        self.xtype(upper, "LiteralUnlimitedNatural")
        self.xid(upper, stable_id("XMI-UPPER", part_id))
        upper.set("value", "1")
        self.part_ids[(owner_code, child_code)] = part_id
        return part_id

    def path_to(self, product_code: str) -> list[str]:
        codes: list[str] = []
        cursor = product_code
        while cursor != "__CONTEXT__":
            codes.append(cursor)
            cursor = PARENTS[cursor]
        codes.reverse()
        result: list[str] = []
        owner = "__CONTEXT__"
        for child in codes:
            result.append(self.part_ids[(owner, child)])
            owner = child
        return result

    def add_directional_interface_block(self, package: ET.Element, interface: dict) -> tuple[str, str]:
        resolution = self.direction_by_interface[interface["interface_instance_id"]]
        ib_id = resolution["interface_block_id"]
        flow_id = resolution["flow_property_id"]
        direction = resolution["flow_property_direction"]
        item = self.items[interface["item_id"]]
        ib = self.packaged(
            package,
            "Class",
            ib_id,
            f"IB_{safe_name(interface['interface_type_id'])}_{safe_name(interface['item_id'])}_{direction.upper()}",
        )
        flow = ET.SubElement(ib, "ownedAttribute")
        self.xtype(flow, "Property")
        self.xid(flow, flow_id)
        flow.set("name", f"flow_{safe_name(interface['item_id'])}")
        flow.set("type", item["xmi_id"])
        self.stereotype(
            "InterfaceBlock",
            stable_id("XMI-APP-INTERFACEBLOCK", f"STRUCTURE-PROBE-V4::{ib_id}"),
            base_Class=ib_id,
        )
        self.stereotype(
            "FlowProperty",
            stable_id("XMI-APP-FLOWPROPERTY", f"STRUCTURE-PROBE-V4::{flow_id}"),
            base_Property=flow_id,
            direction=direction,
        )
        comment = ET.SubElement(ib, "ownedComment")
        self.xtype(comment, "Comment")
        self.xid(comment, stable_id("XMI-COMMENT-IB-TRACE", ib_id))
        comment.set(
            "body",
            f"Canonical interface_type_id={interface['interface_type_id']}; item_id={interface['item_id']}; effective_direction={direction}",
        )
        return ib_id, flow_id

    def build(self) -> bytes:
        connection = next(
            c for c in self.data["connections"]
            if c["source_product_id"] == "4235"
            and c.get("target_product_id") == "5111"
            and c["item_id"] == "ITM-MEA-005"
            and c["mode"] == "SIGNAL"
        )
        source_port = self.interfaces[connection["source_interface_id"]]
        target_port = self.interfaces[connection["target_interface_id"]]
        item = self.items[connection["item_id"]]
        function = next(f for f in self.data["functions"] if f["function_id"] == "F-4235-01")
        allocation = next(
            a for a in self.data["allocations"]
            if a["function_id"] == function["function_id"] and a["product_id"] == "4235"
        )

        root = ET.Element(self.qx("XMI"))
        model = ET.SubElement(root, self.qu("Model"))
        self.xtype(model, "Model")
        self.xid(model, "XMI-MODEL-RAIL-MBSE-STRUCTURE-PROBE-V4")
        model.set("name", "Rail_MBSE_TractionBrake_Structure_Probe_v4")

        profile_application = ET.SubElement(model, "profileApplication")
        self.xtype(profile_application, "ProfileApplication")
        self.xid(profile_application, "XMI-PROFILEAPPLICATION-SYSML17-STRUCTURE-PROBE-V4")
        applied = ET.SubElement(profile_application, "appliedProfile")
        applied.set("href", self.compatibility["profile_resolution_strategy"]["applied_profile_href"])

        library = self.packaged(model, "Package", "XMI-PACKAGE-01-PRODUCTLIBRARY-STRUCTURE-PROBE-V4", "01_ProductLibrary")
        main_power = self.packaged(library, "Package", "XMI-PACKAGE-MAINPOWERSUPPLY-STRUCTURE-PROBE-V4", "MainPowerSupply")
        traction = self.packaged(library, "Package", "XMI-PACKAGE-TRACTION-STRUCTURE-PROBE-V4", "Traction")
        interfaces_pkg = self.packaged(model, "Package", "XMI-PACKAGE-02-INTERFACES-STRUCTURE-PROBE-V4", "02_Interfaces")
        ib_pkg = self.packaged(interfaces_pkg, "Package", "XMI-PACKAGE-INTERFACEBLOCKS-STRUCTURE-PROBE-V4", "InterfaceBlocks")
        signal_pkg = self.packaged(interfaces_pkg, "Package", "XMI-PACKAGE-SIGNALS-STRUCTURE-PROBE-V4", "Signals")
        behavior_pkg = self.packaged(model, "Package", "XMI-PACKAGE-03-BEHAVIOR-STRUCTURE-PROBE-V4", "03_Behavior")
        reference_pkg = self.packaged(model, "Package", "XMI-PACKAGE-04-REFERENCE-STRUCTURE-PROBE-V4", "04_ReferenceArchitecture")
        reference_instance = self.packaged(reference_pkg, "Package", "XMI-PACKAGE-CRH-AC25KV-SC-STRUCTURE-PROBE-V4", "CRH_AC25KV_SC")
        connections_pkg = self.packaged(model, "Package", "XMI-PACKAGE-05-CONNECTIONS-STRUCTURE-PROBE-V4", "05_Connections")
        allocations_pkg = self.packaged(model, "Package", "XMI-PACKAGE-06-ALLOCATIONS-STRUCTURE-PROBE-V4", "06_Allocations")

        context = self.packaged(reference_instance, "Class", CONTEXT_ID, "Rail_MBSE_TractionBrake_Context")
        self.stereotype("Block", stable_id("XMI-APP-BLOCK", "STRUCTURE-PROBE-V4::CONTEXT"), base_Class=CONTEXT_ID)

        for code in PROBE_PRODUCTS:
            package = main_power if code.startswith("4") else traction
            product = self.products[code]
            product_element = self.packaged(package, "Class", product["xmi_id"], product["name"])
            self.product_elements[code] = product_element
            self.stereotype(
                "Block",
                stable_id("XMI-APP-BLOCK", f"STRUCTURE-PROBE-V4::{code}"),
                base_Class=product["xmi_id"],
            )

        for code in PROBE_PRODUCTS:
            owner_code = PARENTS[code]
            owner = context if owner_code == "__CONTEXT__" else self.product_elements[owner_code]
            self.add_part(owner_code, code, owner)

        item_element = self.packaged(signal_pkg, "Signal", item["xmi_id"], item["name_cn"])
        item_comment = ET.SubElement(item_element, "ownedComment")
        self.xtype(item_comment, "Comment")
        self.xid(item_comment, stable_id("XMI-COMMENT-ITEM", f"STRUCTURE-PROBE-V4::{item['item_code']}"))
        item_comment.set("body", item["semantic_definition"])

        source_ib_id, source_flow_id = self.add_directional_interface_block(ib_pkg, source_port)
        target_ib_id, _target_flow_id = self.add_directional_interface_block(ib_pkg, target_port)

        for interface, product_code, interface_block_id in (
            (source_port, "4235", source_ib_id),
            (target_port, "5111", target_ib_id),
        ):
            port = ET.SubElement(self.product_elements[product_code], "ownedAttribute")
            self.xtype(port, "Port")
            self.xid(port, interface["xmi_id"])
            port.set("name", interface["name"])
            port.set("type", interface_block_id)
            port.set("isConjugated", "false")
            port.set("isBehavior", "false")
            port.set("isService", "false")
            self.stereotype(
                "ProxyPort",
                stable_id("XMI-APP-PROXYPORT", f"STRUCTURE-PROBE-V4::{interface['interface_instance_id']}"),
                base_Port=interface["xmi_id"],
            )

        connector = ET.SubElement(context, "ownedConnector")
        self.xtype(connector, "Connector")
        self.xid(connector, connection["xmi_id"])
        connector.set("name", connection["connection_id"])
        for index, (interface, product_code) in enumerate(((source_port, "4235"), (target_port, "5111")), 1):
            end_id = stable_id("XMI-CONNECTOREND", f"STRUCTURE-PROBE-V4::{connection['connection_id']}::{index}")
            end = ET.SubElement(connector, "end")
            self.xtype(end, "ConnectorEnd")
            self.xid(end, end_id)
            end.set("role", interface["xmi_id"])
            property_path = self.path_to(product_code)
            end.set("partWithPort", property_path[-1])
            self.stereotype(
                "NestedConnectorEnd",
                stable_id("XMI-APP-NESTEDEND", f"STRUCTURE-PROBE-V4::{end_id}"),
                base_ConnectorEnd=end_id,
                propertyPath=" ".join(property_path),
            )

        info_id = stable_id("XMI-INFORMATIONFLOW", f"STRUCTURE-PROBE-V4::{connection['connection_id']}")
        information_flow = self.packaged(connections_pkg, "InformationFlow", info_id, f"IF_{connection['connection_id']}")
        information_flow.set("informationSource", source_port["xmi_id"])
        information_flow.set("informationTarget", target_port["xmi_id"])
        information_flow.set("conveyed", item["xmi_id"])
        information_flow.set("realizingConnector", connection["xmi_id"])
        self.stereotype(
            "ItemFlow",
            stable_id("XMI-APP-ITEMFLOW", f"STRUCTURE-PROBE-V4::{connection['connection_id']}"),
            base_InformationFlow=info_id,
            itemProperty=source_flow_id,
        )

        activity = self.packaged(behavior_pkg, "Activity", function["xmi_id"], function["name_cn"])
        function_comment = ET.SubElement(activity, "ownedComment")
        self.xtype(function_comment, "Comment")
        self.xid(function_comment, stable_id("XMI-COMMENT-FUNCTION", f"STRUCTURE-PROBE-V4::{function['function_id']}"))
        function_comment.set("body", function["description"])
        abstraction = self.packaged(allocations_pkg, "Abstraction", allocation["xmi_id"], allocation["allocation_id"])
        abstraction.set("client", function["xmi_id"])
        abstraction.set("supplier", self.products["4235"]["xmi_id"])
        self.stereotype(
            "Allocate",
            stable_id("XMI-APP-ALLOCATE", f"STRUCTURE-PROBE-V4::{allocation['allocation_id']}"),
            base_Abstraction=allocation["xmi_id"],
        )

        root.extend(self.apps)
        ET.indent(root, space="  ")
        return ET.tostring(root, encoding="utf-8", xml_declaration=True, short_empty_elements=True) + b"\n"


def build_probe() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    compatibility = json.loads(COMPATIBILITY.read_text(encoding="utf-8"))
    directions = json.loads(DIRECTIONS.read_text(encoding="utf-8"))
    first = StructureProbeBuilder(architecture, compatibility, directions).build()
    second = StructureProbeBuilder(architecture, compatibility, directions).build()
    if first != second:
        raise AssertionError("Structure Probe v4 generation is not byte deterministic")
    OUTPUT.write_bytes(first)
    manifest = {
        "path": str(OUTPUT),
        "sha256": hashlib.sha256(first).hexdigest(),
        "byte_deterministic": True,
        "probe_product_blocks": len(PROBE_PRODUCTS),
        "probe_context_blocks": 1,
        "probe_composite_parts": len(PROBE_PRODUCTS),
        "probe_proxy_ports": 2,
        "probe_directional_interface_blocks": 2,
        "full_xmi_published": False,
    }
    MANIFEST.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return manifest


def main() -> None:
    print(json.dumps(build_probe(), ensure_ascii=False))


if __name__ == "__main__":
    main()
