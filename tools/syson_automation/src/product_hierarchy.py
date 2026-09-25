from __future__ import annotations

from .models import HierarchyNode, ProductClosureNode


def load_product_hierarchy(product_nodes: list[dict]) -> dict[str, dict]:
    """Read explicit Product level and parent_code from ModelGraph/frozen SysML."""
    result = {}
    for product in product_nodes:
        code = product.get("code") or product.get("product_id")
        if not code:
            continue
        level = product.get("level")
        parent = product.get("parent_code")
        if level not in (1, 2, 3, 4):
            raise ValueError(f"Product {code} 缺少可用的真实 1–4 层 hierarchy level。")
        result[code] = {"product_id": code, "product_name": product.get("display_name") or product.get("name") or code,
                        "level": int(level), "parent_product_id": parent}
    return result


def resolve_ancestor(product_id: str, target_level: int, hierarchy: dict[str, dict]) -> str | None:
    current = hierarchy.get(product_id)
    visited = set()
    while current and current["level"] > target_level:
        if current["product_id"] in visited:
            raise ValueError("Product hierarchy contains a parent cycle.")
        visited.add(current["product_id"])
        parent_id = current.get("parent_product_id")
        current = hierarchy.get(parent_id) if parent_id else None
    return current["product_id"] if current and current["level"] == target_level else None


def reconstruct_scope_hierarchy(closure_nodes: list[ProductClosureNode], hierarchy: dict[str, dict], seed_product_ids: set[str]) -> list[HierarchyNode]:
    included = {n.product_id for n in closure_nodes}
    for code in list(included):
        current = hierarchy.get(code)
        while current and current.get("parent_product_id"):
            parent = current["parent_product_id"]
            if parent not in hierarchy:
                raise ValueError(f"真实父产品 {parent} 缺失，不能恢复 hierarchy。")
            included.add(parent)
            current = hierarchy[parent]
    children: dict[str, list[str]] = {}
    for code in included:
        parent = hierarchy[code].get("parent_product_id")
        if parent in included:
            children.setdefault(parent, []).append(code)
    paths = {}
    for code in included:
        chain, current, seen = [], hierarchy[code], set()
        while current:
            cid = current["product_id"]
            if cid in seen:
                raise ValueError("Product hierarchy contains a parent cycle.")
            seen.add(cid); chain.append(cid)
            parent = current.get("parent_product_id")
            current = hierarchy.get(parent) if parent else None
        paths[code] = list(reversed(chain))
    role_by_id = {n.product_id: ("OWNER" if n.product_id in seed_product_ids else "INTERACTION_NEIGHBOR") for n in closure_nodes}
    result = []
    for code in sorted(included, key=lambda x: (hierarchy[x]["level"], x)):
        p = hierarchy[code]
        parent = p.get("parent_product_id") if p.get("parent_product_id") in included else None
        result.append(HierarchyNode(product_id=code, product_name=p["product_name"], level=p["level"],
            parent_product_id=parent, child_product_ids=sorted(children.get(code, [])), hierarchy_path=paths[code],
            role=role_by_id.get(code, "HIERARCHY_ANCESTOR")))
    return result
