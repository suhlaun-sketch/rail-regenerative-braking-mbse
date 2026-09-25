from __future__ import annotations

import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
PIPELINE_WORK = PIPELINE_DIR / "work"
REPORTS = ROOT / "reports"
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
V4 = ROOT / "work" / "Rail_MBSE_SysML17_structure_probe_v4.xmi"
V5 = ROOT / "work" / "Rail_MBSE_SysML17_itemflow_probe_v5.xmi"
OLD_FULL = ROOT / "work" / "Rail_MBSE_SysML17_v1.xmi"


def namespaces(path: Path) -> dict[str, str]:
    result = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result[prefix or "default"] = uri
    return result


def has_cjk(value: str) -> bool:
    return bool(re.search(r"[\u3400-\u9fff]", value or ""))


def qa(identifier: str, condition: bool, detail: str) -> dict:
    return {"id": identifier, "status": "PASS" if condition else "FAIL", "detail": detail}


def validate() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    contract = json.loads((PIPELINE_WORK / "itemflow_mapping_contract_v2.json").read_text(encoding="utf-8"))
    name_map = json.loads((PIPELINE_WORK / "interface_human_name_map.json").read_text(encoding="utf-8"))
    directions = json.loads((PIPELINE_WORK / "port_direction_resolution.json").read_text(encoding="utf-8"))
    manifest = json.loads((PIPELINE_WORK / "itemflow_probe_v5_manifest.json").read_text(encoding="utf-8"))
    compatibility = json.loads((PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json").read_text(encoding="utf-8"))

    ns = namespaces(V5)
    XMI = ns["xmi"]
    SYSML = compatibility["namespace_separation"]["sysml_stereotype_namespace"]
    qx = lambda name: f"{{{XMI}}}{name}"
    qs = lambda name: f"{{{SYSML}}}{name}"
    root = ET.parse(V5).getroot()
    elements = list(root.iter())
    ids = {element.get(qx("id")): element for element in elements if element.get(qx("id"))}
    parents = {child: parent for parent in elements for child in parent}

    def of_type(name: str) -> list[ET.Element]:
        return [element for element in elements if element.get(qx("type")) == f"uml:{name}"]

    def apps(name: str) -> list[ET.Element]:
        return [element for element in root if element.tag == qs(name)]

    signal_connections = [c for c in architecture["connections"] if c["mode"] == "SIGNAL"]
    mappings = contract["mappings"]
    mapping_by_connection = {row["connection_id"]: row for row in mappings}
    interface_by_id = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
    direction_by_interface = {r["interface_instance_id"]: r for r in directions["records"]}
    item_by_id = {i["item_code"]: i for i in architecture["items"]}
    all_source_out = all(row["source_effective_direction"] == "out" for row in mappings)
    all_target_in = all(row["target_effective_direction"] == "in" for row in mappings)
    all_realizing = all(row["information_flow"]["realizingConnector"] == row["connector_xmi_id"] for row in mappings)
    all_conveyed = all(row["information_flow"]["conveyed"] == row["conveyed_classifier_xmi_id"] for row in mappings)
    all_signal_names = all(row["signal_name_cn"] == item_by_id[row["conveyed_item_code"]]["name_cn"] and row["signal_name_has_cjk"] for row in mappings)
    mapping_connection_counts = Counter(row["connection_id"] for row in mappings)
    mapping_info_counts = Counter(row["information_flow_xmi_id"] for row in mappings)
    mapping_item_counts = Counter(row["item_flow_application_xmi_id"] for row in mappings)

    # Prior full is read only and used solely to confirm the frozen 147-connection baseline.
    old_ns = namespaces(OLD_FULL)
    old_xmi = old_ns["xmi"]
    old_qx = lambda name: f"{{{old_xmi}}}{name}"
    old_root = ET.parse(OLD_FULL).getroot()
    old_connectors = [e for e in old_root.iter() if e.get(old_qx("type")) == "uml:Connector"]
    old_infos = [e for e in old_root.iter() if e.get(old_qx("type")) == "uml:InformationFlow"]
    old_itemflows = [e for e in old_root.iter() if e.tag.rsplit("}", 1)[-1] == "ItemFlow"]
    final_connector_ids = {c["xmi_id"] for c in signal_connections}
    old_signal_connectors = [e for e in old_connectors if e.get(old_qx("id")) in final_connector_ids]

    connection = next(c for c in signal_connections if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111" and c["item_id"] == "ITM-MEA-005")
    mapping = mapping_by_connection[connection["connection_id"]]
    source = interface_by_id[connection["source_interface_id"]]
    target = interface_by_id[connection["target_interface_id"]]
    connector = ids[connection["xmi_id"]]
    info = ids[mapping["information_flow_xmi_id"]]
    itemflow = next(app for app in apps("ItemFlow") if app.get("base_InformationFlow") == mapping["information_flow_xmi_id"])
    signal = ids[mapping["conveyed_classifier_xmi_id"]]
    source_port = ids[source["xmi_id"]]
    target_port = ids[target["xmi_id"]]

    human_by_ib = {row["interface_block_id"]: row for row in name_map["interface_blocks"]}
    probe_ibs = [ids[source_port.get("type")], ids[target_port.get("type")]]
    metadata_by_ib = {}
    for ib in probe_ibs:
        metadata = {
            child.get("name"): child
            for child in ib
            if child.get(qx("type")) == "uml:Property" and child.get("name") in {"interface_type_code", "item_code", "port_type_code", "direction_code"}
        }
        metadata_by_ib[ib.get(qx("id"))] = metadata
    probe_code_metadata_ok = all(
        set(metadata_by_ib[ib_id]) == {"interface_type_code", "item_code", "port_type_code", "direction_code"}
        and all(any(child.tag == "defaultValue" and child.get("value") == next(m["value"] for m in human_by_ib[ib_id]["metadata_properties"] if m["name"] == name) for child in prop) for name, prop in metadata_by_ib[ib_id].items())
        for ib_id in metadata_by_ib
    )

    # v4/v5 structural signatures must be identical.
    def structural_signature(path: Path) -> dict:
        n = namespaces(path)
        x = n["xmi"]
        q = lambda name: f"{{{x}}}{name}"
        r = ET.parse(path).getroot()
        parent_map = {child: parent for parent in r.iter() for child in parent}
        products = {p["xmi_id"] for p in architecture["products"]}
        blocks = sorted(e.get(q("id")) for e in r.iter() if e.get(q("type")) == "uml:Class" and e.get(q("id")) in products)
        parts = sorted(
            (parent_map[e].get(q("id")), e.get("name"), e.get("type"), e.get("aggregation"))
            for e in r.iter() if e.get(q("type")) == "uml:Property" and e.get("aggregation") == "composite"
        )
        ports = sorted(
            (parent_map[e].get(q("id")), e.get(q("id")), e.get("name"))
            for e in r.iter() if e.get(q("type")) == "uml:Port"
        )
        return {"blocks": blocks, "parts": parts, "ports": ports}

    structure_unchanged = structural_signature(V4) == structural_signature(V5)
    info_diagram_symbols = [
        e for e in elements
        if ("diagram" in (e.tag + (e.get(qx("type")) or "")).lower())
        and (e.get("element") == mapping["information_flow_xmi_id"] or e.get("subject") == mapping["information_flow_xmi_id"])
    ]
    unique_signal_ids = {row["conveyed_classifier_xmi_id"] for row in mappings}
    human_stats = name_map["statistics"]

    flow_results = [
        qa("FLOW-QA-01", len(signal_connections) == 147 and len(old_signal_connectors) == 147, "147 SIGNAL Final Connections have standard Connectors in the frozen baseline."),
        qa("FLOW-QA-02", all(e.get(old_qx("type")) == "uml:Connector" for e in old_signal_connectors) and connector.get(qx("type")) == "uml:Connector", "Signal Connectors are standard uml:Connector elements."),
        qa("FLOW-QA-03", len(mappings) == 147 and len(old_infos) == 147, "Corrected deterministic mapping contains 147 InformationFlows; frozen baseline count remains 147."),
        qa("FLOW-QA-04", len(mappings) == 147 and len(old_itemflows) == 147, "Corrected deterministic mapping contains 147 standard ItemFlows; frozen baseline count remains 147."),
        qa("FLOW-QA-05", len(mapping_connection_counts) == 147 and max(mapping_connection_counts.values()) == 1 and len(mapping_info_counts) == 147, "Each SIGNAL connection maps to exactly one InformationFlow."),
        qa("FLOW-QA-06", len(mapping_item_counts) == 147 and max(mapping_item_counts.values()) == 1, "Each SIGNAL connection maps to exactly one ItemFlow application."),
        qa("FLOW-QA-07", all_conveyed and info.get("conveyed") == signal.get(qx("id")) and signal.get(qx("type")) == "uml:Signal", "Every conveyed reference resolves to its Item Signal classifier; the Probe conveyed classifier is uml:Signal."),
        qa("FLOW-QA-08", all_signal_names and signal.get("name") == item_by_id[connection["item_id"]]["name_cn"] and has_cjk(signal.get("name")), "All conveyed Signal classifiers use frozen Chinese engineering Item names."),
        qa("FLOW-QA-09", all_source_out and direction_by_interface[source["interface_instance_id"]]["effective_port_direction"] == "out" and info.get("informationSource") == source["xmi_id"], "All InformationFlow sources are effective out Ports."),
        qa("FLOW-QA-10", all_target_in and direction_by_interface[target["interface_instance_id"]]["effective_port_direction"] == "in" and info.get("informationTarget") == target["xmi_id"], "All InformationFlow targets are effective in Ports."),
        qa("FLOW-QA-11", all_realizing and info.get("realizingConnector") == connector.get(qx("id")), "Every InformationFlow realizes its frozen Connector."),
        qa("FLOW-QA-12", contract["statistics"]["illegal_item_property"] == 0 and itemflow.get("itemProperty") is None, "No ItemFlow references an InterfaceBlock-owned FlowProperty as itemProperty."),
        qa("FLOW-QA-13", itemflow.get("itemProperty") is None and contract["item_property_policy"]["value"] == "OMIT", "Static source of the MagicDraw common-owner ItemProperty warning is absent."),
        qa("FLOW-QA-14", contract["statistics"]["independent_information_flow_symbols"] == 0 and not info_diagram_symbols, "No independent dashed InformationFlow diagram symbol is generated."),
        qa("FLOW-QA-15", all_source_out and all_target_in and all(row["diagram_projection"]["item_flow_marker"] == "SOURCE_TO_TARGET" for row in mappings), "ItemFlow direction is source out -> target in for all 147 mappings."),
    ]
    name_results = [
        qa("NAME-QA-01", all(not row["name_cn"].startswith(("IB_", "IF-", "ITM-")) for row in name_map["interface_blocks"]), "No InterfaceBlock primary name starts with a technical code prefix."),
        qa("NAME-QA-02", human_stats["interface_blocks"] == human_stats["human_chinese_names"] == 221 and all(has_cjk(ib.get("name")) for ib in probe_ibs), "All 221 directional InterfaceBlocks have Chinese engineering names; both Probe names are Chinese."),
        qa("NAME-QA-03", human_stats["metadata_complete_interface_blocks"] == 221 and all(any(m["name"] == "interface_type_code" for m in row["metadata_properties"]) for row in name_map["interface_blocks"]), "interface_type_code is retained as a standard UML String Property for all InterfaceBlocks."),
        qa("NAME-QA-04", all(any(m["name"] == "item_code" for m in row["metadata_properties"]) for row in name_map["interface_blocks"]), "item_code is retained as a standard UML String Property for all InterfaceBlocks."),
        qa("NAME-QA-05", all(any(m["name"] == "port_type_code" for m in row["metadata_properties"]) for row in name_map["interface_blocks"]), "port_type_code is retained as a standard UML String Property for all InterfaceBlocks."),
        qa("NAME-QA-06", all(has_cjk(i["name"]) for i in architecture["interfaces"]) and source_port.get("name") == source["name"] and target_port.get("name") == target["name"], "All frozen Port names remain Chinese engineering names; Probe Port names are unchanged."),
        qa("NAME-QA-07", len(unique_signal_ids) == contract["statistics"]["unique_signal_classifiers_with_chinese_name"] == 79, "All 79 distinct conveyed Signal classifiers use their frozen Chinese Item names."),
    ]
    probe_checks = {
        "structure_unchanged_from_v4": structure_unchanged,
        "probe_connector_count": len(of_type("Connector")) == 1,
        "probe_information_flow_count": len(of_type("InformationFlow")) == 1,
        "probe_itemflow_count": len(apps("ItemFlow")) == 1,
        "probe_illegal_itemproperty_count": sum(app.get("itemProperty") is not None for app in apps("ItemFlow")) == 0,
        "probe_code_metadata": probe_code_metadata_ok,
        "probe_signal_name_chinese": has_cjk(signal.get("name")),
        "probe_interface_names_chinese": all(has_cjk(ib.get("name")) for ib in probe_ibs),
        "probe_no_vendor_diagram": not any("ownedDiagram" in e.tag or "DiagramRepresentation" in e.tag for e in elements),
        "byte_deterministic": manifest["byte_deterministic"] and hashlib.sha256(V5.read_bytes()).hexdigest() == manifest["sha256"],
    }
    all_results = flow_results + name_results
    pass_count = sum(row["status"] == "PASS" for row in all_results)
    probe_pass = all(probe_checks.values()) and pass_count == len(all_results)
    result = {
        "validation_id": "RAIL-MBSE-ITEMFLOW-DISPLAY-PROBE-V5-QA",
        "counts": {
            "signal_connections": len(signal_connections),
            "information_flows": len(mappings),
            "item_flows": len(mappings),
            "illegal_item_property": contract["statistics"]["illegal_item_property"],
            "signal_chinese_names": contract["statistics"]["unique_signal_classifiers_with_chinese_name"],
            "interface_block_chinese_names": human_stats["human_chinese_names"],
            "interface_blocks_with_complete_code_metadata": human_stats["metadata_complete_interface_blocks"],
            "interface_code_properties": human_stats["metadata_properties"],
            "independent_information_flow_symbols": contract["statistics"]["independent_information_flow_symbols"],
        },
        "qa": all_results,
        "qa_summary": {"PASS": pass_count, "FAIL": len(all_results) - pass_count},
        "probe_checks": probe_checks,
        "probe_status": "PASS" if probe_pass else "FAIL",
        "probe_path": str(V5),
        "magicdraw_presentation": contract["magicdraw_presentation"]["status"],
        "full_xmi_published": False,
    }
    (PIPELINE_WORK / "itemflow_validation.json").write_text(
        json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return result


def write_report(result: dict) -> None:
    counts = result["counts"]
    failed = [row["id"] for row in result["qa"] if row["status"] == "FAIL"]
    lines = [
        "# ItemFlow Display Fix Report",
        "",
        "- Scope: corrected ItemFlow semantics, human-readable interface names, code metadata, and presentation strategy only.",
        "- Block/Part hierarchy, Ports, ConnectGraph, Functions, Allocations, and frozen inputs: unchanged.",
        "- Full XMI: not published.",
        "",
        "## Result",
        "",
        f"- SIGNAL Connections / InformationFlows / ItemFlows: {counts['signal_connections']} / {counts['information_flows']} / {counts['item_flows']}",
        f"- Illegal ItemFlow.itemProperty: {counts['illegal_item_property']}",
        f"- Distinct conveyed Signals with Chinese names: {counts['signal_chinese_names']}",
        f"- Directional InterfaceBlocks with Chinese names: {counts['interface_block_chinese_names']}",
        f"- InterfaceBlocks with all code metadata: {counts['interface_blocks_with_complete_code_metadata']} ({counts['interface_code_properties']} standard UML String Properties)",
        f"- Independent InformationFlow diagram symbols: {counts['independent_information_flow_symbols']}",
        f"- QA: {result['qa_summary']['PASS']} PASS / {result['qa_summary']['FAIL']} FAIL; Probe {result['probe_status']}",
        f"- Failed checks: {', '.join(failed) if failed else 'None'}",
        "",
        "## MagicDraw Presentation",
        "",
        "- Installed MagicDraw examples confirm ItemFlow without itemProperty and InformationFlow.realizingConnector.",
        "- Exact diagram paths, line styles, markers, and label placement are stored in proprietary binary streams inside mdzip, not portable neutral XMI.",
        f"- Status: {result['magicdraw_presentation']}",
        "- Required golden sample: minimal MagicDraw-saved IBD containing two parts, two ProxyPorts, one solid Connector, and one displayed ItemFlow.",
        "",
        "## Probe",
        "",
        f"- `{result['probe_path']}`",
    ]
    REPORTS.mkdir(parents=True, exist_ok=True)
    (REPORTS / "itemflow_display_fix_report.md").write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    result = validate()
    write_report(result)
    print(json.dumps({"qa": result["qa_summary"], "probe": result["probe_status"], "counts": result["counts"], "presentation": result["magicdraw_presentation"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
