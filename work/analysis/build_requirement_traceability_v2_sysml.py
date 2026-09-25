from __future__ import annotations

import hashlib
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

from openpyxl import load_workbook


ROOT = Path(__file__).resolve().parents[2]
XLSX = ROOT / "Req" / "牵引制动能量回收系统_正式需求库_v2_扩展版.xlsx"
BASE = ROOT / "work" / "sysmlv2" / "full_engineering_model" / "01_generated"
FROZEN = BASE / "Rail_MBSE_Full_v1.sysml"
FUNC_SOURCE = BASE / "06_FunctionDefinitions.sysml"
PRODUCT_SOURCE = BASE / "05_ProductDefinitions.sysml"
ALLOC_SOURCE = BASE / "08_FunctionAllocations.sysml"
INTERACTION_SOURCE = ROOT / "work" / "sysmlv2" / "requirements_traceability" / "05_FunctionInteractionTrace.sysml"
OUT = ROOT / "work" / "sysmlv2" / "requirements_traceability_v2"
REPORT = ROOT / "work" / "reports" / "REQUIREMENT_TRACEABILITY_V2_SYSML_REPORT.md"
IMPORT_ORDER = OUT / "SYSON_IMPORT_ORDER_V2.md"


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def cell(v):
    return "" if v is None else str(v)


def split_ids(v: str) -> list[str]:
    return [x.strip() for x in re.split(r"[；;\n,，]+", v or "") if x.strip()]


def q(v: str) -> str:
    return json.dumps(cell(v), ensure_ascii=False)


def safe_id(v: str) -> str:
    return re.sub(r"[^A-Za-z0-9_]", "_", v)


def field_name(v: str) -> str:
    words = re.findall(r"[A-Za-z0-9]+", v)
    if not words:
        return "fieldValue"
    s = words[0].lower() + "".join(w[:1].upper() + w[1:] for w in words[1:])
    if s[0].isdigit():
        s = "field" + s
    return s


def sysml_quote(v: str) -> str:
    # SysML string literals use escaped quotes/backslashes; JSON quoting matches this subset.
    return q(v)


def read_rows(ws):
    values = list(ws.iter_rows(values_only=True))
    headers = [cell(x) for x in values[0]]
    return [dict(zip(headers, row)) for row in values[1:] if any(x is not None for x in row)]


def attrs(obj: dict, mapping: dict[str, str], indent="        ") -> str:
    return "\n".join(f"{indent}attribute :>> {mapping[k]} = {sysml_quote(cell(obj.get(k)))};" for k in mapping)


def requirement_body(r: dict, columns: list[str], col_to_attr: dict[str, str], indent="        ") -> str:
    return attrs(r, {c: col_to_attr[c] for c in columns}, indent)


def type_and_instances(reqs: list[dict], columns: list[str], col_to_attr: dict[str, str], package: str) -> str:
    lines = [f"package {package} {{", "    private import ScalarValues::*;", "", "    requirement def RailRequirementV2 {"]
    for c in columns:
        lines.append(f"        attribute {col_to_attr[c]} : String;")
    lines += ["    }", ""]
    for r in reqs:
        ident = cell(r["Requirement_ID"])
        lines += [f"    requirement req_{safe_id(ident)} : RailRequirementV2 {{", requirement_body(r, columns, col_to_attr), "    }", ""]
    lines += ["}", ""]
    return "\n".join(lines)


def get_property(block: str, prop: str) -> str | None:
    m = re.search(rf'attribute\s+(?::>>\s*)?{re.escape(prop)}(?:\s*:\s*String)?\s*=\s*"((?:\\.|[^"\\])*)"\s*;', block)
    if not m:
        return None
    try:
        return json.loads('"' + m.group(1) + '"')
    except Exception:
        return m.group(1)


def parse_functions(text: str):
    result = {}
    current = None
    lines = text.splitlines()
    for line in lines:
        m = re.search(r"action def\s+(FN_[A-Za-z0-9_]+)\s*\{", line)
        if m:
            current = {"definition_name": m.group(1)}
            result[m.group(1)] = current
            continue
        if current is not None:
            if line.strip() == "}":
                current = None
                continue
            m = re.search(r'attribute functionId\s*:\s*String\s*=\s*"([^"]+)"', line)
            if m:
                current["function_id"] = m.group(1)
            m = re.search(r'attribute chineseName\s*:\s*String\s*=\s*"((?:\\.|[^"\\])*)"', line)
            if m:
                current["function_name"] = json.loads('"' + m.group(1) + '"')
    return result


def parse_products(text: str):
    result = {}
    current = None
    for line in text.splitlines():
        m = re.search(r"part def\s+P_(?:N_)?([A-Za-z0-9_]+)\s*\{", line)
        if m:
            current = {"definition_name": m.group(1)}
            result[m.group(1)] = current
            continue
        if current is not None:
            if line.strip() == "}":
                current = None
                continue
            m = re.search(r'attribute productCode\s*:\s*String\s*=\s*"([^"]+)"', line)
            if m:
                current["product_id"] = m.group(1)
            m = re.search(r'attribute chineseName\s*:\s*String\s*=\s*"((?:\\.|[^"\\])*)"', line)
            if m:
                current["product_name"] = json.loads('"' + m.group(1) + '"')
    return result


def parse_interactions(text: str):
    records = []
    blocks = []
    active = None
    for line in text.splitlines():
        m = re.search(r"item ProductInteractionTraceRecord_(\d+)\s*:\s*ProductInteractionTraceRecord\s*\{", line)
        if m:
            active = [m.group(1), line]
            continue
        if active is not None:
            if line.strip() == "}":
                blocks.append((active[0], "\n".join(active[1:])))
                active = None
            else:
                active.append(line)
    for ix, body in blocks:
        record = {"record_id": ix}
        for attr in ["sourceProductId", "targetProductId", "flowName", "flowKind", "flowRef", "interfaceRefs", "connectorRefs", "source", "evidence"]:
            val = get_property(body, attr)
            if val is not None:
                record[attr] = val
        if len(record) > 1:
            records.append(record)
    return records


def sysml_item_records(package: str, type_name: str, records: list[dict], fields: list[tuple[str, str]], prefix: str) -> str:
    lines = [f"package {package} {{", "    private import ScalarValues::*;", "", f"    item def {type_name} {{"]
    for attr, _ in fields:
        lines.append(f"        attribute {attr} : String;")
    lines += ["    }", ""]
    for i, row in enumerate(records, 1):
        lines.append(f"    item {prefix}_{i:03d} : {type_name} {{")
        for attr, key in fields:
            lines.append(f"        attribute :>> {attr} = {sysml_quote(cell(row.get(key)))};")
        lines += ["    }", ""]
    lines += ["}", ""]
    return "\n".join(lines)


def check_balance(path: Path):
    text = path.read_text(encoding="utf-8")
    depth = 0
    quote = False
    escape = False
    line_comment = False
    block_comment = False
    i = 0
    while i < len(text):
        c = text[i]
        n = text[i + 1] if i + 1 < len(text) else ""
        if line_comment:
            if c == "\n": line_comment = False
            i += 1; continue
        if block_comment:
            if c == "*" and n == "/": block_comment = False; i += 2; continue
            i += 1; continue
        if quote:
            if escape: escape = False
            elif c == "\\": escape = True
            elif c == '"': quote = False
            i += 1; continue
        if c == "/" and n == "/": line_comment = True; i += 2; continue
        if c == "/" and n == "*": block_comment = True; i += 2; continue
        if c == '"': quote = True
        elif c == "{": depth += 1
        elif c == "}":
            depth -= 1
            if depth < 0: return False, "negative brace depth"
        i += 1
    return (depth == 0 and not quote and not block_comment), f"depth={depth}; quote={quote}; block_comment={block_comment}"


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    REPORT.parent.mkdir(parents=True, exist_ok=True)
    wb = load_workbook(XLSX, read_only=True, data_only=True)
    all_sheets = {ws.title: read_rows(ws) for ws in wb.worksheets}
    required_sheets = ["正式需求库", "需求-功能映射", "Function覆盖审计", "关键词检索表", "需求主题簇"]
    missing_sheets = [x for x in required_sheets if x not in all_sheets]
    if missing_sheets:
        raise ValueError(f"Missing required sheets: {missing_sheets}")
    reqs = all_sheets["正式需求库"]
    mappings = all_sheets["需求-功能映射"]
    audit = all_sheets["Function覆盖审计"]
    keyword_rows = all_sheets["关键词检索表"]
    topic_rows = all_sheets["需求主题簇"]

    base_text = FROZEN.read_text(encoding="utf-8-sig")
    func_text = FUNC_SOURCE.read_text(encoding="utf-8-sig")
    product_text = PRODUCT_SOURCE.read_text(encoding="utf-8-sig")
    alloc_text = ALLOC_SOURCE.read_text(encoding="utf-8-sig")
    interface_text = (BASE / "04_InterfaceDefinitions.sysml").read_text(encoding="utf-8-sig")
    functions = parse_functions(func_text)
    products = parse_products(product_text)
    function_by_id = {x.get("definition_name"): x for x in functions.values()}
    product_by_id = {x.get("product_id"): x for x in products.values()}
    allocations = {}
    for m in re.finditer(r"allocation\s+(\w+)\s+allocate\s+fu_(\w+)\s+to\s+ap_(?:N_)?([A-Za-z0-9_]+)\s*;", alloc_text):
        alloc_id, function_suffix, product_id = m.groups()
        function_def = "FN_" + function_suffix
        allocations[function_def] = {"allocation_id": alloc_id, "product_id": product_id, "evidence": m.group(0).strip()}

    # All worksheet rows and values are loaded above. The canonical mapping comes only from the V2 map sheet.
    req_by_id = {cell(r["Requirement_ID"]): r for r in reqs}
    func_to_req = defaultdict(list)
    req_to_functions = defaultdict(list)
    dangling_requirements = sorted(set(cell(r["Requirement_ID"]) for r in mappings) - set(req_by_id))
    dangling_functions = sorted(set(cell(r["Function_ID"]) for r in mappings) - set(function_by_id))
    dangling_products = sorted(set(a["product_id"] for a in allocations.values()) - set(product_by_id))
    no_allocation = sorted(set(function_by_id) - set(allocations))
    allocation_without_function = sorted(set(allocations) - set(function_by_id))
    parent_pairs = []
    for r in reqs:
        rid = cell(r["Requirement_ID"])
        for parent in split_ids(cell(r.get("Parent_Requirement_IDs"))):
            parent_pairs.append((parent, rid))
    dangling_parents = [(a, b) for a, b in parent_pairs if a not in req_by_id or b not in req_by_id]

    mapping_product_mismatches = []
    for m in mappings:
        req_id, function_id = cell(m["Requirement_ID"]), cell(m["Function_ID"])
        req_to_functions[req_id].append(function_id)
        func_to_req[function_id].append(req_id)
        owner = allocations.get(function_id, {}).get("product_id")
        map_product = cell(m.get("Product_ID"))
        if owner and map_product and owner != map_product:
            mapping_product_mismatches.append({"requirement_id": req_id, "function_id": function_id, "mapping_product_id": map_product, "frozen_owner_product_id": owner})
    audit_by_fn = {cell(r["Function_ID"]): r for r in audit}
    uncovered = sorted(set(function_by_id) - set(func_to_req))
    function_source_coverage = {cell(r["Function_ID"]): split_ids(cell(r.get("Requirement_IDs"))) for r in audit}
    audit_uncovered = sorted(k for k, v in function_source_coverage.items() if not v)
    support_records = []
    for row in audit:
        if cell(row.get("Coverage_Type")) == "IMPLEMENTATION_SUPPORT":
            support_records.append({"function_id": cell(row["Function_ID"]), "function_name": cell(row.get("Function_Name")), "requirement_ids": split_ids(cell(row.get("Requirement_IDs"))), "coverage_type": cell(row.get("Coverage_Type")), "evidence": "Function覆盖审计中的实现支持来源；不是289条正式Requirement→Function映射之一。"})
    dangling_support = [(x["function_id"], rid) for x in support_records for rid in x["requirement_ids"] if rid not in req_by_id]

    # Requirement attributes include every formal V2 sheet column so metadata cannot be lost.
    req_columns = list(reqs[0].keys())
    col_to_attr = {c: field_name(c) for c in req_columns}
    # Preserve user-facing exact field identities in the generated file through a metadata map.
    (OUT / "01_RequirementDefinitions_v2.sysml").write_text(type_and_instances(reqs, req_columns, col_to_attr, "RequirementDefinitionsV2"), encoding="utf-8")

    # The derivation relation is a first-class SysML connection between the exact requirement usages.
    hierarchy = [
        "package RequirementHierarchyV2 {",
        "    private import RequirementDefinitionsV2::*;",
        "",
        "    connection def RequirementDerivationConnection {",
        "        end parentRequirement : RailRequirementV2;",
        "        end derivedRequirement : RailRequirementV2;",
        "    }",
        "",
    ]
    for i, (parent, child) in enumerate(parent_pairs, 1):
        hierarchy += [f"    connection derivation_{i:03d} : RequirementDerivationConnection connect (req_{safe_id(parent)}, req_{safe_id(child)}) {{", f"        attribute relationType : String = \"PARENT_TO_DERIVED_REQUIREMENT\";", "    }", ""]
    hierarchy += ["}", ""]
    (OUT / "02_RequirementHierarchy_v2.sysml").write_text("\n".join(hierarchy), encoding="utf-8")

    trace = [
        "package RequirementFunctionTraceV2 {",
        "    private import RequirementDefinitionsV2::*;",
        "    private import FunctionAllocations::*;",
        "",
        "    // Each satisfy usage is copied directly from the V2 Excel mapping sheet; the by-end references the frozen model's allocated action usage.",
    ]
    for m in mappings:
        rid, fid = cell(m["Requirement_ID"]), cell(m["Function_ID"])
        suffix = fid.removeprefix("FN_")
        trace.append(f"    satisfy req_{safe_id(rid)} by fu_{suffix};")
    trace += ["", "    // Coverage-audit implementation-support links are kept distinct from the 289 formal satisfaction mappings.", "    item def FunctionImplementationSupportTrace {"]
    for attr in ["functionId", "functionName", "requirementIds", "coverageType", "evidence"]:
        trace.append(f"        attribute {attr} : String;")
    trace += ["    }", ""]
    for i, record in enumerate(support_records, 1):
        trace.append(f"    item implementationSupport_{i:03d} : FunctionImplementationSupportTrace {{")
        trace.append(f"        attribute :>> functionId = {sysml_quote(record['function_id'])};")
        trace.append(f"        attribute :>> functionName = {sysml_quote(record['function_name'])};")
        trace.append(f"        attribute :>> requirementIds = {sysml_quote('；'.join(record['requirement_ids']))};")
        trace.append(f"        attribute :>> coverageType = {sysml_quote(record['coverage_type'])};")
        trace.append(f"        attribute :>> evidence = {sysml_quote(record['evidence'])};")
        trace += ["    }", ""]
    trace += ["}", ""]
    (OUT / "03_RequirementFunctionTrace_v2.sysml").write_text("\n".join(trace), encoding="utf-8")

    owner_records = []
    for fdef, allocation in sorted(allocations.items()):
        f = function_by_id[fdef]
        p = product_by_id[allocation["product_id"]]
        owner_records.append({"function_id": fdef, "function_name": f.get("function_name", ""), "owner_product_id": allocation["product_id"], "owner_product_name": p.get("product_name", ""), "allocation_id": allocation["allocation_id"], "evidence": allocation["evidence"], "source_file": "work/sysmlv2/full_engineering_model/01_generated/08_FunctionAllocations.sysml"})
    owner_fields = [("functionId", "function_id"), ("functionName", "function_name"), ("ownerProductId", "owner_product_id"), ("ownerProductName", "owner_product_name"), ("allocationId", "allocation_id"), ("evidence", "evidence"), ("sourceFile", "source_file")]
    (OUT / "04_FunctionProductAllocationTrace_v2.sysml").write_text(sysml_item_records("FunctionProductAllocationTraceV2", "FunctionOwnerAllocationReference", owner_records, owner_fields, "ownerTrace"), encoding="utf-8")

    interactions = parse_interactions(INTERACTION_SOURCE.read_text(encoding="utf-8-sig"))
    interaction_missing_interfaces = sorted({iid for row in interactions for iid in split_ids(row.get("interfaceRefs", "")) if iid not in interface_text})
    interaction_missing_connectors = sorted({cid for row in interactions for cid in split_ids(row.get("connectorRefs", "")) if cid not in base_text})
    interaction_fields = [("sourceProductId", "sourceProductId"), ("targetProductId", "targetProductId"), ("flowName", "flowName"), ("flowKind", "flowKind"), ("flowRef", "flowRef"), ("interfaceRefs", "interfaceRefs"), ("connectorRefs", "connectorRefs"), ("source", "source"), ("evidence", "evidence")]
    (OUT / "05_ProductInteractionReference_v2.sysml").write_text(
        "// Product/flow/interface endpoints reference the frozen PhysicalNetworks package; no Function-to-Connector relation is asserted.\n" +
        "package ProductInteractionReferenceV2 {\n    private import PhysicalNetworks::*;\n\n" +
        sysml_item_records("ProductInteractionReferenceRecords", "ProductFlowTraceReference", interactions, interaction_fields, "productFlow").split("\n", 1)[1].rsplit("\n}", 1)[0] + "\n}\n",
        encoding="utf-8")

    # JSON keeps the workbook relation rows and replaces owner labels with names/allocations read from frozen SysML.
    json_trace = []
    for m in mappings:
        rid, fid = cell(m["Requirement_ID"]), cell(m["Function_ID"])
        fdef = function_by_id[fid]
        alloc = allocations[fid]
        owner = product_by_id[alloc["product_id"]]
        json_trace.append({
            "requirement_id": rid,
            "requirement_name": cell(req_by_id[rid].get("Name")),
            "function_id": fid,
            "function_name": fdef.get("function_name", ""),
            "owner_product_id": alloc["product_id"],
            "owner_product_name": owner.get("product_name", ""),
            "mapping_type": cell(m.get("Mapping_Type")),
            "evidence": cell(m.get("Evidence")),
        })
    json_path = OUT / "requirement_function_trace_v2.json"
    json_path.write_text(json.dumps(json_trace, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    # All-in-one repeats the overlay content for single-file import after the frozen system model.
    one = [
        "package RequirementTraceabilityAllInOneV2 {",
        "    private import ScalarValues::*;",
        "    private import FunctionDefinitions::*;",
        "    private import ProductDefinitions::*;",
        "    private import FunctionAllocations::*;",
        "    private import PhysicalNetworks::*;",
        "",
        "    requirement def RailRequirementV2 {",
    ]
    for c in req_columns:
        one.append(f"        attribute {col_to_attr[c]} : String;")
    one += ["    }", ""]
    for r in reqs:
        rid = cell(r["Requirement_ID"])
        one += [f"    requirement req_{safe_id(rid)} : RailRequirementV2 {{", requirement_body(r, req_columns, col_to_attr), "    }", ""]
    one += [
        "    connection def RequirementDerivationConnection {",
        "        end parentRequirement : RailRequirementV2;",
        "        end derivedRequirement : RailRequirementV2;",
        "    }",
        "",
    ]
    for i, (parent, child) in enumerate(parent_pairs, 1):
        one += [f"    connection derivation_{i:03d} : RequirementDerivationConnection connect (req_{safe_id(parent)}, req_{safe_id(child)}) {{", "        attribute relationType : String = \"PARENT_TO_DERIVED_REQUIREMENT\";", "    }", ""]
    for m in mappings:
        rid, fid = cell(m["Requirement_ID"]), cell(m["Function_ID"])
        suffix = fid.removeprefix("FN_")
        one.append(f"    satisfy req_{safe_id(rid)} by fu_{suffix};")
    one += ["", "    item def FunctionOwnerAllocationReference {"]
    for a, _ in owner_fields:
        one.append(f"        attribute {a} : String;")
    one += ["    }", ""]
    for i, record in enumerate(owner_records, 1):
        one.append(f"    item ownerTrace_{i:03d} : FunctionOwnerAllocationReference {{")
        for a, k in owner_fields:
            one.append(f"        attribute :>> {a} = {sysml_quote(cell(record.get(k)))};")
        one += ["    }", ""]
    one += ["    item def ProductFlowTraceReference {"]
    for a, _ in interaction_fields:
        one.append(f"        attribute {a} : String;")
    one += ["    }", ""]
    for i, record in enumerate(interactions, 1):
        one.append(f"    item productFlow_{i:03d} : ProductFlowTraceReference {{")
        for a, k in interaction_fields:
            one.append(f"        attribute :>> {a} = {sysml_quote(cell(record.get(k)))};")
        one += ["    }", ""]
    one += ["    item def FunctionImplementationSupportTrace {"]
    for attr in ["functionId", "functionName", "requirementIds", "coverageType", "evidence"]:
        one.append(f"        attribute {attr} : String;")
    one += ["    }", ""]
    for i, record in enumerate(support_records, 1):
        one += [f"    item implementationSupport_{i:03d} : FunctionImplementationSupportTrace {{",
                f"        attribute :>> functionId = {sysml_quote(record['function_id'])};",
                f"        attribute :>> functionName = {sysml_quote(record['function_name'])};",
                f"        attribute :>> requirementIds = {sysml_quote('；'.join(record['requirement_ids']))};",
                f"        attribute :>> coverageType = {sysml_quote(record['coverage_type'])};",
                f"        attribute :>> evidence = {sysml_quote(record['evidence'])};", "    }", ""]
    one += ["}", ""]
    all_in_one_text = "\n".join(one)
    all_in_one_path = OUT / "06_RequirementTraceability_AllInOne_v2.sysml"
    all_in_one_path.write_text(all_in_one_text, encoding="utf-8")
    generated_req_blocks = {}
    for m in re.finditer(r"requirement req_([A-Za-z0-9_]+) : RailRequirementV2\s*\{(.*?)\n\s*\}", all_in_one_text, re.S):
        generated_req_blocks[m.group(1)] = m.group(2)
    requirement_metadata_ok = len(generated_req_blocks) == 46
    for req in reqs:
        block = generated_req_blocks.get(safe_id(cell(req["Requirement_ID"])), "")
        for column in req_columns:
            expected_attribute = f"attribute :>> {col_to_attr[column]} = {sysml_quote(cell(req.get(column)))};"
            if expected_attribute not in block:
                requirement_metadata_ok = False
                break
    expected_formal_edges = {(safe_id(cell(m["Requirement_ID"])), "fu_" + cell(m["Function_ID"]).removeprefix("FN_")) for m in mappings}
    generated_formal_edges = set(re.findall(r"^\s*satisfy req_([A-Za-z0-9_]+) by (fu_[A-Za-z0-9_]+);", all_in_one_text, re.M))
    owner_trace_text = (OUT / "04_FunctionProductAllocationTrace_v2.sysml").read_text(encoding="utf-8")
    interaction_trace_text = (OUT / "05_ProductInteractionReference_v2.sysml").read_text(encoding="utf-8")

    # Quantities and exact relation integrity checks.
    unique_req_ids = len(req_by_id) == len(reqs)
    unique_map_pairs = len({(cell(m["Requirement_ID"]), cell(m["Function_ID"])) for m in mappings}) == len(mappings)
    expected = {
        "requirements": len(reqs) == 46,
        "requirement_function": len(mappings) == 289,
        "functions": len(functions) == 191,
        "function_coverage": len(set(func_to_req) | {x["function_id"] for x in support_records}) == 191 and len(uncovered) == 13 and not dangling_support,
        "allocations": len(allocations) == 191 and not no_allocation and not allocation_without_function,
        "requirements_unique": unique_req_ids,
        "mapping_pairs_unique": unique_map_pairs,
        "function_ids_resolve": not dangling_functions,
        "product_ids_resolve": not dangling_products,
        "parents_resolve": not dangling_parents,
        "audit_all_191_covered": len(audit) == 191 and not audit_uncovered,
        "interactions_resolve_products": all(cell(x.get("sourceProductId")) in product_by_id and cell(x.get("targetProductId")) in product_by_id for x in interactions),
        "product_interaction_records": len(interactions) == 74,
        "interaction_interface_refs_resolve": not interaction_missing_interfaces,
        "interaction_connector_refs_resolve": not interaction_missing_connectors,
        "generated_requirement_usages": len(re.findall(r"^\s*requirement req_[A-Za-z0-9_]+ : RailRequirementV2 \{", all_in_one_text, re.M)) == 46,
        "generated_satisfy_edges": len(re.findall(r"^\s*satisfy req_[A-Za-z0-9_]+ by fu_[A-Za-z0-9_]+;", all_in_one_text, re.M)) == 289,
        "generated_satisfy_edges_match_excel": generated_formal_edges == expected_formal_edges,
        "generated_requirement_metadata_matches_excel": requirement_metadata_ok,
        "generated_parent_derived_edges": len(re.findall(r"^\s*connection derivation_[0-9]+ : RequirementDerivationConnection", all_in_one_text, re.M)) == len(parent_pairs),
        "generated_support_records": len(re.findall(r"^\s*item implementationSupport_[0-9]+ : FunctionImplementationSupportTrace", all_in_one_text, re.M)) == 13,
        "generated_product_flow_records": len(re.findall(r"^\s*item productFlow_[0-9]+ : ProductFlowTraceReference", all_in_one_text, re.M)) == 74,
        "generated_owner_allocation_records": len(re.findall(r"^\s*item ownerTrace_[0-9]+ : FunctionOwnerAllocationReference", owner_trace_text, re.M)) == 191,
        "generated_interaction_reference_records": len(re.findall(r"^\s*item productFlow_[0-9]+ : ProductFlowTraceReference", interaction_trace_text, re.M)) == 74,
    }
    files = sorted(OUT.glob("*.sysml"))
    balance = {f.name: check_balance(f) for f in files}
    utf8_ok = all(f.read_bytes().decode("utf-8") is not None for f in files)
    parent_function_counts = defaultdict(set)
    direct_requirement_count = sum(1 for r in reqs if cell(r["Requirement_ID"]) in req_to_functions)
    derived_req_ids = {cell(r["Requirement_ID"]) for r in reqs if cell(r["Requirement_ID"]).startswith("DRV-")}
    direct_original = sum(1 for r in reqs if not cell(r["Requirement_ID"]).startswith("DRV-") and cell(r["Requirement_ID"]) in req_to_functions)
    derived_req_with_function = sum(1 for r in reqs if cell(r["Requirement_ID"]) in derived_req_ids and cell(r["Requirement_ID"]) in req_to_functions)
    through_derived_parents = {p for p, c in parent_pairs if c in req_to_functions}
    through_derived_parent_count = len(through_derived_parents)
    per_req = Counter(cell(m["Requirement_ID"]) for m in mappings)
    per_function = Counter(cell(m["Function_ID"]) for m in mappings)
    avg_links = len(mappings) / len(reqs) if reqs else 0
    xlsx_product_sets = {cell(r["Requirement_ID"]): set(split_ids(cell(r.get("Linked_Product_IDs")))) for r in reqs}
    frozen_product_sets = {rid: {allocations[fid]["product_id"] for fid in set(fids) if fid in allocations} for rid, fids in req_to_functions.items()}
    req_product_differences = []
    for rid, xp in xlsx_product_sets.items():
        fp = frozen_product_sets.get(rid, set())
        if xp != fp:
            req_product_differences.append({"requirement_id": rid, "v2_products": sorted(xp), "frozen_owner_products": sorted(fp), "only_v2": sorted(xp - fp), "only_frozen": sorted(fp - xp)})
    req_product_differences.sort(key=lambda x: x["requirement_id"])

    # Recheck source workbook and frozen source SHA; only overlay outputs are written.
    manifest = json.loads((ROOT / "work" / "sysmlv2" / "requirements_traceability" / "traceability_manifest.json").read_text(encoding="utf-8"))
    frozen_hash = sha256(FROZEN)
    frozen_hash_ok = frozen_hash == manifest["expected_frozen_sysml_sha256"]
    sysml_balanced = all(x[0] for x in balance.values())
    all_checks = all(expected.values()) and sysml_balanced and utf8_ok and frozen_hash_ok and len(json_trace) == 289

    import_order = f"""# SysON 导入顺序（Requirement Traceability V2）

1. 冻结工程模型：`work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml`
2. V2 overlay 单文件：`work/sysmlv2/requirements_traceability_v2/06_RequirementTraceability_AllInOne_v2.sysml`

All-In-One 已包含 46 个需求 usage、Parent→Derived requirement connection、289 条 `satisfy` trace，以及来自冻结 allocation 和 Product interaction reference 的可审计数据；并导入冻结模型中的 `FunctionDefinitions`、`ProductDefinitions`、`FunctionAllocations` 与 `PhysicalNetworks` 包。先导入冻结模型确保引用到原模型的真实 action、product、allocation 和 flow。

如果 SysON 当前只允许逐文件/包导入而不能一次导入多 package，请用下列依赖顺序：

1. `01_RequirementDefinitions_v2.sysml`
2. `02_RequirementHierarchy_v2.sysml`
3. `03_RequirementFunctionTrace_v2.sysml`
4. `04_FunctionProductAllocationTrace_v2.sysml`
5. `05_ProductInteractionReference_v2.sysml`

拆分文件均依赖先导入的冻结工程模型；关系只引用已有 Requirement usage 和冻结 `fu_*` allocation/action usage，不覆盖冻结模型定义。
"""
    IMPORT_ORDER.write_text(import_order, encoding="utf-8")

    pilot_available = False
    import shutil
    for cmd in ["sysml", "syside", "sysml-v2-pilot", "SysMLv2Pilot"]:
        if shutil.which(cmd):
            pilot_available = True
            break
    # Existing traceability manifest also records the last known local official kernel state.
    pilot_state = "AVAILABLE_COMMAND_FOUND_NOT_RUN" if pilot_available else "OFFICIAL_PARSE_NOT_RUN"

    category_direct = {}
    for r in audit:
        ftype = cell(r.get("Coverage_Type"))
        category_direct[ftype] = category_direct.get(ftype, 0) + 1
    mismatch_summary = "无 Product_ID 不一致。" if not mapping_product_mismatches and not req_product_differences else f"V2 mapping rows whose Product_ID differs from frozen Function allocation: {len(mapping_product_mismatches)}; requirement Linked_Product_ID set differences: {len(req_product_differences)}. Frozen allocation prevails."
    report_lines = [
        "# Requirement Traceability V2 SysML Overlay Report", "",
        "## Result", "",
        f"- Requirement: {len(reqs)} = {sum(1 for r in reqs if not cell(r['Requirement_ID']).startswith('DRV-'))} original + {len(derived_req_ids)} derived.",
        f"- Requirement→Function mappings read directly from V2 Excel: {len(mappings)} (unique pairs: {len({(cell(m['Requirement_ID']), cell(m['Function_ID'])) for m in mappings})}).",
        f"- Functions: {len(functions)}; direct formal Requirement→Function map coverage: {len(set(func_to_req))}; implementation-support source coverage: {len(support_records)}; with any Requirement upstream per V2 coverage audit: {len(set(func_to_req) | {x['function_id'] for x in support_records})}; unresolved: {len(dangling_support) + len(audit_uncovered)}.",
        f"- Function→OWNER Product allocations parsed from frozen SysML: {len(allocations)}.",
        f"- Parent→Derived links from V2 Parent_Requirement_IDs: {len(parent_pairs)}.",
        f"- Frozen Product interaction references: {len(interactions)} flow records.",
        f"- Requirement rows directly connected to at least one Function: {direct_requirement_count}; original requirements: {direct_original}; derived requirements: {derived_req_with_function}.",
        f"- Original requirements with linked derived-requirement Functions: {through_derived_parent_count}.",
        f"- Maximum Functions per Requirement: {max(per_req.values(), default=0)}; maximum Requirements per Function: {max(per_function.values(), default=0)}; mean mappings per Requirement: {avg_links:.2f}.",
        f"- Coverage audit categories from V2: {json.dumps(category_direct, ensure_ascii=False, sort_keys=True)}.",
        f"- Product comparison: {mismatch_summary}",
        "",
        "## Validation", "",
        f"- Structural / ID / reference checks: {'PASS' if all(expected.values()) else 'FAIL'}.",
        f"- UTF-8 and brace balance: {'PASS' if utf8_ok and sysml_balanced else 'FAIL'}.",
        f"- Frozen SysML SHA-256: {'PASS' if frozen_hash_ok else 'FAIL'} (`{frozen_hash}`; expected `{manifest['expected_frozen_sysml_sha256']}`).",
        f"- V2 Excel SHA-256 (input snapshot): `{sha256(XLSX)}`.",
        f"- Official SysML Pilot 0.59.0 parser: `{pilot_state}`.",
        f"- Overall internal structure: {'PASS' if all_checks else 'FAIL'}.",
        "",
        "### Checks", "",
    ]
    report_lines += [f"- {'PASS' if ok else 'FAIL'} {name}" for name, ok in expected.items()]
    report_lines += [f"- {'PASS' if ok else 'FAIL'} brace balance `{name}` ({detail})" for name, (ok, detail) in balance.items()]
    report_lines += ["", "## Anomalies and dangling references", ""]
    anomalies = []
    for label, values in [("Dangling requirement IDs in mapping", dangling_requirements), ("Function IDs absent from frozen SysML", dangling_functions), ("Product IDs absent from frozen SysML", dangling_products), ("Functions without frozen allocation", no_allocation), ("Allocations without known action", allocation_without_function), ("Functions without any V2 requirement upstream source", audit_uncovered), ("Dangling implementation-support requirement IDs", [f"{a}->{b}" for a, b in dangling_support]), ("Dangling Parent_Requirement_IDs", [f"{a}->{b}" for a, b in dangling_parents]), ("Interaction interface references absent from frozen SysML", interaction_missing_interfaces), ("Interaction connector references absent from frozen SysML", interaction_missing_connectors)]:
        if values: anomalies.append(f"- {label}: {', '.join(values)}")
    if mapping_product_mismatches:
        anomalies.append(f"- V2 mapping Product_ID mismatches: {len(mapping_product_mismatches)}; see mismatch table below.")
    if req_product_differences:
        anomalies.append(f"- V2 Linked_Product_ID set differs from products reached through frozen owners for {len(req_product_differences)} requirements; see table below.")
    report_lines += anomalies or ["- None."]
    if mapping_product_mismatches:
        report_lines += ["", "### Mapping Product_ID differences (frozen allocation is authoritative)", "", "| Requirement | Function | V2 Product | Frozen OWNER Product |", "|---|---|---|---|"]
        report_lines += [f"| {x['requirement_id']} | {x['function_id']} | {x['mapping_product_id']} | {x['frozen_owner_product_id']} |" for x in mapping_product_mismatches]
    if req_product_differences:
        report_lines += ["", "### Linked_Product_ID set differences", "", "| Requirement | V2 Linked_Product_IDs | Frozen OWNER Product IDs |", "|---|---|---|"]
        report_lines += [f"| {x['requirement_id']} | {'；'.join(x['v2_products'])} | {'；'.join(x['frozen_owner_products'])} |" for x in req_product_differences]
    report_lines += [
        "", "## Generated Files", "",
        *[f"- `work/sysmlv2/requirements_traceability_v2/{name}`" for name in ["01_RequirementDefinitions_v2.sysml", "02_RequirementHierarchy_v2.sysml", "03_RequirementFunctionTrace_v2.sysml", "04_FunctionProductAllocationTrace_v2.sysml", "05_ProductInteractionReference_v2.sysml", "06_RequirementTraceability_AllInOne_v2.sysml", "requirement_function_trace_v2.json", "SYSON_IMPORT_ORDER_V2.md"]],
        "",
        "No UI, V2 Excel, or frozen SysML source was written by this generator.",
        "",
    ]
    REPORT.write_text("\n".join(report_lines), encoding="utf-8")
    result = {"overall": "PASS" if all_checks else "FAIL", "checks": expected, "brace_balance": {k: v[0] for k, v in balance.items()}, "utf8": utf8_ok, "frozen_sha256": frozen_hash, "official_parser": pilot_state, "mappings": len(mappings), "requirements": len(reqs), "functions": len(functions), "allocations": len(allocations), "derived": len(derived_req_ids), "parent_edges": len(parent_pairs), "interaction_records": len(interactions), "mapping_product_mismatches": len(mapping_product_mismatches), "requirement_linked_product_set_differences": len(req_product_differences), "report": str(REPORT)}
    print(json.dumps(result, ensure_ascii=False))
    if not all_checks:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
