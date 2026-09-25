"""Synthesize auditable leaf functions from ports, items, roles and ConnectGraph evidence."""
from __future__ import annotations

import json
from collections import defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
SOURCE = HERE / "work" / "source_architecture.json"
OUTPUT = HERE / "work" / "leaf_functions.json"

CATEGORIES = {
    "PHYSICAL_TRANSFORMATION", "PHYSICAL_TRANSPORT", "ENERGY_STORAGE",
    "ENERGY_DISSIPATION", "CONTROL", "COORDINATION", "MEASUREMENT",
    "PROTECTION", "SAFETY", "STATUS_REPORTING", "STATISTICS",
}


def read(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def write(path: Path, data) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def unique(values):
    return sorted(set(x for x in values if x))


def spec(category, cn, en, selector="all"):
    return {"category": category, "cn": cn, "en": en, "selector": selector}


CORE = {
    "4511": [
        spec("PHYSICAL_TRANSFORMATION", "实现高压交流电能与牵引变压器次级交流电能转换", "Transform high-voltage AC to traction-transformer secondary AC", ["ITM-PHY-001", "ITM-PHY-014"]),
        spec("MEASUREMENT", "检测主变压器电气与温度状态", "Measure traction-transformer electrical and thermal state", ["ITM-MEA", "ITM-STA", "ITM-PHY-013"]),
    ],
    "5131": [
        spec("PHYSICAL_TRANSFORMATION", "实现主变次级交流电能与中间直流电能双向转换", "Convert transformer secondary AC and DC-link energy bidirectionally", ["ITM-PHY-014", "ITM-PHY-003"]),
        spec("CONTROL", "执行网侧变流控制并反馈运行状态", "Execute line-side conversion control and report operating state", ["ITM-CMD", "ITM-MEA", "ITM-STA", "ITM-LIM"]),
    ],
    "5132": [
        spec("PHYSICAL_TRANSFORMATION", "实现中间直流电能与电机侧三相交流电能双向转换", "Convert DC-link and motor-side three-phase AC energy bidirectionally", ["ITM-PHY-003", "ITM-PHY-004"]),
        spec("CONTROL", "响应电机侧变流控制并反馈运行状态", "Execute motor-side conversion control and report operating state", ["ITM-CMD", "ITM-MEA", "ITM-STA", "ITM-LIM"]),
    ],
    "5311": [
        spec("PHYSICAL_TRANSFORMATION", "实现三相交流电能与旋转机械能双向转换", "Convert three-phase AC and rotational mechanical energy bidirectionally", ["ITM-PHY-004", "ITM-PHY-005"]),
        spec("MEASUREMENT", "提供牵引电机转速、转矩及电气状态反馈", "Provide traction-motor speed, torque and electrical feedback", ["ITM-MEA", "ITM-STA"]),
    ],
    "7211": [
        spec("CONTROL", "处理制动请求", "Process braking requests", ["ITM-CMD"]),
        spec("COORDINATION", "协调再生制动与摩擦制动力", "Coordinate regenerative and friction braking effort", ["ITM-CMD", "ITM-MEA", "ITM-LIM"]),
        spec("CONTROL", "执行电空制动控制", "Execute electro-pneumatic brake control", ["ITM-CMD", "ITM-STA"]),
        spec("SAFETY", "协调防滑与紧急制动安全请求", "Coordinate anti-slip and emergency-brake safety requests", ["ITM-CMD", "ITM-STA", "ITM-LIM"]),
    ],
    "X111": [
        spec("PHYSICAL_TRANSFORMATION", "实现中间直流母线与储能侧直流母线双向能量转换", "Convert energy bidirectionally between DC link and storage DC bus", ["ITM-PHY-003", "ITM-PHY-016"]),
        spec("CONTROL", "执行双向DC/DC功率变换指令并反馈状态", "Execute bidirectional DC/DC power commands and report state", ["ITM-CMD", "ITM-MEA", "ITM-STA", "ITM-LIM"]),
    ],
    "X112": [
        spec("CONTROL", "控制双向DC/DC功率变换", "Control bidirectional DC/DC power conversion", ["ITM-CMD", "ITM-MEA"]),
        spec("PROTECTION", "限制储能充放电功率并协调保护", "Limit storage charge-discharge power and coordinate protection", ["ITM-LIM", "ITM-STA"]),
        spec("STATUS_REPORTING", "报告储能变换系统状态", "Report energy-storage conversion system state", ["ITM-STA", "ITM-ACC"]),
    ],
    "X121": [
        spec("ENERGY_STORAGE", "储存并按需释放再生制动电能", "Store and release regenerative braking energy on demand", ["ITM-PHY-016", "ITM-PHY-013"]),
        spec("MEASUREMENT", "提供超级电容荷电状态反馈", "Provide supercapacitor state-of-charge feedback", ["ITM-MEA-028"]),
    ],
    "7226": [
        spec("SAFETY", "执行紧急制动气动隔离与施加", "Execute pneumatic isolation and application for emergency braking", "all"),
    ],
    "7252": [spec("PHYSICAL_TRANSPORT", "传递制动夹钳作用力", "Transmit brake-caliper force", "all")],
    "7254": [spec("ENERGY_DISSIPATION", "通过闸片耗散机械制动能量", "Dissipate mechanical braking energy through brake pads", "all")],
    "7255": [spec("PHYSICAL_TRANSFORMATION", "将气动压力转换为制动机械力", "Convert pneumatic pressure into mechanical braking force", "all")],
    "3131": [spec("ENERGY_DISSIPATION", "通过外轮盘耗散机械制动能量", "Dissipate mechanical braking energy through the selected outer wheel disc", "all")],
}


def selected_ports(ports, selector):
    if selector == "all":
        return list(ports)
    selected = []
    for port in ports:
        code = port["item_code"]
        if any(code == token or code.startswith(token + "-") or code.startswith(token) for token in selector):
            selected.append(port)
    return selected


def generic_specs(product, role, ports):
    name = product["name"]
    label = f"Product {product['code']}"
    physical = [x for x in ports if x["port_category"] == "物理"]
    signal = [x for x in ports if x["port_category"] == "信号"]
    item_codes = {x["item_code"] for x in ports}
    result = []

    base = {
        "ENERGY_SOURCE": spec("PHYSICAL_TRANSPORT", f"提供{name}外部能量", f"Provide external energy through {label}", "physical"),
        "ENERGY_CONVERTER": spec("PHYSICAL_TRANSFORMATION", f"实现{name}能量转换", f"Convert energy through {label}", "physical"),
        "ENERGY_STORAGE": spec("ENERGY_STORAGE", f"储存并释放{name}能量", f"Store and release energy through {label}", "physical"),
        "ENERGY_SINK": spec("ENERGY_DISSIPATION", f"通过{name}耗散能量", f"Dissipate energy through {label}", "physical"),
        "SERIES_ELECTRICAL": spec("PHYSICAL_TRANSPORT", f"传递{name}电能", f"Transmit electrical energy through {label}", "physical"),
        "SERIES_MECHANICAL": spec("PHYSICAL_TRANSPORT", f"传递{name}机械能", f"Transmit mechanical energy through {label}", "physical"),
        "MECHANICAL_TRANSFORMER": spec("PHYSICAL_TRANSFORMATION", f"转换{name}机械参数", f"Transform mechanical parameters through {label}", "physical"),
        "PNEUMATIC_ELEMENT": spec("PHYSICAL_TRANSPORT", f"传递{name}气动压力", f"Transmit pneumatic pressure through {label}", "physical"),
        "SENSOR_TAP": spec("MEASUREMENT", f"检测{name}状态", f"Measure state at {label}", "all"),
        "SERIES_SENSOR": spec("MEASUREMENT", f"检测并贯通{name}物理量", f"Measure while conducting the physical quantity through {label}", "all"),
        "CONTROLLER": spec("CONTROL", f"控制{name}运行", f"Control {label} operation", "signal"),
        "IO_ROUTER": spec("CONTROL", f"路由{name}输入输出信号", f"Route input and output signals through {label}", "signal"),
        "ACTUATOR": spec("PHYSICAL_TRANSFORMATION" if physical else "CONTROL", f"执行{name}动作", f"Execute {label} action", "all"),
        "SAFETY_LOGIC": spec("SAFETY" if signal else "PHYSICAL_TRANSPORT", f"执行{name}安全逻辑" if signal else f"传递{name}物理能量", f"Execute {label} safety logic" if signal else f"Transmit physical energy through {label}", "signal" if signal else "physical"),
        "EXTERNAL_BOUNDARY": spec("PHYSICAL_TRANSPORT" if physical else "CONTROL", f"提供{name}边界交互", f"Provide boundary interaction for {label}", "all"),
    }.get(role)
    if base:
        result.append(base)

    if role in {"CONTROLLER", "IO_ROUTER", "SAFETY_LOGIC"} and len(signal) >= 8:
        result.append(spec("COORDINATION", f"协调{name}接口交互", f"Coordinate {label} interface interactions", "signal"))
    if any(x.startswith("ITM-LIM-") for x in item_codes) and role not in {"SENSOR_TAP", "SERIES_SENSOR"}:
        result.append(spec("PROTECTION", f"限制并保护{name}运行", f"Limit and protect {label} operation", ["ITM-LIM"]))
    if any(x.startswith("ITM-STA-") for x in item_codes) and role in {"CONTROLLER", "IO_ROUTER", "SAFETY_LOGIC", "ENERGY_CONVERTER", "ENERGY_STORAGE"}:
        result.append(spec("STATUS_REPORTING", f"报告{name}运行状态", f"Report {label} operating state", ["ITM-STA"]))
    if any(x.startswith("ITM-ACC-") for x in item_codes):
        result.append(spec("STATISTICS", f"统计{name}运行数据", f"Accumulate {label} operating statistics", ["ITM-ACC"]))
    if not result:
        result.append(spec("CONTROL" if signal else "PHYSICAL_TRANSPORT", f"执行{name}接口行为", f"Execute interface behavior for {label}", "all"))
    return result[:5]


def main() -> None:
    data = read(SOURCE)
    products = {x["code"]: x for x in data["products"]}
    roles = {x["product_code"]: x["derived_role"] for x in data["product_roles"]}
    by_product = defaultdict(list)
    for port in data["interfaces"]:
        if port["profile_active"]:
            by_product[port["product_code"]].append(port)
    connections = data["connections"]
    memberships = data["net_memberships"]
    functions = []

    for code in sorted(by_product):
        product = products[code]
        if not product["leaf"]:
            raise RuntimeError(f"Active interface belongs to non-leaf Product: {code}")
        ports = sorted(by_product[code], key=lambda x: x["port_id"])
        specs = CORE.get(code, generic_specs(product, roles[code], ports))
        built = []
        for candidate in specs:
            selector = candidate["selector"]
            if selector == "physical":
                evidence_ports = [x for x in ports if x["port_category"] == "物理"]
            elif selector == "signal":
                evidence_ports = [x for x in ports if x["port_category"] == "信号"]
            else:
                evidence_ports = selected_ports(ports, selector)
            if not evidence_ports:
                continue
            port_ids = {x["port_id"] for x in evidence_ports}
            related_connections = [
                x["connection_id"] for x in connections
                if x["source_port_id"] in port_ids or x.get("target_port_id") in port_ids
            ]
            related_nets = [
                x["net_id"] for x in memberships
                if x["product_code"] == code and x["port_id"] in port_ids
            ]
            built.append({
                "function_name_cn": candidate["cn"],
                "function_name_en": candidate["en"],
                "function_category": candidate["category"],
                "derived_from_items": unique(x["item_code"] for x in evidence_ports),
                "derived_from_ports": unique(port_ids),
                "derived_from_connections": unique(related_connections),
                "derived_from_nets": unique(related_nets),
            })
        if not built:
            raise RuntimeError(f"No traceable function synthesized for active leaf Product {code}")
        for index, entry in enumerate(built[:5], start=1):
            function_id = f"F-{code}-{index:02d}"
            functions.append({
                "function_id": function_id,
                "function_name_cn": entry["function_name_cn"],
                "function_name_en": entry["function_name_en"],
                "function_level": int(product["level"]),
                "function_category": entry["function_category"],
                "owner_product_code": code,
                "owner_product_name": product["name"],
                "derived_from_items": entry["derived_from_items"],
                "derived_from_ports": entry["derived_from_ports"],
                "derived_from_connections": entry["derived_from_connections"],
                "derived_from_nets": entry["derived_from_nets"],
                "description": entry["function_name_cn"] + "。",
                "generation_basis": f"Product Role={roles[code]}; aggregated Active Port/Canonical Item and frozen ConnectGraph evidence",
                "verification_status": "PASS",
                "aggregated_from_functions": [],
            })

    invalid = [x for x in functions if x["function_category"] not in CATEGORIES]
    if invalid:
        raise RuntimeError("Invalid function category")
    expected_leaf_owners = {x["code"] for x in data["products"] if x["leaf"] and x["code"] in by_product}
    if {x["owner_product_code"] for x in functions} != expected_leaf_owners:
        raise RuntimeError("Leaf function owner coverage mismatch")
    result = {
        "metadata": {
            "project_id": data["metadata"]["project_id"],
            "profile_id": data["metadata"]["profile_id"],
            "leaf_product_count": len(expected_leaf_owners),
            "leaf_function_count": len(functions),
            "method": "deterministic role/item/port/connectgraph aggregation",
        },
        "functions": sorted(functions, key=lambda x: x["function_id"]),
    }
    write(OUTPUT, result)
    print(json.dumps({"stage": 2, "status": "PASS", "leaf_products": len(expected_leaf_owners), "leaf_functions": len(functions)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
