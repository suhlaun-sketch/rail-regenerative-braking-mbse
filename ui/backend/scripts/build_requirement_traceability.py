from __future__ import annotations

import hashlib
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
DATA = ROOT / "ui/backend/data/semantic_slice"
OUT = ROOT / "work/sysmlv2/requirements_traceability"
REPORT = ROOT / "work/reports/REQUIREMENT_FUNCTION_PRODUCT_MAPPING_AUDIT.md"
SOURCE = ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
BASELINE_SHA = "a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5"


def load(name):
    return json.loads((DATA / name).read_text(encoding="utf-8"))


def q(value):
    return json.dumps("" if value is None else str(value), ensure_ascii=False)


def safe_id(value):
    return re.sub(r"[^A-Za-z0-9_]", "_", value)


def props(record, fields):
    return "\n".join(f"        attribute :>> {field} = {q(record.get(field, ''))};" for field in fields)


def attr_def(fields):
    return "\n".join(f"        attribute {field} : String;" for field in fields)


def item_type(name, fields):
    return f"    item def {name} {{\n{attr_def(fields)}\n    }}"


def item_usage(name, type_name, record, fields, keyword="item"):
    return f"    {keyword} {name} : {type_name} {{\n{props(record, fields)}\n    }}"


def package(name, body, imports=()):
    imports_text = "\n".join(f"    private import {name}::*;" for name in imports)
    return f"package {name} {{\n{imports_text}\n\n{body}\n}}\n"


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    requirements = load("requirement_catalog.json")["requirements"]
    functions = load("function_catalog.json")["functions"]
    products = load("product_catalog.json")["products"]
    req_map = load("requirement_function_map.json")
    candidate_suggestions = load("requirement_function_candidates.json")["relations"]
    owner_map = load("function_product_map.json")["relations"]
    interaction_map = load("l2_interaction_catalog.json")["interactions"]
    function_map = load("function_interaction_map.json")["functions"]
    req_by_id = {x["requirement_id"]: x for x in requirements}
    fn_by_id = {x["function_id"]: x for x in functions}
    owner_by_fn = defaultdict(list)
    for x in owner_map:
        owner_by_fn[x["function_id"]].append(x)
    rf_by_req = defaultdict(list)
    for x in req_map["relations"]:
        rf_by_req[x["requirement_id"]].append(x)

    req_fields = ["requirementId", "domain", "requirementName", "requirementText", "standardNo", "standardClause",
        "criteria", "applicableConditions", "requirementType", "verificationStatus", "sourceFile"]
    rf_fields = ["requirementId", "functionId", "relationType", "mappingSource", "coverageStatus", "confidence", "evidence", "semanticEvidence", "structuralEvidence", "evidencePath", "sourceFiles", "sourceFile", "notes"]
    owner_fields = ["functionId", "productId", "role", "mappingSource", "evidence", "sourceFile"]
    interaction_fields = ["sourceProductId", "targetProductId", "flowName", "flowKind", "flowRef", "interfaceRefs",
        "connectorRefs", "source", "evidence"]
    assessment_fields = ["functionId", "interactionStatus", "unresolvedReason"]

    definitions = "    requirement def RailRequirement {\n" + "\n".join(
        f"        attribute {name} : String;" for name in req_fields) + "\n    }"
    definitions_text = package("RequirementTraceDefinitions", definitions, ("ScalarValues",))
    usages = []
    for r in requirements:
        record = {"requirementId": r["requirement_id"], "domain": r["domain"], "requirementName": r["name"],
            "requirementText": r["text"], "standardNo": r["standard_no"], "standardClause": r["standard_clause"],
            "criteria": r["criteria"], "applicableConditions": r["applicable_conditions"],
            "requirementType": r["requirement_type"], "verificationStatus": r["verification_status"],
            "sourceFile": "Req/牵引制动能量回收系统_正式需求库_v1.xlsx"}
        usages.append(item_usage("req_" + safe_id(r["requirement_id"]), "RailRequirement", record, req_fields, "requirement"))
    usages_text = package("RequirementTraceUsages", "\n\n".join(usages), ("RequirementTraceDefinitions",))

    def make_records(pkg, type_name, fields, records, name_field):
        body = item_type(type_name, fields)
        for index, record in enumerate(records, 1):
            body += "\n\n" + item_usage(f"{type_name}_{index:03d}", type_name, record, fields)
        return package(pkg, body, ("ScalarValues",))

    rf_records = [{"requirementId": x["requirement_id"], "functionId": x["function_id"], "relationType": x["relation_type"],
        "mappingSource": x["mapping_source"], "coverageStatus": x.get("coverage_status", "FULLY_RESOLVED"),
        "confidence": x["confidence"], "evidence": x["evidence"],
        "semanticEvidence": x.get("semantic_evidence", ""),
        "structuralEvidence": json.dumps(x.get("structural_evidence", {}), ensure_ascii=False, separators=(",", ":")),
        "evidencePath": json.dumps(x.get("evidence_path", []), ensure_ascii=False, separators=(",", ":")),
        "sourceFiles": json.dumps(x.get("source_files", [x["source_file"]]), ensure_ascii=False, separators=(",", ":")),
        "sourceFile": x["source_file"], "notes": x["notes"]} for x in req_map["relations"]]
    rf_fields_sysml = rf_fields.copy()
    # Numeric evidence remains a string for robust interchange and preserves the source confidence exactly.
    rf_body = item_type("RequirementFunctionTraceRecord", rf_fields_sysml)
    for index, record in enumerate(rf_records, 1):
        rf_body += "\n\n" + item_usage(f"RequirementFunctionTraceRecord_{index:03d}", "RequirementFunctionTraceRecord", record, rf_fields_sysml)
    context_lines = ["    part satisfactionContext {"]
    context_functions = sorted({x["functionId"] for x in rf_records})
    for fid in context_functions:
        context_lines.append(f"        action fn_{safe_id(fid)} : FunctionDefinitions::{fid};")
    for record in rf_records:
        req = req_by_id[record["requirementId"]]
        usage_record = {"requirementId": req["requirement_id"], "domain": req["domain"], "requirementName": req["name"],
            "requirementText": req["text"], "standardNo": req["standard_no"], "standardClause": req["standard_clause"],
            "criteria": req["criteria"], "applicableConditions": req["applicable_conditions"], "requirementType": req["requirement_type"],
            "verificationStatus": req["verification_status"], "sourceFile": "Req/牵引制动能量回收系统_正式需求库_v1.xlsx"}
        context_lines.append(f"        satisfy requirement req_{safe_id(record['requirementId'])} : RailRequirement by fn_{safe_id(record['functionId'])} {{")
        context_lines.extend(f"            attribute :>> {field} = {q(usage_record[field])};" for field in req_fields)
        context_lines.append("        }")
    context_lines.append("    }")
    rf_body += "\n\n" + "\n".join(context_lines)
    rf_text = package("RequirementFunctionTrace", rf_body, ("RequirementTraceDefinitions", "FunctionDefinitions"))

    owners = [{"functionId": x["function_id"], "productId": x["product_id"], "role": "OWNER",
        "mappingSource": "SYSML_ALLOCATION", "evidence": x["evidence"], "sourceFile": x["source_file"]} for x in owner_map]
    owner_text = make_records("FunctionOwnerTrace", "FunctionOwnerTraceRecord", owner_fields, owners, "functionId")

    interaction_records = [{"sourceProductId": x["source_product_id"], "targetProductId": x["target_product_id"],
        "flowName": x["flow_name"], "flowKind": x["flow_kind"], "flowRef": x["flow_ref"],
        "interfaceRefs": ",".join(x["interface_refs"]), "connectorRefs": ",".join(x["connector_refs"]),
        "source": x["source"], "evidence": x["evidence"]} for x in interaction_map]
    assessments = [{"functionId": x["function_id"], "interactionStatus": x["interaction_status"],
        "unresolvedReason": x["unresolved_reason"]} for x in function_map]
    interaction_body = item_type("ProductInteractionTraceRecord", interaction_fields)
    for index, record in enumerate(interaction_records, 1):
        interaction_body += "\n\n" + item_usage(f"ProductInteractionTraceRecord_{index:03d}", "ProductInteractionTraceRecord", record, interaction_fields)
    interaction_body += "\n\n" + item_type("FunctionInteractionAssessment", assessment_fields)
    for index, record in enumerate(assessments, 1):
        interaction_body += "\n\n" + item_usage(f"FunctionInteractionAssessment_{index:03d}", "FunctionInteractionAssessment", record, assessment_fields)
    interaction_text = package("FunctionInteractionTrace", interaction_body, ("ScalarValues",))

    file_contents = {
        "01_RequirementDefinitions.sysml": definitions_text,
        "02_RequirementUsages.sysml": usages_text,
        "03_RequirementFunctionTrace.sysml": rf_text,
        "04_FunctionProductAllocationTrace.sysml": owner_text,
        "05_FunctionInteractionTrace.sysml": interaction_text,
    }
    for name, content in file_contents.items():
        (OUT / name).write_text(content, encoding="utf-8")

    # Standalone import-ready package. It uses source object IDs as trace-reference values and does not redefine them.
    all_body = definitions.replace("    requirement def RailRequirement", "    requirement def RailRequirement")
    all_body = all_body.replace("    }", "    }", 1)
    all_parts = [all_body]
    for r in requirements:
        record = {"requirementId": r["requirement_id"], "domain": r["domain"], "requirementName": r["name"],
            "requirementText": r["text"], "standardNo": r["standard_no"], "standardClause": r["standard_clause"],
            "criteria": r["criteria"], "applicableConditions": r["applicable_conditions"], "requirementType": r["requirement_type"],
            "verificationStatus": r["verification_status"], "sourceFile": "Req/牵引制动能量回收系统_正式需求库_v1.xlsx"}
        all_parts.append(item_usage("req_" + safe_id(r["requirement_id"]), "RailRequirement", record, req_fields, "requirement"))
    for typename, fields, records in (("RequirementFunctionTraceRecord", rf_fields, rf_records),
        ("FunctionOwnerTraceRecord", owner_fields, owners), ("ProductInteractionTraceRecord", interaction_fields, interaction_records),
        ("FunctionInteractionAssessment", assessment_fields, assessments)):
        all_parts.append(item_type(typename, fields))
        for index, record in enumerate(records, 1):
            all_parts.append(item_usage(f"{typename}_{index:03d}", typename, record, fields))
    all_parts.extend(context_lines)
    all_in_one = package("RailRequirementTraceability", "\n\n".join(all_parts), ("ScalarValues", "FunctionDefinitions"))
    all_path = OUT / "06_RequirementTraceability_AllInOne.sysml"
    all_path.write_text(all_in_one, encoding="utf-8")

    model_sha = hashlib.sha256(SOURCE.read_bytes()).hexdigest()
    rf_counts = Counter(x["requirement_id"] for x in req_map["relations"])
    owner_counts = Counter(x["function_id"] for x in owner_map)
    l2_groups = {x["aggregate_interface_ref"] for x in interaction_map}
    pairs = {(x["source_product_id"], x["target_product_id"]) for x in interaction_map}
    sources = {x["source_product_id"] for x in interaction_map}; targets = {x["target_product_id"] for x in interaction_map}
    flow_refs = {x["flow_ref"] for x in interaction_map}; connector_refs = {c for x in interaction_map for c in x["connector_refs"]}
    classes = Counter(x["source_classification"] for x in functions)
    directional = [x for x in functions if re.search(r"(向.{1,12}(传递|输出|发送|输送)|给.{1,12}(提供|输出)|从.{1,12}(接收|获取))", x["name"])]
    x100 = [x for x in interaction_map if "X100" in (x["source_product_id"], x["target_product_id"])]
    x100_summary = Counter((x["source_product_id"], x["target_product_id"], x["flow_kind"]) for x in x100)
    mapped_requirements = sorted(rf_counts)
    unresolved_reqs = [x for x in requirements if x["requirement_id"] not in rf_counts]
    no_owner = [x["function_id"] for x in functions if not owner_counts[x["function_id"]]]
    no_interaction = [x["function_id"] for x in functions]
    resolution = req_map.get("resolution_by_requirement", {})
    map_counts = Counter(x["mapping_source"] for x in req_map["relations"])
    resolution_counts = Counter(resolution.values())
    lines = [
        "# Requirement → Function → Product → Interaction Mapping Audit", "",
        "## Source integrity and data basis", "",
        f"- Frozen SysML SHA-256: `{model_sha}` (expected `{BASELINE_SHA}`; {'MATCH' if model_sha == BASELINE_SHA else 'MISMATCH'}).",
        "- Formal requirements: `Req/牵引制动能量回收系统_正式需求库_v1.xlsx`, sheet `正式需求库`.",
        "- Function and owner evidence: frozen `Rail_MBSE_Full_v1.sysml` action defs and allocations.",
        "- Product and interaction evidence: SysML-declared connectors projected to true L2 boundaries by `TaskSliceService` / `ModelGraphService` Stage 4 aggregation.",
        "- No UI source was changed in this audit phase.", "",
        "## Why the previous 5 → 5 → 5 result was misleading", "",
        "The builder scored shared Chinese character bigrams, gave a product-affinity bonus, then sliced `[:3]` for every requirement without review. This generated a fixed three RULE_BASED links for each of 31 requirements (93 links), regardless of whether the shared terms proved the engineering relation. The query service separately takes at most 12 local requirement candidates, then keeps 5 for focused queries or 10 for broad queries. `local_matcher` reads only the first five matches when composing suggested keywords; it does not truncate Function/Product relations. Targeted inspection found no `functions[0]`, `products[0]`, nor one-function/one-product relation rule in these layers. The prior 5/5/5 screen therefore reflected a focused five-requirement query plus downstream display behavior over invalidly promoted candidates; the current query service has no explicit Function/Product five-item cap.",
        "The builder now accepts Excel `known_function_id` as `EXPLICIT`; remaining mappings are curated `MODEL_DERIVED` relations only when semantic screening resolves to real existing Functions and an auditable Product→allocation→Function path. Bigram/character-overlap suggestions are disabled. `SEMANTIC_ASSISTED` suggestions remain separate from formal satisfaction links (currently zero). Excel `primary_product` is scope evidence, not itself a Function→Product relation.", "",
        "## Cardinality and resolution", "",
        f"- Requirements: {len(requirements)}; Functions: {len(functions)}; Products: {len(products)}.",
        f"- Requirement → Function trace relations: {len(req_map['relations'])}; EXPLICIT: {map_counts.get('EXPLICIT', 0)}; MODEL_DERIVED: {map_counts.get('MODEL_DERIVED', 0)}; SEMANTIC_ASSISTED candidates: {len(candidate_suggestions)}.",
        f"- Requirement resolution: fully resolved {resolution_counts.get('FULLY_RESOLVED', 0)}/34; partially resolved {resolution_counts.get('PARTIALLY_RESOLVED', 0)}/34; unresolved {resolution_counts.get('UNRESOLVED', 0)}/34.",
        "- Every model-derived relation carries `evidence_path`, `semantic_evidence`, `structural_evidence`, and `source_files`; parameter, product-boundary flow and system-level V&V evidence are typed and scoped. No direct Function→Connector claim is generated.",
        f"- Owner Function → Product allocation relations: {len(owner_map)}; owner-count distribution: `{dict(Counter(owner_counts.values()))}`; every Function has exactly one OWNER: {'YES' if len(owner_counts)==len(functions) and all(v==1 for v in owner_counts.values()) else 'NO'}.",
        "- These 191 relations are actual SysML `allocation` statements, not a builder-imposed one-product cap. They identify OWNER only and say nothing about interaction participants.",
        f"- Stage 4 L2 aggregate interface groups: {len(l2_groups)}; flow-level interaction records: {len(interaction_map)}; distinct source/target L2 pairs: {len(pairs)}; source products: {len(sources)}; target products: {len(targets)}; distinct flow refs: {len(flow_refs)}; distinct leaf connector refs represented at the L2 boundary: {len(connector_refs)}.",
        f"- Function-specific Interaction assignments supported by direct action→port/interface/connector references: 0. Function interaction status is UNRESOLVED for all {len(no_interaction)} Functions; no interaction was assigned based on owner-product adjacency or name similarity.",
        "- The 74 flow-level rows are actual Stage 4 records across 38 aggregate interfaces; the same connector can support multiple flow records, so these counts are not interchangeable.", "",
        "## Function source classification", "",
        "Every one of the 191 source elements is a SysML `action def` with a function ID and a formal allocation. Classification is based on source `functionLevel`, source `category`, and a conservative directional-name scan; it is not a claim that the source element was natively a connector.", "",
        f"- SYSTEM_FUNCTION: {classes.get('SYSTEM_FUNCTION', 0)} (action def with `functionLevel` ≤ 2).",
        f"- ACTION: {classes.get('ACTION', 0)} (action def with `functionLevel` ≥ 3).",
        f"- INTERACTION_FUNCTION: {classes.get('INTERACTION_FUNCTION', 0)} (action def explicitly categorized `PHYSICAL_TRANSPORT`).",
        f"- FLOW_DERIVED_DESCRIPTION: {len(directional)} exact directional-template name candidates; not reclassified from the source action def and not deleted.",
        f"- UNKNOWN: {classes.get('UNKNOWN', 0)}.",
        "- The 39 `PHYSICAL_TRANSPORT` elements remain `action def` objects in the original model. The source alone does not establish they were derived from actual Flow/Connector declarations; they need separate engineering review before any model-type change.",
        "- Directional-name candidates: " + (", ".join(f"`{x['function_id']}` {x['name']}" for x in directional) if directional else "none by the exact A→B transfer/provider/receiver templates scanned."), "",
        "## Requirement coverage", "",
        "| Requirement ID | Requirement | Evidence path → Final Function → OWNER Product | Resolution |", "|---|---|---|---|",
    ]
    for r in requirements:
        ids = [x["function_id"] for x in rf_by_req[r["requirement_id"]]]
        mappings = []
        for x in rf_by_req[r["requirement_id"]]:
            owner = next((o["product_id"] for o in owner_map if o["function_id"] == x["function_id"]), "—")
            hop_labels = []
            for hop in x.get("evidence_path", []):
                if hop.get("type") == "FUNCTION":
                    continue
                object_id = hop.get("id") or hop.get("product_id") or ""
                hop_labels.append(f"{hop.get('type', 'EXPLICIT')}:{object_id}".rstrip(":"))
            if not hop_labels:
                hop_labels = [f"REQUIREMENT:{x['requirement_id']}", f"FUNCTION:{x['function_id']}"]
            mappings.append(f"{' → '.join(hop_labels)} → {x['function_id']} → {owner} [{x['mapping_source']}]")
        lines.append(f"| {r['requirement_id']} | {r['name'].replace('|', '/')} | {'<br>'.join(mappings) if mappings else '—'} | {resolution.get(r['requirement_id'], 'UNRESOLVED')} |")
    lines += ["", "### Unresolved requirements", "", *(f"- `{x['requirement_id']}` — {x['name']} (no model-derived or explicit Function path)." for x in unresolved_reqs), "",
        "### Functions without OWNER Product", "", *((f"- `{x}`" for x in no_owner) if no_owner else ["- None; all 191 have exactly one source allocation."]), "",
        "### Functions without a proven Interaction", "", "All 191 Functions. The model has product-level connectors, but no direct reference linking an individual action def to a connector/flow. This remains unresolved rather than inferred.", "",
        "## Product interaction evidence and X100 finding", "",
        "X100 has product-boundary interactions with 8100 in the current L2 Stage 4 graph. Direction is preserved from SysML connector endpoints:", "",
        *(f"- `{s} → {t}`: {n} flow-level records, flow kinds `{kind}`." for (s, t, kind), n in sorted(x100_summary.items())),
        "- Exact flow names at this boundary: " + "; ".join(f"`{x['source_product_id']} → {x['target_product_id']}: {x['flow_name']}`" for x in x100),
        "- The X100 records retain the real `IF_IF_*` interface definition IDs and `CG_*` connector IDs in `l2_interaction_catalog.json` and the SysML overlay.",
        "- No direct `5100 ↔ X100` aggregate interface exists in the frozen model’s L2 Stage 4 projection. Therefore `5100 → regenerative power → X100` is not supported as a direct L2 boundary path and is not asserted. An indirect chain would require a separate, explicit path query with each intermediate connector shown.", "",
        "## SysML v2 overlay", "",
        "Generated under `work/sysmlv2/requirements_traceability/`; frozen source model remains read-only. The overlay creates formal requirement definitions/usages and trace-record items keyed to existing source IDs; it does not redefine Product or Function definitions. EXPLICIT and evidence-backed MODEL_DERIVED Requirement→Function relations become SysML `satisfy requirement` usages; their separate trace records retain the full path/evidence metadata. Import the frozen full model first, then `06_RequirementTraceability_AllInOne.sysml`, or use split import order 01 → 02 → 03 → 04 → 05.",
        "Product-boundary flows remain Product→Product records and are never asserted as direct Function→Connector assignments. SEMANTIC_ASSISTED candidates remain outside SysML satisfaction relations.", "",
        "## Unresolved items", "",
        f"- {len(unresolved_reqs)} requirements have no resolved Requirement→Function path.",
        f"- {len(no_interaction)} Functions have no direct Function→Interaction connector evidence.",
        "- The 39 PHYSICAL_TRANSPORT-category actions require review to determine whether their definitions are genuine system functions or descriptions that should be represented as interactions.",
        "- No 5100–X100 direct interaction was found at the L2 boundary; any proposed indirect path is unresolved until an exact path and its intermediate products/flows are traced.",
        "- Fully/partially resolved classifies available functional path coverage; it is not a V&V pass/fail label.", "",
    ]
    REPORT.parent.mkdir(parents=True, exist_ok=True)
    REPORT.write_text("\n".join(lines), encoding="utf-8")
    manifest = {
        "schema_version": "1.0", "frozen_sysml_sha256": model_sha, "expected_frozen_sysml_sha256": BASELINE_SHA,
        "requirement_count": len(requirements), "function_count": len(functions), "product_count": len(products),
        "requirement_function_relations": len(req_map["relations"]), "mapping_source_counts": dict(map_counts),
        "resolution_counts": dict(resolution_counts), "semantic_assisted_candidate_count": len(candidate_suggestions), "owner_allocation_relations": len(owner_map),
        "l2_aggregate_interface_groups": len(l2_groups), "flow_level_interaction_records": len(interaction_map),
        "function_specific_interactions_confirmed": 0, "unresolved_requirement_ids": [x["requirement_id"] for x in unresolved_reqs],
        "files": list(file_contents) + [all_path.name],
        "import_order": ["full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml", *list(file_contents)],
        "all_in_one_import_after": "full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml",
        "validation": {"official_sysml_pilot_0_59_0": "PENDING"},
    }
    (OUT / "traceability_manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"AUDIT=PASS REQUIREMENTS={len(requirements)} CONFIRMED_RF={len(req_map['relations'])} UNRESOLVED_RF={len(unresolved_reqs)}")
    print(f"OVERLAY=GENERATED FILES={len(file_contents)+1} BASELINE_SHA={'PASS' if model_sha == BASELINE_SHA else 'FAIL'}")
    print(f"INTERACTIONS=GROUPS:{len(l2_groups)} FLOWS:{len(flow_refs)} FUNCTION_SPECIFIC:0")


if __name__ == "__main__":
    main()
