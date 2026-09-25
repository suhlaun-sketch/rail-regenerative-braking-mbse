from __future__ import annotations

import hashlib
import json
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))

from tools.syson_automation.src.explorer_client import ExplorerClient, flatten_tree
from tools.syson_automation.src.syson_client import SysONClient

CACHE = ROOT / "tools/syson_automation/cache/current_element_index.json"
REPORT = ROOT / "tools/syson_automation/generated/reports/SYSON_ELEMENT_INDEX_REPORT.md"
PROJECT = ROOT / "tools/syson_automation/cache/current_project.json"
FROZEN = ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
REQUIREMENTS_SOURCE = ROOT / "work/sysmlv2/requirements_traceability_v2/06_RequirementTraceability_AllInOne_v2.sysml"


def _children(rows: list[dict], parent_id: str) -> list[dict]:
    return [r for r in rows if r["parent_object_id"] == parent_id]


def _expand(client: ExplorerClient, ids: list[str]) -> list[dict]:
    return flatten_tree(client.tree(ids))


def build_index(force: bool = False, *, project_path: Path = PROJECT, cache_path: Path = CACHE,
                model_path: Path = FROZEN, deep_products: tuple[str, ...] = ()) -> dict:
    project = json.loads(project_path.read_text(encoding="utf-8"))
    gql = SysONClient(timeout=15)
    live = gql.execute("query{viewer{projects(first:100){edges{node{id name currentEditingContext{id}}}}}}")
    matches = [x["node"] for x in live["viewer"]["projects"]["edges"]
               if x["node"]["name"] == project["project_name"]]
    if len(matches) != 1:
        raise RuntimeError("Current SysON project is not uniquely available")
    actual = matches[0]
    live_context = actual["currentEditingContext"]["id"]
    if project["project_id"] != actual["id"] or project["editing_context_id"] != live_context:
        project["project_id"], project["editing_context_id"] = actual["id"], live_context
        project_path.write_text(json.dumps(project, ensure_ascii=False, indent=2), encoding="utf-8")
    fingerprint = hashlib.sha256(model_path.read_bytes() + REQUIREMENTS_SOURCE.read_bytes()).hexdigest()
    if cache_path.is_file() and not force:
        cached = json.loads(cache_path.read_text(encoding="utf-8"))
        if (cached.get("project_id"), cached.get("editing_context_id"), cached.get("model_fingerprint")) == (
                project["project_id"], project["editing_context_id"], fingerprint):
            return cached

    query = "query($id:ID!){viewer{editingContext(editingContextId:$id){explorerDescriptions{id label}}}}"
    descriptions = gql.execute(query, {"id": project["editing_context_id"]})["viewer"]["editingContext"]["explorerDescriptions"]
    description = next(d for d in descriptions if d["label"] == "SysON Explorer")
    explorer = ExplorerClient(project["editing_context_id"], description["id"], timeout=60)
    roots = _expand(explorer, [])
    entries: dict[str, dict] = {}

    def collect(rows: list[dict], document: str) -> None:
        for row in rows:
            if row["kind"].startswith("siriusComponents://semantic?"):
                entry = {"semantic_id": row["label"], "label": row["label"],
                         "sysml_type": row["kind"].split("entity=")[-1], "syson_object_id": row["id"],
                         "qualified_name": row["qualified_name"], "parent_object_id": row["parent_object_id"],
                         "source_model": document, "properties": {}}
                entries[row["id"]] = entry

    def document_packages(document_name: str) -> tuple[list[str], list[dict], dict[str, dict]]:
        doc = next(r for r in roots if r["label"] == document_name)
        expanded = [doc["id"]]
        rows = _expand(explorer, expanded)
        namespace = next(r for r in _children(rows, doc["id"]) if r["label"] == "Namespace")
        expanded.append(namespace["id"])
        rows = _expand(explorer, expanded)
        memberships = [r["id"] for r in _children(rows, namespace["id"]) if r["label"] == "OwningMembership"]
        expanded.extend(memberships)
        rows = _expand(explorer, expanded)
        packages = {r["label"]: r for r in rows if r["parent_object_id"] in memberships
                    and r["kind"].endswith("entity=Package")}
        collect(rows, document_name)
        return expanded, rows, packages

    full_name = model_path.name
    base, _, packages = document_packages(full_name)
    for name in ("FunctionDefinitions", "ProductDefinitions", "PortDefinitions", "InterfaceDefinitions",
                 "FunctionAllocations", "PhysicalNetworks"):
        package = packages.get(name)
        if not package:
            continue
        expanded = base + [package["id"]]
        rows = _expand(explorer, expanded)
        wrappers = [r["id"] for r in _children(rows, package["id"]) if r["label"] == "OwningMembership"]
        rows = _expand(explorer, expanded + wrappers)
        collect(rows, full_name)
        if name == "ProductDefinitions" and deep_products:
            selected = [r for r in rows if r["label"] in deep_products and r["kind"].endswith("entity=PartDefinition")]
            for part in selected:
                part_expanded = expanded + wrappers + [part["id"]]
                part_rows = _expand(explorer, part_expanded)
                member_ids = [r["id"] for r in _children(part_rows, part["id"])
                              if r["label"] == "OwningMembership"]
                collect(_expand(explorer, part_expanded + member_ids), full_name)

    req_name = "06_RequirementTraceability_AllInOne_v2.sysml"
    base, _, packages = document_packages(req_name)
    req_package = packages.get("RequirementTraceabilityAllInOneV2")
    if req_package:
        expanded = base + [req_package["id"]]
        rows = _expand(explorer, expanded)
        wrappers = [r["id"] for r in _children(rows, req_package["id"]) if r["label"] == "OwningMembership"]
        rows = _expand(explorer, expanded + wrappers)
        collect(rows, req_name)

    # SysON Explorer elides deeply nested feature memberships in its default
    # tree. Resolve the exact, provenance-listed IDs through the live semantic
    # search API, never through a name-based product join.
    if deep_products:
        trace_path = model_path.parent / "PORT_TRACEABILITY.json"
        if trace_path.is_file():
            trace = json.loads(trace_path.read_text(encoding="utf-8"))
            port_props = {x["port_id"]: {"productCode": x["owner_product"],
                "connector_refs": x["connector_refs"], "interface_refs": x["interface_refs"],
                "direction": x["direction"]} for x in trace["port_usages"]}
            names = set(port_props) | {x["connection_id"] for x in trace["connection_usages"]}
            names |= {x["source_path"].rsplit(".", 1)[-1] for x in trace["connection_usages"]}
            names |= {x["target_path"].rsplit(".", 1)[-1] for x in trace["connection_usages"]}
            for label in sorted(names):
                for match in gql.search(project["editing_context_id"], label):
                    if match["id"] in entries or match["label"] != label:
                        continue
                    entries[match["id"]] = {"semantic_id": label, "label": label,
                        "sysml_type": match["kind"].split("entity=")[-1],
                        "syson_object_id": match["id"], "qualified_name": label,
                        "parent_object_id": None, "source_model": full_name,
                        "properties": port_props.get(label, {})}

    by_semantic: dict[str, list[str]] = {}
    for entry in entries.values():
        label = entry["label"]
        if label == "OwningMembership" or not label:
            continue
        by_semantic.setdefault(label, []).append(entry["syson_object_id"])
    # Join aliases using explicit identifiers in the frozen source catalogs.
    # Similar-looking labels alone do not establish product or requirement identity.
    from ui.backend.app.services.model_graph_service import ModelGraphService
    graph = ModelGraphService(ROOT).get_full_model_graph()
    for node in graph["nodes"]:
        data = node["data"]
        code, sysml_id = data.get("code"), data.get("sysml_id")
        if code and sysml_id and sysml_id in by_semantic:
            by_semantic[code] = list(by_semantic[sysml_id])
    req_text = REQUIREMENTS_SOURCE.read_text(encoding="utf-8")
    for match in re.finditer(r'requirement\s+(req_[A-Za-z0-9_]+)\s*:[^{]+\{\s*attribute\s+:>>\s+requirementID\s*=\s*"([^"]+)"', req_text):
        label, formal_id = match.groups()
        if label in by_semantic:
            by_semantic[formal_id] = list(by_semantic[label])
            for entry in entries.values():
                if entry["label"] == label:
                    entry["properties"]["requirementID"] = formal_id
    function_text = model_path.read_text(encoding="utf-8")
    for match in re.finditer(r'part\s+def\s+(P_[A-Za-z0-9_]+)\s*\{\s*attribute\s+productCode\s*:\s*String\s*=\s*"([^"]+)"', function_text):
        label, code = match.groups()
        if label in by_semantic:
            by_semantic[code] = list(by_semantic[label])
            for entry in entries.values():
                if entry["label"] == label:
                    entry["properties"]["productCode"] = code
    for match in re.finditer(r'action\s+def\s+(FN_F_[A-Za-z0-9_]+)\s*\{([^}]+)\}', function_text):
        label, body = match.groups()
        if label not in by_semantic:
            continue
        attributes = dict(re.findall(r'attribute\s+(\w+)\s*:\s*\w+\s*=\s*"([^"]*)"', body))
        for entry in entries.values():
            if entry["label"] == label:
                entry["properties"].update({k: attributes[k] for k in ("functionId", "chineseName", "englishName", "category", "allocatedProductCode") if k in attributes})

    if deep_products:
        trace_path = model_path.parent / "PORT_TRACEABILITY.json"
        if trace_path.is_file():
            traces = json.loads(trace_path.read_text(encoding="utf-8"))["port_usages"]
            for port in traces:
                for entry in entries.values():
                    if entry["sysml_type"] == "PortUsage" and entry["label"] == port["port_id"]:
                        entry["properties"].update({"productCode": port["owner_product"],
                            "connector_refs": port["connector_refs"], "interface_refs": port["interface_refs"],
                            "direction": port["direction"]})

    result = {"project_id": project["project_id"], "editing_context_id": project["editing_context_id"],
              "generated_at": datetime.now(timezone.utc).isoformat(), "model_fingerprint": fingerprint,
              "explorer_description_id": description["id"], "entries": list(entries.values()),
              "by_semantic_id": by_semantic}
    cache_path.parent.mkdir(parents=True, exist_ok=True)
    cache_path.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
    return result


def main() -> None:
    active_path = ROOT / "tools/syson_automation/cache/active_target.json"
    report_path = REPORT
    if active_path.is_file():
        config = json.loads(active_path.read_text(encoding="utf-8"))
        result = build_index("--force" in sys.argv,
            project_path=ROOT / config["project_path"], cache_path=ROOT / config["index_path"],
            model_path=ROOT / config["model_path"],
            deep_products=("P_X100", "P_N_8100", "P_X110", "P_X120", "P_X130", "P_X112", "P_N_8122"))
        report_path = ROOT / "tools/syson_automation/generated/reports/SYSON_PORT_ENHANCED_ELEMENT_INDEX_REPORT.md"
    else:
        result = build_index("--force" in sys.argv)
    types: dict[str, int] = {}
    for entry in result["entries"]:
        types[entry["sysml_type"]] = types.get(entry["sysml_type"], 0) + 1
    targets = ["FN_F_3110_01", "FN_F_X100_01", "REQ-BRK-007", "req_REQ_BRK_007", "X100", "X110", "X111", "X112", "X121", "X123", "7211", "5311"]
    lines = ["# SysON Element Index", "", f"- Entries: {len(result['entries'])}",
             f"- Project: `{result['project_id']}`", f"- EditingContext: `{result['editing_context_id']}`",
             f"- Model fingerprint: `{result['model_fingerprint']}`", "",
             "## Element types", ""]
    lines += [f"- {key}: {value}" for key, value in sorted(types.items())]
    lines += ["", "## Required resolution targets", "", "| Semantic ID | SysON object ID | Type |", "|---|---|---|"]
    for target in targets:
        ids = result["by_semantic_id"].get(target, [])
        matched = [e for e in result["entries"] if e["syson_object_id"] in ids]
        lines.append(f"| {target} | {', '.join(ids) or 'NOT_FOUND'} | {', '.join(e['sysml_type'] for e in matched) or '-'} |")
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(json.dumps({"index_size": len(result["entries"]), "type_counts": types,
                      "targets": {target: result["by_semantic_id"].get(target, []) for target in targets}}, ensure_ascii=False))


if __name__ == "__main__":
    main()
