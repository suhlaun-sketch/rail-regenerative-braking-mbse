from __future__ import annotations

import json

import httpx

from .base import SemanticLLMProvider
from .schemas import RequirementMatchResponse

SYSTEM_PROMPT = """你是一个MBSE需求语义匹配器。你的任务仅是根据用户问题，从给出的候选中选择最相关的Requirement ID。
只能返回候选中已有的Requirement ID；禁止创建Requirement、Function或Product ID。广义问题可返回多个，狭义问题应返回较少；没有明显匹配时返回空数组。不要扩大工程含义。只返回严格JSON：
{"query":"...","matches":[{"requirement_id":"...","semantic_score":0.0,"reason":"..."}]}
semantic_score仅用于语义排序，不是工程置信度或验证结论。"""


class QwenClient(SemanticLLMProvider):
    def __init__(self, api_key: str, base_url: str, model: str, timeout: int):
        self.api_key, self.base_url, self.model, self.timeout = api_key, base_url.rstrip("/"), model, timeout

    async def match_requirements(self, query: str, candidates: list[dict]) -> dict:
        compact = [{"requirement_id": x["requirement_id"], "name": x["name"], "domain": x["domain"],
                    "text": x["text"], "keywords": x["keywords"], "user_phrases": x["user_phrases"]} for x in candidates]
        payload = {"model": self.model, "temperature": 0, "response_format": {"type": "json_object"}, "messages": [
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": json.dumps({"query": query, "candidates": compact}, ensure_ascii=False)}]}
        async with httpx.AsyncClient(timeout=self.timeout) as client:
            response = await client.post(f"{self.base_url}/chat/completions", json=payload,
                headers={"Authorization": f"Bearer {self.api_key}", "Content-Type": "application/json"})
            response.raise_for_status()
        content = response.json()["choices"][0]["message"]["content"]
        return RequirementMatchResponse.model_validate_json(content).model_dump()
