"""Create/query-back the complete formal SysON view set in four resumable phases."""
from __future__ import annotations

import json
import sys
import time
import uuid
from pathlib import Path

from tools.syson_automation.src.representation_service import RepresentationService
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
STATE = ROOT / "tools/syson_automation/cache/full_final_project.json"
INDEX = ROOT / "tools/syson_automation/cache/full_final_element_index.json"
HIERARCHY = ROOT / "work/reports/FULL_PRODUCT_HIERARCHY.json"
TRACE = ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/FULL_PORT_TRACEABILITY.json"
OUT = ROOT / "work/reports/FULL_SYSON_VIEW_REGISTRY.json"


def main(phase: str) -> None:
    state = json.loads(STATE.read_text(encoding="utf-8"))
    index = json.loads(INDEX.read_text(encoding="utf-8"))
    hierarchy = json.loads(HIERARCHY.read_text(encoding="utf-8"))
    trace = json.loads(TRACE.read_text(encoding="utf-8"))
    rows = {x["product_code"]: x for x in hierarchy["products"]}
    port_by_owner: dict[str, list[dict]] = {}
    for port in trace["port_usages"]:
        port_by_owner.setdefault(port["owner_product"], []).append(port)
    ports_by_definition: dict[str, list[str]] = {}
    for entry in index["entries"]:
        if entry["sysml_type"] != "PortUsage":
            continue
        segments = entry["qualified_name"].split("::")
        if len(segments) >= 2 and segments[-2].startswith("P_"):
            ports_by_definition.setdefault(segments[-2], []).append(entry["label"])
    registry = json.loads(OUT.read_text(encoding="utf-8")) if OUT.is_file() else {}
    client = SysONClient(timeout=180)
    svc = RepresentationService(client, state["editing_context_id"])
    lookup = index["by_semantic_id"]

    def oid(label: str) -> str:
        ids = lookup.get(label, [])
        if len(ids) != 1:
            hits = [x for x in client.search(state["editing_context_id"], label) if x["label"] == label]
            ids = [x["id"] for x in hits]
            if len(ids) == 1:
                lookup[label] = ids
        if len(ids) != 1:
            raise RuntimeError(f"Nonunique/missing SysON anchor {label}: {len(ids)}")
        return ids[0]

    def create(name: str, root: str, description: str, labels: list[str], *, chunk: int = 20) -> None:
        if name in registry and registry[name].get("status") == "PASS" and set(registry[name]["requested_object_ids"]) == {
            oid(label) for label in labels}:
            print(f"{name}=REUSED", flush=True)
            return
        options = svc.descriptions(oid(root))
        selected = next(x for x in options if x["label"] == description)
        rep = svc.create_or_reuse(stable_key=state["project_id"] + ":" + name,
                                  root_object_id=oid(root), description_id=selected["id"], name=name)
        object_ids = list(dict.fromkeys(oid(label) for label in labels))
        if len(object_ids) > 100 or name == "AUTO_REQ_ALL_CANDIDATE":
            shown = {x["targetObjectId"] for x in svc.diagram(rep["id"], deep=False)["nodes"]}
            missing_ids = [x for x in object_ids if x not in shown]
            q = ("mutation($input:DropOnDiagramInput!){dropOnDiagram(input:$input){__typename "
                 "... on DropOnDiagramSuccessPayload{diagram{id}} ... on ErrorPayload{message}}}")
            for start in range(0, len(missing_ids), chunk):
                batch = missing_ids[start:start+chunk]
                payload = svc.mutation("dropOnDiagram", q, {"input": {"id": str(uuid.uuid4()),
                    "editingContextId": state["editing_context_id"], "representationId": rep["id"],
                    "diagramTargetElementId": rep["id"], "objectIds": batch,
                    "startingPositionX": 80.0 + (start % 100) * 25.0,
                    "startingPositionY": 80.0 + (start // 100) * 700.0}}, rep["id"])["dropOnDiagram"]
                if payload["__typename"] != "DropOnDiagramSuccessPayload":
                    raise RuntimeError(f"{name} batch {start//chunk}: {payload.get('message')}")
                print(f"{name} BATCH={start//chunk+1}/{(len(missing_ids)+chunk-1)//chunk}", flush=True)
        else:
            for start in range(0, len(object_ids), chunk):
                try:
                    result = svc.populate_and_verify(rep["id"], object_ids[start:start+chunk], arrange=False)
                    for _ in range(2):
                        if result["status"] == "CREATED":
                            break
                        time.sleep(0.4)
                        result = svc.populate_and_verify(rep["id"], object_ids[start:start+chunk], arrange=False)
                except Exception as exc:
                    raise RuntimeError(f"{name} drop {labels[start:start+chunk]}: {exc}") from exc
                if result["status"] != "CREATED":
                    raise RuntimeError(f"{name} chunk {start//chunk}: {result['status']} {result.get('missing_object_ids',[])[:3]}")
        diagram = svc.diagram(rep["id"], deep=len(object_ids) <= 100)
        shown = {x["targetObjectId"] for x in diagram["nodes"]}
        missing = set(object_ids) - shown
        if missing:
            raise RuntimeError(f"{name}: queryback missing {len(missing)} nodes")
        registry[name] = {"status": "PASS", "representation_id": rep["id"], "root_label": root,
                          "root_object_id": oid(root), "diagram_target_object_id": diagram["targetObjectId"],
                          "description": description, "requested_object_ids": object_ids,
                          "node_count": len(diagram["nodes"]), "edge_count": len(diagram["edges"]),
                          "edge_target_object_ids": [x["targetObjectId"] for x in diagram["edges"]],
                          "url": f"http://localhost:8080/projects/{state['project_id']}/edit/{rep['id']}"}
        OUT.write_text(json.dumps(registry, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"{name}=PASS NODES={len(diagram['nodes'])} EDGES={len(diagram['edges'])}", flush=True)

    if phase == "A" or phase.startswith("A_"):
        # SysON General View rejects some later drops when related requirements
        # are already represented. Reverse declaration order keeps the child
        # requirement ahead of its overlapping predecessor.
        reqs = list(reversed([x["label"] for x in index["entries"] if x["sysml_type"] == "RequirementUsage"]))
        functions = [x["label"] for x in index["entries"] if x["sysml_type"] == "ActionUsage"]
        owners = [x["label"] for x in index["entries"] if x["sysml_type"] == "PartUsage" and x["label"].startswith("ap_")]
        if phase in ("A", "A_REQ_ALL"):
            create("AUTO_REQ_ALL", "RequirementTraceabilityAllInOneV2", "General View", reqs, chunk=1)
        if phase == "A_REQ_CANDIDATE":
            create("AUTO_REQ_ALL_CANDIDATE", "RequirementTraceabilityAllInOneV2", "General View", reqs, chunk=20)
        if phase in ("A", "A_REQ_FUNCTION"):
            create("AUTO_REQ_FUNCTION_TRACE", "RequirementTraceabilityAllInOneV2", "General View", reqs + functions, chunk=20)
        if phase in ("A", "A_ALLOCATION"):
            create("AUTO_FUNCTION_PRODUCT_ALLOCATION", "FunctionAllocations", "Interconnection View", functions + owners)
        if phase in ("A", "A_ROOT"):
            create("AUTO_PRODUCT_ARCHITECTURE_ROOT", "railSystem", "Interconnection View",
                   [rows[x]["usage_id"] for x in sorted(rows) if rows[x]["level"] == 1])
    elif phase in ("B", "C", "D"):
        level = {"B": 1, "C": 2, "D": 3}[phase]
        products = [x for x in hierarchy["products"] if x["level"] == level and x["direct_children"]]
        for row in products:
            code = row["product_code"]
            ports = port_by_owner.get(code, [])
            child_usages = [rows[ch]["usage_id"] for ch in row["direct_children"]]
            child_ports = [port for child in row["direct_children"]
                           for port in ports_by_definition.get(rows[child]["definition_id"], [])]
            peer_codes = sorted({x["neighbor_product"] for x in ports if x["neighbor_product"] in rows
                                 and x["neighbor_product"] not in row["direct_children"]
                                 and x["neighbor_product"] != code})
            peer_usages = [rows[peer]["usage_id"] for peer in peer_codes]
            reciprocal = [x["port_id"] for peer in peer_codes for x in port_by_owner.get(peer, [])
                          if x["neighbor_product"] == code]
            labels = child_usages + child_ports + [x["port_id"] for x in ports]
            try:
                create("AUTO_IBD_" + code, row["usage_id"], "Interconnection View", labels)
            except Exception as exc:
                print(f"AUTO_IBD_{code}=FAIL {exc}", flush=True)
                raise
    else:
        raise ValueError("Phase must be A, B, C or D")


if __name__ == "__main__":
    main(sys.argv[1])
