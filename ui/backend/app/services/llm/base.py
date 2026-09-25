from __future__ import annotations

from abc import ABC, abstractmethod


class SemanticLLMProvider(ABC):
    @abstractmethod
    async def match_requirements(self, query: str, candidates: list[dict]) -> dict: ...
