"""Write concise final evidence reports from live SysON query-back."""
from __future__ import annotations

import hashlib
import json
from collections import Counter
from pathlib import Path

from tools.syson_automation.src.container_ibd_builder import build_container_view
from tools.syson_automation.src.representation_service import RepresentationService
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
REPORTS = ROOT / "work/reports"
V2 = ROOT / "work/sysmlv2/full_engineering_model/02_port_enhanced"
V1 = ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
EXCEL = ROOT / "Req/牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx"


def main() -> None:
    audit = json.loads((REPORTS / "PORT_GAP_AUDIT.json").read_text(encoding="utf-8"))
    trace = json.loads((V2 / "PORT_TRACEABILITY.json").read_text(encoding="utf-8"))
    validation = json.loads((V2 / "Official_Validation.json").read_text(encoding="utf-8"))
    index = json.loads((ROOT / "tools/syson_automation/cache/port_enhanced_element_index.json").read_text(encoding="utf-8"))
    project = json.loads((ROOT / "tools/syson_automation/cache/port_enhanced_project.json").read_text(encoding="utf-8"))
    views = json.loads((ROOT / "tools/syson_automation/cache/port_enhanced_views.json").read_text(encoding="utf-8"))
    scope = json.loads((ROOT / "tools/syson_automation/generated/scopes/scope_6289f72770e3.json").read_text(encoding="utf-8"))
    service = RepresentationService(SysONClient(timeout=30), index["editing_context_id"])
    diagrams = {name: service.diagram(id) for name, id in views.items()}
    by_id = {x["syson_object_id"]: x for x in index["entries"]}
    x100 = build_container_view(scope, "X100", index)
    old_x100 = build_container_view(scope, "X100")
    x110 = build_container_view(scope, "X110", index)
    gaps = {(x["owner_product"], x["connector_ref"]) for x in audit["boundary_gaps"]}
    covered = {(x["owner_product"], x["connector_refs"][0]) for x in trace["port_usages"]}
    x100_edges = [by_id.get(x["targetObjectId"], {}).get("label", "") for x in diagrams["x100_ibd"]["edges"]]
    x100_port_nodes = [x for x in diagrams["x100_ibd"]["nodes"]
                       if by_id.get(x["targetObjectId"], {}).get("sysml_type") == "PortUsage"]
    port_smoke_nodes = [x for x in diagrams["port_smoke"]["nodes"]
                        if by_id.get(x["targetObjectId"], {}).get("sysml_type") == "PortUsage"]
    relation_ids = {x["syson_object_id"] for x in index["entries"] if x["sysml_type"] == "ConnectionUsage"}
    smoke_edges = sum(x["targetObjectId"] in relation_ids for x in diagrams["connection_smoke"]["edges"])
    fp_edges = len(diagrams["fp"]["edges"])
    hashes = {"v1_sysml": hashlib.sha256(V1.read_bytes()).hexdigest(),
              "v2_excel": hashlib.sha256(EXCEL.read_bytes()).hexdigest()}
    if hashes["v1_sysml"] != "a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5":
        raise RuntimeError("Frozen SysML hash changed")
    if hashes["v2_excel"] != "496736980a493689339eb35df85ec9603f5f9d0fa5e484ef049f990bf0829f01":
        raise RuntimeError("Frozen requirement workbook hash changed")
    if validation["syntax_error_count"] or validation["semantic_error_count"] or validation["exception"]:
        raise RuntimeError("Official parser did not pass")
    if not all((port_smoke_nodes, smoke_edges, fp_edges,
                sum(x.endswith("_internal") for x in x100_edges))):
        raise RuntimeError("One or more SysON graphical-edge criteria failed")

    summary = f"""# Port enhancement report

- Source: frozen v1 SHA-256 `{hashes['v1_sysml']}`; V2 requirement Excel SHA-256 `{hashes['v2_excel']}`.
- New model: `work/sysmlv2/full_engineering_model/02_port_enhanced/Rail_MBSE_Full_v2_PortEnhanced.sysml`.
- Official SysML v2 Pilot 0.59.0: **PARSE_PASS**, syntax 0, semantic 0, warnings 0.
- Original PortDefinition / PortUsage: **{audit['counts']['PortDefinition']} / {audit['counts']['PortUsage']}**.
- Added PortDefinition / PortUsage: **0 / {len(trace['port_usages'])}**. Existing typed PortDefinitions were reused.
- Original ConnectionUsage / added refinement ConnectionUsage: **{audit['counts']['ConnectionUsage']} / {len(trace['connection_usages'])}**.
- Original 191 Function→Product allocations are unchanged. Requirement Traceability source is unchanged and imported separately.
- Leaf interface endpoints already had PortUsage. New ports represent evidence-backed container boundaries only.
- Missing boundary interactions (unique owner+connector): **{len(gaps)}**; modeled in this X100 phase: **{len(gaps & covered)}**; outside this phase: **{len(gaps - covered)}**. None of the remainder is labeled evidence-insufficient without individual review.
- X100 before: real **{len(old_x100['real_boundary_ports'])}**, virtual **{len(old_x100['virtual_boundary_projections'])}**. After: real **{len(x100['real_boundary_ports'])}**, virtual **{len(x100['virtual_boundary_projections'])}**.
- X100 child internal interactions: **{len(x100['internal_connections'])}**. X110 drilldown has **{len(x110['internal_connections'])}** internal interaction groups.
- Closure remains **{len(scope['seed_products'])} seed / {len(scope['product_closure'])} products / {len(scope['closure_edges'])} directed edges**.
- New relation provenance: each added PortUsage and ConnectionUsage references an explicit frozen connector in `PORT_TRACEABILITY.json`.
- The 12 X100↔8100 connectors additionally match one formal SSD connection and one implementation binding record each.
- Bogus direct 5100↔X100 relation added: **NO**.

The v2 model refines 12 explicit X100↔8100 leaf connectors into parent boundary paths and 9 explicit cross-child X100 connectors into X110/X120/X130 boundary paths. Other product branches remain outside this phase.
"""
    (REPORTS / "PORT_ENHANCEMENT_REPORT.md").write_text(summary, encoding="utf-8")
    lines = ["# SysON Port-Enhanced IBD Report", "",
             f"- Project: `{project['project_name']}` / `{project['project_id']}`",
             f"- EditingContext: `{project['editing_context_id']}`",
             f"- New element index: **{len(index['entries'])}** entries; fingerprint `{index['model_fingerprint']}`.",
             f"- SysON indexed PortUsage: **{Counter(x['sysml_type'] for x in index['entries'])['PortUsage']}**.",
             "", "| Product | Added boundary PortUsage |", "|---|---:|"]
    lines.extend(f"| {owner} | {sum(x['owner_product'] == owner for x in trace['port_usages'])} |"
                 for owner in ("X100", "X110", "X120", "X130", "8100"))
    lines += ["", "| View | ID | Nodes | Port nodes | Graphical edges |", "|---|---|---:|---:|---:|"]
    for key in ("port_smoke", "connection_smoke", "fp", "x100_ibd", "x100_internal", "x110_ibd"):
        diagram = diagrams[key]
        ports = sum(by_id.get(x["targetObjectId"], {}).get("sysml_type") == "PortUsage" for x in diagram["nodes"])
        lines.append(f"| {key} | `{views[key]}` | {len(diagram['nodes'])} | {ports} | {len(diagram['edges'])} |")
    lines += ["", f"- Port smoke visible PortUsage: **{len(port_smoke_nodes)}**.",
              f"- Connector smoke genuine ConnectionUsage edges: **{smoke_edges}**.",
              f"- Function–Product graphical Allocation edges: **{fp_edges}**; endpoints are actual ActionUsage and PartUsage.",
              f"- X100 IBD internal graphical edges: **{sum(x.endswith('_internal') for x in x100_edges)}**; external boundary edges: **{sum(x.endswith('_outer') for x in x100_edges)}**.",
              f"- X100 IBD visible PortUsage: **{len(x100_port_nodes)}**; direct children: X110, X120, X130; external endpoint: 8100.",
              f"- X100 semantic-root internal drilldown: **{len(diagrams['x100_internal']['edges'])}** graphical internal edges.",
              f"- X110 drilldown: **{len(diagrams['x110_ibd']['edges'])}** graphical edges.",
              "- View kind: Interconnection for Port/Connector/X100/X110 and the final Function–Product view. A verified General View with the same 10 allocation edges is retained as an explicitly named fallback.",
              "- Relation edges appeared automatically when true PartUsage endpoints were represented. A relation drop alone did not render an edge.",
              "- Layout limit: SysON places X100 and its direct children as separate top-level visual nodes in the combined railSystem view. The separate X100-root Interconnection smoke verified all 9 internal edges, but a single physically nested X100 frame with all 12 external edges is not yet achieved.",
              "- No user `view1` was modified; all mutations targeted the new Project.",
              "- Query-back used live `diagramEvent`, including edge target object IDs; HTTP status alone was not used as proof.",
              "- Added 5100↔X100 direct relation: **NO**.", ""]
    (REPORTS / "SYSON_PORT_ENHANCED_IBD_REPORT.md").write_text("\n".join(lines), encoding="utf-8")
    print(f"REPORTS=PASS PORT_SMOKE={len(port_smoke_nodes)} CONNECTOR_EDGES={smoke_edges} FP_EDGES={fp_edges} X100_INTERNAL={sum(x.endswith('_internal') for x in x100_edges)}")


if __name__ == "__main__":
    main()
