"""Generate deterministic Canonical PortTypes and map every Clean Raw Port once."""

from __future__ import annotations

import argparse
from collections import defaultdict
from pathlib import Path

from common import WORK_DIR, read_json, write_json
from rules import (
    canonical_unit_accepts,
    interface_domain,
    stable_interface_type_id,
    stable_port_type_id,
)


def build_porttypes(inventory: dict, cleaned: dict, profile_state: dict) -> dict:
    item_by_name = {
        item["Item中文名"]: item for item in inventory["item_dictionary"]["items"]
    }
    if len(item_by_name) != inventory["item_dictionary"]["item_count"]:
        raise ValueError("Canonical Item中文名不唯一")
    state_by_index = {state["source_index"]: state for state in profile_state["port_states"]}
    if len(state_by_index) != len(cleaned["ports"]):
        raise ValueError("Profile状态数量与Clean Raw Port数量不一致")

    item_categories: dict[str, set[str]] = defaultdict(set)
    mappings = []
    for source_index, port in enumerate(cleaned["ports"], start=1):
        item_name = port["交换内容"]
        if item_name not in item_by_name:
            raise ValueError(f"Raw Port引用非法Item: {port}")
        item = item_by_name[item_name]
        category = port["端口类别"]
        direction = port["方向"]
        if category not in {"信号", "物理"}:
            raise ValueError(f"非法端口类别: {port}")
        if category == "物理" and direction != "双向物理":
            raise ValueError(f"物理Port方向必须为双向物理: {port}")
        if category == "信号" and direction not in {"输入", "输出"}:
            raise ValueError(f"信号Port方向必须为输入/输出: {port}")
        if category == "物理" and item["数据类型"] != "PhysicalConnector":
            raise ValueError(f"物理Port的Item数据类型非法: {port} -> {item['数据类型']}")
        if category == "信号" and item["数据类型"] == "PhysicalConnector":
            raise ValueError(f"信号Port错误引用物理Item: {port}")
        if not canonical_unit_accepts(item["单位/介质"], port["单位/介质"]):
            raise ValueError(
                f"单位/介质不兼容: {port['code']} {port['端口名称']} "
                f"实际={port['单位/介质']} Canonical={item['单位/介质']}"
            )
        item_categories[item["item_code"]].add(category)
        state = state_by_index[source_index]
        mappings.append(
            {
                "code": port["code"],
                "name": port["name"],
                "port_name": port["端口名称"],
                "direction": direction,
                "port_category": category,
                "item_code": item["item_code"],
                "item_name": item_name,
                "port_type_id": stable_port_type_id(item["item_code"]),
                "interface_type_id": stable_interface_type_id(item["item_code"]),
                "profile_active": bool(state["active"]),
            }
        )

    category_conflicts = {code: values for code, values in item_categories.items() if len(values) != 1}
    if category_conflicts:
        raise ValueError(f"同一Canonical Item跨Port Category，不能生成唯一PortType: {category_conflicts}")

    port_types = []
    used_items = sorted(
        (item_by_name[mapping["item_name"]] for mapping in mappings),
        key=lambda item: item["item_code"],
    )
    seen: set[str] = set()
    for item in used_items:
        item_code = item["item_code"]
        if item_code in seen:
            continue
        seen.add(item_code)
        category = next(iter(item_categories[item_code]))
        port_types.append(
            {
                "port_type_id": stable_port_type_id(item_code),
                "port_type_name": "PT_" + item["Item中文名"],
                "item_code": item_code,
                "item_name": item["Item中文名"],
                "port_category": category,
                "datatype": item["数据类型"],
                "unit_medium": item["单位/介质"],
                "semantic_domain": interface_domain(item, category),
                "semantic_definition": item["规范语义定义"],
            }
        )

    if len(mappings) != len(cleaned["ports"]):
        raise AssertionError("并非每个Clean Raw Port均生成了映射")
    if len({mapping["port_type_id"] for mapping in mappings}) != len(port_types):
        raise AssertionError("PortType库与映射引用集合不一致")
    return {"port_types": port_types, "mappings": mappings}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--inventory", type=Path, default=WORK_DIR / "input_inventory.json")
    parser.add_argument("--cleaned", type=Path, default=WORK_DIR / "cleaned_ports.json")
    parser.add_argument("--profile", type=Path, default=WORK_DIR / "profile_state.json")
    parser.add_argument("--output", type=Path, default=WORK_DIR / "porttypes.json")
    args = parser.parse_args()
    result = build_porttypes(read_json(args.inventory), read_json(args.cleaned), read_json(args.profile))
    write_json(args.output, result)
    print(f"PortType数量: {len(result['port_types'])}")
    print(f"Port实例映射数量: {len(result['mappings'])}")
    print(f"PortType结果: {args.output.resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
