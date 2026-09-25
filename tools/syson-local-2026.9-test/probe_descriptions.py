"""Read actual 2026.9 DiagramDescription options for the two smoke roots."""
import json
from pathlib import Path

from tools.syson_automation.src.syson_client import SysONClient

state = json.loads((Path(__file__).resolve().parent / "test_project.json").read_text(encoding="utf-8"))
client = SysONClient(endpoint="http://127.0.0.1:8090/api/graphql", timeout=120)
context = state["editing_context_id"]
query = ("query($ctx:ID!,$obj:ID!){viewer{editingContext(editingContextId:$ctx)"
         "{representationDescriptions(objectId:$obj){edges{node{id label defaultName}}}}}}")
for label in ("P_X130", "p_X130", "P_N_3110", "p_N_3110"):
    hits = [hit for hit in client.search(context, label) if hit["label"] == label]
    if len(hits) != 1:
        print(f"{label}=SEARCH_{len(hits)}", flush=True)
        continue
    descriptions = client.execute(query, {"ctx": context, "obj": hits[0]["id"]})["viewer"]["editingContext"]["representationDescriptions"]["edges"]
    print(f"{label}={[row['node']['label'] for row in descriptions]}", flush=True)
