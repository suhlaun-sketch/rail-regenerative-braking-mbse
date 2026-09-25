"""Resolve all formal product/port/interface/connection objects against live SysON."""
from __future__ import annotations

import json
import re
from collections import Counter
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from tools.syson_automation.src.syson_client import SysONClient

ROOT = Path(__file__).resolve().parents[3]
CACHE = ROOT / "tools/syson_automation/cache/full_final_element_index.json"
STATE = ROOT / "tools/syson_automation/cache/full_final_project.json"
HIERARCHY = ROOT / "work/reports/FULL_PRODUCT_HIERARCHY.json"
TRACE = ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary/FULL_PORT_TRACEABILITY.json"
MODEL = TRACE.parent / "Rail_MBSE_Full_v3_FullBoundary.sysml"


def main() -> None:
    state = json.loads(STATE.read_text(encoding="utf-8"))
    data = json.loads(CACHE.read_text(encoding="utf-8"))
    hierarchy = json.loads(HIERARCHY.read_text(encoding="utf-8"))
    trace = json.loads(TRACE.read_text(encoding="utf-8"))
    text = MODEL.read_text(encoding="utf-8")
    names: dict[str, str] = {}
    for product in hierarchy["products"]:
        names[product["usage_id"]] = "PartUsage"
        names[product["definition_id"]] = "PartDefinition"
    for port in trace["port_usages"]:
        names[port["port_id"]] = "PortUsage"
    for connection in trace["connection_usages"]:
        names[connection["connection_id"]] = "ConnectionUsage"
    for kind, sysml_type in (("port", "PortUsage"), ("interface", "InterfaceUsage"),
                             ("connection", "ConnectionUsage")):
        for name in re.findall(r"(?m)^\s*" + kind + r"\s+([A-Za-z][A-Za-z0-9_]*)\b", text):
            names[name] = sysml_type
    names.pop("def", None)
    existing = {(x["label"], x["sysml_type"]) for x in data["entries"]}
    todo = [(name, kind) for name, kind in names.items() if (name, kind) not in existing]
    ctx = state["editing_context_id"]

    def resolve(item: tuple[str, str]) -> tuple[str, str, list[dict]]:
        name, kind = item
        client = SysONClient(timeout=90)
        matches = [x for x in client.search(ctx, name)
                   if x["label"] == name and x["kind"].endswith("entity=" + kind)]
        return name, kind, matches

    found, missing, ambiguous = [], [], []
    with ThreadPoolExecutor(max_workers=5) as pool:
        for future in as_completed([pool.submit(resolve, x) for x in todo]):
            name, kind, matches = future.result()
            if len(matches) == 1:
                found.append((name, kind, matches[0]))
            elif not matches:
                missing.append((name, kind))
            else:
                ambiguous.append((name, kind, len(matches)))
    port_by_name = {x["port_id"]: x for x in trace["port_usages"]}
    conn_by_name = {x["connection_id"]: x for x in trace["connection_usages"]}
    for name, kind, match in found:
        props = port_by_name.get(name) or conn_by_name.get(name) or {}
        data["entries"].append({"semantic_id": name, "label": name, "sysml_type": kind,
                                "syson_object_id": match["id"], "qualified_name": name,
                                "parent_object_id": None, "source_model": MODEL.name,
                                "properties": props})
        data["by_semantic_id"].setdefault(name, []).append(match["id"])
    data["resolution"] = {"requested": len(names), "new_found": len(found),
                          "missing": missing, "ambiguous": ambiguous,
                          "type_counts": dict(Counter(x["sysml_type"] for x in data["entries"]))}
    CACHE.write_text(json.dumps(data, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"FINAL_INDEX={len(data['entries'])} NEW={len(found)} MISSING={len(missing)} AMBIGUOUS={len(ambiguous)}")
    if missing or ambiguous:
        print("ERROR_SAMPLES", (missing + ambiguous)[:8])


if __name__ == "__main__":
    main()
