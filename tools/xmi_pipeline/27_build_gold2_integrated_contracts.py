from __future__ import annotations

import hashlib
import json
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
WORK = PIPELINE_DIR / "work"
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
UPWARD = WORK / "upward_port_inference_v1.json"
PROJECTION = WORK / "hierarchical_connection_projection_v1.json"
INVENTORY = WORK / "gold2_full_inventory_v1.json"

KIND_OUTPUT = WORK / "hierarchical_connector_kind_v2.json"


def write_json(name: str, value: dict) -> None:
    (WORK / name).write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def classify(segment: dict) -> str:
    if segment["mode"] != "SIGNAL":
        return "PHYSICAL"
    source_kind = segment["source_endpoint"]["kind"]
    target_kind = segment["target_endpoint"]["kind"]
    if source_kind == "PART_PORT" and target_kind == "FRAME_PORT":
        return "DELEGATION_SOURCE"
    if source_kind == "FRAME_PORT" and target_kind == "PART_PORT":
        return "DELEGATION_TARGET"
    if source_kind in {"PART_PORT", "BOUNDARY_PORT"} and target_kind in {"PART_PORT", "BOUNDARY_PORT"}:
        return "ASSEMBLY_SIGNAL"
    raise AssertionError(f"Unclassifiable segment {segment['segment_id']}: {source_kind}->{target_kind}")


def build() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    upward = json.loads(UPWARD.read_text(encoding="utf-8"))
    projection = json.loads(PROJECTION.read_text(encoding="utf-8"))
    inventory = json.loads(INVENTORY.read_text(encoding="utf-8"))
    products = {entry["id"]: entry for entry in architecture["products"]}
    promoted = {entry["promoted_port_id"]: entry for entry in upward["promoted_ports"]}
    raw_interfaces = {entry["port_id"]: entry for entry in architecture["interfaces"]}

    def direction(endpoint: dict) -> str:
        port_id = endpoint["port_id"]
        if port_id in promoted:
            return promoted[port_id]["effective_direction"]
        if port_id in raw_interfaces:
            raw = raw_interfaces[port_id]["direction"]
            return {"输入": "in", "输出": "out", "双向物理": "inout"}[raw]
        if endpoint["kind"] == "BOUNDARY_PORT":
            return "inout"
        raise AssertionError(f"Unknown endpoint port {port_id}")

    records = []
    direction_violations = []
    expected_pairs = {
        "DELEGATION_SOURCE": ("out", "out"),
        "ASSEMBLY_SIGNAL": ("out", "in"),
        "DELEGATION_TARGET": ("in", "in"),
        "PHYSICAL": ("inout", "inout"),
    }
    for segment in projection["segments"]:
        kind = classify(segment)
        source_direction = direction(segment["source_endpoint"])
        target_direction = direction(segment["target_endpoint"])
        expected = expected_pairs[kind]
        valid = (source_direction, target_direction) == expected
        if not valid:
            direction_violations.append(segment["segment_id"])
        records.append(
            {
                "segment_id": segment["segment_id"],
                "xmi_id": segment["xmi_id"],
                "derived_from_connection_id": segment["derived_from_connection_id"],
                "owner_ibd": segment["owner_ibd"],
                "owner_block": segment["owner_block"],
                "source_element": segment["source_element"],
                "source_endpoint_kind": segment["source_endpoint"]["kind"],
                "source_port_id": segment["source_port"],
                "source_port_xmi_id": segment["source_port_xmi_id"],
                "source_direction": source_direction,
                "target_element": segment["target_element"],
                "target_endpoint_kind": segment["target_endpoint"]["kind"],
                "target_port_id": segment["target_port"],
                "target_port_xmi_id": segment["target_port_xmi_id"],
                "target_direction": target_direction,
                "mode": segment["mode"],
                "item_code": segment["item_code"],
                "connector_kind": kind,
                "expected_local_direction_pair": list(expected),
                "direction_valid": valid,
                "global_flow": f"{next(c['source_product_id'] for c in architecture['connections'] if c['connection_id'] == segment['derived_from_connection_id'])} → "
                f"{next((c['target_product_id'] or c['target_boundary_id']) for c in architecture['connections'] if c['connection_id'] == segment['derived_from_connection_id'])}",
                "classification_basis": {
                    "mode": segment["mode"],
                    "owner_ibd": segment["owner_ibd"],
                    "source_endpoint_kind": segment["source_endpoint"]["kind"],
                    "target_endpoint_kind": segment["target_endpoint"]["kind"],
                    "is_lca_segment": segment["is_lca_segment"],
                    "parent_child_verified": (
                        segment["owner_block"] == "__SYSTEM_CONTEXT__"
                        or segment["source_element"] == segment["owner_block"]
                        or segment["target_element"] == segment["owner_block"]
                        or products.get(segment["source_element"], {}).get("parent_id") == segment["owner_block"]
                        or products.get(segment["target_element"], {}).get("parent_id") == segment["owner_block"]
                    ),
                },
            }
        )

    counts = Counter(record["connector_kind"] for record in records)
    kind_document = {
        "contract_id": "RAIL-MBSE-HIERARCHICAL-CONNECTOR-KIND-V2",
        "source_projection": str(PROJECTION),
        "source_projection_sha256": hashlib.sha256(PROJECTION.read_bytes()).hexdigest(),
        "deterministic_rule": "mode + source endpoint kind + target endpoint kind; no LLM classification",
        "segment_count": len(records),
        "counts": dict(sorted(counts.items())),
        "unknown": 0,
        "direction_violations": direction_violations,
        "records": records,
    }
    write_json(KIND_OUTPUT.name, kind_document)

    gold_integrity = inventory["integrity"]
    write_json(
        "gold2_structure_contract_v2.json",
        {
            "contract_id": "GOLD2-STRUCTURE-CONTRACT-V2",
            "source_sha256": inventory["sha256"],
            "rules": {
                "product_classifier": "uml:Class + SysML::Block",
                "package_role": "organization only; package is never a Product",
                "composition": "Parent Block.ownedAttribute uml:Property, aggregation=composite, type=direct Child Block",
                "part_property": "SysML::PartProperty applied to the composite Property",
                "visible_part_name": "Child Product Chinese name",
                "hierarchy": "strict parent_id, one level per Part Property; no flattening",
            },
            "gold2_evidence": {
                "blocks": gold_integrity["business_block_count"],
                "composite_parts": gold_integrity["composite_part_count"],
                "chain_field": "block_to_ibd_to_part_to_port_to_connector_chain",
            },
        },
    )
    write_json(
        "gold2_connector_contract_v2.json",
        {
            "contract_id": "GOLD2-CONNECTOR-CONTRACT-V2",
            "rules": {
                "ownership": "uml:Connector is ownedConnector of IBD.context Block",
                "child_end": "partWithPort=direct Child Part Property; role=Port owned by Child Block",
                "frame_end": "partWithPort absent; role=Port owned by context Block",
                "assembly_end": "both ends use direct Child Part Property and Child Port",
                "nested_connector_end": "not used for one-level promoted-port delegation",
                "presentation": "native Connector path elementID references the same ownedConnector",
            },
            "connector_kind_source": str(KIND_OUTPUT),
            "counts": dict(sorted(counts.items())),
        },
    )
    write_json(
        "gold2_ibd_contract_v2.json",
        {
            "contract_id": "GOLD2-IBD-CONTRACT-V2",
            "rules": {
                "diagram": "ownedDiagram under context Block modelExtension",
                "owner_context": "ownerOfDiagram=context=Block xmi:id",
                "scope": "direct child Parts only",
                "usedObjects_usedElements": "all presented Part, Port, Connector, and ConnectorEnd model IDs resolve",
                "connector_path": "solid native Connector; never an independent InformationFlow path",
                "itemflow_display": "conveyed compartment plus connector label on Connector presentation",
            },
            "gold2_ibd_count": gold_integrity["ibd_count"],
            "gold2_connector_native_presentation": gold_integrity["all_connectors_have_native_presentation"],
        },
    )
    write_json(
        "integrated_direction_contract_v2.json",
        {
            "contract_id": "INTEGRATED-DIRECTION-CONTRACT-V2",
            "port_direction_source": "SysML::FlowProperty.direction in typed InterfaceBlock",
            "port_metaclass_direction_attribute": "forbidden",
            "pairs": {key: list(value) for key, value in expected_pairs.items()},
            "hierarchical_counts": dict(sorted(counts.items())),
            "unknown": 0,
            "golden_trace": "4235 → 5111",
        },
    )
    write_json(
        "integrated_itemflow_contract_v2.json",
        {
            "contract_id": "INTEGRATED-ITEMFLOW-CONTRACT-V2",
            "signal_classifier": "uml:Signal",
            "information_flow": {
                "conveyed": "uml:Signal xmi:id",
                "informationSource": "global source ProxyPort xmi:id",
                "informationTarget": "global target ProxyPort xmi:id",
                "realizingConnector": "local ownedConnector xmi:id",
            },
            "item_flow": "SysML::ItemFlow.base_InformationFlow references the uml:InformationFlow",
            "item_property": "empty",
            "diagram": "Connector path carries arrow/label; InformationFlow path count=0",
            "physical": "no Signal ItemFlow required",
        },
    )
    write_json(
        "integrated_icd_contract_v2.json",
        {
            "contract_id": "INTEGRATED-ICD-CONTRACT-V2",
            "probe": "ICD_4235_5111_Trace",
            "row_element": "uml:Connector",
            "row_count": 7,
            "columns": [
                "Connector Name",
                "Connector Kind",
                "Owner Block Name",
                "Owner Block Code",
                "Part A Name",
                "Part A Block Name",
                "Part A Block Code",
                "Port A Name",
                "Port A Direction",
                "Item Flow",
                "Conveyed Signal Name",
                "Signal Code",
                "Signal Data Type",
                "Unit",
                "Global Flow Direction",
                "Port B Name",
                "Port B Direction",
                "Part B Name",
                "Part B Block Name",
                "Part B Block Code",
                "Original Connection ID",
                "Derived Segment ID",
                "Simulation Boundary",
                "Simulink Binding Status",
            ],
            "query_chain": "Connector <- InformationFlow.realizingConnector <- SysML::ItemFlow.base_InformationFlow",
            "signal_itemflow_required": True,
            "physical_itemflow_required": False,
        },
    )
    write_json(
        "magicdraw_block_package_contract_v2.json",
        {
            "contract_id": "MAGICDRAW-BLOCK-PACKAGE-CONTRACT-V2",
            "product_count_frozen": 147,
            "product_mapping": "exactly one uml:Class + SysML::Block per Product",
            "forbidden_product_metaclasses": ["uml:Package", "uml:Signal", "uml:DataType", "uml:Property"],
            "domain_packages": {
                "3000": "转向架产品域",
                "4000": "主供电产品域",
                "5000": "牵引产品域",
                "7000": "供风制动产品域",
                "8000": "网络与辅助监控产品域",
                "D000": "驾驶设施产品域",
                "E000": "电务车载产品域",
                "X000": "再生储能产品域",
            },
            "context": "Rail_MBSE_TractionBrake_Context is uml:Class + SysML::Block",
        },
    )
    return kind_document


def main() -> None:
    result = build()
    print(json.dumps({"output": str(KIND_OUTPUT), "segment_count": result["segment_count"], "counts": result["counts"], "unknown": result["unknown"], "direction_violations": len(result["direction_violations"])}, ensure_ascii=False))


if __name__ == "__main__":
    main()
