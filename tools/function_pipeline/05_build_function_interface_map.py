"""Map active interface instances to leaf functions with deterministic usage semantics."""
from __future__ import annotations

import hashlib
import json
from collections import defaultdict
from pathlib import Path

HERE = Path(__file__).resolve().parent
WORK = HERE / "work"


def read(name):
    return json.loads((WORK / name).read_text(encoding="utf-8"))


def mapping_id(function_id, port_id):
    token = hashlib.sha1(port_id.encode("utf-8")).hexdigest()[:16].upper()
    return f"FMAP-{function_id}-{token}"


def usage(function, port):
    category = function["function_category"]
    if port["port_category"] == "物理":
        return "MONITORS" if category in {"MEASUREMENT", "PROTECTION", "STATUS_REPORTING"} else "EXCHANGES"
    if port["direction"] == "输入":
        return "CONSUMES"
    if port["item_code"].startswith("ITM-CMD-") or category in {"CONTROL", "COORDINATION", "SAFETY"}:
        return "CONTROLS"
    return "PRODUCES"


def score(function, port):
    category = function["function_category"]
    item = port["item_code"]
    if port["port_category"] == "物理":
        base = 100 if category in {"PHYSICAL_TRANSFORMATION", "PHYSICAL_TRANSPORT", "ENERGY_STORAGE", "ENERGY_DISSIPATION"} else 50
    elif item.startswith("ITM-MEA-"):
        base = {"MEASUREMENT": 100, "PROTECTION": 80, "CONTROL": 55, "COORDINATION": 50}.get(category, 30)
    elif item.startswith("ITM-LIM-"):
        base = {"PROTECTION": 100, "SAFETY": 95, "COORDINATION": 80, "CONTROL": 60}.get(category, 30)
    elif item.startswith("ITM-STA-"):
        base = {"STATUS_REPORTING": 100, "SAFETY": 90, "CONTROL": 75, "COORDINATION": 65}.get(category, 30)
    elif item.startswith("ITM-ACC-"):
        base = {"STATISTICS": 100, "STATUS_REPORTING": 80}.get(category, 30)
    elif item.startswith("ITM-CMD-"):
        base = {"CONTROL": 100, "SAFETY": 95, "COORDINATION": 90}.get(category, 30)
    else:
        base = 40

    if function["owner_product_code"] == "7211":
        name = port["port_name"]
        fid = function["function_id"]
        if any(k in name for k in ("紧急", "ATP", "防滑", "安全")) and fid.endswith("-04"):
            base += 80
        elif any(k in name for k in ("再生", "摩擦", "分配", "协调", "制动力")) and fid.endswith("-02"):
            base += 70
        elif any(k in name for k in ("电空", "气动", "阀", "制动缸", "执行")) and fid.endswith("-03"):
            base += 70
        elif port["direction"] == "输入" and fid.endswith("-01"):
            base += 35
    return base


def main():
    source = read("source_architecture.json")
    functions = read("all_functions.json")["functions"]
    ports = {x["port_id"]: x for x in source["interfaces"] if x["profile_active"]}
    leaf_functions = [x for x in functions if not x["aggregated_from_functions"]]
    eligible = defaultdict(list)
    for function in leaf_functions:
        for port_id in function["derived_from_ports"]:
            if port_id in ports:
                eligible[port_id].append(function)

    mappings = []
    assigned_functions = set()
    for port_id in sorted(eligible):
        port = ports[port_id]
        candidates = sorted(eligible[port_id], key=lambda x: (-score(x, port), x["function_id"]))
        function = candidates[0]
        mappings.append({
            "mapping_id": mapping_id(function["function_id"], port_id),
            "function_id": function["function_id"],
            "interface_instance_id": f"IFINST::{port_id}",
            "usage_role": usage(function, port),
        })
        assigned_functions.add(function["function_id"])

    # Guarantee that each traceable leaf behavior has at least one explicit interface usage.
    for function in sorted(leaf_functions, key=lambda x: x["function_id"]):
        if function["function_id"] in assigned_functions:
            continue
        port_id = next((x for x in function["derived_from_ports"] if x in ports), None)
        if not port_id:
            raise RuntimeError(f"Leaf function lacks an active derived interface: {function['function_id']}")
        port = ports[port_id]
        mappings.append({
            "mapping_id": mapping_id(function["function_id"], port_id),
            "function_id": function["function_id"],
            "interface_instance_id": f"IFINST::{port_id}",
            "usage_role": usage(function, port),
        })

    dedup = {x["mapping_id"]: x for x in mappings}
    output = {
        "metadata": {
            "project_id": source["metadata"]["project_id"],
            "profile_id": source["metadata"]["profile_id"],
            "mapping_count": len(dedup),
            "mapped_leaf_function_count": len({x["function_id"] for x in dedup.values()}),
        },
        "function_interface_mappings": sorted(dedup.values(), key=lambda x: x["mapping_id"]),
    }
    (WORK / "function_interface_mappings.json").write_text(json.dumps(output, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"stage": 5, "status": "PASS", **output["metadata"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
