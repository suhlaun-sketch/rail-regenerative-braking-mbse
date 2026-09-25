"""Create exactly two test-only representations, rejecting any General View fallback."""
from __future__ import annotations

import json
import subprocess
import uuid
from pathlib import Path

from tools.syson_automation.src.syson_client import SysONClient

HERE = Path(__file__).resolve().parent
state = json.loads((HERE / "test_project.json").read_text(encoding="utf-8"))
client = SysONClient(endpoint="http://127.0.0.1:8090/api/graphql", timeout=120)
context = state["editing_context_id"]
query = ("query($ctx:ID!,$obj:ID!){viewer{editingContext(editingContextId:$ctx)"
         "{representationDescriptions(objectId:$obj){edges{node{id label}}}}}}")
mutation = ("mutation($input:CreateRepresentationInput!){createRepresentation(input:$input){__typename "
            "... on CreateRepresentationSuccessPayload{representation{id label kind}} "
            "... on ErrorPayload{message}}}")


def persisted_description(name: str) -> str:
    sql = f"select description_id from representation_metadata where label='{name}' and id like '{context}#%';"
    result = subprocess.run(["docker", "exec", "rail-syson-2026-9-test-db", "psql", "-U", "syson_test",
                             "-d", "syson_test", "-At", "-c", sql], capture_output=True, text=True, check=True)
    values = [line for line in result.stdout.splitlines() if line]
    if len(values) != 1:
        raise RuntimeError(f"Persisted description count for {name}: {len(values)}")
    return values[0]


def main() -> None:
    results = {}
    for code, root_label in (("X130", "P_X130"), ("3110", "P_N_3110")):
        name = f"TEST_2026_9_IBD_{code}"
        hits = [hit for hit in client.search(context, root_label) if hit["label"] == root_label]
        if len(hits) != 1:
            raise RuntimeError(f"{code} root search returned {len(hits)}")
        root_id = hits[0]["id"]
        options = [edge["node"] for edge in client.execute(query, {"ctx": context, "obj": root_id})
                   ["viewer"]["editingContext"]["representationDescriptions"]["edges"]]
        choices = [item for item in options if item["label"] == "Interconnection View"]
        if len(choices) != 1:
            raise RuntimeError(f"{code}: Interconnection View unavailable; STOP")
        choice = choices[0]
        existing_query = "query($ctx:ID!){viewer{editingContext(editingContextId:$ctx){representations(first:100){edges{node{id label kind}}}}}}"
        existing = [edge["node"] for edge in client.execute(existing_query, {"ctx": context})
                    ["viewer"]["editingContext"]["representations"]["edges"] if edge["node"]["label"] == name]
        if len(existing) > 1:
            raise RuntimeError(f"Duplicate {name}")
        if existing:
            representation = existing[0]
        else:
            payload = client.execute(mutation, {"input": {"id": str(uuid.uuid4()),
                "editingContextId": context, "objectId": root_id,
                "representationDescriptionId": choice["id"], "representationName": name}})["createRepresentation"]
            if payload["__typename"] != "CreateRepresentationSuccessPayload":
                raise RuntimeError(f"{name}: {payload}")
            representation = payload["representation"]
        actual = persisted_description(name)
        result = {"name": name, "representation_id": representation["id"], "root_object_id": root_id,
                  "requested_description_id": choice["id"], "actual_description_id": actual,
                  "actual_description": "Interconnection View" if "74c5d045" in actual else
                                        "General View" if "8dcd14b0" in actual else "UNKNOWN"}
        results[code] = result
        (HERE / "two_smokes.json").write_text(json.dumps(results, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"{name}={result['actual_description']} REP={representation['id']}", flush=True)
    if any(row["actual_description"] != "Interconnection View" for row in results.values()):
        raise RuntimeError("Server changed requested Interconnection View to General View; STOP before populate")


if __name__ == "__main__":
    main()
