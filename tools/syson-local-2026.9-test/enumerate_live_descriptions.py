"""Read and preserve 2026.9 representation-description applicability from live GraphQL."""
from __future__ import annotations

import json
from pathlib import Path
from urllib.parse import parse_qs, urlparse

from tools.syson_automation.src.syson_client import SysONClient

HERE = Path(__file__).resolve().parent
state = json.loads((HERE / "test_project.json").read_text(encoding="utf-8"))
client = SysONClient(endpoint="http://127.0.0.1:8090/api/graphql", timeout=120)
context = state["editing_context_id"]
query = ("query($ctx:ID!,$obj:ID!){viewer{editingContext(editingContextId:$ctx)"
         "{representationDescriptions(objectId:$obj){edges{node{id label defaultName documentation}}}}}}")

results = {}
for code, label in (("X130", "p_X130"), ("X130", "P_X130"),
                    ("3110", "p_N_3110"), ("3110", "P_N_3110")):
    hits = [hit for hit in client.search(context, label) if hit["label"] == label]
    if len(hits) != 1:
        raise RuntimeError(f"{label} search count {len(hits)}")
    hit = hits[0]
    raw = client.execute(query, {"ctx": context, "obj": hit["id"]})
    edges = raw["viewer"]["editingContext"]["representationDescriptions"]["edges"]
    rows = []
    for edge in edges:
        node = edge["node"]
        parsed = parse_qs(urlparse(node["id"]).query)
        rows.append({"description_id": node["id"], "label": node["label"],
                     "name": node["defaultName"], "kind": parsed.get("kind", [None])[0],
                     "source_kind": parsed.get("sourceKind", [None])[0],
                     "source_id": parsed.get("sourceId", [None])[0],
                     "source_element_id": parsed.get("sourceElementId", [None])[0],
                     "applicable_root_type": hit["kind"].split("entity=")[-1],
                     "applicable_root_label": label, "applicable_root_id": hit["id"]})
    results[label] = rows
    print(f"{label}=DESCRIPTIONS_{len(rows)} INTERCONNECTION={sum(row['label']=='Interconnection View' for row in rows)}", flush=True)

(HERE / "live_description_inventory.json").write_text(json.dumps(results, ensure_ascii=False, indent=2), encoding="utf-8")
for label in ("Interconnection View", "General View"):
    identifiers = {row["description_id"] for rows in results.values() for row in rows if row["label"] == label}
    if len(identifiers) != 1:
        raise RuntimeError(f"{label} has {len(identifiers)} distinct IDs across applicable roots")
    print(f"{label.upper().replace(' ', '_')}_DESCRIPTION_ID={next(iter(identifiers))}", flush=True)
