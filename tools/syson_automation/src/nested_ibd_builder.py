from __future__ import annotations

from collections import Counter, defaultdict
from hashlib import sha1

from .models import CanonicalProduct, HierarchyNode, ProductClosureEdge


def _id(prefix: str, *parts: str) -> str:
    return f"{prefix}_{sha1('|'.join(parts).encode('utf-8')).hexdigest()[:12]}"


def _evidence_type(edge: ProductClosureEdge) -> str:
    if edge.connector_refs:
        return "EXPLICIT_CONNECTOR"
    if edge.flow_refs or edge.interface_refs:
        return "EXPLICIT_FLOW"
    raise ValueError(f"Connection {edge.source_product_id}->{edge.target_product_id} has no real evidence refs")


def _refs(edge: ProductClosureEdge) -> dict:
    return {"interface_refs": sorted(set(edge.interface_refs)), "flow_refs": sorted(set(edge.flow_refs)),
            "connector_refs": sorted(set(edge.connector_refs))}


def build_nested_ibd_plans(scope_slug: str, hierarchy_nodes: list[HierarchyNode], edges: list[ProductClosureEdge],
                           canonical_products: list[CanonicalProduct]) -> list[dict]:
    """Project real interactions into their lowest shared hierarchy container.

    Connections between descendants of the same container are internal there.
    Connections crossing top-level products are rendered between derived boundary
    ports at L1. Child-to-parent links carry the original edge evidence at each
    crossed boundary; no SysML connector or interface is invented.
    """
    node_by_id = {n.product_id: n for n in hierarchy_nodes}
    canonical_by_product = {pid: c.canonical_id for c in canonical_products for pid in c.source_product_ids}
    levels = sorted({n.level for n in hierarchy_nodes if 1 <= n.level <= 4})
    plans: dict[int, dict] = {}
    for level in levels:
        products = [{"product_id": n.product_id, "name": n.product_name, "level": n.level,
                     "parent_product_id": n.parent_product_id,
                     "canonical_product_id": canonical_by_product.get(n.product_id)}
                    for n in hierarchy_nodes if n.level == level]
        plans[level] = {"level": level, "products": products, "internal_connections": [], "boundary_ports": [],
                        "boundary_links": [], "external_connections": [], "evidence_summary": {}}

    port_map: dict[tuple[str, str, str], str] = {}
    port_acc: dict[tuple[int, str, str, str], dict] = {}
    link_acc: dict[tuple[int, str, str, str], dict] = {}

    def make_record(edge: ProductClosureEdge, source_product: str, source_element: str,
                    target_product: str, target_element: str, evidence_type: str) -> dict:
        return {"source_product_id": source_product, "source_element_id": source_element,
                "target_product_id": target_product, "target_element_id": target_element,
                **_refs(edge), "evidence_type": evidence_type}

    for edge in edges:
        source_node, target_node = node_by_id.get(edge.source_product_id), node_by_id.get(edge.target_product_id)
        if not source_node or not target_node:
            continue
        evidence_type = _evidence_type(edge)
        source_path, target_path = source_node.hierarchy_path, target_node.hierarchy_path
        common_len = 0
        for a, b in zip(source_path, target_path):
            if a != b:
                break
            common_len += 1
        common_id = source_path[common_len - 1] if common_len else None
        owner_level = node_by_id[common_id].level if common_id else 1
        if owner_level not in plans:
            owner_level = min(levels, key=lambda x: abs(x - owner_level))

        # Each hierarchy boundary crossed by an endpoint gets a stable, view-only
        # port and a child-to-parent link carrying exactly the same real evidence.
        endpoint_port: dict[str, str] = {}
        for side, path, endpoint_id in (("s", source_path, edge.source_product_id),
                                        ("t", target_path, edge.target_product_id)):
            stop_index = common_len if common_id else 0
            # For a shared container, the interaction terminates on its immediate
            # children; boundaries deeper than that are projected up to that child.
            for child_index in range(len(path) - 1, stop_index, -1):
                child_id, parent_id = path[child_index], path[child_index - 1]
                parent = node_by_id[parent_id]
                port_id = port_map.setdefault((parent_id, child_id, side),
                                               _id("boundary_port", parent_id, child_id, side))
                key = (parent.level, parent_id, child_id, port_id)
                port = port_acc.setdefault(key, {"port_id": port_id, "parent_product_id": parent_id,
                    "child_product_id": child_id, "source_product_id": parent_id,
                    "source_element_id": port_id, "target_product_id": child_id,
                    "target_element_id": f"product::{child_id}", **_refs(edge),
                    "evidence_type": "DERIVED_BOUNDARY"})
                for field in ("flow_refs", "interface_refs", "connector_refs"):
                    port[field] = sorted(set(port[field]) | set(getattr(edge, field)))
                link_key = (parent.level, parent_id, child_id, port_id)
                link = link_acc.setdefault(link_key, {"source_product_id": child_id,
                    "source_element_id": f"product::{child_id}", "target_product_id": parent_id,
                    "target_element_id": port_id, "interface_refs": [], "flow_refs": [],
                    "connector_refs": [], "evidence_type": "DERIVED_BOUNDARY"})
                for field in ("flow_refs", "interface_refs", "connector_refs"):
                    link[field] = sorted(set(link[field]) | set(getattr(edge, field)))
                if child_index == stop_index + 1 or (not common_id and child_index == 1):
                    endpoint_port[side] = port_id

        refs = _refs(edge)
        if common_id:
            source_branch = source_path[common_len] if len(source_path) > common_len else edge.source_product_id
            target_branch = target_path[common_len] if len(target_path) > common_len else edge.target_product_id
            record = make_record(edge, source_branch, f"product::{source_branch}",
                                 target_branch, f"product::{target_branch}", evidence_type)
            record.update({"aggregated_from_flow_refs": refs["flow_refs"],
                           "aggregated_from_interface_refs": refs["interface_refs"],
                           "aggregated_from_connector_refs": refs["connector_refs"]})
            plans[owner_level]["internal_connections"].append(record)
        else:
            source_root, target_root = source_path[0], target_path[0]
            source_port = endpoint_port.get("s") or _id("boundary_port", source_root, edge.source_product_id, "s")
            target_port = endpoint_port.get("t") or _id("boundary_port", target_root, edge.target_product_id, "t")
            record = make_record(edge, source_root, source_port, target_root, target_port, "DERIVED_BOUNDARY")
            record.update({"aggregated_from_flow_refs": refs["flow_refs"],
                           "aggregated_from_interface_refs": refs["interface_refs"],
                           "aggregated_from_connector_refs": refs["connector_refs"],
                           "source": source_root, "target": target_root,
                           "source_canonical_id": canonical_by_product.get(source_root, f"canonical_{source_root}"),
                           "target_canonical_id": canonical_by_product.get(target_root, f"canonical_{target_root}")})
            plans[owner_level]["external_connections"].append(record)

    for level, parent_id, _child_id, _port_id in sorted(port_acc):
        plans[level]["boundary_ports"].append(port_acc[(level, parent_id, _child_id, _port_id)])
        plans[level]["boundary_links"].append(link_acc[(level, parent_id, _child_id, _port_id)])

    for plan in plans.values():
        counts = Counter(x["evidence_type"] for field in ("internal_connections", "boundary_links", "external_connections")
                         for x in plan[field])
        plan["evidence_summary"] = {"connection_count": sum(counts.values()),
            "internal_connection_count": len(plan["internal_connections"]),
            "boundary_port_count": len(plan["boundary_ports"]),
            "boundary_link_count": len(plan["boundary_links"]),
            "external_connection_count": len(plan["external_connections"]),
            "evidence_type_counts": dict(sorted(counts.items()))}
    return [plans[level] for level in levels]
