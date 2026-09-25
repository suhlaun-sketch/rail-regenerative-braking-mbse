from __future__ import annotations

import re


def normalized(value: str) -> str:
    value = re.sub(r"我只?想看|我想了解|请问|相关|一下|的是|为什么|怎么|如何", "", value.strip().lower())
    value = value.replace("超级电容", "储能").replace("制动产生的能量", "再生能量").replace("回收制动能量", "再生能量")
    return re.sub(r"[^0-9a-z\u4e00-\u9fff]", "", value)


def ngrams(value: str, size=2):
    text = normalized(value)
    return {text[i:i + size] for i in range(max(0, len(text) - size + 1))}


class LocalSemanticMatcher:
    FIELD_WEIGHTS = {"name": 7.0, "domain": 4.5, "text": 2.5, "keywords": 5.0, "synonyms": 5.5,
                     "user_phrases": 6.0, "expected_function_semantics": 3.5, "primary_product": 5.0}
    BROAD_TERMS = {"制动", "制动系统", "牵引", "牵引系统", "能量回收", "储能"}

    def __init__(self, catalog): self.catalog = catalog

    def search(self, query: str, top_k=12):
        core = normalized(query); qgrams = ngrams(core)
        scored = []
        for req in self.catalog.requirements:
            score = 0.0; reasons = []; matched_keywords = []
            for field, weight in self.FIELD_WEIGHTS.items():
                values = req.get(field, [])
                if not isinstance(values, list): values = [values]
                for raw in values:
                    text = normalized(str(raw or ""))
                    if not text: continue
                    if core and (core in text or text in core):
                        bonus = weight * (1.25 if field in ("name", "user_phrases", "primary_product") else 1)
                        score += bonus; reasons.append(field); matched_keywords.append(str(raw))
                    else:
                        common = qgrams & ngrams(text)
                        if common:
                            coverage = len(common) / max(1, len(qgrams))
                            if coverage >= .25: score += weight * coverage
            detail = self.catalog.requirement_detail(req["requirement_id"]) or {"functions": []}
            for fn in detail["functions"]:
                if core and (core in normalized(fn["name"]) or normalized(fn["name"]) in core):
                    score += 4.5; reasons.append("known function name")
                for product in fn.get("products", []):
                    code = product["product_id"].lower()
                    pname = normalized(product["name"])
                    if code in query.lower() or (pname and (pname in core or core in pname)):
                        score += 8; reasons.append("linked product")
            if score >= 2.2:
                scored.append({"requirement_id": req["requirement_id"], "semantic_score": round(score, 3),
                    "reason": "、".join(dict.fromkeys(reasons)) or "工程术语覆盖",
                    "matched_keywords": list(dict.fromkeys(matched_keywords))[:8]})
        scored.sort(key=lambda x: (-x["semantic_score"], x["requirement_id"]))
        return scored[:top_k]

    def interpret(self, query: str, matches):
        core = normalized(query)
        scope = "broad" if core in self.BROAD_TERMS else "focused"
        keywords = []
        for match in matches[:5]: keywords.extend(match.get("matched_keywords", []))
        keywords = [x for x in dict.fromkeys(keywords) if len(normalized(x)) >= 2][:8]
        return {"keywords": keywords, "scope": scope,
                "summary": "按领域展开多个相关需求" if scope == "broad" else "聚焦到特定工程语义或产品"}
