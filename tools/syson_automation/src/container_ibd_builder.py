from __future__ import annotations

from collections import Counter
from hashlib import sha1


def _port_id(container: str, child: str, external: str, side: str) -> str:
    key = f"{container}|{child}|{external}|{side}"
    return "virtual_boundary_" + sha1(key.encode("utf-8")).hexdigest()[:12]


def build_container_view(scope: dict, container_product_id: str, element_index: dict | None = None) -> dict:
    nodes = {x["product_id"]: x for x in scope["hierarchy_nodes"]}
    if container_product_id != "ROOT" and container_product_id not in nodes:
        raise ValueError(f"Container {container_product_id} is outside this scope hierarchy")
    if container_product_id == "ROOT":
        children = sorted((x for x in nodes.values() if x["level"] == 1), key=lambda x: x["product_id"])
        level, name, parent_id = 1, "Root System", None
    else:
        container = nodes[container_product_id]
        children = sorted((nodes[x] for x in container["child_product_ids"] if x in nodes), key=lambda x: x["product_id"])
        level, name, parent_id = container["level"], container["product_name"], container["parent_product_id"]
    child_ids = {x["product_id"] for x in children}
    direct_children = [{"product_id": x["product_id"], "name": x["product_name"], "level": x["level"],
                        "has_children": bool(x["child_product_ids"])} for x in children]

    def branch(product_id: str) -> str | None:
        node = nodes.get(product_id)
        if not node:
            return None
        if container_product_id == "ROOT":
            return node["hierarchy_path"][0]
        path = node["hierarchy_path"]
        return path[path.index(container_product_id) + 1] if container_product_id in path and len(path) > path.index(container_product_id) + 1 else None

    internal: list[dict] = []
    external: list[dict] = []
    links: list[dict] = []
    virtual_by_id: dict[str, dict] = {}
    external_by_id: dict[str, dict] = {}
    for edge in scope["closure_edges"]:
        src, dst = edge["source_product_id"], edge["target_product_id"]
        src_branch, dst_branch = branch(src), branch(dst)
        refs = {key: sorted(set(edge.get(key, []))) for key in ("interface_refs", "flow_refs", "connector_refs")}
        if not any(refs.values()):
            raise ValueError(f"Missing true evidence for {src}->{dst}")
        evidence_type = "EXPLICIT_CONNECTOR" if refs["connector_refs"] else "EXPLICIT_FLOW"
        if src_branch and dst_branch:
            if src_branch == dst_branch:
                continue  # This interaction belongs to the selected child's drill-down.
            internal.append({"source_product_id": src_branch, "source_element_id": f"product::{src_branch}",
                             "target_product_id": dst_branch, "target_element_id": f"product::{dst_branch}",
                             "actual_source_product_id": src, "actual_target_product_id": dst,
                             **refs, "evidence_type": evidence_type})
            continue
        if not (src_branch or dst_branch):
            continue
        inside_source = bool(src_branch)
        child = src_branch or dst_branch
        actual_child = src if inside_source else dst
        actual_external = dst if inside_source else src
        external_node = nodes.get(actual_external)
        if not external_node:
            continue
        # Only expose the nearest peer container; its descendants remain hidden.
        display_external = actual_external
        if level:
            for pid in external_node["hierarchy_path"]:
                if nodes[pid]["level"] == level:
                    display_external = pid
                    break
        else:
            display_external = external_node["hierarchy_path"][0]
        side = "out" if inside_source else "in"
        port_id = _port_id(container_product_id, child, display_external, side)
        projection = virtual_by_id.setdefault(port_id, {"port_id": port_id, "container_product_id": container_product_id,
            "child_product_id": child, "external_product_id": display_external,
            "interface_refs": [], "flow_refs": [], "connector_refs": [],
            "evidence_type": "DERIVED_BOUNDARY", "renderability": "VIRTUAL_BOUNDARY_PROJECTION"})
        for key in refs:
            projection[key] = sorted(set(projection[key]) | set(refs[key]))
        record = {"source_product_id": child if inside_source else display_external,
                  "source_element_id": f"product::{child}" if inside_source else f"product::{display_external}",
                  "target_product_id": display_external if inside_source else child,
                  "target_element_id": f"product::{display_external}" if inside_source else f"product::{child}",
                  "actual_source_product_id": src, "actual_target_product_id": dst,
                  "container_boundary_port_id": port_id, **refs, "evidence_type": "DERIVED_BOUNDARY"}
        external.append(record)
        links.append({"source_product_id": child, "source_element_id": f"product::{actual_child}",
                      "target_product_id": container_product_id, "target_element_id": port_id,
                      **refs, "evidence_type": "DERIVED_BOUNDARY"})
        external_by_id[display_external] = {"product_id": display_external,
            "name": nodes[display_external]["product_name"], "actual_endpoint_product_ids": []}
        actuals = external_by_id[display_external]["actual_endpoint_product_ids"]
        if actual_external not in actuals:
            actuals.append(actual_external)

    # Promotion requires an explicit container-owned PortUsage association to
    # the very connector/interface refs supporting the projected boundary.
    # A similarly named PortDefinition is insufficient evidence.
    real_ports: list[dict] = []
    for port_id, projection in list(virtual_by_id.items()):
        candidates = []
        for entry in (element_index or {}).get("entries", []):
            props = entry.get("properties") or {}
            if entry.get("sysml_type") != "PortUsage" or props.get("productCode") != container_product_id:
                continue
            connector_match = set(props.get("connector_refs", [])) & set(projection["connector_refs"])
            interface_match = set(props.get("interface_refs", [])) & set(projection["interface_refs"])
            if connector_match or interface_match:
                candidates.append(entry)
        if not candidates:
            continue
        required = {x for x in projection["connector_refs"] if x.startswith("CG_")}
        covered = set().union(*(set(e["properties"].get("connector_refs", [])) for e in candidates))
        if not required or not required <= covered:
            continue
        for entry in candidates:
            props = entry["properties"]
            refs = set(props.get("connector_refs", [])) & required
            if not refs:
                continue
            real_ports.append({**projection, "syson_object_id": entry["syson_object_id"],
                "label": entry["label"], "connector_refs": sorted(refs),
                "interface_refs": sorted(set(props.get("interface_refs", []))),
                "flow_refs": ["flow::" + x for x in sorted(refs)],
                "renderability": "REAL_BOUNDARY_PORT"})
        def split_rows(rows: list[dict], key: str) -> list[dict]:
            result = []
            for row in rows:
                if row[key] != port_id:
                    result.append(row)
                    continue
                for entry in candidates:
                    props = entry["properties"]
                    row_refs = {x for x in row["connector_refs"] if x.startswith("CG_")}
                    refs = set(props.get("connector_refs", [])) & required & row_refs
                    if not refs:
                        continue
                    result.append({**row, key: entry["syson_object_id"],
                        "connector_refs": sorted(refs),
                        "interface_refs": sorted(set(props.get("interface_refs", []))),
                        "flow_refs": ["flow::" + x for x in sorted(refs)]})
            return result
        links = split_rows(links, "target_element_id")
        external = split_rows(external, "container_boundary_port_id")
        del virtual_by_id[port_id]
    counts = Counter(x["evidence_type"] for x in internal + external + links)
    targets = [{"product_id": x["product_id"], "name": x["name"], "status": "AVAILABLE_DRILLDOWN_TARGET"}
               for x in direct_children if x["has_children"] and x["level"] < 4]
    slug = scope["scope_id"].removeprefix("scope_")
    view_name = f"AUTO_IBD_{container_product_id}_{slug}" if container_product_id != "ROOT" else f"AUTO_IBD_ROOT_{slug}"
    return {"view_id": f"ibd_{container_product_id}_{slug}", "view_name": view_name,
            "container_product_id": container_product_id, "container_product_name": name,
            "hierarchy_level": level, "drilldown_depth": 0 if container_product_id == "ROOT" else level,
            "direct_children": direct_children,
            "internal_connections": internal, "real_boundary_ports": real_ports,
            "virtual_boundary_projections": list(virtual_by_id.values()), "boundary_links": links,
            "external_endpoints": list(external_by_id.values()), "external_connections": external,
            "drilldown_targets": targets, "parent_container_id": parent_id,
            "evidence_summary": {"evidence_type_counts": dict(counts), "internal_connection_count": len(internal),
                                 "real_boundary_port_count": len(real_ports),
                                 "virtual_boundary_projection_count": len(virtual_by_id),
                                 "external_connection_count": len(external),
                                 "external_endpoint_count": len(external_by_id)}}
