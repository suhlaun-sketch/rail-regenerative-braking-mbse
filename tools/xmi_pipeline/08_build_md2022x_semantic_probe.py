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
CONTRACT = PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json"
OUTPUT = WORK_DIR / "Rail_MBSE_SysML17_probe_MD2022x_v3.xmi"

PROBE_PRODUCTS = ("4000", "4200", "4230", "4235", "5000", "5100", "5110", "5111")
PARENTS = {
    "4000": "__CONTEXT__", "4200": "4000", "4230": "4200", "4235": "4230",
    "5000": "__CONTEXT__", "5100": "5000", "5110": "5100", "5111": "5110",
}
CONTEXT_ID = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE-MD2022X-PROBE"


def stable_id(prefix: str, seed: str, length: int = 18) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def safe_name(value: str) -> str:
    return re.sub(r"[^0-9A-Za-z_]+", "_", value).strip("_") or "Element"


class SemanticProbeBuilder:
    def __init__(self, architecture: dict, contract: dict):
        ns = contract["namespace_separation"]
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
        self.contract = contract
        self.product_by_id = {p["id"]: p for p in architecture["products"]}
        self.interface_by_id = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
        self.item_by_id = {i["item_code"]: i for i in architecture["items"]}
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

    def app(self, name: str, identifier: str, **attrs: str) -> ET.Element:
        element = ET.Element(self.qs(name))
        self.xid(element, identifier)
        for key, value in attrs.items():
            if value is not None:
                element.set(key, value)
        self.apps.append(element)
        return element

    def part(self, owner_code: str, child_code: str, owner: ET.Element) -> str:
        identifier = stable_id("XMI-PART", f"MD2022X::{owner_code}::{child_code}")
        prop = ET.SubElement(owner, "ownedAttribute")
        self.xtype(prop, "Property")
        self.xid(prop, identifier)
        prop.set("name", f"part_{child_code}")
        prop.set("type", self.product_by_id[child_code]["xmi_id"])
        prop.set("aggregation", "composite")
        lower = ET.SubElement(prop, "lowerValue")
        self.xtype(lower, "LiteralInteger")
        self.xid(lower, stable_id("XMI-LOWER", identifier))
        lower.set("value", "1")
        upper = ET.SubElement(prop, "upperValue")
        self.xtype(upper, "LiteralUnlimitedNatural")
        self.xid(upper, stable_id("XMI-UPPER", identifier))
        upper.set("value", "1")
        self.part_ids[(owner_code, child_code)] = identifier
        return identifier

    def path(self, product_code: str) -> list[str]:
        chain = []
        current = product_code
        while current != "__CONTEXT__":
            chain.append(current)
            current = PARENTS[current]
        chain.reverse()
        result = []
        owner = "__CONTEXT__"
        for child in chain:
            result.append(self.part_ids[(owner, child)])
            owner = child
        return result

    def build(self) -> bytes:
        connection = next(
            c for c in self.data["connections"]
            if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111"
            and c["item_id"] == "ITM-MEA-005" and c["mode"] == "SIGNAL"
        )
        source_port = self.interface_by_id[connection["source_interface_id"]]
        target_port = self.interface_by_id[connection["target_interface_id"]]
        item = self.item_by_id[connection["item_id"]]
        function = next(f for f in self.data["functions"] if f["function_id"] == "F-4235-01")
        allocation = next(a for a in self.data["allocations"] if a["function_id"] == function["function_id"] and a["product_id"] == "4235")

        root = ET.Element(self.qx("XMI"))
        model = ET.SubElement(root, self.qu("Model"))
        self.xtype(model, "Model")
        self.xid(model, "XMI-MODEL-RAIL-MBSE-MD2022X-SEMANTIC-PROBE-V3")
        model.set("name", "Rail_MBSE_TractionBrake_MD2022x_Semantic_Probe")

        profile_application = ET.SubElement(model, "profileApplication")
        self.xtype(profile_application, "ProfileApplication")
        self.xid(profile_application, "XMI-PROFILEAPPLICATION-SYSML17-MD2022X")
        applied = ET.SubElement(profile_application, "appliedProfile")
        applied.set("href", self.contract["profile_resolution_strategy"]["applied_profile_href"])

        product_library = self.packaged(model, "Package", "XMI-PACKAGE-01-PRODUCTLIBRARY-PROBE", "01_ProductLibrary")
        main_power = self.packaged(product_library, "Package", "XMI-PACKAGE-MAINPOWERSUPPLY-PROBE", "MainPowerSupply")
        traction = self.packaged(product_library, "Package", "XMI-PACKAGE-TRACTION-PROBE", "Traction")
        interfaces_pkg = self.packaged(model, "Package", "XMI-PACKAGE-02-INTERFACES-PROBE", "02_Interfaces")
        ib_pkg = self.packaged(interfaces_pkg, "Package", "XMI-PACKAGE-INTERFACEBLOCKS-PROBE", "InterfaceBlocks")
        signal_pkg = self.packaged(interfaces_pkg, "Package", "XMI-PACKAGE-SIGNALS-PROBE", "Signals")
        behavior_pkg = self.packaged(model, "Package", "XMI-PACKAGE-03-BEHAVIOR-PROBE", "03_Behavior")
        reference_pkg = self.packaged(model, "Package", "XMI-PACKAGE-04-REFERENCE-PROBE", "04_ReferenceArchitecture")
        profile_pkg = self.packaged(reference_pkg, "Package", "XMI-PACKAGE-CRH-AC25KV-SC-PROBE", "CRH_AC25KV_SC")
        connections_pkg = self.packaged(model, "Package", "XMI-PACKAGE-05-CONNECTIONS-PROBE", "05_Connections")
        allocations_pkg = self.packaged(model, "Package", "XMI-PACKAGE-06-ALLOCATIONS-PROBE", "06_Allocations")
        self.packaged(model, "Package", "XMI-PACKAGE-07-VERIFICATION-PROBE", "07_Verification")

        context = self.packaged(profile_pkg, "Class", CONTEXT_ID, "Rail_MBSE_TractionBrake_Context")
        self.app("Block", stable_id("XMI-APP-BLOCK", "MD2022X::CONTEXT"), base_Class=CONTEXT_ID)

        for code in PROBE_PRODUCTS:
            package = main_power if code.startswith("4") else traction
            product = self.product_by_id[code]
            element = self.packaged(package, "Class", product["xmi_id"], product["name"])
            self.product_elements[code] = element
            self.app("Block", stable_id("XMI-APP-BLOCK", f"MD2022X::{code}"), base_Class=product["xmi_id"])

        for code in PROBE_PRODUCTS:
            owner_code = PARENTS[code]
            owner = context if owner_code == "__CONTEXT__" else self.product_elements[owner_code]
            self.part(owner_code, code, owner)

        item_element = self.packaged(signal_pkg, "Signal", item["xmi_id"], item["name_cn"])
        item_comment = ET.SubElement(item_element, "ownedComment")
        self.xtype(item_comment, "Comment")
        self.xid(item_comment, stable_id("XMI-COMMENT-ITEM", item["item_code"]))
        item_comment.set("body", item["semantic_definition"])

        definition_seed = f"{connection['interface_type_id']}::{connection['item_id']}"
        ib_id = stable_id("XMI-IB", definition_seed)
        ib_app_id = stable_id("XMI-APP-INTERFACEBLOCK", f"MD2022X::{definition_seed}")
        flow_id = stable_id("XMI-FLOWPROPERTY", definition_seed)
        ib = self.packaged(ib_pkg, "Class", ib_id, f"IB_{safe_name(connection['interface_type_id'])}_{safe_name(connection['item_id'])}")
        flow = ET.SubElement(ib, "ownedAttribute")
        self.xtype(flow, "Property")
        self.xid(flow, flow_id)
        flow.set("name", f"flow_{safe_name(connection['item_id'])}")
        flow.set("type", item["xmi_id"])
        self.app("InterfaceBlock", ib_app_id, base_Class=ib_id)
        self.app("FlowProperty", stable_id("XMI-APP-FLOWPROPERTY", f"MD2022X::{definition_seed}"), base_Property=flow_id, direction="out")

        conjugated_id = stable_id("XMI-IB-CONJ", definition_seed)
        conjugated = self.packaged(ib_pkg, "Class", conjugated_id, f"~IB_{safe_name(connection['interface_type_id'])}_{safe_name(connection['item_id'])}")
        self.app(
            "tildeInterfaceBlock", stable_id("XMI-APP-TILDEINTERFACEBLOCK", f"MD2022X::{definition_seed}"),
            base_Class=conjugated_id, original=ib_app_id,
        )

        for interface, owner_code, type_id in ((source_port, "4235", ib_id), (target_port, "5111", conjugated_id)):
            port = ET.SubElement(self.product_elements[owner_code], "ownedAttribute")
            self.xtype(port, "Port")
            self.xid(port, interface["xmi_id"])
            port.set("name", interface["name"])
            port.set("type", type_id)
            port.set("isConjugated", "false")
            port.set("isBehavior", "false")
            port.set("isService", "false")
            self.app("ProxyPort", stable_id("XMI-APP-PROXYPORT", f"MD2022X::{interface['interface_instance_id']}"), base_Port=interface["xmi_id"])

        connector = ET.SubElement(context, "ownedConnector")
        self.xtype(connector, "Connector")
        self.xid(connector, connection["xmi_id"])
        connector.set("name", connection["connection_id"])
        for index, (interface, product_code) in enumerate(((source_port, "4235"), (target_port, "5111")), 1):
            end_id = stable_id("XMI-CONNECTOREND", f"MD2022X::{connection['connection_id']}::{index}")
            end = ET.SubElement(connector, "end")
            self.xtype(end, "ConnectorEnd")
            self.xid(end, end_id)
            end.set("role", interface["xmi_id"])
            property_path = self.path(product_code)
            end.set("partWithPort", property_path[-1])
            self.app(
                "NestedConnectorEnd", stable_id("XMI-APP-NESTEDEND", f"MD2022X::{end_id}"),
                base_ConnectorEnd=end_id, propertyPath=" ".join(property_path),
            )

        info_id = stable_id("XMI-INFORMATIONFLOW", f"MD2022X::{connection['connection_id']}")
        info = self.packaged(connections_pkg, "InformationFlow", info_id, f"IF_{connection['connection_id']}")
        info.set("informationSource", source_port["xmi_id"])
        info.set("informationTarget", target_port["xmi_id"])
        info.set("conveyed", item["xmi_id"])
        info.set("realizingConnector", connection["xmi_id"])
        self.app(
            "ItemFlow", stable_id("XMI-APP-ITEMFLOW", f"MD2022X::{connection['connection_id']}"),
            base_InformationFlow=info_id, itemProperty=flow_id,
        )

        activity = self.packaged(behavior_pkg, "Activity", function["xmi_id"], function["name_cn"])
        function_comment = ET.SubElement(activity, "ownedComment")
        self.xtype(function_comment, "Comment")
        self.xid(function_comment, stable_id("XMI-COMMENT-FUNCTION", function["function_id"]))
        function_comment.set("body", function["description"])
        abstraction = self.packaged(allocations_pkg, "Abstraction", allocation["xmi_id"], allocation["allocation_id"])
        abstraction.set("client", function["xmi_id"])
        abstraction.set("supplier", self.product_by_id["4235"]["xmi_id"])
        self.app("Allocate", stable_id("XMI-APP-ALLOCATE", f"MD2022X::{allocation['allocation_id']}"), base_Abstraction=allocation["xmi_id"])

        root.extend(self.apps)
        ET.indent(root, space="  ")
        return ET.tostring(root, encoding="utf-8", xml_declaration=True, short_empty_elements=True) + b"\n"


def build_probe() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    contract = json.loads(CONTRACT.read_text(encoding="utf-8"))
    first = SemanticProbeBuilder(architecture, contract).build()
    second = SemanticProbeBuilder(architecture, contract).build()
    if first != second:
        raise AssertionError("MD2022x semantic Probe is not byte deterministic")
    OUTPUT.write_bytes(first)
    manifest = {
        "path": str(OUTPUT),
        "sha256": hashlib.sha256(first).hexdigest(),
        "byte_deterministic": True,
        "probe_products": list(PROBE_PRODUCTS),
        "full_xmi_published": False,
    }
    (PIPELINE_WORK / "md2022x_probe_build_manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return manifest


def main() -> None:
    manifest = build_probe()
    print(f"MD2022x semantic Probe: {manifest['path']}")
    print(f"SHA256: {manifest['sha256']}")


if __name__ == "__main__":
    main()
