from __future__ import annotations

import csv
import json
import re
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
DATA = ROOT / "ui/backend/data/semantic_slice"
PARAMS = ROOT / "work/analysis/simulation_parameter_audit/01_parameter_inventory.csv"
VV = ROOT / "work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json"
REQ_SOURCE = "Req/牵引制动能量回收系统_正式需求库_v1.xlsx"
PARAMETER_MODEL = "work/simulation/simulink_fmu_v2_reviewed/02_parameters/Rail_MBSE_Simulation_Parameters_v2.json"
SOURCE_FILE_PATHS = {
    "Rail_MBSE_Simulation_Parameters_v2.json": PARAMETER_MODEL,
    "L2_8100_behavior.m": "work/simulation/simulink_fmu_v2_reviewed/00_baseline/generated_behaviors/L2_8100_behavior.m",
}

# Curated Function selection is semantic; structural paths below are independently
# resolved through source Product containment and the frozen SysML allocation.
FUNCTIONS = {
    "REQ-TRAC-001": ["FN_F_5132_01", "FN_F_5311_01", "FN_F_5311_02", "FN_F_5112_01"],
    "REQ-TRAC-002": ["FN_F_5132_01", "FN_F_5311_01", "FN_F_5311_02", "FN_F_5112_01"],
    "REQ-TRAC-003": ["FN_F_7211_04", "FN_F_722A_01", "FN_F_5311_02"],
    "REQ-TRAC-004": ["FN_F_4511_01", "FN_F_5131_01", "FN_F_5132_01", "FN_F_5311_01"],
    "REQ-BRK-001": ["FN_F_7211_01", "FN_F_7211_02", "FN_F_7211_03", "FN_F_7255_01", "FN_F_5311_01"],
    "REQ-BRK-002": ["FN_F_7211_04", "FN_F_7226_01", "FN_F_7255_01", "FN_F_D121_01"],
    "REQ-BRK-003": ["FN_F_7211_02", "FN_F_7211_03", "FN_F_7255_01"],
    "REQ-BRK-004": ["FN_F_7211_02", "FN_F_7211_03", "FN_F_5311_01", "FN_F_7255_01"],
    "REQ-BRK-005": ["FN_F_7224_01", "FN_F_7211_01"],
    "REQ-BRK-006": ["FN_F_7211_02", "FN_F_5311_01", "FN_F_7255_01"],
    "REQ-BRK-007": ["FN_F_7211_02", "FN_F_5311_01", "FN_F_X121_01", "FN_F_X112_02"],
    "REQ-BRK-008": ["FN_F_7211_02", "FN_F_7211_03", "FN_F_7255_01"],
    "REQ-BRK-009": ["FN_F_7211_02", "FN_F_7211_03", "FN_F_5311_01", "FN_F_7255_01"],
    "REQ-BRK-010": ["FN_F_7211_04", "FN_F_722A_01", "FN_F_722B_01"],
    "REQ-BRK-011": ["FN_F_7211_04", "FN_F_7255_01"],
    "REQ-BRK-012": ["FN_F_7142_01", "FN_F_7131_01", "FN_F_7100_01"],
    "REQ-BRK-013": ["FN_F_722B_01", "FN_F_722C_01", "FN_F_7255_01"],
    "REQ-BRK-014": ["FN_F_8152_01", "FN_F_8152_02", "FN_F_8128_01", "FN_F_722B_01", "FN_F_722C_01"],
    "REQ-BRK-015": ["FN_F_7211_04", "FN_F_7226_01", "FN_F_7255_01", "FN_F_8152_01"],
    "REQ-ENE-002": ["FN_F_X113_01", "FN_F_X112_03", "FN_F_8122_03"],
    "REQ-ENE-003": ["FN_F_X121_02", "FN_F_X112_03", "FN_F_8122_03", "FN_F_8128_03"],
    "REQ-ENE-004": ["FN_F_X122_01", "FN_F_X112_01"],
    "REQ-ENE-005": ["FN_F_X121_01", "FN_F_X112_01"],
    "REQ-ENE-006": ["FN_F_X124_01"],
    "REQ-ENE-007": ["FN_F_X124_01", "FN_F_X112_02"],
    "REQ-ENE-008": ["FN_F_X123_01", "FN_F_X112_02"],
    "REQ-ENE-009": ["FN_F_X112_02", "FN_F_X113_01"],
    "PRJ-BRK-001": ["FN_F_7211_01", "FN_F_7211_02", "FN_F_7211_03", "FN_F_7255_01", "FN_F_5311_01"],
    "PRJ-ENE-002": ["FN_F_X112_02", "FN_F_X112_01", "FN_F_X121_01"],
    "PRJ-ENE-003": ["FN_F_X123_01", "FN_F_X112_02"],
    "PRJ-PWR-001": ["FN_F_4111_01", "FN_F_4511_01", "FN_F_5131_01", "FN_F_5132_01"],
}

SCOPES = {
    "REQ-TRAC-001": ["5100", "5300"], "REQ-TRAC-002": ["5100", "5300", "8100"],
    "REQ-TRAC-003": ["5300", "7200", "8100"], "REQ-TRAC-004": ["4500", "5100", "5300"],
    "REQ-BRK-001": ["7200", "5300", "8100"], "REQ-BRK-002": ["7200", "8100", "D100"],
    "REQ-BRK-003": ["7200", "8100"], "REQ-BRK-004": ["7200", "5300"],
    "REQ-BRK-005": ["7200", "8100"], "REQ-BRK-006": ["7200", "5300"],
    "REQ-BRK-007": ["7200", "5300", "X100"], "REQ-BRK-008": ["7200", "5300"],
    "REQ-BRK-009": ["7200", "5300"], "REQ-BRK-010": ["7200", "8100"],
    "REQ-BRK-011": ["7200", "8100"], "REQ-BRK-012": ["7100", "7200"],
    "REQ-BRK-013": ["7200", "8100"], "REQ-BRK-014": ["7200", "8100"],
    "REQ-BRK-015": ["7200", "8100"], "REQ-ENE-002": ["X100", "8100"],
    "REQ-ENE-003": ["X100", "8100"], "REQ-ENE-004": ["X100"], "REQ-ENE-005": ["X100"],
    "REQ-ENE-006": ["X100"], "REQ-ENE-007": ["X100"], "REQ-ENE-008": ["X100"],
    "REQ-ENE-009": ["X100"], "PRJ-BRK-001": ["7200", "5300"],
    "PRJ-ENE-002": ["X100"], "PRJ-ENE-003": ["X100"], "PRJ-PWR-001": ["4100", "4500", "5100"],
}

PARAM_IDS = {
    "REQ-TRAC-001": ["VEH-001", "MOT-009"], "REQ-TRAC-002": ["MOT-009"],
    "REQ-BRK-001": ["BRK-001", "BRK-002", "BRK-003"],
    "REQ-BRK-003": ["BRK-004", "BRK-005", "BRK-006"],
    "REQ-BRK-005": ["VEH-001"], "REQ-BRK-008": ["BRK-007", "BRK-008", "BRK-009"],
    "REQ-BRK-011": ["BRK-011"], "REQ-BRK-013": ["BRK-003", "BRK-012"],
    "REQ-ENE-004": ["SC-003", "SC-004"], "REQ-ENE-007": ["SC-005"],
    "REQ-ENE-008": ["SC-008"], "PRJ-ENE-002": ["SC-006"],
    "PRJ-ENE-003": ["SC-008"], "PRJ-PWR-001": ["LINE-001", "TRF-003", "CNV-001"],
}

FLOW_PAIRS = {
    "REQ-TRAC-001": {("5100", "5300"), ("5300", "5100")},
    "REQ-TRAC-002": {("5100", "5300"), ("5300", "5100")},
    "REQ-TRAC-004": {("4200", "4500"), ("4200", "5100"), ("4500", "5100"), ("5100", "5300")},
    "REQ-ENE-002": {("X100", "8100")}, "REQ-ENE-003": {("X100", "8100")},
    "PRJ-PWR-001": {("4100", "4200"), ("4200", "4500"), ("4500", "5100"), ("4200", "5100")},
}
PREFER_FLOW = {"REQ-TRAC-001", "REQ-TRAC-002", "REQ-TRAC-004", "REQ-ENE-002", "REQ-ENE-003", "PRJ-PWR-001"}

PARTIAL = {
    "REQ-TRAC-003", "REQ-BRK-002", "REQ-BRK-003", "REQ-BRK-005", "REQ-BRK-008",
    "REQ-BRK-010", "REQ-BRK-012", "REQ-BRK-014", "REQ-BRK-015", "REQ-ENE-002",
    "REQ-ENE-004", "REQ-ENE-006", "REQ-ENE-007", "REQ-ENE-009",
}

SEMANTICS = {
    "REQ-TRAC-001": "牵引电能变换、牵引电机机电转换及反馈；只选取对应变流器/电机控制功能。",
    "REQ-TRAC-002": "速度/转矩控制与牵引电机状态反馈对应既有牵引控制功能。",
    "REQ-TRAC-003": "防滑安全功能、阀压力传递及电机转速反馈对应黏着/空转相关功能；未声称存在独立黏着估算功能。",
    "REQ-TRAC-004": "主变压器次级、牵引变流器直流链和电机侧交流变换构成牵引能量转换链。",
    "REQ-BRK-001": "制动请求、再生/摩擦协调、气压到机械力转换及牵引电机制动力相关功能。",
    "REQ-BRK-002": "紧急制动安全协调、气动隔离施加和制动力转换；缺少专门紧急停车性能证据。",
    "REQ-BRK-003": "制动协调/执行和机械力形成与制动斜率控制相关；模型未提供 jerk 指标。",
    "REQ-BRK-004": "再生与摩擦制动协调、制动执行、牵引电机再生制动和气动机械力形成。",
    "REQ-BRK-005": "空重车调整阀状态检测及制动请求处理；没有 AW0/AW1/AW2/AW3 工况证据。",
    "REQ-BRK-006": "电制动力协调优先与机械制动力补足功能。",
    "REQ-BRK-007": "再生制动协调、储能吸收释放和储能功率保护功能；不推断 5100 与 X100 直接接口。",
    "REQ-BRK-008": "制动切换协调、制动执行和机械力形成；未发现专门连续性/平顺性度量。",
    "REQ-BRK-009": "制动力协调、再生电制动和机械制动力形成支持剩余制动力补足语义。",
    "REQ-BRK-010": "防滑安全逻辑、气动防滑阀压力传递和压力状态检测；未发现滑移率验证量。",
    "REQ-BRK-011": "制动安全协调与机械制动力形成，且有既有保持制动参数/门控。",
    "REQ-BRK-012": "供风压力传递及总风管压力检测；不存在明确泄漏模型，故为部分覆盖。",
    "REQ-BRK-013": "制动压力状态检测与制动力形成，结合制动压力/总力容差参数。",
    "REQ-BRK-014": "制动安全回路状态、路由IO及压力诊断信号；模型没有独立事件日志功能。",
    "REQ-BRK-015": "制动安全协调、紧急气动施加和安全回路；未见明确逆变器故障降级场景。",
    "REQ-ENE-002": "储能故障检测与状态报告，并以真实 X100→8100 故障状态接口作边界证据；无事件日志功能。",
    "REQ-ENE-003": "超级电容 SOC 测量、储能系统状态报告，并由真实 X100→8100 SOC/可用功率接口支撑。",
    "REQ-ENE-004": "超级电容电压传感器检测与双向 DC/DC 控制；有电压参数，但没有单体均衡功能。",
    "REQ-ENE-005": "储能吸收/释放与双向功率变换，并由系统能量收支/效率 V&V 支撑。",
    "REQ-ENE-006": "温度传感器状态检测存在；没有热模型，不能证明温度一致性。",
    "REQ-ENE-007": "温度检测和储能功率保护功能存在；缺少热模型/过温阈值验证。",
    "REQ-ENE-008": "电流检测及储能功率保护，SC-008 为真实电流限制参数。",
    "REQ-ENE-009": "储能功率保护及检测功能存在；没有专门短路故障注入证据。",
    "PRJ-BRK-001": "制动请求协调、再生/摩擦分配和机械力形成覆盖项目制动目标。",
    "PRJ-ENE-002": "双向 DC/DC 控制、功率保护及储能功能，SC-006 为充电功率约束参数。",
    "PRJ-ENE-003": "电流检测及储能功率保护，SC-008 为电流限制参数。",
    "PRJ-PWR-001": "接触网受流、主变压器变换和变流器直流链功能构成有证据的供电转换链。",
}


def load(name):
    return json.loads((DATA / name).read_text(encoding="utf-8"))


def parameter_source(row):
    return SOURCE_FILE_PATHS.get(row["source_file"], row["source_file"])


def main():
    reqs = load("requirement_catalog.json")["requirements"]
    fns = load("function_catalog.json")["functions"]
    products = load("product_catalog.json")["products"]
    fp = load("function_product_map.json")["relations"]
    interactions = load("l2_interaction_catalog.json")["interactions"]
    old = [x for x in load("requirement_function_map.json")["relations"] if x.get("mapping_source") == "EXPLICIT"]
    fn_by_id = {x["function_id"]: x for x in fns}
    prod_by_id = {x["product_id"]: x for x in products}
    req_by_id = {x["requirement_id"]: x for x in reqs}
    owners = {x["function_id"]: x for x in fp}
    old_by_req = {}
    for x in old:
        old_by_req.setdefault(x["requirement_id"], []).append(x)
    assert set(FUNCTIONS) == set(SCOPES) == set(SEMANTICS)
    assert set(FUNCTIONS) | set(old_by_req) == set(req_by_id)
    param_rows = {}
    with PARAMS.open(encoding="utf-8-sig", newline="") as f:
        for row in csv.DictReader(f):
            param_rows[row["parameter_id"]] = row
    vv = json.loads(VV.read_text(encoding="utf-8"))
    metric_names = set(vv.get("metrics", {}))

    def ancestors(pid):
        out = {pid}; node = prod_by_id.get(pid)
        while node and node.get("parent_product_id"):
            pid = node["parent_product_id"]
            if pid in out: break
            out.add(pid); node = prod_by_id.get(pid)
        return out

    def owner_l2(pid):
        p = prod_by_id[pid]
        return p.get("l2_product_id") or (pid if p.get("level") == 2 else None)

    relations = [dict(x, mapping_source="EXPLICIT", coverage_status="FULLY_RESOLVED",
        evidence_path=[{"type": "REQUIREMENT", "id": x["requirement_id"], "source_file": REQ_SOURCE},
                       {"type": "FUNCTION", "id": x["function_id"], "source_file": fn_by_id[x["function_id"]]["source_file"]}],
        semantic_evidence="需求库中显式填写 known_function_id。", structural_evidence="Excel 显式 Function_ID 与现有 SysML action def 精确匹配。",
        source_files=[REQ_SOURCE]) for x in old]

    for rid, selected in FUNCTIONS.items():
        req = req_by_id[rid]; scope = set(SCOPES[rid])
        for fid in selected:
            if fid not in fn_by_id or fid not in owners:
                raise ValueError(f"Unknown Function or missing allocation: {rid} -> {fid}")
            owner = owners[fid]; owner_pid = owner["product_id"]; owner_product = prod_by_id[owner_pid]
            l2 = owner_l2(owner_pid)
            # The named L2 scope must be the owner or an ancestor of the allocated owner.
            if not (owner_pid in scope or l2 in scope or any(s in ancestors(owner_pid) for s in scope)):
                raise ValueError(f"Function owner outside curated requirement scope: {rid} -> {fid} owner={owner_pid} scope={sorted(scope)}")
            source_files = [REQ_SOURCE, owner["source_file"], owner_product["source_file"]]
            # Boundary flow evidence is kept at Product level. It never asserts Function→Connector.
            flow_rows = []
            if rid in {"REQ-ENE-002", "REQ-ENE-003"}:
                words = ("故障状态",) if rid == "REQ-ENE-002" else ("超级电容SOC", "可用充电功率", "可用放电功率")
                flow_rows = [x for x in interactions if x["source_product_id"] == "X100" and x["target_product_id"] == "8100"
                    and any(w in x["flow_name"] for w in words)]
            elif rid == "PRJ-PWR-001":
                allowed = {("4100", "4200"), ("4200", "4500"), ("4500", "5100"), ("4200", "5100")}
                flow_rows = [x for x in interactions if (x["source_product_id"], x["target_product_id"]) in allowed]
            elif rid in FLOW_PAIRS:
                flow_rows = [x for x in interactions if (x["source_product_id"], x["target_product_id"]) in FLOW_PAIRS[rid]]
            # Make one primary, ordered evidence path. Side corroboration is kept
            # separately so every hop in evidence_path is a real model object.
            scoped_params = []
            for parid in PARAM_IDS.get(rid, []):
                row = param_rows.get(parid)
                if not row: raise ValueError(f"Missing parameter evidence {parid} for {rid}")
                scoped_params.append((parid, row))
            owner_param = next(((pid, row) for pid, row in scoped_params
                if l2 and f"L2_{l2}" in row["component_code"].split("/")), None)
            matching_flow = next((flow for flow in flow_rows
                if l2 in {flow["source_product_id"], flow["target_product_id"]}), None)
            path = [{"type": "REQUIREMENT", "id": rid, "source_file": REQ_SOURCE}]
            if matching_flow and rid in PREFER_FLOW:
                flow = matching_flow
                interface_id = next(iter(flow["interface_refs"]), None)
                if not interface_id: raise ValueError(f"Flow has no real interface ref: {rid} {flow['flow_ref']}")
                path.extend([{"type": "INTERFACE", "id": interface_id, "source_file": flow.get("source_path")},
                    {"type": "FLOW", "id": flow["flow_ref"], "name": flow["flow_name"],
                     "kind": flow["flow_kind"], "connector_refs": flow["connector_refs"],
                     "source_product_id": flow["source_product_id"], "target_product_id": flow["target_product_id"],
                     "source_file": flow.get("source_path")},
                    {"type": "PRODUCT", "id": l2, "source_file": prod_by_id[l2]["source_file"],
                     "endpoint_role": "source" if flow["source_product_id"] == l2 else "target"}])
                if flow.get("source_path"): source_files.append(flow["source_path"])
            elif owner_param:
                parid, row = owner_param
                path.append({"type": "PARAMETER", "id": parid, "name": row["parameter_name"],
                    "component_code": row["component_code"], "unit": row["unit"],
                    "source_file": parameter_source(row),
                    "inventory_file": "work/analysis/simulation_parameter_audit/01_parameter_inventory.csv",
                    "source_location": row["source_location"]})
                path.append({"type": "PRODUCT", "id": l2, "source_file": prod_by_id[l2]["source_file"],
                    "selection_basis": "parameter owner component"})
                source_files.extend(["work/analysis/simulation_parameter_audit/01_parameter_inventory.csv",
                    parameter_source(row)])
            elif matching_flow:
                flow = matching_flow
                interface_id = next(iter(flow["interface_refs"]), None)
                if not interface_id: raise ValueError(f"Flow has no real interface ref: {rid} {flow['flow_ref']}")
                path.extend([{"type": "INTERFACE", "id": interface_id, "source_file": flow.get("source_path")},
                    {"type": "FLOW", "id": flow["flow_ref"], "name": flow["flow_name"],
                     "kind": flow["flow_kind"], "connector_refs": flow["connector_refs"],
                     "source_product_id": flow["source_product_id"], "target_product_id": flow["target_product_id"],
                     "source_file": flow.get("source_path")},
                    {"type": "PRODUCT", "id": l2, "source_file": prod_by_id[l2]["source_file"],
                     "endpoint_role": "source" if flow["source_product_id"] == l2 else "target"}])
                if flow.get("source_path"): source_files.append(flow["source_path"])
            else:
                path.append({"type": "PRODUCT", "id": l2 or owner_pid,
                    "source_file": prod_by_id[l2 or owner_pid]["source_file"],
                    "selection_basis": "curated semantic filter within formal requirement product scope"})
            if l2 and l2 != owner_pid:
                path.append({"type": "PRODUCT", "id": owner_pid,
                    "source_file": owner_product["source_file"], "relationship": "CONTAINED_IN_SCOPE_PRODUCT"})
            path.extend([{"type": "ALLOCATION", "id": owner.get("allocation_id"), "product_id": owner_pid,
                "source_file": owner["source_file"], "evidence": owner["evidence"]},
                {"type": "FUNCTION", "id": fid, "source_file": fn_by_id[fid]["source_file"]}])
            support = []
            for parid, row in scoped_params:
                support.append({"type": "PARAMETER", "id": parid, "component_code": row["component_code"],
                    "unit": row["unit"], "source_file": parameter_source(row),
                    "inventory_file": "work/analysis/simulation_parameter_audit/01_parameter_inventory.csv",
                    "source_location": row["source_location"], "physical_meaning": row["physical_meaning"]})
                source_files.extend(["work/analysis/simulation_parameter_audit/01_parameter_inventory.csv",
                    parameter_source(row)])
            # Attach only directly relevant system-level metrics, clearly labelled as system V&V.
            req_metrics = {
                "REQ-BRK-001": ["brake_overshoot_percent", "brake_steady_error_percent", "stop_speed_time_s"],
                "REQ-BRK-011": ["hold_brake_present"], "REQ-ENE-005": ["overall_recovery_efficiency_percent",
                    "E_motor_mechanical_regen_J", "E_converter_dc_regen_J", "E_ess_absorbed_integral_J", "delta_E_supercap_J"],
                "PRJ-BRK-001": ["brake_overshoot_percent", "brake_steady_error_percent"],
            }.get(rid, [])
            for metric in req_metrics:
                if metric in metric_names:
                    support.append({"type": "SYSTEM_VV_METRIC", "id": metric, "value": vv["metrics"].get(metric),
                        "evidence_file": "work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json",
                        "scope_note": "全系统V&V结果；不表示该指标被单独分配给此Function"})
                    source_files.append("work/simulation/simulink_fmu_v2_reviewed/07_results/Physical_VV_v2.json")
            relation = {"requirement_id": rid, "function_id": fid, "relation_type": "SATISFIED_BY",
                "confidence": 0.8, "mapping_source": "MODEL_DERIVED", "coverage_status": "PARTIALLY_RESOLVED" if rid in PARTIAL else "FULLY_RESOLVED",
                "source_file": owner["source_file"], "source_files": sorted(set(source_files)),
                "evidence": SEMANTICS[rid], "semantic_evidence": SEMANTICS[rid],
                "structural_evidence": {"owner_product_id": owner_pid, "owner_product_name": owner_product["name"],
                    "owner_l2_product_id": l2, "allocation": owner["evidence"],
                    "allocation_id": owner.get("allocation_id"), "scope_product_ids": sorted(scope),
                    "product_scope_match": True, "function_semantic_filter": SEMANTICS[rid]},
                "evidence_path": path, "supporting_evidence": support,
                "notes": "模型派生映射；coverage_status描述需求功能覆盖，不是V&V结论。未创建基线模型对象。"}
            relations.append(relation)

    for x in relations:
        if x["function_id"] not in fn_by_id: raise ValueError(f"Unresolved function id {x['function_id']}")
    unresolved = sorted(set(req_by_id) - {x["requirement_id"] for x in relations})
    candidate_ids = []  # No lexical/bigram candidate promotion or top-N suggestions.
    counts = Counter(x["mapping_source"] for x in relations)
    resolution = {rid: ("UNRESOLVED" if rid in unresolved else
        "PARTIALLY_RESOLVED" if any(x["requirement_id"] == rid and x.get("coverage_status") == "PARTIALLY_RESOLVED" for x in relations)
        else "FULLY_RESOLVED") for rid in req_by_id}
    (DATA / "requirement_function_map.json").write_text(json.dumps({"relations": relations,
        "unresolved_requirement_ids": unresolved, "resolution_by_requirement": resolution,
        "mapping_source_counts": dict(counts)}, ensure_ascii=False, indent=2), encoding="utf-8")
    (DATA / "requirement_function_candidates.json").write_text(json.dumps({"status": "NO_UNREVIEWED_LEXICAL_CANDIDATES",
        "relations": candidate_ids}, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"REQUIREMENT_STRATEGY=PASS EXPLICIT={counts['EXPLICIT']} MODEL_DERIVED={counts['MODEL_DERIVED']} SEMANTIC_ASSISTED_CANDIDATES=0")
    print(f"RESOLUTION FULL={sum(v == 'FULLY_RESOLVED' for v in resolution.values())} PARTIAL={sum(v == 'PARTIALLY_RESOLVED' for v in resolution.values())} UNRESOLVED={len(unresolved)}")
    print(f"PATHS={len(relations)} PARAMETER_REFS={sum(len(PARAM_IDS.get(r, [])) for r in FUNCTIONS)} FLOW_PATHS={sum(1 for x in relations for p in x['evidence_path'] if p.get('type')=='FLOW')}")


if __name__ == "__main__":
    main()
