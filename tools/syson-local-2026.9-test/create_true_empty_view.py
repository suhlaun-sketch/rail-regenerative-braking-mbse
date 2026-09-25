"""Create one empty view using a live applicable description; never drop elements."""
from __future__ import annotations

import json
import subprocess
import sys
import uuid
from pathlib import Path

from tools.syson_automation.src.syson_client import SysONClient

HERE = Path(__file__).resolve().parent
state = json.loads((HERE / "test_project.json").read_text(encoding="utf-8"))
inventory = json.loads((HERE / "live_description_inventory.json").read_text(encoding="utf-8"))
client = SysONClient(endpoint="http://127.0.0.1:8090/api/graphql", timeout=45)
context = state["editing_context_id"]


def sql_scalar(sql: str) -> str | None:
    process = subprocess.run(["docker", "exec", "rail-syson-2026-9-test-db", "psql", "-U",
                              "syson_test", "-d", "syson_test", "-At", "-c", sql],
                             check=True, capture_output=True, text=True)
    values = [line for line in process.stdout.splitlines() if line]
    if len(values) > 1:
        raise RuntimeError(f"SQL expected at most one row, got {len(values)}")
    return values[0] if values else None


def main(code: str) -> None:
    if code not in ("X130", "3110"):
        raise ValueError("Only two specified smoke roots are allowed")
    root_label = "p_X130" if code == "X130" else "p_N_3110"
    options = [row for row in inventory[root_label] if row["label"] == "Interconnection View"
               and row["kind"] == "diagramDescription"]
    if len(options) != 1:
        raise RuntimeError("No unique live applicable Interconnection diagram description")
    option = options[0]
    name = f"TEST_TRUE_INTERCONNECTION_{code}"
    existing_query = ("query($ctx:ID!){viewer{editingContext(editingContextId:$ctx)"
                      "{representations(first:100){edges{node{id label kind}}}}}}")
    existing = [edge["node"] for edge in client.execute(existing_query, {"ctx": context})
                ["viewer"]["editingContext"]["representations"]["edges"]
                if edge["node"]["label"] == name]
    if len(existing) > 1:
        raise RuntimeError("Duplicate test representation")
    if existing:
        rep = existing[0]
    else:
        mutation = ("mutation($input:CreateRepresentationInput!){createRepresentation(input:$input){__typename "
                    "... on CreateRepresentationSuccessPayload{representation{id label kind}} "
                    "... on ErrorPayload{message}}}")
        payload = client.execute(mutation, {"input": {"id": str(uuid.uuid4()),
            "editingContextId": context, "objectId": option["applicable_root_id"],
            "representationDescriptionId": option["description_id"],
            "representationName": name}})["createRepresentation"]
        if payload["__typename"] != "CreateRepresentationSuccessPayload":
            raise RuntimeError(f"createRepresentation failed: {payload}")
        rep = payload["representation"]
    persisted = sql_scalar("select description_id from representation_metadata "
                           f"where id='{context}#{rep['id']}'")
    content = sql_scalar("select content::jsonb->>'descriptionId' from representation_content "
                         f"where id like '%{rep['id']}'")
    returned = None
    returned_label = None
    graphql_error = None
    try:
        query = ("query($ctx:ID!){viewer{editingContext(editingContextId:$ctx)"
                 "{representations(first:100){edges{node{id label description{id label}}}}}}}")
        edges = client.execute(query, {"ctx": context})["viewer"]["editingContext"]["representations"]["edges"]
        hit = next(edge["node"] for edge in edges if edge["node"]["id"] == rep["id"])
        returned = hit["description"]["id"]
        returned_label = hit["description"]["label"]
    except Exception as exc:
        graphql_error = f"{type(exc).__name__}: {exc}"
    result = {"name": name, "root_label": root_label, "root_object_id": option["applicable_root_id"],
              "representation_id": rep["id"], "semantic_view_type": None,
              "requested_description_id": option["description_id"],
              "persisted_description_id": persisted, "content_description_id": content,
              "returned_description_id": returned, "returned_description_label": returned_label,
              "graphql_description_error": graphql_error,
              "status": "PASS" if returned == persisted == content == option["description_id"]
                                   and returned_label == "Interconnection View" else "FAIL"}
    path = HERE / f"true_empty_{code}.json"
    path.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"{name}={result['status']} REP={rep['id']} RETURNED={returned_label} "
          f"PERSISTED_INTERCONNECTION={persisted == option['description_id']}", flush=True)


if __name__ == "__main__":
    main(sys.argv[1])
