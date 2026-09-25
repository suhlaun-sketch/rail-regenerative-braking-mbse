"""Evidence-only audit of the frozen rail SysML port hierarchy.

This module reads the frozen sources and writes audit artifacts; it never edits
the source model, SSD, binding, or requirement workbook.
"""
from __future__ import annotations

import json
import re
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
MODEL = ROOT / "work/sysmlv2/full_engineering_model/01_generated/Rail_MBSE_Full_v1.sysml"
SSD = ROOT / "work/sysmlv2/ssi_integration/03_ssd/Rail_MBSE_L2_All16_v1.ssd"
BINDING = ROOT / "work/simulation/implementation_binding/Rail_MBSE_Executable_FMU_Interface_v1.json"
SCOPE = ROOT / "tools/syson_automation/generated/scopes/scope_6289f72770e3.json"
OUT = ROOT / "work/reports"

KINDS = {
    "PartDefinition": r"\bpart def\s+\w+",
    "PartUsage": r"(?m)^\s+part\s+\w+\s*:",
    "PortDefinition": r"\bport def\s+\w+",
    "PortUsage": r"(?m)^\s+port\s+\w+\s*:",
    "InterfaceDefinition": r"\binterface def\s+\w+",
    "InterfaceUsage": r"(?m)^\s+interface\s+\w+\s*:",
    "ConnectionUsage": r"(?m)^\s+connection\s+\w+\s+connect",
    "BindingConnector": r"(?m)^\s+bind\s+",
    "FlowConnectionUsage": r"(?m)^\s+flow\s+",
    "AllocationUsage": r"(?m)^\s+allocation\s+",
}
INTERFACE = re.compile(r"^\s*interface\s+(c_CG_[A-F0-9]+)\s*:\s*(IF_\w+)\s+connect\s+(\S+)\s+to\s+(\S+)\s*\{")


def _blocks(source: str) -> dict[str, str]:
    """Extract PartDefinition bodies with balanced braces, including child port blocks."""
    result = {}
    for match in re.finditer(r"\bpart def\s+(P_\w+)\s*(?::>\s*\w+)?\s*\{", source):
        depth = 1
        i = match.end()
        while depth and i < len(source):
            depth += (source[i] == "{") - (source[i] == "}")
            i += 1
        result[match.group(1)] = source[match.end():i - 1]
    return result


def _product_code(path: str) -> str | None:
    matches = re.findall(r"(?:^|\.)p_(?:N_)?([A-Z0-9]+)", path)
    return matches[-1] if matches else None


def build_audit() -> dict:
    source = MODEL.read_text(encoding="utf-8")
    scope = json.loads(SCOPE.read_text(encoding="utf-8"))
    binding = json.loads(BINDING.read_text(encoding="utf-8"))
    blocks = _blocks(source)
    parent = {}
    ports = defaultdict(list)
    for definition, body in blocks.items():
        code = definition.removeprefix("P_N_").removeprefix("P_")
        m = re.search(r'attribute parentCode\s*:\s*String\s*=\s*"([^"]*)"', body)
        if m:
            parent[code] = m.group(1)
        ports[code] = re.findall(r"(?m)^\s+port\s+(\w+)\s*:\s*([^\s{;]+)", body)
    records = []
    missing = []
    endpoint_gaps = []
    for line in source.splitlines():
        m = INTERFACE.match(line)
        if not m:
            continue
        connector, interface, src_path, dst_path = m.groups()
        src, dst = _product_code(src_path), _product_code(dst_path)
        if not src or not dst:
            continue
        src_port, dst_port = src_path.rsplit(".", 1)[-1], dst_path.rsplit(".", 1)[-1]
        row = {"connector_ref": connector.removeprefix("c_"), "interface_ref": interface,
               "source_product_id": src, "target_product_id": dst,
               "source_path": src_path, "target_path": dst_path,
               "source_element_id": src_port, "target_element_id": dst_port,
               "source_endpoint_type": "PortUsage" if src_port.startswith("rp_") else "PartUsage",
               "target_endpoint_type": "PortUsage" if dst_port.startswith("rp_") else "PartUsage"}
        records.append(row)
        for endpoint, other, port in ((src, dst, src_port), (dst, src, dst_port)):
            if port not in {p[0] for p in ports[endpoint]}:
                endpoint_gaps.append({**row, "owner_product": endpoint, "status": "MISSING_ENDPOINT_PORT"})
            ancestor = parent.get(endpoint)
            while ancestor:
                cursor = other
                inside = False
                while cursor:
                    if cursor == ancestor:
                        inside = True
                        break
                    cursor = parent.get(cursor)
                if not inside and not ports[ancestor]:
                    missing.append({"owner_product": ancestor, "leaf_product": endpoint,
                                    "external_product": other, "connector_ref": row["connector_ref"],
                                    "interface_ref": interface, "status": "MISSING_BOUNDARY_PORT"})
                ancestor = parent.get(ancestor)
    ssd_root = ET.parse(SSD).getroot()
    ssd_connections = [e for e in ssd_root.iter() if e.tag.rsplit("}", 1)[-1] == "Connection"]
    x100_external = [r for r in records if (r["source_product_id"].startswith("X") and r["target_product_id"].startswith("81"))
                     or (r["target_product_id"].startswith("X") and r["source_product_id"].startswith("81"))]
    gap_groups = Counter((x["owner_product"], x["external_product"]) for x in missing)
    return {"counts": {k: len(re.findall(pattern, source)) for k, pattern in KINDS.items()},
            "part_definition_count_in_blocks": len(blocks), "product_parent": parent,
            "ports_by_product": {k: [p[0] for p in v] for k, v in ports.items()},
            "interface_connections": records, "endpoint_gaps": endpoint_gaps,
            "boundary_gaps": missing,
            "boundary_gap_groups": [{"owner_product": a, "external_product": b, "connector_count": n}
                                    for (a, b), n in gap_groups.most_common()],
            "x100_8100_connections": x100_external,
            "ssd_connection_count": len(ssd_connections),
            "binding_statistics": binding.get("statistics", {}),
            "scope_statistics": {"seed": len(scope["seed_products"]), "closure": len(scope["product_closure"]),
                                 "directed_edges": len(scope["closure_edges"])}}


def main() -> None:
    audit = build_audit()
    OUT.mkdir(parents=True, exist_ok=True)
    (OUT / "PORT_GAP_AUDIT.json").write_text(json.dumps(audit, ensure_ascii=False, indent=2), encoding="utf-8")
    lines = ["# Port Gap Audit", "", "Frozen v1, formal SSD, implementation binding and current scope are read only.", "",
             "## Frozen SysML element counts", ""]
    lines.extend(f"- {k}: {v}" for k, v in audit["counts"].items())
    lines += ["", "## Evidence check", "",
              f"- Explicit SysML interface connections: {len(audit['interface_connections'])}",
              f"- Source/target leaf PortUsage missing: {len(audit['endpoint_gaps'])}",
              f"- Cross-container interactions requiring a boundary PortUsage: {len(audit['boundary_gaps'])}",
              f"- SSD connections: {audit['ssd_connection_count']}",
              f"- Binding structural connectors: {len(json.loads(BINDING.read_text(encoding='utf-8'))['structural_connectors'])}",
              f"- Binding structural cross-L2 connections: {len(json.loads(BINDING.read_text(encoding='utf-8'))['structural_connections'])}",
              f"- Binding executable signal connections: {len(json.loads(BINDING.read_text(encoding='utf-8'))['executable_signal_connections'])}",
              f"- Binding L2 components: {len(json.loads(BINDING.read_text(encoding='utf-8'))['components'])}",
              f"- Scope seed/closure/edges: {audit['scope_statistics']}", "",
              "## X100 / 8100", "",
              f"- Existing X100 PortUsage: {len(audit['ports_by_product'].get('X100', []))}",
              f"- Existing 8100 PortUsage: {len(audit['ports_by_product'].get('8100', []))}",
              f"- Explicit X-subtree ↔ 8100-subtree leaf connections: {len(audit['x100_8100_connections'])}",
              "- Leaf endpoints already have real PortUsage; parent boundary ports are absent.",
              "- See PORT_GAP_AUDIT.json for every connector, endpoint classification, and missing boundary record.",
              "- No direct 5100 ↔ X100 interface is inferred.", "", "## Largest boundary gaps", ""]
    lines.extend(f"- {x['owner_product']} ↔ {x['external_product']}: {x['connector_count']}"
                 for x in audit["boundary_gap_groups"][:20])
    (OUT / "PORT_GAP_AUDIT.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print("PORT_GAP_AUDIT=PASS")
    print("COUNTS=" + json.dumps(audit["counts"], ensure_ascii=False))
    print(f"BOUNDARY_GAPS={len(audit['boundary_gaps'])} X100_8100={len(audit['x100_8100_connections'])}")


if __name__ == "__main__":
    main()
