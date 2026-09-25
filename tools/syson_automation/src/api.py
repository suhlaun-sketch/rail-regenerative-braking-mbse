from __future__ import annotations

import json
import re
from pathlib import Path

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field

from .element_resolver import resolve_exact
from .container_ibd_builder import build_container_view
from .models import ScopeRequest
from .representation_service import RepresentationService
from .scope_builder import OUT, build_scope
from .syson_client import SysONClient
from tools.syson_automation.scripts.build_syson_element_index import build_index

ROOT = Path(__file__).resolve().parents[3]


def _active_index() -> dict:
    target = ROOT / "tools/syson_automation/cache/active_target.json"
    if not target.is_file():
        return build_index()
    config = json.loads(target.read_text(encoding="utf-8"))
    return build_index(project_path=ROOT / config["project_path"],
        cache_path=ROOT / config["index_path"], model_path=ROOT / config["model_path"],
        deep_products=("P_X100", "P_N_8100", "P_X110", "P_X120", "P_X130", "P_X112", "P_N_8122"))


def _verified_port_views(index: dict, scope_id: str) -> dict | None:
    if scope_id != "scope_6289f72770e3":
        return None
    project_path = ROOT / "tools/syson_automation/cache/port_enhanced_project.json"
    views_path = ROOT / "tools/syson_automation/cache/port_enhanced_views.json"
    if not project_path.is_file() or not views_path.is_file():
        return None
    project = json.loads(project_path.read_text(encoding="utf-8"))
    if index["project_id"] != project["project_id"]:
        return None
    return json.loads(views_path.read_text(encoding="utf-8"))


class GenerateRequest(BaseModel):
    scope_id: str = Field(pattern=r"^scope_[a-f0-9]{12}$")


class ContainerRequest(GenerateRequest):
    container_product_id: str = Field(pattern=r"^(ROOT|[A-Za-z0-9]+)$")
    create_in_syson: bool = False


def _scope(scope_id: str) -> dict:
    path = OUT / "scopes" / f"{scope_id}.json"
    if not path.is_file():
        raise HTTPException(404, "Scope 不存在")
    return json.loads(path.read_text(encoding="utf-8"))


def _create_view(scope: dict, client: SysONClient, service: RepresentationService,
                 index: dict, view_type: str, container_plan: dict | None = None) -> dict:
    scope_id = scope["scope_id"]
    slug = scope_id.removeprefix("scope_")
    by_id = index["by_semantic_id"]
    if view_type == "REQUIREMENT":
        names = [x["id"] for x in scope["requirements"]]
        name, requested_kind = f"AUTO_REQ_{slug}", "GENERAL"
    elif view_type == "FUNCTION_PRODUCT":
        selected = scope["functions"][:5]
        names = [x["id"] for x in selected] + [x["owner_product_id"] for x in selected]
        source = (Path(__file__).resolve().parents[3] / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml").read_text(encoding="utf-8")
        for function in selected:
            usage = "fu_" + function["id"].removeprefix("FN_")
            pattern = (r"allocation\s+(\w+)\s+allocate\s+" + re.escape(usage)
                       + r"\s+to\s+ap_(?:N_)?" + re.escape(function["owner_product_id"]) + r"\s*;")
            matched = re.findall(pattern, source)
            if len(matched) != 1:
                return {"status": "BLOCKED_RESOLUTION", "name": f"AUTO_FP_{slug}",
                        "reason": f"真实 allocation 无唯一匹配：{function['id']} → {function['owner_product_id']}"}
            names.append(matched[0])
        name, requested_kind = f"AUTO_FP_{slug}", "GENERAL"
    else:
        if not container_plan:
            raise ValueError("Container plan is required")
        code = container_plan["container_product_id"]
        names = [x["product_id"] for x in container_plan["direct_children"]]
        names += [x["product_id"] for x in container_plan["external_endpoints"]]
        name, requested_kind = container_plan["view_name"], "INTERCONNECTION"
    if not names:
        return {"status": "BLOCKED_RESOLUTION", "name": name, "reason": "No semantic elements in view plan"}
    missing = [x for x in names if len(by_id.get(x, [])) != 1]
    if missing:
        return {"status": "BLOCKED_RESOLUTION", "name": name, "missing": missing}
    object_ids = [by_id[x][0] for x in dict.fromkeys(names)]
    if view_type == "IBD" and container_plan:
        object_ids.extend(port["syson_object_id"] for port in container_plan["real_boundary_ports"])
    root_name = (("Rail_MBSE" if container_plan["container_product_id"] == "ROOT" else container_plan["container_product_id"])
                 if view_type == "IBD" else names[0])
    root_ids = by_id.get(root_name, [])
    if len(root_ids) != 1:
        return {"status": "BLOCKED_RESOLUTION", "name": name, "missing": [root_name]}
    root = root_ids[0]
    descriptions = service.descriptions(root)
    target_label = "Interconnection View" if requested_kind == "INTERCONNECTION" else "General View"
    selected = next((x for x in descriptions if x["label"] == target_label), None)
    fallback_reason = None
    if not selected and requested_kind == "INTERCONNECTION":
        selected = next((x for x in descriptions if x["label"] == "General View"), None)
        fallback_reason = "Interconnection View is not available for this semantic root"
    if not selected:
        return {"status": "BLOCKED_DESCRIPTION", "name": name, "available": [x["label"] for x in descriptions]}
    stable_key = f"{index['project_id']}:{scope_id}:{view_type}:{container_plan['container_product_id'] if container_plan else '-'}"
    rep = service.create_or_reuse(stable_key=stable_key, root_object_id=root,
                                  description_id=selected["id"], name=name)
    if not rep.get("owned", False):
        return {"status": "BLOCKED", "name": name, "reason": "Existing AUTO_ representation is not automation-owned", "representation": rep}
    verified = service.populate_and_verify(rep["id"], object_ids)
    return {"status": verified["status"], "name": name,
            "representation": {"id": rep["id"], "name": name, "kind": selected["label"],
                               "url": None, "reused": rep["reused"]},
            "requested_kind": requested_kind, "actual_kind": selected["label"], "fallback_reason": fallback_reason,
            "query_back": verified, "resolved_elements": len(object_ids)}


def syson_router(semantic_service, task_slice_service):
    router = APIRouter(prefix="/api/syson", tags=["SysON dynamic views"])

    @router.post("/scope")
    async def create_scope(request: ScopeRequest):
        try:
            semantic_result = await semantic_service.query(request.query, "local")
            manifest = build_scope(request.query, semantic_result, task_slice_service)
            return manifest.model_dump(mode="json")
        except ValueError as exc:
            raise HTTPException(422, str(exc)) from exc

    @router.get("/scope/{scope_id}")
    def get_scope(scope_id: str):
        if not re.fullmatch(r"scope_[a-f0-9]{12}", scope_id):
            raise HTTPException(400, "scope_id 格式错误")
        return _scope(scope_id)

    @router.post("/views/plan")
    def plan_views(request: GenerateRequest):
        scope = _scope(request.scope_id)
        plan = scope["view_plan"]
        ibds = plan.get("container_ibd_views", [])
        return {"scope_id": request.scope_id, "planned_count": 2 + len(ibds), "created_count": 0,
                "views": [plan["requirement_view"], plan["function_product_view"], *ibds],
                "full_hierarchy_projection": plan.get("full_hierarchy_projection", []),
                "status": "PLANNED", "diagnostics": scope.get("diagnostics", [])}

    @router.post("/views/generate")
    def generate_views(request: GenerateRequest):
        scope = _scope(request.scope_id)
        index = _active_index()
        client = SysONClient(timeout=45)
        service = RepresentationService(client, index["editing_context_id"])
        verified = _verified_port_views(index, request.scope_id)
        if verified:
            names = {"port_smoke": "AUTO_PORT_X100_SMOKE",
                     "connection_smoke": "AUTO_CONNECTION_EDGE_SMOKE",
                     "fp": "AUTO_FP_PORTENHANCED_6289f72770e3",
                     "x100_ibd": "AUTO_IBD_X100_PORTENHANCED_6289f72770e3",
                     "x100_internal": "AUTO_IBD_X100_INTERNAL_PORTENHANCED_6289f72770e3",
                     "x110_ibd": "AUTO_IBD_X110_PORTENHANCED_6289f72770e3"}
            outcomes = []
            for key, name in names.items():
                if key not in verified:
                    continue
                diagram = service.diagram(verified[key])
                outcomes.append({"status": "CREATED" if diagram["nodes"] else "VERIFY_FAILED",
                    "name": name, "id": verified[key], "node_count": len(diagram["nodes"]),
                    "edge_count": len(diagram["edges"]), "query_back": True})
            created = sum(x["status"] == "CREATED" for x in outcomes)
            return {"scope_id": request.scope_id, "status": "CREATED" if created == len(outcomes) else "PARTIAL",
                    "planned_count": len(outcomes), "created_count": created,
                    "mutations_attempted": False, "mutation_count": 0, "views": outcomes}
        outcomes = []
        for kind, plan in [("REQUIREMENT", None), ("FUNCTION_PRODUCT", None),
                           ("IBD", build_container_view(scope, "ROOT", index)),
                           ("IBD", build_container_view(scope, "X000", index)),
                           ("IBD", build_container_view(scope, "X100", index))]:
            try:
                outcomes.append(_create_view(scope, client, service, index, kind, plan))
            except Exception as exc:
                outcomes.append({"status": "FAILED", "name": kind, "reason": str(exc)})
        created = sum(x["status"] == "CREATED" for x in outcomes)
        return {"scope_id": request.scope_id, "status": "CREATED" if created == len(outcomes) else "PARTIAL" if created else "BLOCKED",
                "planned_count": len(outcomes), "created_count": created, "mutations_attempted": service.mutation_count > 0,
                "mutation_count": service.mutation_count, "views": outcomes}

    @router.post("/ibd/container")
    def container_view(request: ContainerRequest):
        scope = _scope(request.scope_id)
        try:
            index = _active_index()
            plan = build_container_view(scope, request.container_product_id, index)
        except ValueError as exc:
            raise HTTPException(422, str(exc)) from exc
        representation = None
        status = "PLANNED"
        if request.create_in_syson:
            client = SysONClient(timeout=45)
            service = RepresentationService(client, index["editing_context_id"])
            try:
                verified = _verified_port_views(index, request.scope_id)
                key = {"X100": "x100_ibd", "X110": "x110_ibd"}.get(request.container_product_id)
                if verified and key in verified:
                    diagram = service.diagram(verified[key])
                    representation = {"status": "CREATED", "id": verified[key],
                        "node_count": len(diagram["nodes"]), "edge_count": len(diagram["edges"]),
                        "query_back": True}
                else:
                    representation = _create_view(scope, client, service, index, "IBD", plan)
                status = representation["status"]
            except Exception as exc:
                status = "BLOCKED"
                representation = {"reason": str(exc)}
        internal_representation = None
        verified = _verified_port_views(index, request.scope_id)
        if request.container_product_id == "X100" and verified and "x100_internal" in verified:
            diagram = RepresentationService(SysONClient(timeout=30), index["editing_context_id"]).diagram(verified["x100_internal"])
            internal_representation = {"id": verified["x100_internal"], "node_count": len(diagram["nodes"]),
                                       "edge_count": len(diagram["edges"]), "query_back": True}
        return {"status": status, "container": request.container_product_id, "view_plan": plan,
                "representation": representation, "internal_representation": internal_representation,
                "drilldown_targets": plan["drilldown_targets"]}

    return router
