from __future__ import annotations

import hashlib
import json
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

from .models import CanonicalProduct, EngineeringScopeManifest, Evidence, FlowScopeItem, FunctionScopeItem, InterfaceScopeItem, ProductScopeItem, RequirementScopeItem, ScopeViewPlan, ViewSpec
from .product_closure import build_closure_evidence, build_product_adjacency, compute_interface_product_closure
from .product_canonicalizer import canonicalize_products
from .product_hierarchy import load_product_hierarchy, reconstruct_scope_hierarchy
from .ibd_hierarchy_builder import build_hierarchical_ibd_views
from .container_ibd_builder import build_container_view


ROOT = Path(__file__).resolve().parents[3]
DATA = ROOT / "ui/backend/data/semantic_slice"
OUT = ROOT / "tools/syson_automation/generated"


def _read(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def _hash(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _text(value: Any, fallback: str = "") -> str:
    return str(value or fallback)


def build_scope(query: str, semantic_result: dict, task_slice_service) -> EngineeringScopeManifest:
    """Build a traceable, bounded scope exclusively from existing catalog/model rows."""
    requirements_raw = semantic_result.get("requirements", [])[:20]
    functions_raw = semantic_result.get("functions", [])
    if not requirements_raw or not functions_raw:
        raise ValueError("当前查询没有可追溯的 Requirement→Function 结果，未生成 Scope。")

    catalog = task_slice_service.catalog()
    declared = {f["id"]: f for f in catalog["functions"]}
    requirement_ids = {r.get("requirement_id") or r.get("id") for r in requirements_raw}
    # The query service returns ranked evidence, while the formal V2 map is the
    # complete set of requirement→function links for those selected requirements.
    # Expand from that map so a relevant requirement does not lose its other
    # formally mapped Functions merely because ranking returned one top match.
    mapping_rows = _read(DATA / "requirement_function_map_v2.json").get("relations", [])
    mapped_rows = [x for x in mapping_rows if x.get("requirement_id") in requirement_ids]
    by_function = {f.get("function_id") or f.get("id"): f for f in functions_raw}
    for row in mapped_rows:
        fid = row.get("function_id")
        if fid in declared and fid not in by_function:
            by_function[fid] = {"function_id": fid, "name": row.get("function_name"), "mapping_evidence": [row]}
    functions_raw = list(by_function.values())
    requested_ids = {f.get("function_id") or f.get("id") for f in functions_raw}
    functions_raw = [f for f in functions_raw if (f.get("function_id") or f.get("id")) in declared]
    function_ids = [f.get("function_id") or f.get("id") for f in functions_raw]
    if not function_ids:
        raise ValueError("语义结果中的 Function 未能与正式 SysML allocation 目录匹配。")

    projection = task_slice_service.project(function_ids)
    interface_stage = projection["stages"][3]
    closure_stage = projection["stages"][4]
    product_by_code = {n["data"]["code"]: n["data"] for n in task_slice_service.graph.get_full_model_graph()["nodes"]}

    requirements = []
    for r in requirements_raw:
        rid = _text(r.get("requirement_id") or r.get("id"))
        evidence = [Evidence(source="V2 semantic query", id=rid, text=_text(r.get("match_reason") or r.get("text") or r.get("name"), rid))]
        formal_req = next((x for x in _read(DATA / "requirement_catalog_v2.json").get("requirements", []) if x.get("Requirement_ID") == rid), {})
        requirements.append(RequirementScopeItem(
            id=rid, name=_text(r.get("name") or r.get("requirement_name"), rid),
            requirement_level=_text(r.get("requirement_level") or r.get("level"), "UNKNOWN"),
            source_type=_text(r.get("source_type"), "FORMAL_REQUIREMENT"),
            score=float(r.get("semantic_score", r.get("score", 0)) or 0), evidence=evidence,
            parent_requirement_ids=list(r.get("parent_requirement_ids") or formal_req.get("Parent_Requirement_IDs") or []),
            derived_requirement_ids=list(r.get("derived_requirement_ids") or [])))

    # Owner links are read from the parsed frozen SysML allocation statements.
    owner_by_function: dict[str, tuple[str, str]] = {}
    allocations_by_function = {a["source"]: a for a in projection["stages"][1]["allocations"]}
    for fid in function_ids:
        a = allocations_by_function.get(fid)
        if not a:
            continue
        code = a["product_code"]
        prod = product_by_code.get(code, {})
        owner_by_function[fid] = (code, _text(prod.get("display_name"), code))
    valid_function_ids = []
    owner_codes = set()
    for fid in function_ids:
        if fid not in owner_by_function:
            continue
        owner_code = owner_by_function[fid][0]
        if len(valid_function_ids) >= 25 or len(valid_function_ids) + len(owner_codes | {owner_code}) > 25:
            continue
        valid_function_ids.append(fid)
        owner_codes.add(owner_code)
    functions = []
    for f in functions_raw:
        fid = f.get("function_id") or f.get("id")
        if fid not in owner_by_function:
            continue
        code, name = owner_by_function[fid]
        proof = f.get("mapping_evidence") or f.get("traceability") or []
        if not isinstance(proof, list): proof = [proof]
        functions.append(FunctionScopeItem(
            id=fid, name=_text(f.get("name"), declared[fid].get("display_name", fid)),
            owner_product_id=code, owner_product_name=name,
            evidence=[Evidence(source="SysML allocation", id=fid, text=_text(x.get("evidence") if isinstance(x, dict) else x, f"{fid} allocated to {code}")) for x in proof[:4]] or
                     [Evidence(source="SysML allocation", id=fid, text=f"{fid} allocated to {code}")]))

    real_interactions = _read(DATA / "l2_interaction_catalog.json")["interactions"]
    allowed_aggregates = {i["id"] for i in interface_stage["interfaces"]} | {i["id"] for i in closure_stage["interfaces"]}
    # Include only catalog interactions whose aggregate interface is in the real TaskSlice projection.
    selected = [i for i in real_interactions if i.get("aggregate_interface_ref") in allowed_aggregates]
    # Preserve the original Scope products contract: allocation owners plus the
    # TaskSlice L2 boundary and its real interaction neighbors. Full closure and
    # hierarchy nodes are additive fields below, not replacements for this list.
    legacy_products: dict[str, ProductScopeItem] = {}
    for code in sorted(owner_codes):
        product = product_by_code.get(code, {})
        legacy_products[code] = ProductScopeItem(id=code, name=_text(product.get("display_name"), code),
            level=product.get("level"), role="OWNER",
            evidence=[Evidence(source="SysML allocation", id=f.id, text=f"{f.id} allocated to {code}") for f in functions if f.owner_product_id == code])
    for product in projection["stages"][2]["products"]:
        code = product["code"]
        if code not in legacy_products:
            legacy_products[code] = ProductScopeItem(id=code, name=_text(product.get("display_name"), code),
                level=product.get("level"), role="INTERACTION_NEIGHBOR",
                evidence=[Evidence(source="TaskSlice L2 projection", id=product.get("id"), text=reason["text"]) for reason in product.get("reasons", [])[:3]])
    neighbor_codes = {i["source_product_id"] for i in selected} | {i["target_product_id"] for i in selected}
    for code in sorted(neighbor_codes - set(legacy_products)):
        product = product_by_code.get(code)
        if product:
            legacy_products[code] = ProductScopeItem(id=code, name=_text(product.get("display_name"), code),
                level=product.get("level"), role="INTERACTION_NEIGHBOR",
                evidence=[Evidence(source="L2 interaction catalog", id=next((i.get("aggregate_interface_ref") for i in selected if code in (i["source_product_id"], i["target_product_id"])), None),
                                   text="由真实聚合接口连接到当前 TaskSlice 产品")])

    flows = [FlowScopeItem(
        source_product_id=i["source_product_id"], target_product_id=i["target_product_id"], flow_name=i["flow_name"],
        flow_kind=i["flow_kind"], flow_ref=i["flow_ref"], interface_refs=list(i.get("interface_refs", [])),
        connector_refs=list(i.get("connector_refs", [])), evidence=_text(i.get("evidence"))) for i in selected]
    interfaces_by_id: dict[str, InterfaceScopeItem] = {}
    for i in selected:
        iid = i["aggregate_interface_ref"]
        entry = interfaces_by_id.setdefault(iid, InterfaceScopeItem(id=iid, name=_text(i.get("flow_name"), iid)))
        entry.interface_refs.extend(x for x in i.get("interface_refs", []) if x not in entry.interface_refs)
        entry.flow_refs.extend(x for x in [i.get("flow_ref")] if x and x not in entry.flow_refs)
        entry.connector_refs.extend(x for x in i.get("connector_refs", []) if x not in entry.connector_refs)

    scope_key = json.dumps({"query": " ".join(query.split()), "requirements": [r.id for r in requirements], "functions": valid_function_ids}, ensure_ascii=False, sort_keys=True)
    scope_id = "scope_" + hashlib.sha256(scope_key.encode("utf-8")).hexdigest()[:12]
    scope_slug = scope_id.removeprefix("scope_")
    requirement_view = ViewSpec(name=f"AUTO_REQ_{scope_slug}", view_type="REQUIREMENT", requirement_ids=[r.id for r in requirements],
                                function_ids=valid_function_ids, evidence=["V2 requirement-function map"])
    allocation_view = ViewSpec(name=f"AUTO_FP_{scope_slug}", view_type="FUNCTION_PRODUCT", function_ids=valid_function_ids,
                               product_ids=sorted(owner_codes), evidence=["冻结 SysML 中的真实 allocation 目标产品"])
    # Interface-induced closure uses the complete real Product interaction graph.
    full_graph = task_slice_service.graph.get_full_model_graph()
    product_rows = [x["data"] for x in full_graph["nodes"]]
    hierarchy = load_product_hierarchy(product_rows)
    interaction_rows = _read(DATA / "l2_interaction_catalog.json")["interactions"]
    task_interfaces = interface_stage["interfaces"] + closure_stage["interfaces"]
    adjacency, _ = build_product_adjacency(product_rows, interaction_rows, full_graph, task_interfaces)
    seed_product_ids = set(owner_codes)
    closure_nodes, closure_edges, closure_rounds = compute_interface_product_closure(seed_product_ids, adjacency, product_by_code)
    allocation_refs_by_product: dict[str, list[str]] = {}
    for allocation in projection["stages"][1]["allocations"]:
        allocation_refs_by_product.setdefault(allocation["product_code"], []).append(allocation["id"])
    canonical_products, canonical_by_product = canonicalize_products(closure_nodes, product_by_code, closure_edges, allocation_refs_by_product)
    hierarchy_nodes = reconstruct_scope_hierarchy(closure_nodes, hierarchy, seed_product_ids)
    for item in hierarchy_nodes:
        if item.product_id in canonical_by_product:
            continue
        p = product_by_code[item.product_id]
        canonical_id = f"canonical_{item.product_id}"
        canonical_by_product[item.product_id] = canonical_id
        canonical_products.append(CanonicalProduct(canonical_id=canonical_id, display_name=item.product_name,
            source_product_ids=[item.product_id], source_element_ids=[p["id"], p["sysml_id"]],
            merge_kind="IDENTITY"))
    flow_kind_by_ref = {x.get("id"): x.get("kind", "unknown") for x in full_graph.get("flows", [])}
    for row in interaction_rows:
        if row.get("flow_ref"):
            flow_kind_by_ref[row["flow_ref"]] = row.get("flow_kind", flow_kind_by_ref.get(row["flow_ref"], "unknown"))
    hierarchical_ibd_views = build_hierarchical_ibd_views(scope_slug, closure_nodes, hierarchy_nodes, closure_edges, canonical_products, flow_kind_by_ref)
    container_source = {"scope_id": scope_id, "hierarchy_nodes": [x.model_dump(mode="json") for x in hierarchy_nodes],
                        "closure_edges": [x.model_dump(mode="json") for x in closure_edges]}
    available_ids = {x.product_id for x in hierarchy_nodes}
    container_ibd_views = [build_container_view(container_source, code) for code in ("ROOT", "X000", "X100")
                           if code == "ROOT" or code in available_ids]
    hierarchy_levels = sorted({x.level for x in hierarchy_nodes})
    closure_stats = {"seed_product_count": len(seed_product_ids), "closure_product_count": len(closure_nodes),
        "closure_edge_count": len(closure_edges), "closure_rounds": closure_rounds,
        "canonical_product_count": len(closure_nodes), "hierarchy_context_canonical_count": len(canonical_products), "hierarchy_levels_present": hierarchy_levels,
        "ibd_view_count": len(hierarchical_ibd_views), "container_ibd_view_count": len(container_ibd_views)}
    # Keep allocation owners, interface-induced neighbors, and hierarchy-only
    # ancestors as explicit roles; closure never changes Function ownership.
    # Persist a standalone auditable closure alongside the full scope manifest.
    closure_out = OUT / "closures"; closure_out.mkdir(parents=True, exist_ok=True)
    (closure_out / f"{scope_id}_product_closure.json").write_text(json.dumps({
        "scope_id": scope_id, "seed_product_ids": sorted(seed_product_ids),
        "product_closure": [x.model_dump(mode="json") for x in closure_nodes],
        "closure_edges": [x.model_dump(mode="json") for x in closure_edges],
        "closure_rounds": closure_rounds, "closure_stats": closure_stats}, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    source_files = [DATA / "requirement_catalog_v2.json", DATA / "requirement_function_map_v2.json", DATA / "function_product_map.json", DATA / "l2_interaction_catalog.json", task_slice_service.graph.source]
    manifest = EngineeringScopeManifest(
        scope_id=scope_id, query=query, created_at=datetime.now(timezone.utc), query_provider="LOCAL",
        requirements=requirements, functions=functions, products=list(legacy_products.values()), interfaces=list(interfaces_by_id.values()), flows=flows,
        seed_products=sorted(seed_product_ids), product_closure=closure_nodes, closure_edges=closure_edges,
        canonical_products=canonical_products, hierarchy_nodes=hierarchy_nodes, hierarchical_ibd_views=hierarchical_ibd_views,
        full_hierarchy_projection=hierarchical_ibd_views, container_ibd_views=container_ibd_views,
        closure_stats=closure_stats,
        view_plan=ScopeViewPlan(requirement_view=requirement_view, function_product_view=allocation_view,
                                hierarchical_ibd_views=hierarchical_ibd_views, full_hierarchy_projection=hierarchical_ibd_views,
                                container_ibd_views=container_ibd_views, ibd_views=hierarchical_ibd_views),
        limits_applied=["Requirement ≤20", "Function/Product Allocation View ≤25 nodes",
                        "Container IBD 按需下钻，最多四层；全局层级投影仅供审计"],
        source_hashes={p.name: _hash(p) for p in source_files if p.exists()},
        diagnostics=["没有创建或推断模型元素；所有产品/接口/flow来自现有 SysML 与 V2 interaction catalog。"],
        raw_stats={"matched_requirement_count": len(semantic_result.get("requirements", [])), "scope_requirement_count": len(requirements),
                   "scope_function_count": len(functions), "legacy_scope_product_count": len(legacy_products), "owner_product_count": len(seed_product_ids),
                   "interface_closure_product_count": len(closure_nodes), "hierarchy_context_product_count": len(hierarchy_nodes),
                   "aggregate_interface_count": len(interfaces_by_id), "real_flow_count": len(flows),
                   "ibd_view_count": len(hierarchical_ibd_views), "unmatched_semantic_function_count": len(requested_ids - set(valid_function_ids))})
    OUT.joinpath("scopes").mkdir(parents=True, exist_ok=True)
    OUT.joinpath("scopes", f"{scope_id}.json").write_text(manifest.model_dump_json(indent=2), encoding="utf-8")
    return manifest
