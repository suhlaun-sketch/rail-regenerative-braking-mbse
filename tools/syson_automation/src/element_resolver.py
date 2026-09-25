from __future__ import annotations

from .syson_client import SysONClient, SysONError


def resolve_exact(client: SysONClient, context_id: str, semantic_name: str) -> dict:
    """Resolve current model index first; global search is a last resort."""
    try:
        from tools.syson_automation.scripts.build_syson_element_index import build_index
        index = build_index()
        if index["editing_context_id"] != context_id:
            raise ValueError("Element index EditingContext mismatch")
        ids = index["by_semantic_id"].get(semantic_name, [])
        if len(ids) == 1:
            entry = next(x for x in index["entries"] if x["syson_object_id"] == ids[0])
            return {"semantic_name": semantic_name, "status": "RESOLVED", "object_id": ids[0],
                    "kind": entry["sysml_type"], "label": entry["label"],
                    "qualified_name": entry["qualified_name"], "parent_object_id": entry["parent_object_id"],
                    "resolver_method": "CURRENT_ELEMENT_INDEX"}
        if len(ids) > 1:
            return {"semantic_name": semantic_name, "status": "AMBIGUOUS", "object_id": None,
                    "match_count": len(ids), "resolver_method": "CURRENT_ELEMENT_INDEX"}
    except Exception as exc:
        index_error = str(exc)
    else:
        index_error = "not in current element index"
    # Explorer traversal is performed when building the index. Search is used
    # only for a missing label after that path has been exhausted.
    try:
        matches = client.search(context_id, semantic_name)
    except SysONError as exc:
        reason = str(exc)
        status = "TIMEOUT" if "timed out" in reason.lower() or "timeout" in reason.lower() else "SERVER_ERROR"
        return {"semantic_name": semantic_name, "status": status, "object_id": None,
                "reason": reason, "index_reason": index_error, "resolver_method": "GLOBAL_SEARCH_FALLBACK"}
    exact = [m for m in matches if m.get("label") == semantic_name]
    if len(exact) == 1:
        return {"semantic_name": semantic_name, "status": "RESOLVED", "object_id": exact[0]["id"], "kind": exact[0].get("kind"), "label": exact[0].get("label"), "resolver_method": "GLOBAL_SEARCH_FALLBACK"}
    return {"semantic_name": semantic_name, "status": "NOT_FOUND" if not exact else "AMBIGUOUS", "object_id": None,
            "match_count": len(exact), "reason": "SysON 当前 EditingContext 中没有唯一精确标签匹配。", "resolver_method": "GLOBAL_SEARCH_FALLBACK"}
