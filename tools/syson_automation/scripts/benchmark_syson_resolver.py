from __future__ import annotations

import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from tools.syson_automation.src.syson_client import SysONClient

REPORT = ROOT / "tools/syson_automation/generated/reports/SYSON_RESOLVER_BENCHMARK.md"
QUERIES = ["FunctionDefinitions", "FN_F_3110_01", "FN_F_3111_01", "FN_F_X100_01",
           "X100", "RequirementDefinitionsV2", "req_REQ_BRK_007"]
TIMEOUTS = [5, 15, 30, 60]


def probe(query: str, timeout: int, search_in_attributes: bool) -> dict:
    project = json.loads((ROOT / "tools/syson_automation/cache/current_project.json").read_text(encoding="utf-8"))
    client = SysONClient(timeout=timeout)
    operation = """query($id:ID!,$s:SearchQuery!){viewer{editingContext(editingContextId:$id){search(query:$s){
      __typename ... on SearchSuccessPayload{result{matches{id kind label}}} ... on ErrorPayload{message}}}}}"""
    variables = {"id": project["editing_context_id"], "s": {"text": query, "matchCase": True,
                 "matchWholeWord": True, "useRegularExpression": False,
                 "searchInAttributes": search_in_attributes, "searchInLibraries": False}}
    start = time.monotonic()
    try:
        response = client.execute(operation, variables)["viewer"]["editingContext"]["search"]
        matches = (response.get("result") or {}).get("matches") or []
        exact = [x for x in matches if x["label"] == query]
        status = "RESOLVED" if len(exact) == 1 else "AMBIGUOUS" if len(exact) > 1 else "NOT_FOUND"
        return {"query": query, "timeout": timeout, "search_in_attributes": search_in_attributes,
                "elapsed": round(time.monotonic() - start, 3), "status": status,
                "result_count": len(matches), "resolved_id": exact[0]["id"] if len(exact) == 1 else None,
                "type": exact[0]["kind"] if len(exact) == 1 else None, "error": response.get("message")}
    except Exception as exc:
        message = str(exc)
        return {"query": query, "timeout": timeout, "search_in_attributes": search_in_attributes,
                "elapsed": round(time.monotonic() - start, 3),
                "status": "TIMEOUT" if "timed out" in message.lower() or "timeout" in message.lower() else "SERVER_ERROR",
                "result_count": 0, "resolved_id": None, "type": None, "error": message}


def main() -> None:
    rows = [probe(name, timeout, False) for name in QUERIES for timeout in TIMEOUTS]
    # The old attributes-inclusive path is expensive; one controlled sentinel
    # proves whether it differs from the model-tree/index path.
    rows.append(probe("FN_F_3110_01", 5, True))
    if "--slow-attributes" in sys.argv:
        rows += [probe("FN_F_3110_01", timeout, True) for timeout in (15, 30, 60)]
    REPORT.parent.mkdir(parents=True, exist_ok=True)
    lines = ["# SysON Resolver Benchmark", "", "| Query | Timeout s | Attributes | Elapsed s | Status | Matches | Resolved ID | Type | Error |",
             "|---|---:|---|---:|---|---:|---|---|---|"]
    for x in rows:
        lines.append(f"| {x['query']} | {x['timeout']} | {x['search_in_attributes']} | {x['elapsed']} | {x['status']} | {x['result_count']} | {x['resolved_id'] or '-'} | {x['type'] or '-'} | {(x['error'] or '-').replace('|', '/')} |")
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps({"runs": len(rows), "statuses": {s: sum(x["status"] == s for x in rows)
                       for s in sorted({x["status"] for x in rows})}}, ensure_ascii=False))


if __name__ == "__main__":
    main()
