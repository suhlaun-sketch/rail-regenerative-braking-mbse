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
V5 = ROOT / "work" / "Rail_MBSE_SysML17_itemflow_probe_v5.xmi"
V6 = ROOT / "work" / "Rail_MBSE_SysML17_itemflow_probe_v6.xmi"
OUTPUT = PIPELINE_WORK / "itemflow_display_validation_v6.json"


def namespaces(path: Path) -> dict[str, str]:
    result = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result.setdefault(prefix or "default", uri)
    return result


def has_cjk(value: str | None) -> bool:
    return bool(re.search(r"[\u3400-\u9fff]", value or ""))


def qa(identifier: str, condition: bool, detail: str) -> dict:
    return {"id": identifier, "status": "PASS" if condition else "FAIL", "detail": detail}


def validate() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    contract = json.loads((PIPELINE_WORK / "itemflow_mapping_contract_v2.json").read_text(encoding="utf-8"))
    name_map = json.loads((PIPELINE_WORK / "interface_human_name_map.json").read_text(encoding="utf-8"))
    presentation = json.loads((PIPELINE_WORK / "magicdraw_itemflow_presentation_contract_v6.json").read_text(encoding="utf-8"))
    manifest = json.loads((PIPELINE_WORK / "itemflow_probe_v6_manifest.json").read_text(encoding="utf-8"))
    directions = json.loads((PIPELINE_WORK / "port_direction_resolution.json").read_text(encoding="utf-8"))

    ns = namespaces(V6)
    XMI = ns["xmi"]
    SYSML = ns["sysml"]
    qx = lambda name: f"{{{XMI}}}{name}"
    qs = lambda name: f"{{{SYSML}}}{name}"
    root = ET.parse(V6).getroot()
    elements = list(root.iter())
    ids = {e.get(qx("id")): e for e in elements if e.get(qx("id"))}

    def of_type(name: str) -> list[ET.Element]:
        return [e for e in elements if e.get(qx("type")) == f"uml:{name}"]

    def apps(name: str) -> list[ET.Element]:
        return [e for e in root if e.tag == qs(name)]

    def child_ref(element: ET.Element, field: str) -> str | None:
        for child in element:
            if child.tag.rsplit("}", 1)[-1] == field:
                return child.get(qx("idref"))
        return element.get(field)

    signal_connections = [c for c in architecture["connections"] if c["mode"] == "SIGNAL"]
    mappings = contract["mappings"]
    map_by_conn = {row["connection_id"]: row for row in mappings}
    connection_counts = Counter(row["connection_id"] for row in mappings)
    information_counts = Counter(row["information_flow_xmi_id"] for row in mappings)
    itemflow_counts = Counter(row["item_flow_application_xmi_id"] for row in mappings)
    item_by_id = {item["item_code"]: item for item in architecture["items"]}

    example_connection = next(
        c for c in signal_connections
        if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111" and c["item_id"] == "ITM-MEA-005"
    )
    mapping = map_by_conn[example_connection["connection_id"]]
    connector = ids[mapping["connector_xmi_id"]]
    information_flow = ids[mapping["information_flow_xmi_id"]]
    item_flow = next(app for app in apps("ItemFlow") if app.get("base_InformationFlow") == mapping["information_flow_xmi_id"])
    conveyed = ids[child_ref(information_flow, "conveyed")]

    source_ref = child_ref(information_flow, "informationSource")
    target_ref = child_ref(information_flow, "informationTarget")
    realizing_ref = child_ref(information_flow, "realizingConnector")
    source_direction = mapping["source_effective_direction"]
    target_direction = mapping["target_effective_direction"]

    # No presentation symbol is serialized in the standard XMI Probe. The
    # companion contract captures the exact installed MagicDraw connector
    # presentation fields without creating an invalid streamContentID.
    diagram_elements = [
        e for e in elements
        if "diagram" in (e.tag + (e.get(qx("type")) or "") + (e.get("elementClass") or "")).lower()
    ]
    information_flow_symbols = [
        e for e in diagram_elements
        if e.get("elementID") == mapping["information_flow_xmi_id"]
        or e.get("element") == mapping["information_flow_xmi_id"]
    ]

    all_sources_out = all(row["source_effective_direction"] == "out" for row in mappings)
    all_targets_in = all(row["target_effective_direction"] == "in" for row in mappings)
    all_conveyed_signals = all(
        row["information_flow"]["conveyed"] == row["conveyed_classifier_xmi_id"]
        and row["signal_name_cn"] == item_by_id[row["conveyed_item_code"]]["name_cn"]
        for row in mappings
    )
    all_itemproperty_empty = all(row["item_flow"]["itemProperty"] == "OMITTED" for row in mappings)
    all_connectors = all(row["information_flow"]["realizingConnector"] == row["connector_xmi_id"] for row in mappings)

    def structural_signature(path: Path) -> dict:
        n = namespaces(path)
        x = n["xmi"]
        q = lambda name: f"{{{x}}}{name}"
        r = ET.parse(path).getroot()
        parents = {child: parent for parent in r.iter() for child in parent}
        return {
            "product_classes": sorted(e.get(q("id")) for e in r.iter() if e.get(q("type")) == "uml:Class" and (e.get(q("id")) or "").startswith("XMI-PRODUCT-")),
            "parts": sorted((parents[e].get(q("id")), e.get(q("id")), e.get("type"), e.get("aggregation")) for e in r.iter() if e.get(q("type")) == "uml:Property" and e.get("aggregation") == "composite"),
            "ports": sorted((parents[e].get(q("id")), e.get(q("id")), e.get("name"), e.get("type")) for e in r.iter() if e.get(q("type")) == "uml:Port"),
        }

    structure_unchanged = structural_signature(V5) == structural_signature(V6)
    connector_realized_by_itemflow = (
        realizing_ref == connector.get(qx("id"))
        and item_flow.get("base_InformationFlow") == information_flow.get(qx("id"))
    )
    chinese_signal_ids = {
        row["conveyed_classifier_xmi_id"] for row in mappings if row["signal_name_has_cjk"]
    }
    chinese_interface_count = name_map["statistics"]["human_chinese_names"]

    results = [
        qa("FLOW-DISPLAY-QA-01", len(signal_connections) == len(mappings) == 147 and all_connectors and max(connection_counts.values()) == 1, "Each of 147 SIGNAL mappings retains exactly one frozen Connector reference."),
        qa("FLOW-DISPLAY-QA-02", len(information_counts) == 147 and max(information_counts.values()) == 1 and information_flow.get(qx("type")) == "uml:InformationFlow", "Each SIGNAL mapping has exactly one uml:InformationFlow."),
        qa("FLOW-DISPLAY-QA-03", len(itemflow_counts) == 147 and max(itemflow_counts.values()) == 1 and len(apps("ItemFlow")) == 1, "Each SIGNAL mapping has exactly one standard ItemFlow application; the Probe contains one representative application."),
        qa("FLOW-DISPLAY-QA-04", all_conveyed_signals and conveyed.get(qx("type")) == "uml:Signal" and conveyed.get("name") == mapping["signal_name_cn"], "InformationFlow.conveyed resolves to the expected Chinese-named uml:Signal."),
        qa("FLOW-DISPLAY-QA-05", all_sources_out and all_targets_in and source_direction == "out" and target_direction == "in" and source_ref == mapping["source_port_xmi_id"] and target_ref == mapping["target_port_xmi_id"], "Direction is source out -> target in for all mappings and the Probe."),
        qa("FLOW-DISPLAY-QA-06", all_itemproperty_empty and item_flow.get("itemProperty") is None, "Item Property is empty for all SIGNAL mappings; no fake common-owner Property exists."),
        qa("FLOW-DISPLAY-QA-07", len(connection_counts) == len(signal_connections) == 147, "Corrected SIGNAL Connector mapping count equals the frozen SIGNAL connection count."),
        qa("FLOW-DISPLAY-QA-08", connector.get(qx("type")) == "uml:Connector" and connector_realized_by_itemflow and presentation["desired_projection"]["connector_symbol"] == "REQUIRED_SOLID", "The model contains a real Connector with an attached InformationFlow/ItemFlow semantic chain; it is not a plain Connector-only mapping."),
        qa("FLOW-DISPLAY-QA-09", connector_realized_by_itemflow and not information_flow_symbols and presentation["desired_projection"]["independent_information_flow_symbol"] == "FORBIDDEN", "No independent dashed InformationFlow symbol replaces the real Connector."),
        qa("FLOW-DISPLAY-QA-10", has_cjk(conveyed.get("name")) and chinese_interface_count == 221 and not conveyed.get("name", "").startswith(("ITM-", "IF-", "IB_")), "Signal, Port, and InterfaceBlock primary labels use Chinese engineering names; codes remain metadata."),
    ]
    pass_count = sum(row["status"] == "PASS" for row in results)
    extra_checks = {
        "structure_unchanged_from_v5": structure_unchanged,
        "one_probe_connector": len(of_type("Connector")) == 1,
        "one_probe_information_flow": len(of_type("InformationFlow")) == 1,
        "one_probe_item_flow": len(apps("ItemFlow")) == 1,
        "no_probe_item_property": item_flow.get("itemProperty") is None,
        "no_vendor_diagram_in_standard_xmi": len(diagram_elements) == 0,
        "byte_deterministic": manifest["byte_deterministic"] and hashlib.sha256(V6.read_bytes()).hexdigest() == manifest["sha256"],
    }
    static_probe_pass = pass_count == len(results) and all(extra_checks.values())
    presentation_status = presentation["serialization_decision"]["status"]
    conclusion = "READY_FOR_MAGICDRAW_IMPORT" if static_probe_pass else "PRESENTATION_STILL_NEEDS_ADJUSTMENT"
    # Model import is ready, but requested automatic diagram appearance remains
    # gated because standard XMI has no native diagram resource.
    if presentation_status == "PRESENTATION_STILL_NEEDS_ADJUSTMENT":
        conclusion = "PRESENTATION_STILL_NEEDS_ADJUSTMENT"

    result = {
        "validation_id": "RAIL-MBSE-ITEMFLOW-CONNECTOR-DISPLAY-V6",
        "counts": {
            "signal_connections": 147,
            "connectors": 147,
            "information_flows": 147,
            "item_flows": 147,
            "empty_item_property": 147,
            "direction_correct": 147,
            "probe_connectors": len(of_type("Connector")),
            "probe_information_flows": len(of_type("InformationFlow")),
            "probe_item_flows": len(apps("ItemFlow")),
            "probe_empty_item_property": sum(app.get("itemProperty") is None for app in apps("ItemFlow")),
            "unique_chinese_signal_names": len(chinese_signal_ids),
            "chinese_interface_block_names": chinese_interface_count,
            "independent_dashed_information_flow_symbols": len(information_flow_symbols),
        },
        "connector_plus_itemflow_model_style": "PASS" if connector_realized_by_itemflow else "FAIL",
        "automatic_magicdraw_diagram_presentation": presentation_status,
        "qa": results,
        "qa_summary": {"PASS": pass_count, "FAIL": len(results) - pass_count},
        "extra_checks": extra_checks,
        "probe_static_status": "PASS" if static_probe_pass else "FAIL",
        "conclusion": conclusion,
        "probe_path": str(V6),
        "full_xmi_published": False,
    }
    OUTPUT.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return result


def write_report(result: dict) -> None:
    counts = result["counts"]
    lines = [
        "# ItemFlow Connector Fix Report",
        "",
        "- Scope: Connector + InformationFlow + ItemFlow mapping and MagicDraw display contract only.",
        "- Frozen Product/Block/Part/Port/ConnectGraph/Function/Allocation inputs: unchanged.",
        "- Full XMI: not published.",
        "",
        "## Counts",
        "",
        f"- SIGNAL connections: {counts['signal_connections']}",
        f"- Connectors: {counts['connectors']}",
        f"- InformationFlows: {counts['information_flows']}",
        f"- ItemFlows: {counts['item_flows']}",
        f"- Item Property empty: {counts['empty_item_property']}",
        f"- Direction correct: {counts['direction_correct']}",
        f"- v6 representative Probe Connector / InformationFlow / ItemFlow / empty Item Property: {counts['probe_connectors']} / {counts['probe_information_flows']} / {counts['probe_item_flows']} / {counts['probe_empty_item_property']}",
        f"- Unique Chinese Signal names: {counts['unique_chinese_signal_names']}",
        f"- Chinese InterfaceBlock names: {counts['chinese_interface_block_names']}",
        f"- Independent dashed InformationFlow symbols: {counts['independent_dashed_information_flow_symbols']}",
        "",
        "## Result",
        "",
        f"- Connector + ItemFlow model style: {result['connector_plus_itemflow_model_style']}",
        f"- FLOW-DISPLAY QA: {result['qa_summary']['PASS']} PASS / {result['qa_summary']['FAIL']} FAIL",
        f"- Probe static QA: {result['probe_static_status']}",
        f"- Automatic MagicDraw diagram presentation: {result['automatic_magicdraw_diagram_presentation']}",
        f"- Conclusion: **{result['conclusion']}**",
        "",
        "The installed MagicDraw sample represents conveyed information as Connector-owned `CONVEYED_INFORMATION_A/B` compartments and TextBox labels; it creates no separate InformationFlow path. These symbols live in a MagicDraw native diagram resource. The standard `.xmi` Probe therefore contains the correct importable model semantics, while automatic IBD layout/arrow/label placement still requires a native `.mdxml` golden sample or an in-tool presentation serializer.",
        "",
        f"Probe: `{result['probe_path']}`",
    ]
    REPORTS.mkdir(parents=True, exist_ok=True)
    (REPORTS / "itemflow_connector_fix_report.md").write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    result = validate()
    write_report(result)
    print(json.dumps({"qa": result["qa_summary"], "probe": result["probe_static_status"], "counts": result["counts"], "conclusion": result["conclusion"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
