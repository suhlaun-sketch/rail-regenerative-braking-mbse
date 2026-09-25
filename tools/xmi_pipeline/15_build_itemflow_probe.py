from __future__ import annotations

import hashlib
import json
import xml.etree.ElementTree as ET
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
PIPELINE_WORK = PIPELINE_DIR / "work"
WORK = ROOT / "work"
SOURCE = WORK / "architecture_xmi_ready_v1.json"
BASE_PROBE = WORK / "Rail_MBSE_SysML17_structure_probe_v4.xmi"
OUTPUT = WORK / "Rail_MBSE_SysML17_itemflow_probe_v5.xmi"
COMPATIBILITY = PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json"
HUMAN_NAMES = PIPELINE_WORK / "interface_human_name_map.json"
ITEMFLOW_CONTRACT = PIPELINE_WORK / "itemflow_mapping_contract_v2.json"
MANIFEST = PIPELINE_WORK / "itemflow_probe_v5_manifest.json"


def stable_id(prefix: str, seed: str, length: int = 18) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def transform() -> bytes:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    compatibility = json.loads(COMPATIBILITY.read_text(encoding="utf-8"))
    human_names = json.loads(HUMAN_NAMES.read_text(encoding="utf-8"))
    itemflow_contract = json.loads(ITEMFLOW_CONTRACT.read_text(encoding="utf-8"))
    ns = compatibility["namespace_separation"]
    XMI = ns["xmi_xml_namespace"]
    UML = ns["uml_xml_namespace"]
    SYSML = ns["sysml_stereotype_namespace"]
    ET.register_namespace("xmi", XMI)
    ET.register_namespace("uml", UML)
    ET.register_namespace("sysml", SYSML)
    qx = lambda local: f"{{{XMI}}}{local}"
    qu = lambda local: f"{{{UML}}}{local}"
    qs = lambda local: f"{{{SYSML}}}{local}"

    tree = ET.parse(BASE_PROBE)
    root = tree.getroot()
    ids = {element.get(qx("id")): element for element in root.iter() if element.get(qx("id"))}
    model = next(element for element in root if element.tag == qu("Model"))
    model.set(qx("id"), "XMI-MODEL-RAIL-MBSE-ITEMFLOW-PROBE-V5")
    model.set("name", "Rail_MBSE_TractionBrake_ItemFlow_Probe_v5")

    connection = next(
        c for c in architecture["connections"]
        if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111"
        and c["item_id"] == "ITM-MEA-005" and c["mode"] == "SIGNAL"
    )
    item = next(i for i in architecture["items"] if i["item_code"] == connection["item_id"])
    mapping = next(row for row in itemflow_contract["mappings"] if row["connection_id"] == connection["connection_id"])
    signal = ids[item["xmi_id"]]
    signal.set("name", item["name_cn"])

    connector = ids[connection["xmi_id"]]
    connector.attrib.pop("name", None)
    connector_comment = ET.SubElement(connector, "ownedComment")
    connector_comment.set(qx("type"), "uml:Comment")
    connector_comment.set(qx("id"), stable_id("XMI-COMMENT-CONNECTOR-CODE", f"ITEMFLOW-V5::{connection['connection_id']}"))
    connector_comment.set("body", f"connection_id={connection['connection_id']}")

    old_information_flow = next(
        element for element in root.iter()
        if element.get(qx("type")) == "uml:InformationFlow" and element.get("realizingConnector") == connection["xmi_id"]
    )
    old_info_id = old_information_flow.get(qx("id"))
    new_info_id = mapping["information_flow_xmi_id"]
    old_information_flow.set(qx("id"), new_info_id)
    old_information_flow.set("name", item["name_cn"])
    old_information_flow.set("informationSource", mapping["information_flow"]["informationSource"])
    old_information_flow.set("informationTarget", mapping["information_flow"]["informationTarget"])
    old_information_flow.set("conveyed", mapping["information_flow"]["conveyed"])
    old_information_flow.set("realizingConnector", mapping["information_flow"]["realizingConnector"])

    itemflow_app = next(element for element in root if element.tag == qs("ItemFlow"))
    itemflow_app.set(qx("id"), mapping["item_flow_application_xmi_id"])
    itemflow_app.set("base_InformationFlow", new_info_id)
    itemflow_app.attrib.pop("itemProperty", None)
    if old_info_id != new_info_id:
        for element in root.iter():
            for key, value in list(element.attrib.items()):
                if key != "base_InformationFlow" and value == old_info_id:
                    element.set(key, new_info_id)

    name_by_ib = {row["interface_block_id"]: row for row in human_names["interface_blocks"]}
    probe_ib_ids = {
        interface.get("type")
        for interface in root.iter()
        if interface.get(qx("type")) == "uml:Port"
    }
    for interface_block_id in sorted(probe_ib_ids):
        ib = ids[interface_block_id]
        mapping_name = name_by_ib[interface_block_id]
        ib.set("name", mapping_name["name_cn"])
        for metadata in mapping_name["metadata_properties"]:
            prop = ET.SubElement(ib, "ownedAttribute")
            prop.set(qx("type"), "uml:Property")
            prop.set(qx("id"), metadata["xmi_id"])
            prop.set("name", metadata["name"])
            type_ref = ET.SubElement(prop, "type")
            type_ref.set("href", metadata["uml_type_href"])
            default = ET.SubElement(prop, "defaultValue")
            default.set(qx("type"), "uml:LiteralString")
            default.set(qx("id"), metadata["default_value_xmi_id"])
            default.set("value", metadata["value"])

    ET.indent(root, space="  ")
    return ET.tostring(root, encoding="utf-8", xml_declaration=True, short_empty_elements=True) + b"\n"


def build() -> dict:
    first = transform()
    second = transform()
    if first != second:
        raise AssertionError("ItemFlow Probe v5 is not byte deterministic")
    OUTPUT.write_bytes(first)
    result = {
        "path": str(OUTPUT),
        "sha256": hashlib.sha256(first).hexdigest(),
        "byte_deterministic": True,
        "based_on": str(BASE_PROBE),
        "block_part_hierarchy_changed": False,
        "port_count_changed": False,
        "vendor_diagram_presentation_serialized": False,
        "full_xmi_published": False,
    }
    MANIFEST.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return result


def main() -> None:
    print(json.dumps(build(), ensure_ascii=False))


if __name__ == "__main__":
    main()
