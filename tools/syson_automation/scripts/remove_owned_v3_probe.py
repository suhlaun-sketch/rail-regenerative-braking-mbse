"""Remove only this task's disposable V3 pilot representations and ViewUsages."""
from __future__ import annotations

import json
import sys
import uuid
from pathlib import Path
from urllib.parse import quote

import psycopg2

from tools.syson_automation.src.representation_service import REGISTRY
from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
ALLOWED = {"AUTO_V3_IBD_X130", "AUTO_V3_IBD_X130_USAGE_PROBE"}


def main(name):
    if name not in ALLOWED:
        raise ValueError("Only disposable X130 V3 pilots may be removed")
    state = json.loads((ROOT / "tools/syson_automation/cache/full_final_project.json").read_text(encoding="utf-8"))
    registry = json.loads(REGISTRY.read_text(encoding="utf-8"))
    key = state["project_id"] + ":" + name
    owned = registry[key]
    if owned.get("created_by") != "syson_automation":
        raise RuntimeError("Representation ownership not proven")
    db = psycopg2.connect(host="127.0.0.1", dbname="postgres", user="syson")
    db.set_session(readonly=True)
    cur = db.cursor()
    cur.execute("select content from document where id=%s", (state["model_document_id"],))
    document = json.loads(cur.fetchone()[0])
    hits = []
    def walk(value, ancestors):
        if isinstance(value, list):
            for item in value:
                walk(item, ancestors)
        elif isinstance(value, dict):
            if "eClass" in value and "id" in value:
                if value["eClass"].endswith("ViewUsage") and (value.get("data") or {}).get("declaredName") == name:
                    hits.append((value["id"], ancestors))
                ancestors = ancestors + [value["id"]]
            for item in value.values():
                if isinstance(item, (dict, list)):
                    walk(item, ancestors)
    walk(document, [])
    if len(hits) != 1:
        raise RuntimeError("V3 ViewUsage is not unique")
    cur.execute("select content from representation_content where id like %s", ("%" + owned["id"],))
    content = cur.fetchone()
    if not content or hits[0][0] not in content[0]:
        raise RuntimeError("Representation does not belong to expected ViewUsage")
    cur.close()
    db.close()
    client = SysONClient(timeout=60)
    q = "mutation($input:DeleteRepresentationInput!){deleteRepresentation(input:$input){__typename}}"
    result = client.execute(q, {"input": {"id": str(uuid.uuid4()), "editingContextId": state["editing_context_id"],
                                           "representationId": owned["id"]}})["deleteRepresentation"]
    if "Success" not in result["__typename"]:
        raise RuntimeError(f"Delete representation failed: {result}")
    view_id, ancestors = hits[0]
    explorer = "explorer://?treeDescriptionId=" + quote(state["explorer_description_id"], safe="") + \
        "&expandedIds=[" + ",".join(quote(x, safe="") for x in [state["model_document_id"]] + ancestors) + "]&activeFilterIds=[]"
    q = "mutation($input:DeleteTreeItemInput!){deleteTreeItem(input:$input){__typename ... on ErrorPayload{message}}}"
    result = client.execute(q, {"input": {"id": str(uuid.uuid4()), "editingContextId": state["editing_context_id"],
                                           "representationId": explorer, "treeItemId": view_id}})["deleteTreeItem"]
    if "Success" not in result["__typename"]:
        raise RuntimeError(f"Delete V3 ViewUsage failed: {result}")
    registry.pop(key)
    REGISTRY.write_text(json.dumps(registry, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"REMOVED_DISPOSABLE={name}")


if __name__ == "__main__":
    main(sys.argv[1])
