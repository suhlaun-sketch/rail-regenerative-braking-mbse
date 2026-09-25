"""Generate deterministic InterfaceTypes and the non-generative compatibility rule set."""

from __future__ import annotations

import argparse
from pathlib import Path

from common import WORK_DIR, read_json, write_json
from rules import COMPATIBILITY_RULES, stable_interface_type_id


def build_interfacetypes(porttype_data: dict) -> dict:
    interface_types = []
    seen_ids: set[str] = set()
    for port_type in porttype_data["port_types"]:
        item_code = port_type["item_code"]
        interface_id = stable_interface_type_id(item_code)
        if interface_id in seen_ids:
            raise ValueError(f"InterfaceType ID重复: {interface_id}")
        seen_ids.add(interface_id)
        if port_type["port_category"] == "物理":
            source_category = "物理"
            compatibility = (
                "双向物理↔双向物理；Item一致；PortType一致；Physical Domain一致；"
                "medium一致；Profile Active"
            )
        else:
            source_category = "信号"
            compatibility = (
                "输出→输入；Item一致；PortType一致；datatype兼容；unit兼容；Profile Active"
            )
        interface_types.append(
            {
                "interface_type_id": interface_id,
                "interface_name": "IF_" + port_type["item_name"],
                "port_type_id": port_type["port_type_id"],
                "item_code": item_code,
                "item_name": port_type["item_name"],
                "interface_domain": port_type["semantic_domain"],
                "source_category": source_category,
                "compatibility_rule": compatibility,
                "datatype": port_type["datatype"],
                "unit_medium": port_type["unit_medium"],
                "description": (
                    f"{port_type['item_name']}的Canonical InterfaceType；"
                    "仅定义允许的端口类型关系，不表示任何具体Connection。"
                ),
            }
        )

    port_type_ids = {row["port_type_id"] for row in porttype_data["port_types"]}
    if any(row["port_type_id"] not in port_type_ids for row in interface_types):
        raise AssertionError("InterfaceType引用非法PortType")
    return {
        "interface_types": interface_types,
        "compatibility_rules": COMPATIBILITY_RULES,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--porttypes", type=Path, default=WORK_DIR / "porttypes.json")
    parser.add_argument("--output", type=Path, default=WORK_DIR / "interfacetypes.json")
    args = parser.parse_args()
    result = build_interfacetypes(read_json(args.porttypes))
    write_json(args.output, result)
    print(f"InterfaceType数量: {len(result['interface_types'])}")
    print(f"Compatibility Rule数量: {len(result['compatibility_rules'])}")
    print(f"InterfaceType结果: {args.output.resolve()}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
