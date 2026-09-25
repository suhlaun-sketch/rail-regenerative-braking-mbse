from __future__ import annotations

from collections import defaultdict

from .models import CanonicalProduct, HierarchyNode, ProductClosureEdge, ViewSpec
from .product_hierarchy import resolve_ancestor
from .nested_ibd_builder import build_nested_ibd_plans


def aggregate_projected_interactions(edges: list[ProductClosureEdge], hierarchy: dict[str, dict], target_level: int,
                                      canonical_by_product: dict[str, str], flow_kind_by_ref: dict[str, str]) -> list[dict]:
    grouped: dict[tuple[str, str], dict] = {}
    for edge in edges:
        source = resolve_ancestor(edge.source_product_id, target_level, hierarchy)
        target = resolve_ancestor(edge.target_product_id, target_level, hierarchy)
        if not source or not target or source == target:
            continue
        # Stable visual endpoints, while preserving actual direction in forward/reverse refs.
        left, right = sorted((source, target))
        item = grouped.setdefault((left, right), {"source": left, "target": right,
            "source_canonical_id": canonical_by_product.get(left, f"canonical_{left}"),
            "target_canonical_id": canonical_by_product.get(right, f"canonical_{right}"),
            "forward_flow_refs": set(), "reverse_flow_refs": set(), "interface_refs": set(),
            "connector_refs": set(), "directions": set(), "flow_kind_counts": defaultdict(int)})
        direction = "FORWARD" if (source, target) == (left, right) else "REVERSE"
        item["directions"].add(direction)
        ref_set = item["forward_flow_refs"] if direction == "FORWARD" else item["reverse_flow_refs"]
        fresh_refs = set(edge.flow_refs) - item["forward_flow_refs"] - item["reverse_flow_refs"]
        ref_set.update(fresh_refs)
        item["interface_refs"].update(edge.interface_refs)
        item["connector_refs"].update(edge.connector_refs)
        for ref in fresh_refs:
            item["flow_kind_counts"][flow_kind_by_ref.get(ref, "unknown")] += 1
    output = []
    for _, item in sorted(grouped.items()):
        output.append({**item,
            "forward_flow_refs": sorted(item["forward_flow_refs"]), "reverse_flow_refs": sorted(item["reverse_flow_refs"]),
            "interface_refs": sorted(item["interface_refs"]), "connector_refs": sorted(item["connector_refs"]),
            "directions": sorted(item["directions"]), "flow_kind_counts": dict(sorted(item["flow_kind_counts"].items())),
            "aggregated_from_flow_refs": sorted(item["forward_flow_refs"] | item["reverse_flow_refs"]),
            "aggregated_from_interface_refs": sorted(item["interface_refs"]),
            "aggregated_from_connector_refs": sorted(item["connector_refs"])})
    return output


def project_closure_to_level(closure_nodes, hierarchy_nodes: list[HierarchyNode], closure_edges: list[ProductClosureEdge],
                             canonical_products: list[CanonicalProduct], target_level: int, flow_kind_by_ref: dict[str, str]) -> dict:
    hierarchy = {x.product_id: {"product_id": x.product_id, "product_name": x.product_name, "level": x.level,
                                "parent_product_id": x.parent_product_id} for x in hierarchy_nodes}
    # resolve_ancestor may need full ancestors outside partial hierarchy records; all
    # ancestors are included in reconstructed scope hierarchy.
    canonical_by_product = {code: item.canonical_id for item in canonical_products for code in item.source_product_ids}
    products = [x for x in hierarchy_nodes if x.level == target_level]
    interactions = aggregate_projected_interactions(closure_edges, hierarchy, target_level, canonical_by_product, flow_kind_by_ref)
    return {"level": target_level, "product_ids": [x.product_id for x in products],
            "canonical_product_ids": [canonical_by_product.get(x.product_id, f"canonical_{x.product_id}") for x in products],
            "projected_interactions": interactions}


def build_hierarchical_ibd_views(scope_slug: str, closure_nodes, hierarchy_nodes: list[HierarchyNode],
                                 closure_edges: list[ProductClosureEdge], canonical_products: list[CanonicalProduct],
                                 flow_kind_by_ref: dict[str, str]) -> list[ViewSpec]:
    plans = build_nested_ibd_plans(scope_slug, hierarchy_nodes, closure_edges, canonical_products)
    levels = [plan["level"] for plan in plans]
    names = {level: f"AUTO_IBD_L{level}_{scope_slug}" for level in levels}
    views = []
    for index, plan in enumerate(plans):
        level = plan["level"]
        parent_level = levels[index - 1] if index else None
        child_level = levels[index + 1] if index + 1 < len(levels) else None
        # Backward-compatible projected_interactions now reflects only true
        # product-boundary links. Internal child connections live in their own
        # structured field and are never collapsed away.
        projected = plan["external_connections"]
        evidence = sorted({ref for edge in (plan["internal_connections"] + projected)
                           for ref in edge["flow_refs"]})
        views.append(ViewSpec(name=names[level], view_type="IBD", hierarchy_level=level,
            product_ids=[p["product_id"] for p in plan["products"]],
            canonical_product_ids=[p["canonical_product_id"] or f"canonical_{p['product_id']}" for p in plan["products"]],
            projected_interactions=projected, view_id=f"ibd_l{level}_{scope_slug}", level=level,
            products=plan["products"], internal_connections=plan["internal_connections"],
            boundary_ports=plan["boundary_ports"], boundary_links=plan["boundary_links"],
            external_connections=plan["external_connections"], evidence_summary=plan["evidence_summary"],
            parent_view_name=names.get(parent_level), child_view_names=[names[child_level]] if child_level else [],
            evidence=evidence))
    return views
