"""Build deterministic Function-to-Product allocations."""
from __future__ import annotations

import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
WORK = HERE / "work"


def read(name):
    return json.loads((WORK / name).read_text(encoding="utf-8"))


def main():
    source = read("source_architecture.json")
    functions = read("all_functions.json")["functions"]
    products = {x["code"]: x for x in source["products"]}
    allocations = []
    for function in functions:
        code = function["owner_product_code"]
        if code not in products:
            raise RuntimeError(f"Allocation Product not found: {code}")
        allocations.append({
            "allocation_id": f"ALLOC-{function['function_id']}-{code}",
            "function_id": function["function_id"],
            "product_code": code,
            "product_name": products[code]["name"],
            "allocation_type": "FUNCTION_TO_PRODUCT",
            "source": "deterministic owner Product allocation",
        })
    output = {
        "metadata": {
            "project_id": source["metadata"]["project_id"],
            "profile_id": source["metadata"]["profile_id"],
            "allocation_count": len(allocations),
        },
        "function_allocations": sorted(allocations, key=lambda x: x["allocation_id"]),
    }
    (WORK / "function_allocations.json").write_text(json.dumps(output, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"stage": 4, "status": "PASS", "allocations": len(allocations)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
