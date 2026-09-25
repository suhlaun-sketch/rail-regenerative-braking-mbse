from __future__ import annotations

import logging

from ...config import settings
from .qwen_client import QwenClient

log = logging.getLogger("rail_mbse.semantic")


class SemanticProviderRouter:
    def __init__(self):
        key = settings.qwen_api_key.get_secret_value() if settings.qwen_api_key else ""
        self.enabled = bool(settings.qwen_enabled and key and settings.qwen_base_url)
        self.client = QwenClient(key, settings.qwen_base_url, settings.qwen_model, settings.qwen_timeout_seconds) if self.enabled else None
        if not self.enabled: log.warning("Qwen API disabled, using local semantic matcher.")

    async def rerank(self, query, candidates, catalog):
        if not self.client: return "LOCAL", candidates
        try:
            result = await self.client.match_requirements(query, candidates)
            allowed = {x["requirement_id"] for x in candidates}
            valid = [x for x in result["matches"] if x["requirement_id"] in allowed]
            return "QWEN", valid
        except Exception as error:
            log.warning("Qwen rerank failed; using local fallback: %s", type(error).__name__)
            return "LOCAL_FALLBACK", candidates
