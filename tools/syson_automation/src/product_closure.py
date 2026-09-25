from __future__ import annotations

from collections import defaultdict
from typing import Any

from .models import ClosureWitness, ProductClosureEdge, ProductClosureNode


def _code(node_id: str | None) -> str | None:
    if not node_id:
        return None
    return node_id.split("::", 1)[1] if node_id.startswith("product::") else node_id


def build_product_adjacency(
    product_nodes: list[dict],
    interaction_catalog: list[dict],
    sysml_graph: dict,
    task_slice_interfaces: list[dict] | None = None,
) -> tuple[dict[str, list[dict]], list[dict]]:
    """Create undirected discovery adjacency from real Product↔Product evidence only.

    Each edge record retains its original direction and provenance. The adjacency
    index is undirected, while edge source/target and directions remain directed.
    """
    known = {n.get("code") or n.get("product_id") for n in product_nodes}
    known.discard(None)
    edges: dict[tuple, dict] = {}

    def add(source: str | None, target: str | None, *, flow_refs=(), interface_refs=(), connector_refs=(), direction="source_to_target", kinds=(), source_name=""):
        if not source or not target or source == target or source not in known or target not in known:
            return
        fr, ir, cr, fk = tuple(sorted(set(filter(None, flow_refs)))), tuple(sorted(set(filter(None, interface_refs)))), tuple(sorted(set(filter(None, connector_refs)))), tuple(sorted(set(filter(None, kinds))))
        key = (source, target, fr, ir, cr, direction)
        row = edges.setdefault(key, {"source_product_id": source, "target_product_id": target, "flow_refs": list(fr),
            "interface_refs": list(ir), "connector_refs": list(cr), "directions": [direction], "flow_kinds": list(fk), "evidence_sources": []})
        if source_name and source_name not in row["evidence_sources"]:
            row["evidence_sources"].append(source_name)

    # SysML leaf connections are the authoritative lowest-level connector graph.
    for relation in sysml_graph.get("leaf_interfaces", []):
        source = _code((relation.get("source") or {}).get("node_id"))
        target = _code((relation.get("target") or {}).get("node_id"))
        flows = relation.get("flow_items", [])
        ports = []
        for endpoint in (relation.get("source") or {}, relation.get("target") or {}):
            port = endpoint.get("port") or {}
            ports.extend(x for x in (port.get("id"), port.get("source_port_id"), port.get("raw_id")) if x)
        add(source, target, flow_refs=[x.get("id") for x in flows],
            interface_refs=[relation.get("id"), *ports], connector_refs=relation.get("leaf_connection_ids", []),
            direction=relation.get("direction", "source_to_target"), kinds=[x.get("kind") for x in flows], source_name="FROZEN_SYSML_LEAF_CONNECTION")

    # Formal L2 interaction catalog rows retain aggregate interface, leaf connector,
    # interface definition, and flow references. Include the full catalog for closure.
    for relation in interaction_catalog:
        add(relation.get("source_product_id"), relation.get("target_product_id"),
            flow_refs=[relation.get("flow_ref")],
            interface_refs=[relation.get("aggregate_interface_ref"), *relation.get("interface_refs", []), *relation.get("leaf_connection_refs", [])],
            connector_refs=relation.get("connector_refs", []), direction="source_to_target",
            kinds=[relation.get("flow_kind")], source_name="L2_INTERACTION_CATALOG")

    # TaskSlice-projected real aggregates are included as a second trace path. They
    # do not synthesize neighbors; endpoints and flow items must exist in the model.
    for relation in task_slice_interfaces or []:
        flows = relation.get("flow_items", [])
        add(_code(relation.get("source_node_id")), _code(relation.get("target_node_id")),
            flow_refs=[x.get("id") for x in flows],
            interface_refs=[relation.get("id"), *relation.get("child_interfaces", [])],
            connector_refs=relation.get("leaf_connections", []), direction=relation.get("direction", "source_to_target"),
            kinds=[x.get("kind") for x in flows], source_name="TASKSLICE_PROJECTED_INTERFACE")

    edge_rows = sorted(edges.values(), key=lambda e: (e["source_product_id"], e["target_product_id"], e["flow_refs"], e["interface_refs"]))
    adjacency: dict[str, list[dict]] = defaultdict(list)
    for edge in edge_rows:
        adjacency[edge["source_product_id"]].append(edge)
        adjacency[edge["target_product_id"]].append(edge)
    return dict(adjacency), edge_rows


def compute_interface_product_closure(seed_product_ids: list[str] | set[str], adjacency: dict[str, list[dict]], product_by_code: dict[str, dict]) -> tuple[list[ProductClosureNode], list[ProductClosureEdge], int]:
    """Expand undirected adjacency to a fixed point; never use rounds as hierarchy."""
    seeds = set(seed_product_ids)
    unknown = seeds - set(product_by_code)
    if unknown:
        raise ValueError(f"Seed 产品不在真实 Product hierarchy 中：{sorted(unknown)}")
    introduced_round = {code: 0 for code in seeds}
    introduced_by: dict[str, list[ClosureWitness]] = defaultdict(list)
    closure = set(seeds)
    frontier = set(seeds)
    rounds = 0
    while frontier:
        next_frontier: set[str] = set()
        for current in sorted(frontier):
            for edge in adjacency.get(current, []):
                source, target = edge["source_product_id"], edge["target_product_id"]
                neighbor = target if current == source else source
                if neighbor in closure:
                    continue
                next_frontier.add(neighbor)
                first_flow = edge["flow_refs"][0] if edge["flow_refs"] else None
                first_interface = edge["interface_refs"][0] if edge["interface_refs"] else None
                witness = ClosureWitness(neighbor_product_id=current, interface_ref=first_interface,
                    flow_ref=first_flow, connector_refs=list(edge["connector_refs"]))
                if witness not in introduced_by[neighbor]:
                    introduced_by[neighbor].append(witness)
        if not next_frontier:
            break
        rounds += 1
        for code in next_frontier:
            introduced_round[code] = rounds
        closure.update(next_frontier)
        frontier = next_frontier

    nodes = []
    for code in sorted(closure):
        product = product_by_code[code]
        display = str(product.get("display_name") or product.get("name") or code)
        nodes.append(ProductClosureNode(product_id=code, product_name=display, canonical_name=display,
            source_element_ids=list(dict.fromkeys(x for x in (product.get("id"), product.get("sysml_id"), product.get("source_path")) if x)),
            seed=code in seeds, introduced_at_round=introduced_round.get(code, 0), introduced_by=introduced_by.get(code, [])))

    edge_map: dict[tuple[str, str], dict[str, Any]] = {}
    seen_edges = set()
    for edges in adjacency.values():
        for edge in edges:
            src, dst = edge["source_product_id"], edge["target_product_id"]
            if src not in closure or dst not in closure:
                continue
            edge_key = (src, dst, tuple(edge["flow_refs"]), tuple(edge["interface_refs"]), tuple(edge["connector_refs"]), tuple(edge["directions"]))
            if edge_key in seen_edges:
                continue
            seen_edges.add(edge_key)
            item = edge_map.setdefault((src, dst), {"source_product_id": src, "target_product_id": dst,
                "flow_refs": set(), "interface_refs": set(), "connector_refs": set(), "directions": set(), "flow_kinds": defaultdict(int), "evidence_sources": set()})
            item["flow_refs"].update(edge["flow_refs"]); item["interface_refs"].update(edge["interface_refs"])
            item["connector_refs"].update(edge["connector_refs"]); item["directions"].update(edge["directions"])
            item["evidence_sources"].update(edge["evidence_sources"])
            for kind in edge["flow_kinds"]: item["flow_kinds"][kind] += 1
    closure_edges = [ProductClosureEdge(source_product_id=src, target_product_id=dst,
        flow_refs=sorted(v["flow_refs"]), interface_refs=sorted(v["interface_refs"]), connector_refs=sorted(v["connector_refs"]),
        directions=sorted(v["directions"]), flow_kinds=dict(v["flow_kinds"]), evidence_sources=sorted(v["evidence_sources"]))
        for (src, dst), v in sorted(edge_map.items())]
    return nodes, closure_edges, rounds


def build_closure_evidence(seed_product_ids: set[str], nodes: list[ProductClosureNode], edges: list[ProductClosureEdge]) -> dict:
    return {"seed_product_ids": sorted(seed_product_ids), "nodes": [x.model_dump(mode="json") for x in nodes],
            "edges": [x.model_dump(mode="json") for x in edges]}
