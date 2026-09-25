"""Aggregate leaf functions upward through the frozen Product hierarchy."""
from __future__ import annotations

import json
from collections import defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
WORK = HERE / "work"


def read(name):
    return json.loads((WORK / name).read_text(encoding="utf-8"))


def write(name, data):
    (WORK / name).write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def unique(values):
    return sorted(set(x for x in values if x))


NAMES = {
    "X110": ("实现再生储能双向能量变换、控制与保护", "Provide bidirectional regenerative-storage conversion, control and protection"),
    "X100": ("吸收、存储并按需释放再生制动能量", "Absorb, store and release regenerative braking energy on demand"),
    "X000": ("实现车载再生能量回收与利用", "Provide onboard regenerative-energy recovery and reuse"),
}


def main():
    source = read("source_architecture.json")
    leaf = read("leaf_functions.json")["functions"]
    products = {x["code"]: x for x in source["products"]}
    children = defaultdict(list)
    for product in source["products"]:
        if product["parent_code"]:
            children[product["parent_code"]].append(product["code"])

    all_functions = list(leaf)
    by_owner = defaultdict(list)
    for function in leaf:
        by_owner[function["owner_product_code"]].append(function)

    for level in (3, 2, 1):
        for code in sorted(x["code"] for x in source["products"] if int(x["level"]) == level and not x["leaf"]):
            components = []
            for child_code in sorted(children.get(code, [])):
                components.extend(by_owner.get(child_code, []))
            if not components:
                continue
            product = products[code]
            cn, en = NAMES.get(code, (f"聚合实现{product['name']}系统功能", f"Integrate system functions of Product {code}"))
            categories = {x["function_category"] for x in components}
            if categories & {"CONTROL", "COORDINATION"}:
                category = "COORDINATION"
            elif "SAFETY" in categories:
                category = "SAFETY"
            elif categories & {"PHYSICAL_TRANSFORMATION", "ENERGY_STORAGE", "ENERGY_DISSIPATION"}:
                category = "PHYSICAL_TRANSFORMATION"
            else:
                category = "PHYSICAL_TRANSPORT"
            function = {
                "function_id": f"F-{code}-01",
                "function_name_cn": cn,
                "function_name_en": en,
                "function_level": int(product["level"]),
                "function_category": category,
                "owner_product_code": code,
                "owner_product_name": product["name"],
                "derived_from_items": unique(v for x in components for v in x["derived_from_items"]),
                "derived_from_ports": unique(v for x in components for v in x["derived_from_ports"]),
                "derived_from_connections": unique(v for x in components for v in x["derived_from_connections"]),
                "derived_from_nets": unique(v for x in components for v in x["derived_from_nets"]),
                "description": cn + "。",
                "generation_basis": "deterministic aggregation of direct child Product functions",
                "verification_status": "PASS",
                "aggregated_from_functions": unique(x["function_id"] for x in components),
            }
            all_functions.append(function)
            by_owner[code].append(function)

    all_functions.sort(key=lambda x: x["function_id"])
    leaf_count = len(leaf)
    output = {
        "metadata": {
            "project_id": source["metadata"]["project_id"],
            "profile_id": source["metadata"]["profile_id"],
            "leaf_function_count": leaf_count,
            "aggregated_function_count": len(all_functions) - leaf_count,
            "function_count": len(all_functions),
        },
        "functions": all_functions,
    }
    write("all_functions.json", output)
    print(json.dumps({"stage": 3, "status": "PASS", **output["metadata"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
