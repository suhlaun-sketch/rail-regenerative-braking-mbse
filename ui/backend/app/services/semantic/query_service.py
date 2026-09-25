from __future__ import annotations

import json
from datetime import datetime, timezone
from pathlib import Path
from threading import Lock

from ..llm import SemanticProviderRouter
from .catalog_loader import SemanticCatalog
from .local_matcher import LocalSemanticMatcher


class SemanticQueryService:
    def __init__(self, data_root: Path):
        self.data_root = data_root
        self.catalog = SemanticCatalog(data_root)
        self.matcher = LocalSemanticMatcher(self.catalog)
        self.providers = SemanticProviderRouter()
        self.cache_path = data_root / "semantic_cache.json"
        self._cache_lock = Lock()

    def status(self):
        return {"provider": "QWEN" if self.providers.enabled else "LOCAL", "qwen_enabled": self.providers.enabled,
                "model": "qwen3.7-flash" if self.providers.enabled else None}

    def summary(self):
        m = self.catalog.manifest
        verified = sum(x["verification_status"] == "VERIFIED" for x in self.catalog.requirements)
        not_verified = sum(x["verification_status"] == "NOT_VERIFIED" for x in self.catalog.requirements)
        return {"requirement_count": m["requirement_count"], "function_count": m["function_count"], "product_count": m["product_count"],
            "requirement_function_relation_count": m["requirement_function_relation_count"], "function_product_relation_count": m["function_product_relation_count"],
            "trace_relation_count": m["requirement_function_relation_count"] + m["function_product_relation_count"],
            "verified_requirement_count": verified, "not_verified_requirement_count": not_verified,
            "partially_verified_requirement_count": len(self.catalog.requirements) - verified - not_verified, **self.status()}

    def _read_cache(self):
        try: return json.loads(self.cache_path.read_text(encoding="utf-8"))
        except (OSError, json.JSONDecodeError): return {}

    def _write_cache(self, cache):
        temp = self.cache_path.with_suffix(".tmp")
        temp.write_text(json.dumps(cache, ensure_ascii=False, indent=2), encoding="utf-8")
        temp.replace(self.cache_path)

    async def query(self, query: str, mode="auto"):
        query = query.strip()
        if not query: raise ValueError("query不能为空")
        cache_key = f"{self.catalog.manifest['generated_at']}:{self.status()['provider']}:{mode}:{query}"
        with self._cache_lock: cached = self._read_cache().get(cache_key)
        if cached and all(x in self.catalog.requirement_by_id for x in cached.get("requirement_ids", [])):
            return self._compose(query, cached["provider"], cached["matches"], cache_hit=True)
        local = self.matcher.search(query, top_k=12)
        candidates = [{**self.catalog.requirement_by_id[x["requirement_id"]], **x} for x in local]
        provider, matches = ("LOCAL", local)
        if mode != "local" and local:
            provider, matches = await self.providers.rerank(query, candidates, self.catalog)
        valid = [x for x in matches if x["requirement_id"] in self.catalog.requirement_by_id]
        scope = self.matcher.interpret(query, local)["scope"]
        limit = 10 if scope == "broad" else 5
        valid = valid[:limit]
        with self._cache_lock:
            cache = self._read_cache(); cache[cache_key] = {"provider": provider, "requirement_ids": [x["requirement_id"] for x in valid],
                "matches": valid, "created_at": datetime.now(timezone.utc).isoformat()}; self._write_cache(cache)
        return self._compose(query, provider, valid, cache_hit=False)

    def _compose(self, query, provider, matches, cache_hit):
        match_by_id = {x["requirement_id"]: x for x in matches}
        requirements, functions, products, paths = [], {}, {}, []
        for rid, match in match_by_id.items():
            req = self.catalog.requirement_by_id[rid]
            requirements.append({**req, "semantic_score": match.get("semantic_score", 0),
                "match_reason": match.get("reason", ""), "matched_keywords": match.get("matched_keywords", [])})
            detail = self.catalog.requirement_detail(rid) or {"functions": []}
            for fn in detail["functions"]:
                functions.setdefault(fn["function_id"], {k: fn.get(k) for k in ("function_id", "name", "description", "source", "source_file", "traceability")})
                functions[fn["function_id"]].setdefault("matched_by_requirements", []).append(rid)
                functions[fn["function_id"]].setdefault("mapping_evidence", []).append(fn["mapping"])
                for product in fn.get("products", []):
                    products.setdefault(product["product_id"], {k: product.get(k) for k in ("product_id", "name", "description", "source", "source_file", "traceability")})
                    products[product["product_id"]].setdefault("matched_by_functions", []).append(fn["function_id"])
                    products[product["product_id"]].setdefault("mapping_evidence", []).append(product["mapping"])
                    paths.append({"requirement_id": rid, "function_id": fn["function_id"], "product_id": product["product_id"],
                        "path": ["Question", "Requirement", "Function", "Product"], "requirement_function_evidence": fn["mapping"],
                        "function_product_evidence": product["mapping"]})
        interpretation = self.matcher.interpret(query, matches)
        return {"query": query, "provider": provider, "cache_hit": cache_hit, "interpretation": interpretation,
            "requirements": requirements, "functions": list(functions.values()), "products": list(products.values()), "paths": paths,
            "stats": {"requirement_count": len(requirements), "function_count": len(functions), "product_count": len(products)},
            "next_actions": {"task_slice_available": bool(functions), "sysml_trace_available": bool(products)}}
