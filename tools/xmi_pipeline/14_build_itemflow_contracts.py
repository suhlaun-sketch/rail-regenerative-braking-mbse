from __future__ import annotations

import hashlib
import json
import re
import zipfile
from collections import defaultdict
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
PIPELINE_WORK = PIPELINE_DIR / "work"
DIRECTIONS = PIPELINE_WORK / "port_direction_resolution.json"
SAMPLE = Path(r"C:\Program Files\MagicDraw\samples\MagicGrid\Sample by Cells\1 Problem Domain\1 Black Box\4_VehicleCCU_B3_final.mdzip")
SAMPLE_MEMBER = "com.nomagic.magicdraw.uml_model.model"


def stable_id(prefix: str, seed: str, length: int = 18) -> str:
    return f"{prefix}-{hashlib.sha1(seed.encode('utf-8')).hexdigest()[:length].upper()}"


def has_cjk(value: str) -> bool:
    return bool(re.search(r"[\u3400-\u9fff]", value or ""))


def write_json(path: Path, value: object) -> None:
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def build() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    direction_data = json.loads(DIRECTIONS.read_text(encoding="utf-8"))
    interface_by_id = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
    item_by_id = {i["item_code"]: i for i in architecture["items"]}
    direction_by_interface = {r["interface_instance_id"]: r for r in direction_data["records"]}

    groups: defaultdict[str, list[dict]] = defaultdict(list)
    for interface in architecture["interfaces"]:
        resolution = direction_by_interface[interface["interface_instance_id"]]
        groups[resolution["interface_block_id"]].append(interface)

    human_names = []
    suffix = {"in": "输入接口", "out": "输出接口", "inout": "双向接口"}
    direction_code = {"in": "IN", "out": "OUT", "inout": "INOUT"}
    for interface_block_id in sorted(groups):
        interfaces = groups[interface_block_id]
        first = sorted(interfaces, key=lambda row: row["interface_instance_id"])[0]
        resolution = direction_by_interface[first["interface_instance_id"]]
        effective = resolution["effective_port_direction"]
        item = item_by_id[first["item_id"]]
        port_types = sorted({row["port_type_id"] for row in interfaces})
        if len(port_types) != 1:
            raise AssertionError(f"Directional InterfaceBlock {interface_block_id} has multiple port types: {port_types}")
        metadata_values = {
            "interface_type_code": first["interface_type_id"],
            "item_code": first["item_id"],
            "port_type_code": port_types[0],
            "direction_code": direction_code[effective],
        }
        human_names.append(
            {
                "interface_block_id": interface_block_id,
                "flow_property_id": resolution["flow_property_id"],
                "name_cn": f"{item['name_cn']}{suffix[effective]}",
                "canonical_item_name_cn": item["name_cn"],
                "effective_direction": effective,
                "interface_type_code": first["interface_type_id"],
                "item_code": first["item_id"],
                "port_type_code": port_types[0],
                "direction_code": direction_code[effective],
                "metadata_properties": [
                    {
                        "name": name,
                        "value": value,
                        "xmi_id": stable_id("XMI-IB-METADATA", f"ITEMFLOW-V2::{interface_block_id}::{name}"),
                        "default_value_xmi_id": stable_id("XMI-IB-METADATA-DEFAULT", f"ITEMFLOW-V2::{interface_block_id}::{name}"),
                        "uml_type_href": "http://www.omg.org/spec/UML/20131001/PrimitiveTypes.xmi#String",
                    }
                    for name, value in metadata_values.items()
                ],
                "port_instance_count": len(interfaces),
                "human_name_has_cjk": has_cjk(f"{item['name_cn']}{suffix[effective]}"),
            }
        )

    human_name_map = {
        "map_id": "RAIL-MBSE-INTERFACE-HUMAN-NAME-MAP-V2",
        "source": str(SOURCE),
        "naming_rule": {
            "in": "<Item Chinese name>输入接口",
            "out": "<Item Chinese name>输出接口",
            "inout": "<Item Chinese name>双向接口",
        },
        "technical_identity": "Stable xmi:id plus four standard UML String-valued metadata Properties; no custom stereotype.",
        "statistics": {
            "interface_blocks": len(human_names),
            "human_chinese_names": sum(row["human_name_has_cjk"] for row in human_names),
            "metadata_complete_interface_blocks": sum(len(row["metadata_properties"]) == 4 for row in human_names),
            "metadata_properties": sum(len(row["metadata_properties"]) for row in human_names),
        },
        "interface_blocks": human_names,
    }
    write_json(PIPELINE_WORK / "interface_human_name_map.json", human_name_map)

    signal_connections = sorted(
        (connection for connection in architecture["connections"] if connection["mode"] == "SIGNAL"),
        key=lambda row: row["connection_id"],
    )
    mappings = []
    for connection in signal_connections:
        source = interface_by_id[connection["source_interface_id"]]
        target = interface_by_id[connection["target_interface_id"]]
        source_direction = direction_by_interface[source["interface_instance_id"]]["effective_port_direction"]
        target_direction = direction_by_interface[target["interface_instance_id"]]["effective_port_direction"]
        item = item_by_id[connection["item_id"]]
        information_flow_id = stable_id("XMI-INFORMATIONFLOW", f"ITEMFLOW-V2::{connection['connection_id']}")
        mappings.append(
            {
                "connection_id": connection["connection_id"],
                "connector_xmi_id": connection["xmi_id"],
                "information_flow_xmi_id": information_flow_id,
                "item_flow_application_xmi_id": stable_id("XMI-APP-ITEMFLOW", f"ITEMFLOW-V2::{connection['connection_id']}"),
                "source_interface_instance_id": source["interface_instance_id"],
                "source_port_xmi_id": source["xmi_id"],
                "source_effective_direction": source_direction,
                "target_interface_instance_id": target["interface_instance_id"],
                "target_port_xmi_id": target["xmi_id"],
                "target_effective_direction": target_direction,
                "conveyed_item_code": item["item_code"],
                "conveyed_classifier_xmi_id": item["xmi_id"],
                "signal_name_cn": item["name_cn"],
                "signal_name_has_cjk": has_cjk(item["name_cn"]),
                "information_flow": {
                    "informationSource": source["xmi_id"],
                    "informationTarget": target["xmi_id"],
                    "conveyed": item["xmi_id"],
                    "realizingConnector": connection["xmi_id"],
                },
                "item_flow": {
                    "base_InformationFlow": information_flow_id,
                    "itemProperty": "OMITTED",
                },
                "diagram_projection": {
                    "connector_line": "SOLID",
                    "item_flow_marker": "SOURCE_TO_TARGET",
                    "label": item["name_cn"],
                    "independent_information_flow_symbol": False,
                },
            }
        )

    sample_evidence = {
        "path": str(SAMPLE),
        "status": "NOT_DISCOVERED",
        "standard_itemflow_without_itemproperty": False,
        "diagram_presentation_encoding": None,
    }
    if SAMPLE.exists():
        with zipfile.ZipFile(SAMPLE) as archive:
            text = archive.read(SAMPLE_MEMBER).decode("utf-8", errors="replace")
            itemflow_tags = re.findall(r"<sysml:ItemFlow\b[^>]*>", text) + re.findall(r"<sysml:ItemFlow\b[^>]*/>", text)
            sample_evidence.update(
                {
                    "status": "DISCOVERED",
                    "model_member": SAMPLE_MEMBER,
                    "itemflow_application_count": text.count("<sysml:ItemFlow"),
                    "standard_itemflow_without_itemproperty": any("itemProperty" not in tag for tag in itemflow_tags),
                    "information_flow_realizes_connector": "realizingConnector" in text,
                    "diagram_representation_present": "DiagramRepresentationObject" in text,
                    "diagram_presentation_encoding": "PROPRIETARY_BINARY_STREAM" if "binaryObject" in text else "UNKNOWN",
                    "portable_open_xml_itemflow_path_found": False,
                }
            )

    contract = {
        "contract_id": "RAIL-MBSE-SYSML17-ITEMFLOW-MAPPING-V2",
        "frozen_source": str(SOURCE),
        "signal_connection_count": len(mappings),
        "semantic_layers": {
            "flow_property": "Defines effective Port direction in the InterfaceBlock.",
            "signal": "Defines the conveyed information classifier and uses the frozen Item Chinese name.",
            "information_flow": "Carries source, target, conveyed classifier, and realizing Connector semantics.",
            "item_flow": "Standard SysML application on InformationFlow; itemProperty omitted because no legal common-owner Property exists.",
            "connector": "Standard solid uml:Connector between the endpoint Ports.",
        },
        "item_property_policy": {
            "value": "OMIT",
            "reason": "An InterfaceBlock-owned FlowProperty is not a Property of the common owner of the source and target.",
            "fake_common_owner_property": "FORBIDDEN",
            "installed_magicdraw_sample_support": sample_evidence["standard_itemflow_without_itemproperty"],
        },
        "diagram_projection_contract": {
            "information_flow_model_element": "PRESENT",
            "independent_information_flow_symbol": "FORBIDDEN",
            "connector_symbol": "SOLID",
            "itemflow_marker": "SOURCE_TO_TARGET",
            "label_source": "conveyed uml:Signal.name",
            "physical_connector_itemflow": "NOT_GENERATED_BY_THIS_SIGNAL_RULE",
        },
        "magicdraw_presentation": {
            "status": "GOLDEN_SAMPLE_REQUIRED",
            "MAGICDRAW_PRESENTATION_SAMPLE_REQUIRED": "YES",
            "reason": "Installed examples keep diagram presentation in proprietary binary streams; exact path/label rendering cannot be safely synthesized as neutral XMI.",
            "sample_evidence": sample_evidence,
        },
        "statistics": {
            "information_flows": len(mappings),
            "item_flows": len(mappings),
            "illegal_item_property": sum(row["item_flow"]["itemProperty"] != "OMITTED" for row in mappings),
            "independent_information_flow_symbols": sum(row["diagram_projection"]["independent_information_flow_symbol"] for row in mappings),
            "unique_signal_classifiers": len({row["conveyed_classifier_xmi_id"] for row in mappings}),
            "unique_signal_classifiers_with_chinese_name": len({row["conveyed_classifier_xmi_id"] for row in mappings if row["signal_name_has_cjk"]}),
        },
        "mappings": mappings,
        "full_xmi_published": False,
    }
    write_json(PIPELINE_WORK / "itemflow_mapping_contract_v2.json", contract)
    return {"interfaces": human_name_map["statistics"], "itemflows": contract["statistics"], "presentation": contract["magicdraw_presentation"]["status"]}


def main() -> None:
    print(json.dumps(build(), ensure_ascii=False))


if __name__ == "__main__":
    main()
