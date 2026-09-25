from __future__ import annotations

from collections import defaultdict
from typing import Any

from .models import CanonicalProduct, ProductClosureEdge, ProductClosureNode


def merge_visual_occurrences(occurrences: list[dict]) -> list[dict]:
    """Fold only occurrences carrying the same explicit SysML usage identity.

    Matching display names alone is deliberately insufficient. All source ids and
    provenance arrays are unioned into the visual canonical record.
    """
    groups: dict[str, list[dict]] = defaultdict(list)
    singles: list[dict] = []
    for item in occurrences:
        usage_id = item.get("semantic_usage_id") or item.get("explicit_visual_merge_key")
        if usage_id:
            groups[str(usage_id)].append(item)
        else:
            singles.append(item)
    result = list(singles)
    for usage_id, members in groups.items():
        merged = dict(members[0])
        merged["canonical_id"] = merged.get("canonical_id") or f"canonical_usage_{usage_id}"
        merged["source_product_ids"] = sorted({x for m in members for x in m.get("source_product_ids", [])})
        merged["source_element_ids"] = sorted({x for m in members for x in m.get("source_element_ids", [])})
        for key in ("source_allocation_refs", "interface_refs", "connector_refs", "flow_refs"):
            merged[key] = sorted({x for m in members for x in m.get(key, [])})
        merged["merge_kind"] = "EXPLICIT_VISUAL_OCCURRENCE"
        result.append(merged)
    return result


def canonicalize_products(
    closure_nodes: list[ProductClosureNode],
    product_by_code: dict[str, dict],
    closure_edges: list[ProductClosureEdge],
    allocation_refs_by_product: dict[str, list[str]] | None = None,
) -> tuple[list[CanonicalProduct], dict[str, str]]:
    """Identity merge by exact Product code; no name-based entity merge."""
    allocation_refs_by_product = allocation_refs_by_product or {}
    edges_by_product: dict[str, dict[str, set[str]]] = defaultdict(lambda: defaultdict(set))
    for edge in closure_edges:
        for code in (edge.source_product_id, edge.target_product_id):
            edges_by_product[code]["flow_refs"].update(edge.flow_refs)
            edges_by_product[code]["interface_refs"].update(edge.interface_refs)
            edges_by_product[code]["connector_refs"].update(edge.connector_refs)
    canonical: list[CanonicalProduct] = []
    mapping: dict[str, str] = {}
    for node in closure_nodes:
        code = node.product_id
        product = product_by_code[code]
        cid = f"canonical_{code}"
        mapping[code] = cid
        canonical.append(CanonicalProduct(canonical_id=cid, display_name=node.canonical_name,
            source_product_ids=[code],
            source_element_ids=sorted(set(node.source_element_ids + [str(product.get("id")), str(product.get("sysml_id"))])),
            source_allocation_refs=sorted(set(allocation_refs_by_product.get(code, []))),
            interface_refs=sorted(edges_by_product[code]["interface_refs"]),
            connector_refs=sorted(edges_by_product[code]["connector_refs"]),
            flow_refs=sorted(edges_by_product[code]["flow_refs"]), merge_kind="IDENTITY"))
    # Visual merging requires an explicit occurrence/usage key. ModelGraph Product
    # Definitions expose none, so same-name distinct Product codes remain distinct.
    visual = merge_visual_occurrences([x.model_dump(mode="json") for x in canonical])
    return [CanonicalProduct.model_validate(x) for x in visual], mapping
