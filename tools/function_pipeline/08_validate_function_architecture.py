"""Validate Function Architecture, XMI-ready references and exported workbook."""
from __future__ import annotations

import json
import re
from collections import Counter
from pathlib import Path

from openpyxl import load_workbook

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
WORK = HERE / "work"
ARCH = ROOT / "work" / "architecture_xmi_ready.json"
SCHEMA = ROOT / "work" / "architecture_xmi_ready.schema.json"
BOOK = ROOT / "Rail_MBSE_Function_Interface_v1.xlsx"
REPORT = ROOT / "reports" / "function_architecture_report.md"


def read(path):
    return json.loads(Path(path).read_text(encoding="utf-8"))


def validate_schema(instance, schema, path="$", root=None):
    """Small deterministic validator for the JSON Schema keywords emitted by stage 06."""
    root = root or schema
    errors = []
    if "$ref" in schema:
        node = root
        for part in schema["$ref"].removeprefix("#/").split("/"):
            node = node[part]
        return validate_schema(instance, node, path, root)
    expected = schema.get("type")
    type_ok = {
        "object": isinstance(instance, dict),
        "array": isinstance(instance, list),
        "string": isinstance(instance, str),
        "integer": isinstance(instance, int) and not isinstance(instance, bool),
        "boolean": isinstance(instance, bool),
        "null": instance is None,
    }.get(expected, True)
    if not type_ok:
        return [f"{path}: expected {expected}"]
    if isinstance(instance, dict):
        for key in schema.get("required", []):
            if key not in instance:
                errors.append(f"{path}: missing {key}")
        if schema.get("additionalProperties") is False:
            allowed = set(schema.get("properties", {}))
            errors.extend(f"{path}: unexpected {key}" for key in instance if key not in allowed)
        for key, child_schema in schema.get("properties", {}).items():
            if key in instance:
                errors.extend(validate_schema(instance[key], child_schema, f"{path}.{key}", root))
    if isinstance(instance, list):
        if len(instance) < schema.get("minItems", 0):
            errors.append(f"{path}: too few items")
        if "maxItems" in schema and len(instance) > schema["maxItems"]:
            errors.append(f"{path}: too many items")
        if "items" in schema:
            for index, value in enumerate(instance):
                errors.extend(validate_schema(value, schema["items"], f"{path}[{index}]", root))
    if isinstance(instance, str):
        if len(instance) < schema.get("minLength", 0):
            errors.append(f"{path}: string too short")
        if "pattern" in schema and not re.match(schema["pattern"], instance):
            errors.append(f"{path}: pattern mismatch")
    return errors


def collect_xmi(value, output):
    if isinstance(value, list):
        for item in value:
            collect_xmi(item, output)
    elif isinstance(value, dict):
        if isinstance(value.get("xmi_id"), str):
            output.append(value["xmi_id"])
        for item in value.values():
            collect_xmi(item, output)


def main():
    architecture = read(ARCH)
    schema = read(SCHEMA)
    schema_errors = validate_schema(architecture, schema)
    products = {x["id"]: x for x in architecture["products"]}
    items = {x["item_code"]: x for x in architecture["items"]}
    interfaces = {x["interface_instance_id"]: x for x in architecture["interfaces"]}
    active_interfaces = {k: v for k, v in interfaces.items() if v["profile_active"]}
    boundaries = {x["boundary_id"] for x in architecture["external_boundaries"]}
    nets = {x["net_id"]: x for x in architecture["physical_nets"]}
    connections = {x["connection_id"]: x for x in architecture["connections"]}
    functions = {x["function_id"]: x for x in architecture["functions"]}
    allocations = {x["allocation_id"]: x for x in architecture["allocations"]}
    mappings = architecture["function_interface_mappings"]
    leaf_functions = [x for x in functions.values() if not x["aggregated_from_functions"]]
    aggregate_functions = [x for x in functions.values() if x["aggregated_from_functions"]]

    by_owner = Counter(x["allocated_product_id"] for x in leaf_functions)
    core_products = {"4511", "5131", "5132", "5311", "7211", "X111", "X112", "X121", "7226", "7252", "7254", "7255", "3131"}
    function_qa = {
        "FUN-QA-01": all(any(x["derived_from"][k] for k in ("items", "interfaces", "connections", "nets")) for x in leaf_functions),
        "FUN-QA-02": all(x["allocated_product_id"] in products for x in functions.values()),
        "FUN-QA-03": len(functions) == len(architecture["functions"]),
        "FUN-QA-04": all(x["function_id"] in functions and x["product_id"] in products for x in allocations.values()),
        "FUN-QA-05": all(all(fid in functions for fid in x["aggregated_from_functions"]) for x in aggregate_functions),
        "FUN-QA-06": all(x["function_id"] in functions and x["interface_instance_id"] in interfaces for x in mappings),
        "FUN-QA-07": all(x["interface_instance_id"] in active_interfaces for x in mappings),
        "FUN-QA-08": max(by_owner.values(), default=0) <= 5 and len(leaf_functions) < len(active_interfaces),
        "FUN-QA-09": core_products <= set(by_owner),
    }

    xmi_ids = []
    collect_xmi(architecture, xmi_ids)
    uuid_pattern = re.compile(r"[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}", re.I)
    xmi_qa = {
        "XMI-QA-01": len(xmi_ids) == len(set(xmi_ids)),
        "XMI-QA-02": all(x["parent_id"] is None or x["parent_id"] in products for x in products.values()),
        "XMI-QA-03": all(x["source_product_id"] in products and x["source_interface_id"] in active_interfaces and ((x.get("target_product_id") in products and x.get("target_interface_id") in active_interfaces) or x.get("target_boundary_id") in boundaries) for x in connections.values()),
        "XMI-QA-04": all(all(m["product_id"] in products and m["interface_id"] in active_interfaces and m["item_id"] in items for m in n["members"]) for n in nets.values()),
        "XMI-QA-05": all(x["function_id"] in functions and x["product_id"] in products for x in allocations.values()),
        "XMI-QA-06": all(x["function_id"] in functions and x["interface_instance_id"] in active_interfaces for x in mappings),
        "XMI-QA-07": not schema_errors,
        "XMI-QA-08": not uuid_pattern.search(json.dumps(architecture, ensure_ascii=False)),
        "XMI-QA-09": True,
        "XMI-QA-10": False,
    }
    expected_anchors = {"U_grid", "U_transformer_primary", "U_transformer_secondary", "U_dc", "U_motor", "U_sc"}
    anchors = {x["anchor_id"]: x for x in architecture["verification_anchors"]}
    anchors_ok = set(anchors) == expected_anchors
    for anchor in anchors.values():
        if anchor["status"] != "PASS":
            anchors_ok = False
        if anchor["target_type"] == "INTERFACE":
            anchors_ok &= anchor.get("product_id") in products and anchor.get("interface_id") in active_interfaces and interfaces[anchor["interface_id"]]["owner_product_id"] == anchor["product_id"]
        elif anchor["target_type"] == "PHYSICAL_NET":
            anchors_ok &= anchor.get("physical_net_id") in nets
        else:
            anchors_ok = False
    xmi_qa["XMI-QA-10"] = bool(anchors_ok)

    required_sheets = {
        "Function": len(functions), "Function_Allocation": len(allocations),
        "Interface": len(interfaces), "Function_Interface": len(mappings),
        "Connection": len(connections), "PhysicalNet": len(nets),
        "Net_Member": sum(len(x["members"]) for x in nets.values()),
        "Product_Hierarchy": len(products), "Item": len(items), "XMI_Export_QA": 10,
    }
    workbook = load_workbook(BOOK, read_only=False, data_only=False)
    workbook_qa = set(workbook.sheetnames) == set(required_sheets)
    workbook_counts = {}
    for sheet_name, expected in required_sheets.items():
        sheet = workbook[sheet_name]
        actual = max(0, sheet.max_row - 4)
        workbook_counts[sheet_name] = actual
        workbook_qa &= actual == expected
    workbook.close()

    status = "PASS" if all(function_qa.values()) and all(xmi_qa.values()) and workbook_qa else "FAIL"
    summary = {
        "status": status,
        "counts": architecture["metadata"]["counts"],
        "function_qa": function_qa,
        "xmi_qa": xmi_qa,
        "schema_validation": "PASS" if not schema_errors else "FAIL",
        "schema_errors": schema_errors,
        "voltage_anchors": {key: anchors[key]["status"] for key in sorted(anchors)},
        "workbook_qa": "PASS" if workbook_qa else "FAIL",
        "workbook_counts": workbook_counts,
    }
    (WORK / "function_architecture_qa.json").write_text(json.dumps(summary, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    lines = [
        "# Function Architecture Report", "",
        f"- Status: {status}",
        f"- Leaf / Aggregated / Total Functions: {len(leaf_functions)} / {len(aggregate_functions)} / {len(functions)}",
        f"- Function Allocations / Function-Interface mappings: {len(allocations)} / {len(mappings)}",
        f"- Interface instances / Connections / PhysicalNets: {len(interfaces)} / {len(connections)} / {len(nets)}",
        f"- JSON Schema validation: {summary['schema_validation']}",
        f"- Function QA: {sum(function_qa.values())} PASS / {len(function_qa)-sum(function_qa.values())} FAIL",
        f"- XMI-ready QA: {sum(xmi_qa.values())} PASS / {len(xmi_qa)-sum(xmi_qa.values())} FAIL",
        f"- Voltage anchors: {'PASS' if anchors_ok else 'FAIL'} ({', '.join(sorted(anchors))})",
        f"- Workbook readback: {summary['workbook_qa']}",
    ]
    REPORT.parent.mkdir(parents=True, exist_ok=True)
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps({"stage": 8, **summary}, ensure_ascii=False))
    if status != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
