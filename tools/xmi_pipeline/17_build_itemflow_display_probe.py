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
V5 = WORK / "Rail_MBSE_SysML17_itemflow_probe_v5.xmi"
OUTPUT = WORK / "Rail_MBSE_SysML17_itemflow_probe_v6.xmi"
CONTRACT_V2 = PIPELINE_WORK / "itemflow_mapping_contract_v2.json"
COMPATIBILITY = PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json"
PRESENTATION_CONTRACT = PIPELINE_WORK / "magicdraw_itemflow_presentation_contract_v6.json"
MANIFEST = PIPELINE_WORK / "itemflow_probe_v6_manifest.json"


SAMPLE = Path(r"C:\Program Files\MagicDraw\samples\MagicGrid\Sample by Cells\1 Problem Domain\1 Black Box\4_VehicleCCU_B3_final.mdzip")
SAMPLE_BINARY = "BINARY-6fb379b5-7d34-4e7a-a8b8-75f5da330cbb"


def stable_id(prefix: str, seed: str, length: int = 18) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def build_presentation_contract(architecture: dict, mapping_contract: dict) -> dict:
    connection = next(
        c for c in architecture["connections"]
        if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111"
        and c["item_id"] == "ITM-MEA-005" and c["mode"] == "SIGNAL"
    )
    mapping = next(row for row in mapping_contract["mappings"] if row["connection_id"] == connection["connection_id"])
    contract = {
        "contract_id": "RAIL-MBSE-MAGICDRAW-ITEMFLOW-PRESENTATION-V6",
        "target_tool": "MagicDraw 2022x",
        "semantic_probe_connection": {
            "connection_id": connection["connection_id"],
            "connector_xmi_id": connection["xmi_id"],
            "information_flow_xmi_id": mapping["information_flow_xmi_id"],
            "item_flow_application_xmi_id": mapping["item_flow_application_xmi_id"],
            "source_port_xmi_id": mapping["source_port_xmi_id"],
            "target_port_xmi_id": mapping["target_port_xmi_id"],
            "conveyed_signal_xmi_id": mapping["conveyed_classifier_xmi_id"],
            "label": mapping["signal_name_cn"],
        },
        "installed_golden_sample": {
            "path": str(SAMPLE),
            "diagram_resource": SAMPLE_BINARY,
            "resource_format": "XML mdOwnedViews stored as a MagicDraw native project resource",
            "observed_connector_symbol": {
                "elementClass": "Connector",
                "elementID": "references uml:Connector",
                "line": "solid Connector symbol",
                "conveyed_compartments": ["CONVEYED_INFORMATION_A", "CONVEYED_INFORMATION_B"],
                "direction_binding": "The conveyed side A/B is selected from Connector graphical end ordering.",
                "label_symbol": "Connector-owned TextBox referenced by linkConveyedAID or linkConveyedBID",
                "information_flow_symbol": "ABSENT",
            },
            "observed_visibility_properties": {
                "SHOW_CONVEYED_A": True,
                "SHOW_CONVEYED_B": True,
                "SHOW_NAME_OF_INFORMATION_FLOW": False,
                "SHOW_ID_OF_INFORMATION_FLOW": False,
            },
        },
        "desired_projection": {
            "diagram_type": "SysML Internal Block Diagram",
            "connector_symbol": "REQUIRED_SOLID",
            "independent_information_flow_symbol": "FORBIDDEN",
            "conveyed_item_compartment": "CONVEYED_INFORMATION_B when source is graphical first end and target is graphical second end",
            "itemflow_marker": "BLACK_SOURCE_TO_TARGET",
            "label": "conveyed uml:Signal.name",
            "show_conveyed": True,
            "show_information_flow_name": False,
            "show_information_flow_id": False,
            "show_technical_item_code_as_primary_label": False,
        },
        "serialization_decision": {
            "standard_xmi_model_layer": "GENERATED",
            "vendor_diagram_resource_embedded_in_xmi": False,
            "reason": (
                "MagicDraw 2022x native diagram symbols are stored as separate project resources and are "
                "combined only by native .mdxml/.xml serialization or mdzip packaging. The requested standard "
                ".xmi Probe therefore carries the complete Connector/InformationFlow/ItemFlow model semantics "
                "without inventing an incomplete streamContentID resource."
            ),
            "status": "PRESENTATION_STILL_NEEDS_ADJUSTMENT",
            "next_safe_step": "Import the Probe, create/show the Connector in an IBD, and apply this conveyed-information display contract; save a minimal native .mdxml golden sample for deterministic presentation serialization.",
        },
        "full_xmi_published": False,
    }
    PRESENTATION_CONTRACT.write_text(json.dumps(contract, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return contract


def transform(architecture: dict, mapping_contract: dict, compatibility: dict) -> bytes:
    ns = compatibility["namespace_separation"]
    XMI = ns["xmi_xml_namespace"]
    UML = ns["uml_xml_namespace"]
    SYSML = ns["sysml_stereotype_namespace"]
    ET.register_namespace("xmi", XMI)
    ET.register_namespace("uml", UML)
    ET.register_namespace("sysml", SYSML)
    qx = lambda name: f"{{{XMI}}}{name}"
    qu = lambda name: f"{{{UML}}}{name}"
    qs = lambda name: f"{{{SYSML}}}{name}"

    root = ET.parse(V5).getroot()
    model = next(element for element in root if element.tag == qu("Model"))
    model.set(qx("id"), "XMI-MODEL-RAIL-MBSE-ITEMFLOW-DISPLAY-PROBE-V6")
    model.set("name", "Rail_MBSE_TractionBrake_ItemFlow_Display_Probe_v6")

    connection = next(
        c for c in architecture["connections"]
        if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111"
        and c["item_id"] == "ITM-MEA-005" and c["mode"] == "SIGNAL"
    )
    mapping = next(row for row in mapping_contract["mappings"] if row["connection_id"] == connection["connection_id"])
    information_flow = next(
        element for element in root.iter()
        if element.get(qx("type")) == "uml:InformationFlow"
        and element.get(qx("id")) == mapping["information_flow_xmi_id"]
    )

    # Match the installed MagicDraw 2022x hand-authored serialization: explicit
    # reference children make Direction, Conveyed, Source/Target, and realizing
    # Connector visible in the InformationFlow specification.
    for field in ("conveyed", "informationSource", "informationTarget", "realizingConnector"):
        information_flow.attrib.pop(field, None)
        for existing in [child for child in information_flow if child.tag.rsplit("}", 1)[-1] == field]:
            information_flow.remove(existing)
        ref = ET.SubElement(information_flow, field)
        ref.set(qx("idref"), mapping["information_flow"][field])

    information_flow.set("name", mapping["signal_name_cn"])
    item_flow = next(
        element for element in root
        if element.tag == qs("ItemFlow") and element.get("base_InformationFlow") == mapping["information_flow_xmi_id"]
    )
    item_flow.attrib.pop("itemProperty", None)

    connector = next(
        element for element in root.iter()
        if element.get(qx("type")) == "uml:Connector" and element.get(qx("id")) == connection["xmi_id"]
    )
    # Keep the structural line unnamed so the conveyed Chinese Signal is the
    # primary visual label. The stable connection ID remains in its Comment.
    connector.attrib.pop("name", None)

    ET.indent(root, space="  ")
    return ET.tostring(root, encoding="utf-8", xml_declaration=True, short_empty_elements=True) + b"\n"


def build() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    mapping_contract = json.loads(CONTRACT_V2.read_text(encoding="utf-8"))
    compatibility = json.loads(COMPATIBILITY.read_text(encoding="utf-8"))
    presentation = build_presentation_contract(architecture, mapping_contract)
    first = transform(architecture, mapping_contract, compatibility)
    second = transform(architecture, mapping_contract, compatibility)
    if first != second:
        raise AssertionError("ItemFlow display Probe v6 is not byte deterministic")
    OUTPUT.write_bytes(first)
    result = {
        "path": str(OUTPUT),
        "sha256": hashlib.sha256(first).hexdigest(),
        "byte_deterministic": True,
        "source_probe": str(V5),
        "presentation_contract": str(PRESENTATION_CONTRACT),
        "presentation_status": presentation["serialization_decision"]["status"],
        "block_part_port_structure_changed": False,
        "full_xmi_published": False,
    }
    MANIFEST.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return result


def main() -> None:
    print(json.dumps(build(), ensure_ascii=False))


if __name__ == "__main__":
    main()
