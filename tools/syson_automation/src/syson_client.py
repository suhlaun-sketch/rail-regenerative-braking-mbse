from __future__ import annotations

import json
import urllib.error
import urllib.request
from pathlib import Path


ROOT = Path(__file__).resolve().parents[3]


class SysONError(RuntimeError):
    pass


class SysONClient:
    def __init__(self, endpoint: str = "http://localhost:8080/api/graphql", timeout: float = 8.0):
        self.endpoint = endpoint
        self.timeout = timeout
        payload = json.loads((ROOT / "tools/syson_automation/cache/graphql_schema.json").read_text(encoding="utf-8"))
        schema = payload.get("data", {}).get("__schema", {})
        types = {t.get("name"): t for t in schema.get("types", [])}
        self.query_fields = {f["name"] for f in types.get((schema.get("queryType") or {}).get("name"), {}).get("fields", []) or []}
        self.mutation_fields = {f["name"] for f in types.get((schema.get("mutationType") or {}).get("name"), {}).get("fields", []) or []}

    def require_query(self, name: str):
        if name not in self.query_fields:
            raise SysONError(f"拒绝调用未在本机 GraphQL schema 发现的 query：{name}")

    def require_mutation(self, name: str):
        if name not in self.mutation_fields:
            raise SysONError(f"拒绝调用未在本机 GraphQL schema 发现的 mutation：{name}")

    def execute(self, query: str, variables: dict | None = None) -> dict:
        body = json.dumps({"query": query, "variables": variables or {}}).encode("utf-8")
        req = urllib.request.Request(self.endpoint, data=body,
            headers={"Content-Type": "application/json", "Accept": "application/json"}, method="POST")
        try:
            with urllib.request.urlopen(req, timeout=self.timeout) as response:
                result = json.loads(response.read().decode("utf-8"))
        except urllib.error.HTTPError as exc:
            raise SysONError(f"SysON GraphQL HTTP {exc.code}") from exc
        except Exception as exc:
            raise SysONError(f"SysON GraphQL 请求失败：{type(exc).__name__}: {exc}") from exc
        if result.get("errors"):
            raise SysONError("SysON GraphQL 返回错误：" + "; ".join(x.get("message", "unknown") for x in result["errors"]))
        return result.get("data", {})

    def search(self, context_id: str, text: str) -> list[dict]:
        self.require_query("viewer")
        query = """query ResolveElement($contextId: ID!, $search: SearchQuery!) {
          viewer { editingContext(editingContextId: $contextId) { search(query: $search) {
            __typename ... on SearchSuccessPayload { result { matches { id kind label } } }
            ... on ErrorPayload { message }
          } } }
        }"""
        data = self.execute(query, {"contextId": context_id, "search": {
            "text": text, "matchCase": True, "matchWholeWord": True, "useRegularExpression": False,
            "searchInAttributes": False, "searchInLibraries": False}})
        payload = ((data.get("viewer") or {}).get("editingContext") or {}).get("search") or {}
        if payload.get("__typename") != "SearchSuccessPayload":
            raise SysONError(payload.get("message") or f"SysON search 未成功：{payload.get('__typename', 'empty payload')}")
        return payload.get("result", {}).get("matches", [])
