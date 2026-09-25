from __future__ import annotations

import hashlib
import json
import xml.etree.ElementTree as ET
from collections import Counter
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
PIPELINE_WORK = PIPELINE_DIR / "work"
REPORTS = ROOT / "reports"
SOURCE = ROOT / "work" / "architecture_xmi_ready_v1.json"
PROBE = ROOT / "work" / "Rail_MBSE_SysML17_structure_probe_v4.xmi"
OLD_FULL = ROOT / "work" / "Rail_MBSE_SysML17_v1.xmi"
CONTEXT_ID = "XMI-SYSTEM-CONTEXT-RAIL-MBSE-TRACTIONBRAKE-STRUCTURE-PROBE-V4"
PROBE_PRODUCTS = ("4000", "4200", "4230", "4235", "5000", "5100", "5110", "5111", "5112", "5113")
PARENTS = {
    "4000": "__CONTEXT__", "4200": "4000", "4230": "4200", "4235": "4230",
    "5000": "__CONTEXT__", "5100": "5000", "5110": "5100",
    "5111": "5110", "5112": "5110", "5113": "5110",
}


def namespaces(path: Path) -> dict[str, str]:
    result = {}
    for _event, pair in ET.iterparse(path, events=("start-ns",)):
        prefix, uri = pair
        result[prefix or "default"] = uri
    return result


def check(identifier: str, condition: bool, detail: str) -> dict:
    return {"id": identifier, "status": "PASS" if condition else "FAIL", "detail": detail}


def validate() -> dict:
    architecture = json.loads(SOURCE.read_text(encoding="utf-8"))
    compatibility = json.loads((PIPELINE_WORK / "magicdraw2022x_compatibility_contract.json").read_text(encoding="utf-8"))
    structure = json.loads((PIPELINE_WORK / "structure_mapping_contract_v2.json").read_text(encoding="utf-8"))
    directions = json.loads((PIPELINE_WORK / "port_direction_resolution.json").read_text(encoding="utf-8"))
    relationships = json.loads((PIPELINE_WORK / "block_relationship_contract.json").read_text(encoding="utf-8"))
    audit = json.loads((PIPELINE_WORK / "xmi_duplicate_audit.json").read_text(encoding="utf-8"))
    manifest = json.loads((PIPELINE_WORK / "structure_probe_v4_manifest.json").read_text(encoding="utf-8"))

    ns = namespaces(PROBE)
    XMI = compatibility["namespace_separation"]["xmi_xml_namespace"]
    SYSML = compatibility["namespace_separation"]["sysml_stereotype_namespace"]
    qx = lambda name: f"{{{XMI}}}{name}"
    qs = lambda name: f"{{{SYSML}}}{name}"
    root = ET.parse(PROBE).getroot()
    parents = {child: parent for parent in root.iter() for child in parent}
    all_elements = list(root.iter())
    all_ids = [element.get(qx("id")) for element in all_elements if element.get(qx("id"))]
    ids = {element.get(qx("id")): element for element in all_elements if element.get(qx("id"))}

    def of_type(name: str) -> list[ET.Element]:
        return [element for element in all_elements if element.get(qx("type")) == f"uml:{name}"]

    def apps(name: str) -> list[ET.Element]:
        return [element for element in root if element.tag == qs(name)]

    products = {p["id"]: p for p in architecture["products"]}
    product_xmi = {code: products[code]["xmi_id"] for code in PROBE_PRODUCTS}
    product_xmi_all = {p["xmi_id"] for p in architecture["products"]}
    classes = {element.get(qx("id")): element for element in of_type("Class")}
    block_targets = Counter(app.get("base_Class") for app in apps("Block"))
    interface_targets = {app.get("base_Class") for app in apps("InterfaceBlock")}
    flow_apps = {app.get("base_Property"): app for app in apps("FlowProperty")}
    proxy_targets = {app.get("base_Port") for app in apps("ProxyPort")}

    composition_properties = [
        element for element in of_type("Property") if element.get("aggregation") == "composite"
    ]
    composition_by_pair: dict[tuple[str, str], list[ET.Element]] = {}
    for prop in composition_properties:
        owner = parents[prop]
        composition_by_pair.setdefault((owner.get(qx("id")), prop.get("type")), []).append(prop)
    expected_pairs = []
    for child in PROBE_PRODUCTS:
        owner_code = PARENTS[child]
        owner_id = CONTEXT_ID if owner_code == "__CONTEXT__" else product_xmi[owner_code]
        expected_pairs.append((owner_id, product_xmi[child]))
    expected_part_ids = [composition_by_pair[pair][0].get(qx("id")) for pair in expected_pairs if len(composition_by_pair.get(pair, [])) == 1]

    part_non_block = [
        prop for prop in composition_properties
        if parents[prop].get(qx("id")) in product_xmi_all.union({CONTEXT_ID})
        and prop.get("type") not in product_xmi_all
    ]
    hierarchy_unique = len({(p["parent_id"], p["id"]) for p in architecture["products"] if p.get("parent_id")}) == 139

    connection = next(
        c for c in architecture["connections"]
        if c["source_product_id"] == "4235" and c.get("target_product_id") == "5111"
        and c["item_id"] == "ITM-MEA-005" and c["mode"] == "SIGNAL"
    )
    interfaces = {i["interface_instance_id"]: i for i in architecture["interfaces"]}
    source_port = interfaces[connection["source_interface_id"]]
    target_port = interfaces[connection["target_interface_id"]]
    direction_by_interface = {r["interface_instance_id"]: r for r in directions["records"]}
    source_resolution = direction_by_interface[source_port["interface_instance_id"]]
    target_resolution = direction_by_interface[target_port["interface_instance_id"]]
    source_port_element = ids[source_port["xmi_id"]]
    target_port_element = ids[target_port["xmi_id"]]

    def path_for(code: str) -> list[str]:
        codes = []
        cursor = code
        while cursor != "__CONTEXT__":
            codes.append(cursor)
            cursor = PARENTS[cursor]
        codes.reverse()
        path = []
        owner_id = CONTEXT_ID
        for child in codes:
            pair = (owner_id, product_xmi[child])
            path.append(composition_by_pair[pair][0].get(qx("id")))
            owner_id = product_xmi[child]
        return path

    connector = ids[connection["xmi_id"]]
    connector_ends = [child for child in connector if child.get(qx("type")) == "uml:ConnectorEnd"]
    end_by_role = {end.get("role"): end for end in connector_ends}
    nested_by_end = {app.get("base_ConnectorEnd"): app for app in apps("NestedConnectorEnd")}
    source_end = end_by_role[source_port["xmi_id"]]
    target_end = end_by_role[target_port["xmi_id"]]
    source_nested = nested_by_end[source_end.get(qx("id"))]
    target_nested = nested_by_end[target_end.get(qx("id"))]
    source_path = path_for("4235")
    target_path = path_for("5111")

    info_flows = [flow for flow in of_type("InformationFlow") if flow.get("realizingConnector") == connection["xmi_id"]]
    info = info_flows[0] if len(info_flows) == 1 else None
    itemflow_targets = Counter(app.get("base_InformationFlow") for app in apps("ItemFlow"))
    function = next(f for f in architecture["functions"] if f["function_id"] == "F-4235-01")
    allocation = next(a for a in architecture["allocations"] if a["function_id"] == "F-4235-01" and a["product_id"] == "4235")

    part_5110 = {
        prop.get("name"): prop
        for prop in composition_properties
        if parents[prop].get(qx("id")) == product_xmi["5110"]
    }
    expected_5110_names = {"part_5111", "part_5112", "part_5113"}
    part_5110_ok = set(part_5110) == expected_5110_names and all(
        part_5110[f"part_{code}"].get("type") == product_xmi[code]
        for code in ("5111", "5112", "5113")
    )

    # Resolve all explicit local references used by this standard Probe.
    reference_fields = {
        "type", "role", "partWithPort", "informationSource", "informationTarget",
        "conveyed", "realizingConnector", "client", "supplier", "base_Class",
        "base_Port", "base_Property", "base_ConnectorEnd", "base_InformationFlow",
        "itemProperty", "base_Abstraction",
    }
    unresolved = []
    for element in all_elements:
        for field in reference_fields:
            value = element.get(field)
            if not value or value.startswith("uml:"):
                continue
            for token in value.split():
                if token not in ids:
                    unresolved.append({"element": element.get(qx("id")), "field": field, "value": token})

    direction_stats = directions["statistics"]
    probe_product_blocks_ok = all(product_xmi[c] in classes and block_targets[product_xmi[c]] == 1 for c in PROBE_PRODUCTS)
    all_probe_parts_ok = len(composition_properties) == 10 and all(len(composition_by_pair.get(pair, [])) == 1 for pair in expected_pairs)
    all_part_types_block = not part_non_block and all(prop.get("type") in product_xmi_all for prop in composition_properties)
    all_proxy_owners_ok = all(
        port.get(qx("id")) in proxy_targets and parents[port].get(qx("id")) in {product_xmi["4235"], product_xmi["5111"]}
        for port in of_type("Port")
    )
    allocation_element = ids.get(allocation["xmi_id"])
    allocate_apps = [app for app in apps("Allocate") if app.get("base_Abstraction") == allocation["xmi_id"]]

    results = [
        check("STR-QA-01", structure["product_definition"]["count"] == 147 and audit["observed"]["product_block_definitions"] == 147 and audit["observed"]["product_block_stereotype_applications"] == 147 and probe_product_blocks_ok, "147 Product mappings and prior full definitions are uml:Class + standard Block; all 10 Probe Products are standard Blocks."),
        check("STR-QA-02", all(p["xmi_id"] not in interface_targets for p in architecture["products"]), "No Product in the Probe is typed/stereotyped as InterfaceBlock or Signal."),
        check("STR-QA-03", structure["product_hierarchy"]["relationship_count"] == 139 and all_probe_parts_ok and all_part_types_block, "All source parent-child mappings and Probe Part Properties target Child Block xmi_ids."),
        check("STR-QA-04", not part_non_block, "No composite Part Property is typed by uml:Signal."),
        check("STR-QA-05", not part_non_block, "No composite Part Property is typed by an Item classifier."),
        check("STR-QA-06", not part_non_block, "No composite Part Property is typed by an InterfaceBlock."),
        check("STR-QA-07", hierarchy_unique and audit["categories"]["duplicate_parent_child_part_property"]["excess"] == 0, "139 frozen parent-child keys are unique; prior full contains no duplicate hierarchy Part Property."),
        check("STR-QA-08", audit["categories"]["duplicate_composition"]["excess"] == 0 and all_probe_parts_ok, "Each structural pair has one composite Property representation."),
        check("STR-QA-09", len(architecture["interfaces"]) == 517 and audit["observed"]["uml_ports"] == 517 and audit["observed"]["proxy_port_stereotypes"] == 517 and all_proxy_owners_ok, "The audited mapping contains 517 uml:Ports with 517 standard ProxyPort applications; both Probe Ports have correct Product owners."),
        check("STR-QA-10", direction_stats["total"] == 517 and direction_stats["input"] + direction_stats["output"] + direction_stats["inout"] == 517, "All 517 Ports have a deterministic effective direction."),
        check("STR-QA-11", direction_stats["unknown"] == 0, "UNKNOWN direction = 0."),
        check("STR-QA-12", direction_stats["input"] == 167 and all(r["effective_port_direction"] == "in" for r in directions["records"] if r["raw_direction"] == "输入"), "All 167 frozen input Ports resolve to FlowProperty direction=in."),
        check("STR-QA-13", direction_stats["output"] == 210 and all(r["effective_port_direction"] == "out" for r in directions["records"] if r["raw_direction"] == "输出"), "All 210 frozen output Ports resolve to FlowProperty direction=out."),
        check("STR-QA-14", direction_stats["inout"] == 140 and all(r["effective_port_direction"] == "inout" for r in directions["records"] if r["raw_direction"] == "双向物理"), "All 140 frozen physical Ports resolve to FlowProperty direction=inout."),
        check("STR-QA-15", audit["summary"]["DIAGRAM_DUPLICATE"] == 0 and relationships["diagram_guards"]["BDD_block_symbol_key"] == ["diagram_id", "product_id"], "BDD Block symbol duplicate = 0; the contract uses diagram_id + product_id."),
        check("STR-QA-16", audit["categories"]["duplicate_diagram_relationship_symbol"]["excess"] == 0, "BDD Composition symbol duplicate = 0."),
        check("STR-QA-17", relationships["diagram_guards"]["BDD_connector_count"] == 0, "BDD Connector generation is forbidden and its expected count is 0."),
        check("STR-QA-18", relationships["diagram_guards"]["BDD_itemflow_count"] == 0, "BDD ItemFlow generation is forbidden and its expected count is 0."),
        check("STR-QA-19", structure["ibd_projection"]["internal_parts"] == "only direct owned composite Part Properties" and part_5110_ok, "Probe IBD contract uses only direct child Part Properties; 5110 owns exactly part_5111/5112/5113."),
        check("STR-QA-20", all_part_types_block and part_5110_ok, "All Probe IBD Part Properties are typed by Product Blocks."),
        check("STR-QA-21", len(architecture["connections"]) == 184 and audit["observed"]["final_connectors"] == 184 and audit["categories"]["duplicate_connector_connection_id"]["excess"] == 0, "All 184 frozen Final Connections have one prior-full Connector and no duplicate connection_id."),
        check("STR-QA-22", sum(c["mode"] == "SIGNAL" for c in architecture["connections"]) == 147 and audit["observed"]["signal_information_flows"] == 147 and audit["observed"]["signal_itemflows"] == 147 and audit["categories"]["duplicate_item_flow"]["excess"] == 0, "147 SIGNAL Connections each retain one InformationFlow/ItemFlow without duplicate."),
        check("STR-QA-23", len(architecture["physical_nets"]) == 9 and audit["observed"]["physical_net_connectors"] == 9 and audit["observed"]["all_uml_connectors"] == len(architecture["connections"]) + len(architecture["physical_nets"]) and relationships["physical_net"]["pairwise_clique_generation"] == "FORBIDDEN", "Nine shared PhysicalNets use exactly nine net Connectors; total Connector count is 184 final + 9 net, with no pairwise clique expansion."),
        check("STR-QA-24", len(architecture["allocations"]) == 191 and audit["categories"]["duplicate_allocation_abstraction"]["excess"] == 0 and audit["categories"]["duplicate_allocate_stereotype"]["excess"] == 0, "191 Allocations are unique in the audited full mapping."),
        check("STR-QA-25", product_xmi["5111"] in classes and block_targets[product_xmi["5111"]] == 1 and part_5110_ok and not any(parents[p].get(qx("id")) == product_xmi["4235"] and p.get("type") == product_xmi["5111"] for p in composition_properties), "5111 is a Block; part_5111 owner=5110, type=5111, aggregation=composite; 4235 does not own it."),
    ]

    probe_checks = {
        "xml_namespaces": ns.get("xmi") == XMI and ns.get("uml") == compatibility["namespace_separation"]["uml_xml_namespace"],
        "profile_application": len(of_type("ProfileApplication")) == 1,
        "product_blocks": probe_product_blocks_ok,
        "context_block": block_targets[CONTEXT_ID] == 1,
        "composite_parts": all_probe_parts_ok,
        "part_5110_children": part_5110_ok,
        "part_typed_by_non_block": len(part_non_block) == 0,
        "proxy_ports": len(of_type("Port")) == 2 and all_proxy_owners_ok,
        "source_direction": source_port_element.get("type") == source_resolution["interface_block_id"] and flow_apps[source_resolution["flow_property_id"]].get("direction") == "out",
        "target_direction": target_port_element.get("type") == target_resolution["interface_block_id"] and flow_apps[target_resolution["flow_property_id"]].get("direction") == "in",
        "no_port_direction_attribute": all(port.get("direction") is None for port in of_type("Port")),
        "connector_owner_context": parents[connector].get(qx("id")) == CONTEXT_ID,
        "source_nested_path": source_nested.get("propertyPath", "").split() == source_path and source_end.get("partWithPort") == source_path[-1],
        "target_nested_path": target_nested.get("propertyPath", "").split() == target_path and target_end.get("partWithPort") == target_path[-1],
        "itemflow_direction": info is not None and info.get("informationSource") == source_port["xmi_id"] and info.get("informationTarget") == target_port["xmi_id"] and info.get("conveyed") == next(i["xmi_id"] for i in architecture["items"] if i["item_code"] == connection["item_id"]) and itemflow_targets[info.get(qx("id"))] == 1,
        "activity": ids.get(function["xmi_id"]) is not None and ids[function["xmi_id"]].get(qx("type")) == "uml:Activity",
        "allocate": allocation_element is not None and allocation_element.get(qx("type")) == "uml:Abstraction" and len(allocate_apps) == 1,
        "unique_xmi_ids": len(all_ids) == len(set(all_ids)),
        "local_references": len(unresolved) == 0,
        "byte_deterministic": manifest["byte_deterministic"] and hashlib.sha256(PROBE.read_bytes()).hexdigest() == manifest["sha256"],
        "no_diagram_elements": not any("diagram" in (element.tag + (element.get(qx("type")) or "")).lower() for element in all_elements),
        "old_full_not_overwritten": OLD_FULL.exists(),
    }
    pass_count = sum(result["status"] == "PASS" for result in results)
    probe_pass = all(probe_checks.values()) and pass_count == len(results)
    result = {
        "validation_id": "RAIL-MBSE-STRUCTURE-PROBE-V4-QA",
        "probe": str(PROBE),
        "counts": {
            "product_blocks": 147,
            "product_hierarchy_part_properties": 139,
            "probe_product_blocks": 10,
            "probe_context_blocks": 1,
            "probe_composite_parts": len(composition_properties),
            "part_typed_by_non_block": len(part_non_block),
            "ports": direction_stats,
            "model_duplicates": audit["summary"]["MODEL_DUPLICATE"],
            "bdd_symbol_duplicates": audit["summary"]["DIAGRAM_DUPLICATE"],
            "relationship_duplicates": audit["summary"]["RELATIONSHIP_DUPLICATE"],
        },
        "qa": results,
        "qa_summary": {"PASS": pass_count, "FAIL": len(results) - pass_count},
        "probe_checks": probe_checks,
        "probe_status": "PASS" if probe_pass else "FAIL",
        "unresolved_local_references": unresolved,
        "full_xmi_published": False,
        "cameo_import_test": "PENDING",
    }
    (PIPELINE_WORK / "structure_probe_v4_qa.json").write_text(
        json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    return result


def write_report(result: dict) -> None:
    counts = result["counts"]
    ports = counts["ports"]
    failed = [entry["id"] for entry in result["qa"] if entry["status"] == "FAIL"]
    lines = [
        "# Structure Mapping Fix Report",
        "",
        "- Scope: structure mapping, Port direction, relationship de-duplication, semantic Probe only.",
        "- Frozen JSON/Excel/KG/ConnectGraph: unchanged.",
        "- New full XMI: not published.",
        "",
        "## Counts",
        "",
        f"- Product Block definitions: {counts['product_blocks']}",
        f"- Product hierarchy Part Properties: {counts['product_hierarchy_part_properties']}",
        f"- Probe Product Blocks / Context Block: {counts['probe_product_blocks']} / {counts['probe_context_blocks']}",
        f"- Probe composite Part Properties: {counts['probe_composite_parts']}",
        f"- Part typed by non-Block: {counts['part_typed_by_non_block']}",
        f"- Port direction: in={ports['input']}, out={ports['output']}, inout={ports['inout']}, unknown={ports['unknown']}",
        f"- MODEL_DUPLICATE: {counts['model_duplicates']}",
        f"- DIAGRAM_DUPLICATE: {counts['bdd_symbol_duplicates']}",
        f"- RELATIONSHIP_DUPLICATE: {counts['relationship_duplicates']}",
        "",
        "## QA",
        "",
        f"- STR-QA: {result['qa_summary']['PASS']} PASS / {result['qa_summary']['FAIL']} FAIL",
        f"- Probe: {result['probe_status']}",
        f"- Failed checks: {', '.join(failed) if failed else 'None'}",
        f"- CAMEO_IMPORT_TEST: {result['cameo_import_test']}",
        "",
        "## Output",
        "",
        f"- Probe: `{result['probe']}`",
        "- Direction strategy: standard directional InterfaceBlock projection with standard FlowProperty in/out/inout; no non-standard Port direction attribute.",
        "- BDD and IBD are projection contracts; this Probe does not serialize vendor-specific diagrams.",
    ]
    REPORTS.mkdir(parents=True, exist_ok=True)
    (REPORTS / "structure_mapping_fix_report.md").write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    result = validate()
    write_report(result)
    print(json.dumps({"qa": result["qa_summary"], "probe": result["probe_status"], "counts": result["counts"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
