"""Read only the created test ViewUsage type from the isolated database."""
import json
import subprocess
from pathlib import Path

from tools.syson_automation.src.syson_client import SysONClient

HERE = Path(__file__).resolve().parent
state = json.loads((HERE / "test_project.json").read_text(encoding="utf-8"))
sql = f"select content from document where id='{state['model_document_id']}'"
process = subprocess.run(["docker", "exec", "rail-syson-2026-9-test-db", "psql", "-U",
                          "syson_test", "-d", "syson_test", "-At", "-c", sql],
                         check=True, capture_output=True, text=True, encoding="utf-8")
document = json.loads(process.stdout)

found = {}
def walk(value):
    if isinstance(value, list):
        for item in value:
            walk(item)
    elif isinstance(value, dict):
        data = value.get("data") or {}
        name = data.get("declaredName")
        if name in ("TEST_TRUE_INTERCONNECTION_X130", "TEST_2026_9_IBD_X130", "TEST_2026_9_IBD_3110"):
            typings = [rel for rel in data.get("ownedRelationship", [])
                       if str(rel.get("eClass", "")).endswith("FeatureTyping")]
            found[name] = {"metaclass": str(value.get("eClass", "")).split(":")[-1],
                           "object_id": value.get("id"),
                           "feature_typing_refs": [(rel.get("data") or {}).get("type") for rel in typings]}
        for child in value.values():
            if isinstance(child, (list, dict)):
                walk(child)

walk(document)
(HERE / "view_semantics.json").write_text(json.dumps(found, ensure_ascii=False, indent=2), encoding="utf-8")
for name, row in found.items():
    print(f"{name}=METACLASS_{row['metaclass']} TYPE_REFS_{row['feature_typing_refs']}")

client = SysONClient(endpoint="http://127.0.0.1:8090/api/graphql", timeout=30)
query = ("query($ctx:ID!,$search:SearchQuery!){viewer{editingContext(editingContextId:$ctx)"
         "{search(query:$search){__typename ... on SearchSuccessPayload{result{matches{id kind label}}}}}}}")
search = {"text": "InterconnectionView", "matchCase": True, "matchWholeWord": True,
          "useRegularExpression": False, "searchInAttributes": False, "searchInLibraries": True}
payload = client.execute(query, {"ctx": state["editing_context_id"], "search": search})
matches = payload["viewer"]["editingContext"]["search"]["result"]["matches"]
print("LIVE_INTERCONNECTION_VIEW_LIBRARY_MATCHES=" + str([(m["id"], m["label"]) for m in matches]))
if len(matches) == 1 and "TEST_TRUE_INTERCONNECTION_X130" in found:
    ref = found["TEST_TRUE_INTERCONNECTION_X130"]["feature_typing_refs"]
    if len(ref) == 1 and ref[0].endswith("#" + matches[0]["id"]):
        path = HERE / "true_empty_X130.json"
        result = json.loads(path.read_text(encoding="utf-8"))
        result["semantic_view_type"] = "StandardViewDefinitions::InterconnectionView"
        result["semantic_view_type_ref"] = ref[0]
        path.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
