from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / "work/sysmlv2/requirements_traceability"
SOURCE = ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
DATA = ROOT / "ui/backend/data/semantic_slice"


def load(path):
    return json.loads(path.read_text(encoding="utf-8"))


def strip_literals(text):
    text = re.sub(r'"(?:\\.|[^"\\])*"', '""', text)
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    return re.sub(r"//[^\n]*", "", text)


def braces_ok(text):
    depth = 0
    for char in strip_literals(text):
        if char == "{": depth += 1
        if char == "}":
            depth -= 1
            if depth < 0: return False
    return depth == 0


def main():
    manifest = load(OUT / "traceability_manifest.json")
    requirements = load(DATA / "requirement_catalog.json")["requirements"]
    functions = load(DATA / "function_catalog.json")["functions"]
    products = load(DATA / "product_catalog.json")["products"]
    rf = load(DATA / "requirement_function_map.json")["relations"]
    owners = load(DATA / "function_product_map.json")["relations"]
    interactions = load(DATA / "l2_interaction_catalog.json")["interactions"]
    model = SOURCE.read_text(encoding="utf-8")
    req_ids = {x["requirement_id"] for x in requirements}
    fn_ids = {x["function_id"] for x in functions}
    product_ids = {x["product_id"] for x in products}
    model_functions = {"FN_" + x for x in re.findall(r"action def\s+(FN_F_\w+)", model)}
    # Function IDs in the catalog preserve FN_F_* directly; validate exact declarations in source.
    model_functions = set(re.findall(r"action def\s+(FN_F_\w+)", model))
    model_products = set(re.findall(r"part def P_(?:N_)?([0-9A-Z]+)\s*\{", model))
    model_interfaces = set(re.findall(r"interface def\s+(IF_IF_\w+)", model))
    model_connectors = set(re.findall(r"interface\s+c_(CG_[A-F0-9]+)\s*:", model))
    files = []
    for name in manifest["files"]:
        path = OUT / name
        text = path.read_text(encoding="utf-8")
        files.append({"file": name, "exists": True, "utf8": True, "balanced_braces": braces_ok(text),
            "package_declared": bool(re.search(r"(?m)^package\s+\w+\s*\{", text)),
            "duplicate_local_declarations": len(re.findall(r"(?m)^\s*(?:item|requirement|part|action|interface|allocation)\s+(?:def\s+)?(\w+)", text)) != len(set(re.findall(r"(?m)^\s*(?:item|requirement|part|action|interface|allocation)\s+(?:def\s+)?(\w+)", text))),
            "redefines_product_or_function_definition": bool(re.search(r"(?m)^\s*(?:part|action)\s+def\s+", text))})
    satisfy_text = (OUT / "03_RequirementFunctionTrace.sysml").read_text(encoding="utf-8")
    satisfy_links = re.findall(r"satisfy requirement req_((?:REQ|PRJ)_[A-Za-z0-9_]+)\s*:\s*RailRequirement by fn_(FN_F_[A-Za-z0-9_]+)", satisfy_text)
    model_derived = [x for x in rf if x.get("mapping_source") == "MODEL_DERIVED"]
    allocations = {(x["function_id"], x["product_id"]) for x in owners}
    allocation_ids = {x.get("allocation_id") for x in owners}
    flow_refs = {x["flow_ref"] for x in interactions}
    source_files_resolve = all(Path(p.split(":", 1)[0]).exists() for x in model_derived for p in x.get("source_files", []))
    path_ids_valid = all(all((h.get("type") != "PRODUCT" or h.get("id") in product_ids) and
        (h.get("type") != "INTERFACE" or h.get("id") in model_interfaces) and
        (h.get("type") != "FLOW" or (h.get("id") in flow_refs and h.get("source_product_id") in product_ids and h.get("target_product_id") in product_ids))
        for h in x.get("evidence_path", []))
        for x in model_derived)
    allocation_paths_valid = all(any(h.get("type") == "ALLOCATION" and h.get("id") in allocation_ids and
        h.get("product_id") in product_ids and (x["function_id"], h.get("product_id")) in allocations and
        x.get("evidence_path", [])[-1].get("type") == "FUNCTION" and
        x.get("evidence_path", [])[-1].get("id") == x["function_id"] for h in x.get("evidence_path", [])) for x in model_derived)
    semantic = {
        "requirements_covered": len(req_ids) == 34 and sum(1 for r in requirements if r["requirement_id"] in req_ids) == 34,
        "requirement_function_ids_resolve": all(x["requirement_id"] in req_ids and x["function_id"] in fn_ids and x["function_id"] in model_functions for x in rf),
        "owner_product_ids_resolve": all(x["function_id"] in fn_ids and x["product_id"] in product_ids and x["product_id"] in model_products for x in owners),
        "interaction_endpoints_resolve": all(x["source_product_id"] in product_ids and x["target_product_id"] in product_ids for x in interactions),
        "interaction_interface_connector_ids_resolve": all(set(x["interface_refs"]) <= model_interfaces and set(x["connector_refs"]) <= model_connectors for x in interactions),
        "mapping_sources_are_explicit_or_model_derived": all(x["mapping_source"] in {"EXPLICIT", "MODEL_DERIVED"} for x in rf),
        "model_derived_have_semantic_structural_and_source_evidence": all(x.get("semantic_evidence") and x.get("structural_evidence") and x.get("source_files") and x.get("evidence_path") for x in model_derived),
        "model_derived_source_files_exist": source_files_resolve,
        "model_derived_paths_resolve_product_ids": path_ids_valid,
        "model_derived_paths_begin_with_requirement_and_end_with_function": all(
            x.get("evidence_path", [{}])[0].get("type") == "REQUIREMENT" and
            x.get("evidence_path", [{}])[-1].get("type") == "FUNCTION" and
            x.get("evidence_path", [{}])[-1].get("id") == x["function_id"]
            for x in model_derived),
        "interface_and_flow_paths_resolve": all(all((h.get("type") != "INTERFACE" or h.get("id") in model_interfaces) and
            (h.get("type") != "FLOW" or h.get("id") in flow_refs) for h in x.get("evidence_path", [])) for x in model_derived),
        "model_derived_paths_include_real_allocations": allocation_paths_valid,
        "semantic_assisted_candidates_not_promoted": not any(x["mapping_source"] == "SEMANTIC_ASSISTED" for x in rf),
        "sysml_satisfy_links_match_explicit_map": {(r, f) for r, f in satisfy_links} == {(x["requirement_id"].replace('-', '_'), x["function_id"]) for x in rf},
        "source_hash_matches_frozen_baseline": hashlib.sha256(SOURCE.read_bytes()).hexdigest() == manifest["frozen_sysml_sha256"] == manifest["expected_frozen_sysml_sha256"],
        "baseline_then_split_file_import_order_present": len(manifest["import_order"]) == 6 and manifest["import_order"][0].endswith("Rail_MBSE_Full_v1.sysml"),
    }
    structural_pass = all(x["exists"] and x["balanced_braces"] and x["package_declared"] and
        not x["duplicate_local_declarations"] and not x["redefines_product_or_function_definition"] for x in files)
    consistency_pass = all(semantic.values())
    result = {"structural_checks": files, "semantic_consistency": semantic,
        "sysml_satisfy_usage_count": len(satisfy_links),
        "structural_consistency_status": "PASS" if structural_pass and consistency_pass else "FAIL",
        "official_sysml_pilot_0_59_0": "NOT_RUN: local kernel JAR unavailable; official SysIDE CLI rejected validation because no license key is configured"}
    (OUT / "traceability_validation.json").write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
    manifest["validation"] = {"structural_consistency": result["structural_consistency_status"],
        "official_sysml_pilot_0_59_0": "NOT_RUN_LOCAL_JAR_UNAVAILABLE"}
    (OUT / "traceability_manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
    report = ROOT / "work/reports/REQUIREMENT_FUNCTION_PRODUCT_MAPPING_AUDIT.md"
    content = report.read_text(encoding="utf-8").split("## Overlay validation", 1)[0].rstrip()
    section = ["", "## Overlay validation", "",
        f"- Per-file structural checks and source-ID semantic consistency: **{result['structural_consistency_status']}** for all {len(files)} SysML overlay files.",
        "- Official SysML v2 Pilot 0.59.0 parse/semantic validation: **NOT RUN**. The official kernel JAR is not installed locally; the available SysIDE 0.10.3 validator exits before parsing because its Modeler license key is unavailable. No syntax-validation PASS is claimed.",
        "- `traceability_validation.json` contains file-by-file structural results and ID-resolution checks.", ""]
    content += "\n".join(section)
    report.write_text(content, encoding="utf-8")
    print(f"OVERLAY_STRUCTURAL_CONSISTENCY={result['structural_consistency_status']} FILES={len(files)}")
    print("OFFICIAL_SYSML_0_59=NOT_RUN (kernel unavailable; SysIDE license missing)")
    for key, value in semantic.items(): print(f"{key.upper()}={'PASS' if value else 'FAIL'}")


if __name__ == "__main__":
    main()
