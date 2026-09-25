"""Read-only final query-back of the existing FULL SysON representations."""
from __future__ import annotations

import json
import hashlib
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path

import psycopg2

from tools.syson_automation.src.representation_service import RepresentationService, REGISTRY
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
REPORTS = ROOT / "work/reports"


def read(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def flatten(nodes):
    for node in nodes:
        yield node
        yield from flatten(node.get("childNodes") or [])
        yield from flatten(node.get("borderNodes") or [])


def main():
    state = read(ROOT / "tools/syson_automation/cache/full_final_project.json")
    registry = read(REPORTS / "FULL_SYSON_VIEW_REGISTRY.json")
    ownership = read(REGISTRY)
    hierarchy = read(REPORTS / "FULL_PRODUCT_HIERARCHY.json")
    previous = read(REPORTS / "FULL_IBD_COMPLETENESS.json")
    index = read(ROOT / "tools/syson_automation/cache/full_final_element_index.json")
    trace = read(ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/FULL_PORT_TRACEABILITY.json")
    relations = read(REPORTS / "FULL_RELATION_ENDPOINTS.json")
    frozen = {
        "SysML_v1": (ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml",
                     "A15CF7170DC5458738080A146C391E438FE57B85F9687857F34A081B8EFDF0D5"),
        "Requirement_V2_Excel": (ROOT / "Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx",
                                 "496736980A493689339EB35DF85EC9603F5F9D0FA5E484EF049F990BF0829F01"),
    }
    frozen_checks = {}
    for name, (path, expected) in frozen.items():
        actual = hashlib.sha256(path.read_bytes()).hexdigest().upper()
        frozen_checks[name] = {"path": str(path), "sha256": actual, "unchanged": actual == expected}
    pilot = read(ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/Official_Validation.json")
    products = {p["product_code"]: p for p in hierarchy["products"]}
    evidence = {r["product_code"]: r for r in previous["rows"]}
    entries_by_id = {e["syson_object_id"]: e for e in index["entries"]}
    rel_by_id = {r["relation_id"]: r for r in relations["relations"]}
    svc = RepresentationService(SysONClient(timeout=60), state["editing_context_id"])
    live_reps = {r["label"]: r for r in svc.representations()}
    if len(live_reps) != len(svc.representations()):
        raise RuntimeError("Duplicate live representation labels")
    if len([n for n in registry if n.startswith("AUTO_IBD_")]) != 57:
        raise RuntimeError("Expected exactly 57 registered formal IBDs")

    conn = psycopg2.connect(host="127.0.0.1", dbname="postgres", user="syson")
    conn.set_session(readonly=True)
    cur = conn.cursor()
    cur.execute("select id,content from representation_content where id like %s", ("%",))
    persisted = {}
    for key, content in cur:
        if "#" in key:
            persisted[key.rsplit("#", 1)[1]] = json.loads(content)
    cur.close()
    conn.close()

    rows = []
    failures = []
    for code in hierarchy["container_codes"]:
        name = f"AUTO_IBD_{code}"
        product = products[code]
        record = registry[name]
        rep_id = record["representation_id"]
        issues = []
        if name not in live_reps or live_reps[name]["id"] != rep_id:
            issues.append("representation missing or ID mismatch in live project")
        own = ownership.get(state["project_id"] + ":" + name)
        if not own or own.get("id") != rep_id or own.get("created_by") != "syson_automation":
            issues.append("ownership registry mismatch")
        diagram = persisted.get(rep_id)
        if not diagram:
            issues.append("persisted diagram missing")
            failures.append({"name": name, "issues": issues})
            continue
        live = svc.diagram(rep_id, deep=False)
        if live["id"] != rep_id or live["targetObjectId"] != diagram["targetObjectId"]:
            issues.append("live diagram identity mismatch")
        if {n["targetObjectId"] for n in live["nodes"]} != {n["targetObjectId"] for n in diagram["nodes"]}:
            issues.append("live top-level node mismatch")
        if {e["targetObjectId"] for e in live["edges"]} != {e["targetObjectId"] for e in diagram["edges"]}:
            issues.append("live edge mismatch")
        all_nodes = list(flatten(diagram["nodes"]))
        object_ids = {n["targetObjectId"] for n in all_nodes}
        child_codes = product["direct_children"]
        child_ids = {}
        for child_code in child_codes:
            usage = products[child_code]["usage_id"]
            matching = [e for e in index["entries"] if e["semantic_id"] == usage and
                        e["qualified_name"] == f"ProductDefinitions::{product['definition_id']}::{usage}"]
            if len(matching) != 1:
                issues.append(f"direct child {child_code} has {len(matching)} semantic matches")
                continue
            child_ids[child_code] = matching[0]["syson_object_id"]
        absent_children = sorted(c for c, oid in child_ids.items() if oid not in object_ids)
        if absent_children:
            issues.append("missing graphical direct children: " + ",".join(absent_children))
        unexpected_grandchildren = []
        for child_code in child_codes:
            for grand_code in products[child_code]["direct_children"]:
                grand_id = index["by_semantic_id"].get(products[grand_code]["usage_id"], [])
                if any(oid in {n["targetObjectId"] for n in diagram["nodes"]} for oid in grand_id):
                    unexpected_grandchildren.append(grand_code)
        if unexpected_grandchildren:
            issues.append("grandchildren placed at top level: " + ",".join(unexpected_grandchildren))
        owner_ports = [p for p in trace["port_usages"] if p["owner_product"] == code]
        absent_owner_ports = [p["port_id"] for p in owner_ports if p.get("port_object_id") not in object_ids]
        if absent_owner_ports:
            issues.append(f"missing owner boundary PortUsage: {len(absent_owner_ports)}")
        child_port_entries = [e for e in index["entries"] if e["sysml_type"] == "PortUsage" and
                              any(e["qualified_name"].startswith(f"ProductDefinitions::{products[c]['definition_id']}::") and
                                  e["qualified_name"].count("::") == 2 for c in child_codes)]
        absent_child_ports = [e["semantic_id"] for e in child_port_entries if e["syson_object_id"] not in object_ids]
        if absent_child_ports:
            issues.append(f"missing direct-child PortUsage: {len(absent_child_ports)}")
        visible_ports = [oid for oid in object_ids if entries_by_id.get(oid, {}).get("sysml_type") == "PortUsage"]
        edge_ids = [e["targetObjectId"] for e in diagram["edges"]]
        edge_types = Counter((rel_by_id.get(eid, {}).get("relation_metaclass") or
                              entries_by_id.get(eid, {}).get("sysml_type") or "UNRESOLVED") for eid in edge_ids)
        if edge_types.get("UNRESOLVED"):
            issues.append("graphical edge target lacks semantic relation evidence")
        interaction_edges = edge_types["ConnectionUsage"] + edge_types["InterfaceUsage"]
        if evidence[code]["expected_internal_evidence_count"] and interaction_edges == 0:
            issues.append("real internal interaction has zero graphical connector/interface edge")
        view_matches = [e for e in index["entries"] if e["semantic_id"] == name and
                        e["qualified_name"].endswith("::" + product["usage_id"] + "::" + name)]
        if len(view_matches) != 1 or view_matches[0]["syson_object_id"] != diagram["targetObjectId"]:
            issues.append("ViewUsage is not attached to the matching Product Usage")
        if record["root_object_id"] not in index["by_semantic_id"].get(product["usage_id"], []):
            issues.append("root object does not resolve to Product Usage")
        row = {"name": name, "representation_id": rep_id, "root_product": code,
               "root_usage": product["usage_id"], "level": product["level"],
               "direct_children": child_codes, "direct_children_visible": len(child_ids) - len(absent_children),
               "owner_boundary_ports": len(owner_ports), "owner_boundary_ports_visible": len(owner_ports) - len(absent_owner_ports),
               "direct_child_ports": len(child_port_entries), "direct_child_ports_visible": len(child_port_entries) - len(absent_child_ports),
               "ports": len(visible_ports), "edges": interaction_edges,
               "connection_usage_edges": edge_types["ConnectionUsage"],
               "interface_usage_edges": edge_types["InterfaceUsage"],
               "other_graphical_edges": {k: v for k, v in edge_types.items() if k not in ("ConnectionUsage", "InterfaceUsage")},
               "top_level_nodes": len(diagram["nodes"]), "status": "PASS" if not issues else "FAIL", "issues": issues}
        rows.append(row)
        if issues:
            failures.append({"name": name, "issues": issues})
        print(f"FINAL_IBD {name} {row['status']} CHILDREN={row['direct_children_visible']}/{len(child_codes)} PORTS={row['ports']} EDGES={row['edges']}", flush=True)

    formal = {}
    for name in ("AUTO_PRODUCT_ARCHITECTURE_ROOT", "AUTO_FUNCTION_PRODUCT_ALLOCATION",
                 "AUTO_REQ_ALL", "AUTO_REQ_FUNCTION_TRACE"):
        record = registry[name]
        diagram = persisted.get(record["representation_id"])
        live = svc.diagram(record["representation_id"], deep=False)
        issues = []
        if not diagram or live["id"] != diagram["id"]:
            issues.append("missing live or persisted diagram")
        elif {e["targetObjectId"] for e in live["edges"]} != {e["targetObjectId"] for e in diagram["edges"]}:
            issues.append("live graphical edge mismatch")
        node_ids = {n["targetObjectId"] for n in flatten(diagram["nodes"])} if diagram else set()
        kinds = Counter(entries_by_id.get(oid, {}).get("sysml_type", "OTHER") for oid in node_ids)
        edge_kinds = Counter(rel_by_id.get(e["targetObjectId"], {}).get("relation_metaclass", "OTHER") for e in diagram["edges"]) if diagram else Counter()
        if name == "AUTO_FUNCTION_PRODUCT_ALLOCATION" and edge_kinds["AllocationUsage"] != 191:
            issues.append("expected 191 graphical AllocationUsage edges")
        if name == "AUTO_REQ_ALL" and kinds["RequirementUsage"] != 46:
            issues.append("expected 46 RequirementUsage nodes")
        if name == "AUTO_REQ_FUNCTION_TRACE" and (kinds["RequirementUsage"] != 46 or kinds["ActionUsage"] != 191):
            issues.append("expected 46 RequirementUsage and 191 ActionUsage nodes")
        if name == "AUTO_PRODUCT_ARCHITECTURE_ROOT":
            root_ids = {index["by_semantic_id"][p["usage_id"]][0] for p in products.values() if p["level"] == 1}
            if not root_ids <= node_ids:
                issues.append("missing L1 Product Usage")
        formal[name] = {"representation_id": record["representation_id"], "nodes": len(node_ids),
                        "visible_kinds": dict(kinds), "graphical_edges": dict(edge_kinds),
                        "status": "PASS" if not issues else "FAIL", "issues": issues}
        if issues:
            failures.append({"name": name, "issues": issues})
        print(f"FINAL_VIEW {name} {formal[name]['status']} NODES={len(node_ids)} EDGES={sum(edge_kinds.values())}", flush=True)

    if any(not v["unchanged"] for v in frozen_checks.values()):
        failures.append({"name": "FROZEN_BASELINE", "issues": ["baseline SHA-256 mismatch"]})
    if any(pilot.get(k) != 0 for k in ("syntax_error_count", "semantic_error_count", "warning_count")):
        failures.append({"name": "PILOT_VALIDATION", "issues": ["existing official validation is not clean"]})
    report = {"project_name": state["project_name"], "project_id": state["project_id"],
              "editing_context_id": state["editing_context_id"], "checked_at_utc": datetime.now(timezone.utc).isoformat(),
              "method": "SysON diagramEvent live query-back + read-only persisted representation_content + source evidence",
              "ibd_count": len(rows), "ibd_pass": sum(r["status"] == "PASS" for r in rows),
              "rows": rows, "formal_views": formal,
              "frozen_baseline_checks": frozen_checks,
              "pilot_validation": {k: pilot.get(k) for k in ("syntax_error_count", "semantic_error_count", "warning_count")},
              "layout_only_views": ["AUTO_IBD_8000", "AUTO_IBD_8100", "AUTO_IBD_8120"],
              "semantic_satisfy_relations": relations["counts"]["SatisfyRequirementUsage"],
              "requirement_satisfy_graphical_edges": formal["AUTO_REQ_FUNCTION_TRACE"]["graphical_edges"].get("SatisfyRequirementUsage", 0),
              "failures": failures,
              "graphical_containment_validated": False,
              "superseded_by": ["work/reports/IBD_PORT_OWNERSHIP_AUDIT_X130.json",
                                "work/reports/IBD_PORT_OWNERSHIP_AUDIT_3110.json"],
              "status": "SUPERSEDED_VISIBILITY_ONLY" if not failures and len(rows) == 57 else "FAIL"}
    target = REPORTS / "FULL_SYSON_FINAL_QA.json"
    target.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"FINAL_QA={report['status']} IBD={report['ibd_pass']}/{report['ibd_count']} FAILURES={len(failures)}", flush=True)
    if failures:
        for failure in failures:
            print("FAIL", failure["name"], "; ".join(failure["issues"]), flush=True)
        raise SystemExit(1)


if __name__ == "__main__":
    main()
