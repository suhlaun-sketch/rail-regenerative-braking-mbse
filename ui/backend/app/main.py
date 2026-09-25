from __future__ import annotations

import csv
import json
import sys
from pathlib import Path

from fastapi import FastAPI, HTTPException, Query
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

ROOT = Path(__file__).resolve().parents[3]
if str(ROOT) not in sys.path:
    sys.path.insert(0, str(ROOT))

from .parsers.ssd_parser import SSDParser
from .parsers.sysml_adapter import SysMLAdapter
from .services.model_graph_service import ModelGraphService
from .services.task_slice_service import TaskSliceService
from .services.semantic import SemanticQueryService
from .api.semantic import semantic_router
from .services.neo4j_service import kg
from tools.syson_automation.src.api import syson_router

SIM = ROOT / "work/simulation/simulink_fmu_v2_1_final"
sysml = SysMLAdapter(ROOT); ssd = SSDParser(ROOT)
model_graph = ModelGraphService(ROOT)
task_slice = TaskSliceService(model_graph)
semantic = SemanticQueryService(ROOT / "ui/backend/data/semantic_slice")
app = FastAPI(title="轨道列车数字工程工作台 API", version="1.0.0")
app.add_middleware(CORSMiddleware, allow_origins=["http://127.0.0.1:5173", "http://localhost:5173"], allow_methods=["*"], allow_headers=["*"])
app.include_router(semantic_router(semantic))
app.include_router(syson_router(semantic, task_slice))
LAYOUT_CACHE = ROOT / "ui/backend/cache/layout"; LAYOUT_CACHE.mkdir(parents=True, exist_ok=True)

class LayoutState(BaseModel):
    positions: dict[str, dict[str, float]]

@app.on_event("startup")
def startup(): kg.connect()

@app.on_event("shutdown")
def shutdown(): kg.close()

def read_json(path: Path): return json.loads(path.read_text(encoding="utf-8"))
def status_file():
    values = {}
    for line in (SIM / "08_reports/Final_Status_v2_1.txt").read_text(encoding="utf-8").splitlines():
        if "=" in line:
            k, v = line.split("=", 1); values[k.strip()] = v.strip()
    return values

@app.get("/api/health")
def health(): return {"status": "ok"}

@app.get("/api/project/status")
def project_status():
    st = status_file(); freeze = read_json(SIM / "08_reports/V2_1_FINAL_FREEZE_MANIFEST.json")
    reg = read_json(SIM / "05_fmu/Rail_MBSE_FMU_Model_Registry_v2_1.json")
    sv = read_json(SIM / "06_ssp/Executable_SSP_Validation_v2_1.json"); ss = ssd.summary()
    return {"baseline": "v2.1 FINAL", "frozen": freeze.get("baseline_status") == "FROZEN",
            "authorityModel": "Rail_MBSE_Full_v1.sysml", "sysml": "PASS",
            "l2Components": ss["components"], "structuralConnectors": ss["connectors"], "structuralConnections": ss["crossL2Connections"],
            "fmusAvailable": len(reg.get("models", [])), "fmusValid": int(st.get("FMUS_INTERFACE_VALID", "0/16").split("/")[0]),
            "fmiVariables": int(st.get("FMI_VARIABLES", "0/151").split("/")[0]),
            "connections": int(st.get("CONNECTIONS", "0/87").split("/")[0]),
            "causalPaths": int(sv.get("unique_causal_signal_paths", 0)), "ssp": sv.get("status", "FAIL"),
            "cosimulation": st.get("COSIMULATION", "FAIL"), "physicalVv": st.get("SYSTEM_PHYSICAL_VV", "FAIL")}

@app.get("/api/sysml/summary")
def sysml_summary(): return sysml.summary()
@app.get("/api/sysml/tree")
def sysml_tree(): return sysml.tree()
@app.get("/api/sysml/graph")
def sysml_graph(level: int = Query(1, ge=0, le=4), focus: str | None = None): return sysml.graph(level, focus)
@app.get("/api/sysml/element/{element_id}")
def sysml_element(element_id: str):
    value = sysml.element(element_id)
    if value is None: raise HTTPException(404, "元素不存在")
    return value

@app.get("/api/ssd/summary")
def ssd_summary(): return ssd.summary()
@app.get("/api/ssd/graph")
def ssd_graph():
    graph = ssd.graph(); names = {x["data"]["code"]: x["data"]["display_name"] for x in model_graph.get_l2_application_graph()["nodes"]}
    for node in graph["nodes"]: node["data"]["name"] = names.get(node["data"]["code"], node["data"]["name"])
    return graph

@app.get("/api/vv/summary")
def vv_summary():
    vv = read_json(SIM / "07_results/Brake_Transition_VV_v2_1.json")
    e = read_json(SIM / "07_results/Regenerative_Energy_Flow_Audit_v2_1.json")
    return {"status": vv["status"], "gates": vv["gates"], "metrics": vv["metrics"],
            "overallRecoveryEfficiencyPercent": e["overall_recovery_efficiency_percent"]}
@app.get("/api/vv/brake")
def vv_brake(): return read_json(SIM / "07_results/Brake_Transition_VV_v2_1.json")
@app.get("/api/vv/energy")
def vv_energy(): return read_json(SIM / "07_results/Regenerative_Energy_Flow_Audit_v2_1.json")

@app.get("/api/cosim/replay/data")
def replay_data():
    path = SIM / "07_results/Rail_MBSE_All16_FMU_CoSimulation_Results_v2_1.csv"
    keys = ["time", "v_train", "F_brake_demand", "Fregen_actual", "Fmechanical_actual", "Ftotal_actual", "SOC_energy"]
    points = []
    with path.open(encoding="utf-8-sig", newline="") as f:
        for row in csv.DictReader(f): points.append({k: float(row[k]) for k in keys})
    return {"mode": "冻结结果回放", "authoritative": path.name, "count": len(points), "defaultSpeed": 5, "points": points}

@app.get("/api/model/full")
def full_model(): return model_graph.get_full_model_graph()

@app.get("/api/model/l2")
def l2_model(): return model_graph.get_l2_application_graph()

@app.get("/api/task-slice/catalog")
def slice_catalog(): return task_slice.catalog()

@app.get("/api/task-slice")
def slice_projection(function_ids: str | None = None):
    try:
        return task_slice.project(function_ids.split(",") if function_ids is not None else None)
    except ValueError as error:
        raise HTTPException(422, str(error)) from error

@app.get("/api/model/interface/{interface_id}")
def model_interface(interface_id: str):
    value = model_graph.interface(interface_id)
    if value is None: raise HTTPException(404, "接口不存在")
    return value

@app.get("/api/model/interface/{interface_id}/children")
def interface_children(interface_id: str):
    value = model_interface(interface_id); ids = value.get("child_interfaces", value.get("child_interface_ids", []))
    return [x for x in (model_graph.interface(i) for i in ids) if x]

@app.get("/api/model/interface/{interface_id}/leaf-connections")
def interface_leaves(interface_id: str):
    value = model_interface(interface_id); ids = set(value.get("leaf_connections", value.get("leaf_connection_ids", [])))
    return [x for x in model_graph.get_full_model_graph()["leaf_interfaces"] if x["id"] in ids or any(i in ids for i in x["leaf_connection_ids"])]

@app.get("/api/model/node/{node_id}/interfaces")
def node_interfaces(node_id: str): return model_graph.node_interfaces(node_id)

@app.get("/api/model/node/{node_id}/flows")
def node_flows(node_id: str): return model_graph.node_flows(node_id)

@app.get("/api/kg/status")
def kg_status(): return kg.status()
@app.get("/api/kg/summary")
def kg_summary(): return kg.summary()
@app.get("/api/kg/search")
def kg_search(q: str = ""): return kg.search(q)
@app.get("/api/kg/node/{node_id:path}")
def kg_node(node_id: str):
    value = kg.node(node_id)
    if value is None: raise HTTPException(404, "知识节点不存在")
    return value
@app.get("/api/kg/neighbors/{node_id:path}")
def kg_neighbors(node_id: str): return kg.neighbors(node_id)
@app.get("/api/kg/path")
def kg_path(source: str, target: str): return kg.path(source, target)
@app.get("/api/kg/l2/{component_id}")
def kg_l2(component_id: str):
    full = model_graph.get_full_model_graph(); component = next((x["data"] for x in full["nodes"] if x["data"]["id"] == component_id or x["data"].get("l2_code") == component_id.removeprefix("L2_")), None)
    if not component: raise HTTPException(404, "L2组件不存在")
    return kg.resolve_l2(component)

@app.get("/api/application/binding")
def application_binding():
    full = model_graph.get_full_model_graph(); l2 = model_graph.get_l2_application_graph()
    payload = read_json(ROOT / "work/simulation/implementation_binding/Rail_MBSE_Executable_FMU_Interface_v1.json")
    names = {x["data"]["code"]: x["data"]["display_name"] for x in l2["nodes"]}
    flow_by_connection = {}
    for interface in full["leaf_interfaces"]:
        for cid in interface["leaf_connection_ids"]: flow_by_connection[cid.replace("-", "_")] = interface["flow_items"][0]["display_name"]
    components = []
    for component in payload["components"]:
        variables = []
        for group in ("inputs", "outputs", "parameters", "states_monitoring_outputs"):
            for variable in component.get(group, []) or []:
                display = next((flow_by_connection.get(str(x).replace("-", "_")) for x in variable.get("structural_connection_ids", []) if flow_by_connection.get(str(x).replace("-", "_"))), None)
                meaning = variable.get("engineering_meaning") or ""
                variables.append({"id": variable.get("executable_variable_id"), "display_name": display or (meaning if any('\u4e00' <= c <= '\u9fff' for c in meaning) else variable.get("variable_name")),
                    "variable_name": variable.get("variable_name"), "causality": variable.get("fmi_causality"), "unit": variable.get("unit"),
                    "datatype": variable.get("datatype"), "source_ssd_connectors": variable.get("source_ssd_connectors", []), "source_sysml_elements": variable.get("source_sysml_elements", [])})
        components.append({"id": f"product::{component['l2_code']}", "display_name": names.get(component["l2_code"], component["ssd_component"]),
                           "code": component["l2_code"], "fmu_file": component["future_fmu_file"], "counts": component["counts"], "status": component["readiness"], "variables": variables})
    return {"l2_graph": l2, "components": components, "statistics": payload["statistics"]}

@app.get("/api/application/fmu")
def application_fmu():
    registry = read_json(SIM / "05_fmu/Rail_MBSE_FMU_Model_Registry_v2_1.json"); l2 = model_graph.get_l2_application_graph()
    names = {x["data"]["code"]: x["data"]["display_name"] for x in l2["nodes"]}
    models = []
    for item in registry["models"]:
        code = item["component"].removeprefix("L2_"); models.append({**item, "display_name": names.get(code, item["component"]), "code": code})
    return {"models": models, "summary": registry.get("summary", {}), "l2_graph": l2}

@app.get("/api/application/ssp")
def application_ssp():
    validation = read_json(SIM / "06_ssp/Executable_SSP_Validation_v2_1.json")
    return {"status": validation["status"], "components": validation["components"], "connections": validation["executable_connection_records"],
            "causalPaths": validation["unique_causal_signal_paths"], "l2_graph": model_graph.get_l2_application_graph()}

@app.get("/api/digital-thread/summary")
def digital_thread():
    full = model_graph.get_full_model_graph(); l2 = model_graph.get_l2_application_graph(); ps = project_status()
    return {"stages":[{"id":"sysml","name":"SysML四层","count":full["statistics"]["total_nodes"]},{"id":"l2","name":"L2接口归纳","count":len(l2["aggregated_interfaces"])},
        {"id":"ssd","name":"SSD","count":ps["structuralConnectors"]},{"id":"binding","name":"实施绑定","count":ps["fmiVariables"]},{"id":"fmu","name":"FMU","count":ps["fmusValid"]},
        {"id":"ssp","name":"SSP","count":ps["connections"]},{"id":"simulation","name":"Simulation","count":1},{"id":"vv","name":"V&V","count":1}], "l2_graph": l2, "knowledgeGraph": kg.summary()}

@app.get("/api/layout/{view_id}")
def get_layout(view_id: str):
    safe = "".join(x for x in view_id if x.isalnum() or x in "-_")
    path = LAYOUT_CACHE / f"{safe}.json"
    return read_json(path) if path.exists() else {"positions": {}}

@app.put("/api/layout/{view_id}")
def put_layout(view_id: str, state: LayoutState):
    safe = "".join(x for x in view_id if x.isalnum() or x in "-_")
    (LAYOUT_CACHE / f"{safe}.json").write_text(state.model_dump_json(indent=2), encoding="utf-8")
    return {"status": "saved", "view": safe}
