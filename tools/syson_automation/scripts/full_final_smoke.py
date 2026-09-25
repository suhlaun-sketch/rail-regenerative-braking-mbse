"""Four required live SysON representation preflights for the final project."""
from __future__ import annotations

import json
from pathlib import Path

from tools.syson_automation.src.representation_service import RepresentationService
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
STATE = ROOT / "tools/syson_automation/cache/full_final_project.json"
INDEX = ROOT / "tools/syson_automation/cache/full_final_element_index.json"
TRACE = ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/FULL_PORT_TRACEABILITY.json"
OUT = ROOT / "work/reports/FULL_SYSON_SMOKE.json"


def main() -> None:
    state = json.loads(STATE.read_text(encoding="utf-8"))
    index = json.loads(INDEX.read_text(encoding="utf-8"))
    trace = json.loads(TRACE.read_text(encoding="utf-8"))
    c = SysONClient(timeout=120)
    svc = RepresentationService(c, state["editing_context_id"])
    by_label = index["by_semantic_id"]

    def oid(label: str) -> str:
        ids = by_label.get(label, [])
        if len(ids) != 1:
            hits = [x for x in c.search(state["editing_context_id"], label) if x["label"] == label]
            ids = [x["id"] for x in hits]
        if len(ids) != 1:
            raise RuntimeError(f"Cannot uniquely resolve {label}: {len(ids)}")
        return ids[0]

    def view(name: str, root: str, description: str, nodes: list[str]) -> dict:
        options = svc.descriptions(oid(root))
        choice = next(x for x in options if x["label"] == description)
        rep = svc.create_or_reuse(stable_key=state["project_id"] + ":" + name,
                                  root_object_id=oid(root), description_id=choice["id"], name=name)
        result = svc.populate_and_verify(rep["id"], [oid(x) for x in nodes], arrange=False)
        diagram = svc.diagram(rep["id"])
        return {"representation_id": rep["id"], "root": root, "description": description,
                "nodes": nodes, "result": result, "edge_target_ids": [x["targetObjectId"] for x in diagram["edges"]],
                "target_object_id": diagram["targetObjectId"]}

    ports = [x["port_id"] for x in trace["port_usages"] if x["owner_product"] == "X100"][:2]
    plans = [
        ("requirement", "AUTO_FULL_SMOKE_REQUIREMENT", "req_REQ_BRK_007", "General View",
         ["req_REQ_BRK_007", "req_REQ_BRK_008"]),
        ("allocation", "AUTO_FULL_SMOKE_ALLOCATION", "FunctionAllocations", "Interconnection View",
         ["fu_F_3000_01", "ap_N_3000", "fu_F_3100_01", "ap_N_3100"]),
        ("port", "AUTO_FULL_SMOKE_PORT", "p_X100", "Interconnection View", ["p_X100"] + ports),
        ("ibd", "AUTO_FULL_SMOKE_IBD_X100", "p_X100", "Interconnection View",
         ["p_X110", "p_X120", "p_X130"]),
    ]
    results = {}
    for stage, name, root, description, nodes in plans:
        try:
            results[stage] = view(name, root, description, nodes)
            r = results[stage]["result"]
            print(f"SMOKE_{stage.upper()}={r['status']} NODES={r['node_count']} EDGES={r['edge_count']}", flush=True)
        except Exception as exc:
            results[stage] = {"error": str(exc)}
            print(f"SMOKE_{stage.upper()}=FAIL ERROR={exc}", flush=True)
            break
        finally:
            OUT.write_text(json.dumps(results, ensure_ascii=False, indent=2), encoding="utf-8")
    if len(results) != 4 or any("error" in x for x in results.values()):
        raise RuntimeError("Smoke creation did not complete")
    if results["allocation"]["result"]["edge_count"] <= 0 or results["ibd"]["result"]["edge_count"] <= 0:
        raise RuntimeError("Required real graphical edges absent")
    if results["port"]["result"]["status"] != "CREATED":
        raise RuntimeError("Port nodes not visible")


if __name__ == "__main__":
    main()
