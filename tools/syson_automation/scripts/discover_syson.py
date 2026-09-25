from __future__ import annotations

import json
import re
import sys
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
AUTOMATION = ROOT / "tools" / "syson_automation"
ENDPOINT = "http://localhost:8080/api/graphql"
SCHEMA_PATH = AUTOMATION / "cache" / "graphql_schema.json"
REPORT_PATH = AUTOMATION / "generated" / "reports" / "SYSON_GRAPHQL_DISCOVERY.md"
PROJECT_PATH = AUTOMATION / "cache" / "current_project.json"

INTROSPECTION = r"""
query FullIntrospection {
  __schema {
    description
    queryType { name }
    mutationType { name }
    subscriptionType { name }
    types {
      kind name description
      fields(includeDeprecated: true) {
        name description isDeprecated deprecationReason
        args { name description defaultValue type { ...TypeRef } }
        type { ...TypeRef }
      }
      inputFields { name description defaultValue type { ...TypeRef } }
      interfaces { ...TypeRef }
      enumValues(includeDeprecated: true) { name description isDeprecated deprecationReason }
      possibleTypes { ...TypeRef }
    }
    directives { name description locations args { name description defaultValue type { ...TypeRef } } }
  }
}
fragment TypeRef on __Type {
  kind name ofType {
    kind name ofType {
      kind name ofType {
        kind name ofType {
          kind name ofType {
            kind name ofType {
              kind name ofType {
                kind name ofType { kind name ofType { kind name } }
              }
            }
          }
        }
      }
    }
  }
}
"""

KEYWORDS = re.compile(r"project|model|representation|view|diagram|editingcontext|object|element|tool|node|edge|arrange|layout|export|svg", re.I)


def post_graphql(query: str, variables: dict | None = None, timeout: float = 30) -> tuple[int, dict]:
    payload = json.dumps({"query": query, "variables": variables or {}}).encode("utf-8")
    req = urllib.request.Request(ENDPOINT, data=payload, headers={"Content-Type": "application/json", "Accept": "application/json"}, method="POST")
    try:
        with urllib.request.urlopen(req, timeout=timeout) as response:
            return response.status, json.loads(response.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        body = e.read().decode("utf-8", errors="replace")
        return e.code, {"http_error": body}
    except Exception as e:
        return 0, {"transport_error": f"{type(e).__name__}: {e}"}


def graphql(query: str, variables: dict | None = None, timeout: float = 30) -> dict:
    status, result = post_graphql(query, variables, timeout)
    if status != 200 or result.get("errors"):
        raise RuntimeError(json.dumps(result.get("errors", result), ensure_ascii=False))
    return result.get("data", {})


def names_of_type(ref: dict | None) -> str:
    parts = []
    while ref:
        if ref.get("name"):
            parts.append(ref["name"])
        ref = ref.get("ofType")
    return " / ".join(parts)


def field_summary(owner: dict) -> list[dict]:
    return [{"name": f["name"], "type": names_of_type(f.get("type")), "args": [{"name": a["name"], "type": names_of_type(a.get("type"))} for a in f.get("args", [])]} for f in owner.get("fields", []) or []]


def markdown_items(items: list[dict]) -> str:
    if not items:
        return "- 未发现。"
    return "\n".join(f"- `{x['name']}`: `{x.get('type', '')}`" for x in items)


def main() -> int:
    status, result = post_graphql(INTROSPECTION)
    errors = result.get("errors", []) if isinstance(result, dict) else []
    schema = result.get("data", {}).get("__schema") if isinstance(result, dict) else None
    if status != 200 or not schema:
        REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
        REPORT_PATH.write_text(
            "# SysON GraphQL Schema Discovery\n\n"
            f"- Endpoint: `{ENDPOINT}`\n- Introspection HTTP: `{status}`\n- Schema introspection: **失败**\n"
            f"- Error: `{json.dumps(errors or result, ensure_ascii=False)}`\n- View creation: 未执行。\n",
            encoding="utf-8",
        )
        print(json.dumps({"status": status, "schema": False, "errors": errors or result}, ensure_ascii=False))
        return 1

    SCHEMA_PATH.parent.mkdir(parents=True, exist_ok=True)
    SCHEMA_PATH.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    types = schema.get("types", [])
    by_name = {t.get("name"): t for t in types if t.get("name")}
    query_type = by_name.get((schema.get("queryType") or {}).get("name"), {})
    mutation_type = by_name.get((schema.get("mutationType") or {}).get("name"), {})
    queries = field_summary(query_type)
    mutations = field_summary(mutation_type)
    matching_queries = [x for x in queries if KEYWORDS.search(x["name"] + " " + x["type"])]
    matching_mutations = [x for x in mutations if KEYWORDS.search(x["name"] + " " + x["type"])]
    matching_types = [t for t in types if KEYWORDS.search(t.get("name", ""))]
    introspection_errors = json.dumps(errors, ensure_ascii=False) if errors else "无"
    schema_meta = {k: schema.get(k) for k in ("description", "queryType", "mutationType", "subscriptionType")}
    live_project = None
    project_error = None
    element_search_status = "NOT_TESTED"
    element_search_detail = ""
    try:
        projects = graphql("""query CurrentProjects { viewer { projects(first: 100) { edges { node { id name currentEditingContext { id } } } } } }""")
        edges = projects.get("viewer", {}).get("projects", {}).get("edges", [])
        matches = [e.get("node", {}) for e in edges if e.get("node", {}).get("name") == "Rail_Regenerative_Braking_MBSE"]
        if matches:
            live_project = matches[0]
            context_id = (live_project.get("currentEditingContext") or {}).get("id")
            if context_id:
                rep_query = """query ExistingRepresentations($contextId: ID!) { viewer { editingContext(editingContextId: $contextId) { representations(first: 20) { edges { node { id label kind } } } } } }"""
                reps = graphql(rep_query, {"contextId": context_id})
                live_project["representations"] = [e.get("node", {}) for e in reps.get("viewer", {}).get("editingContext", {}).get("representations", {}).get("edges", [])]
                search_query = """query SearchAnchor($contextId: ID!, $search: SearchQuery!) { viewer { editingContext(editingContextId: $contextId) { search(query: $search) { __typename ... on SearchSuccessPayload { result { matches { id kind label } } } ... on ErrorPayload { message } } } } }"""
                try:
                    search_data = graphql(search_query, {"contextId": context_id, "search": {"text": "FN_F_X100_01", "matchCase": True,
                        "matchWholeWord": True, "useRegularExpression": False, "searchInAttributes": True, "searchInLibraries": False}}, timeout=8)
                    search_payload = search_data.get("viewer", {}).get("editingContext", {}).get("search", {})
                    element_search_status = search_payload.get("__typename", "EMPTY_RESPONSE")
                    element_search_detail = search_payload.get("message", "")
                except Exception as exc:
                    element_search_status = "BLOCKED"
                    element_search_detail = f"{type(exc).__name__}: {exc}"
            PROJECT_PATH.parent.mkdir(parents=True, exist_ok=True)
            PROJECT_PATH.write_text(json.dumps({"base_url": "http://localhost:8080", "graphql_endpoint": ENDPOINT,
                "project_name": live_project.get("name"), "project_id": live_project.get("id"),
                "editing_context_id": (live_project.get("currentEditingContext") or {}).get("id"),
                "representations": live_project.get("representations", []), "element_search_status": element_search_status,
                "element_search_detail": element_search_detail,
                "resolution_status": "PROJECT_CONTEXT_RESOLVED" if element_search_status == "SearchSuccessPayload" else "PROJECT_CONTEXT_RESOLVED_MODEL_ELEMENT_SEARCH_BLOCKED"}, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        else:
            project_error = "未在当前 viewer.projects 中找到目标项目。"
    except Exception as exc:
        project_error = f"{type(exc).__name__}: {exc}"
    report = [
        "# SysON GraphQL Schema Discovery", "",
        f"- Discovery time (UTC): `{datetime.now(timezone.utc).isoformat()}`",
        f"- Endpoint: `{ENDPOINT}`; HTTP `{status}`; introspection: **成功**.",
        f"- Schema metadata: `{json.dumps(schema_meta, ensure_ascii=False)}`",
        f"- Types discovered: `{len(types)}`; Query fields: `{len(queries)}`; Mutation fields: `{len(mutations)}`.",
        f"- Introspection errors: `{introspection_errors}`.",
        f"- Current Project: `{json.dumps(live_project, ensure_ascii=False) if live_project else '未解析'}`。",
        f"- Project query error: `{project_error or '无'}`。",
        f"- Imported model element exact search (`FN_F_X100_01`, 8 s): `{element_search_status}`; `{element_search_detail or '无错误消息'}`.",
        "", "## Project / Model / Editing Context queries", "",
        markdown_items([x for x in matching_queries if re.search(r"project|model|editingcontext", x["name"] + " " + x["type"], re.I)]),
        "", "## Representation / View / Diagram mutations", "",
        markdown_items([x for x in matching_mutations if re.search(r"representation|view|diagram", x["name"] + " " + x["type"], re.I)]),
        "", "## Element / node / edge / tool mutations and query fields", "",
        markdown_items([x for x in matching_mutations if re.search(r"object|element|tool|node|edge", x["name"] + " " + x["type"], re.I)]),
        "", "## Layout / arrange / export / SVG capabilities", "",
        markdown_items([x for x in matching_queries + matching_mutations if re.search(r"arrange|layout|export|svg", x["name"] + " " + x["type"], re.I)]),
        "", "## Related types", "",
        "\n".join(f"- `{t.get('name')}` ({t.get('kind')})" for t in matching_types) or "- 未发现。",
        "", "## All Query fields", "", markdown_items(queries),
        "", "## All Mutation fields", "", markdown_items(mutations),
        "", "## Safety", "", "- Discovery only: introspection ran; no mutation or representation creation was attempted.", "",
    ]
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    REPORT_PATH.write_text("\n".join(report), encoding="utf-8")
    print(json.dumps({"status": status, "type_count": len(types), "query_count": len(queries), "mutation_count": len(mutations), "query_fields": [x["name"] for x in queries], "mutation_fields": [x["name"] for x in mutations], "schema_path": str(SCHEMA_PATH), "report_path": str(REPORT_PATH)}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
