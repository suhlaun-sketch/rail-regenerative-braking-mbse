"""Build a full, evidence-backed container-port refinement of frozen SysML v1."""
from __future__ import annotations

import hashlib
import json
import re
from collections import defaultdict
from pathlib import Path

from tools.syson_automation.scripts.audit_port_gaps import MODEL, _blocks
from tools.syson_automation.scripts.build_full_product_hierarchy import build_hierarchy

ROOT = Path(__file__).resolve().parents[3]
OUT = ROOT / "work/sysmlv2/full_engineering_model/03_full_boundary"
TARGET = OUT / "Rail_MBSE_Full_v3_FullBoundary.sysml"
TRACE = OUT / "FULL_PORT_TRACEABILITY.json"
FROZEN_HASH = "a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5"
INTERFACE = re.compile(r"^\s*interface\s+(c_CG_[A-F0-9]+)\s*:\s*(IF_\w+)\s+connect\s+(\S+)\s+to\s+(\S+)\s*\{")


def _product_code(path: str) -> str | None:
    names = re.findall(r"(?:^|\.)p_(?:N_)?([A-Z0-9]+)", path)
    return names[-1] if names else None


def _boundary_name(path: str) -> str | None:
    m = re.match(r"boundary_(BOUNDARY_[A-Z0-9_]+)\.", path)
    return m.group(1) if m else None


def _port_direction(block: str, port_name: str) -> str:
    m = re.search(r"\bport\s+" + re.escape(port_name) + r"\s*:\s*[^\n]+\{([^}]*)\}", block)
    if not m:
        raise ValueError(f"Leaf port {port_name} not found")
    direction = re.search(r'attribute direction\s*:\s*String\s*=\s*"([^"]+)"', m.group(1))
    if not direction:
        raise ValueError(f"Leaf port {port_name} lacks direction")
    mapping = {"输出": "out", "输入": "in", "双向物理": "inout"}
    if direction.group(1) not in mapping:
        raise ValueError(f"Unsupported direction {direction.group(1)}")
    return mapping[direction.group(1)]


def build() -> dict:
    if hashlib.sha256(MODEL.read_bytes()).hexdigest() != FROZEN_HASH:
        raise ValueError("Frozen v1 hash mismatch")
    hierarchy = build_hierarchy()
    products = {x["product_code"]: x for x in hierarchy["products"]}
    source = MODEL.read_text(encoding="utf-8")
    blocks = _blocks(source)
    connections = []
    for line in source.splitlines():
        m = INTERFACE.match(line)
        if m:
            name, interface, source_path, target_path = m.groups()
            connections.append({"connector_ref": name.removeprefix("c_"), "interface_ref": interface,
                                "source_path": source_path, "target_path": target_path,
                                "source_product": _product_code(source_path),
                                "target_product": _product_code(target_path),
                                "source_boundary": _boundary_name(source_path),
                                "target_boundary": _boundary_name(target_path)})
    if len(connections) != 184:
        raise ValueError(f"Expected 184 explicit interface usages; found {len(connections)}")
    grouped = defaultdict(lambda: {"connector_refs": set(), "flow_refs": set(), "interface_refs": set(),
                                  "leaf_endpoint_refs": set()})
    route = {}
    for link in connections:
        cid = link["connector_ref"]
        paths = []
        for side in ("source", "target"):
            code = link[f"{side}_product"]
            if code:
                if code not in products:
                    raise ValueError(f"Unknown product endpoint {code}")
                path = products[code]["hierarchy_path"]
                definition = products[code]["definition_id"]
                direction = _port_direction(blocks[definition], link[f"{side}_path"].rsplit(".", 1)[-1])
            elif link[f"{side}_boundary"]:
                path, direction = [], "inout"
            else:
                raise ValueError(f"Unresolvable endpoint {link[f'{side}_path']}")
            paths.append((path, direction))
        source_path, target_path = paths[0][0], paths[1][0]
        common = 0
        while common < min(len(source_path), len(target_path)) and source_path[common] == target_path[common]:
            common += 1
        if common == len(source_path) == len(target_path) and source_path:
            route[cid] = {"source_chain": [], "target_chain": []}
            continue
        chains = []
        for side, own_path, other_path, direction in (("source", *paths[0][:1], target_path, paths[0][1]),
                                                      ("target", *paths[1][:1], source_path, paths[1][1])):
            chain = []
            for code in reversed(own_path[common:-1]):
                owner = products[code]
                level = owner["level"]
                neighbor = (other_path[level - 1] if len(other_path) >= level else
                            other_path[-1] if other_path else
                            link[f"{'target' if side == 'source' else 'source'}_boundary"])
                if not neighbor or neighbor == code:
                    raise ValueError(f"Invalid peer projection for {cid} at {code}")
                key = (code, neighbor, link["interface_ref"], direction)
                item = grouped[key]
                item["connector_refs"].add(cid)
                item["flow_refs"].add("flow::" + cid)
                item["interface_refs"].add(link["interface_ref"])
                item["leaf_endpoint_refs"].add(link[f"{side}_path"])
                chain.append(key)
            chains.append(chain)
        route[cid] = {"source_chain": chains[0], "target_chain": chains[1]}

    ports = []
    by_key = {}
    inserts = defaultdict(list)
    for key in sorted(grouped):
        owner, neighbor, interface, direction = key
        digest = hashlib.sha1("|".join(key).encode("utf-8")).hexdigest()[:12]
        port_id = f"bp_{owner}_{digest}"
        port_type = interface.replace("IF_IF_", "PT_PT_", 1)
        if f"port def {port_type} " not in source:
            raise ValueError(f"Missing real PortDefinition {port_type}")
        typed = "~" + port_type if direction == "in" else port_type
        refs = grouped[key]
        connector_refs = sorted(refs["connector_refs"])
        inserts[owner].append(f"        port {port_id} : {typed} {{\n"
                              f"            attribute sourceConnectorIds : String = \"{';'.join(connector_refs)}\";\n"
                              f"            attribute interfaceRef : String = \"{interface}\";\n"
                              f"            attribute direction : String = \"{direction}\";\n"
                              f"        }}")
        record = {"owner_product": owner, "owner_object_id": None, "port_id": port_id,
                  "port_name": port_id, "port_type": port_type, "direction": direction,
                  "interface_ref": interface, "flow_refs": sorted(refs["flow_refs"]),
                  "connector_refs": connector_refs, "neighbor_product": neighbor,
                  "source_evidence": sorted(refs["leaf_endpoint_refs"]),
                  "derived_from": "EXPLICIT_CONNECTOR"}
        ports.append(record)
        by_key[key] = record

    refinements = []
    for link in connections:
        cid = link["connector_ref"]
        chain = route[cid]
        src = [link["source_path"]]
        dst = [link["target_path"]]
        for key in chain["source_chain"]:
            owner = products[key[0]]
            src.append(".".join("p_" + ("N_" if code.isdigit() else "") + code
                                for code in owner["hierarchy_path"]) + "." + by_key[key]["port_id"])
        for key in chain["target_chain"]:
            owner = products[key[0]]
            dst.append(".".join("p_" + ("N_" if code.isdigit() else "") + code
                                for code in owner["hierarchy_path"]) + "." + by_key[key]["port_id"])
        path = src + list(reversed(dst))
        # A same-leaf relation already has a real source/target port and needs no projection.
        if len(path) <= 2:
            continue
        for step, (start, end) in enumerate(zip(path, path[1:]), 1):
            name = f"fc_{cid.removeprefix('CG_')[:12].lower()}_{step:02d}"
            refinements.append({"connection_id": name, "source_path": start, "target_path": end,
                                "derived_from_connector_id": cid, "interface_ref": link["interface_ref"],
                                "flow_refs": ["flow::" + cid], "evidence_type": "DERIVED_BOUNDARY"})
    if len({x["connection_id"] for x in refinements}) != len(refinements):
        raise ValueError("Duplicate refinement ID")
    for owner, snippets in inserts.items():
        definition = products[owner]["definition_id"]
        needle = f"    part def {definition} {{"
        if source.count(needle) != 1:
            raise ValueError(f"Definition {definition} not unique")
        source = source.replace(needle, needle + "\n" + "\n".join(snippets), 1)
    needle = "    part railSystem : RailSystemContext {"
    statements = "\n".join(f"        connection {x['connection_id']} connect {x['source_path']} to {x['target_path']};"
                           for x in refinements)
    source = source.replace(needle, needle + "\n" + statements, 1)
    # The new architecture may represent a parent boundary only where a real
    # leaf connector crosses it. It must not invent the forbidden L2 relation.
    for link in connections:
        a, b = link["source_product"], link["target_product"]
        if a and b:
            pa, pb = products[a]["hierarchy_path"], products[b]["hierarchy_path"]
            if len(pa) >= 2 and len(pb) >= 2 and {pa[1], pb[1]} == {"5100", "X100"}:
                raise ValueError("Frozen source contains forbidden direct 5100-X100 L2 interaction")
    OUT.mkdir(parents=True, exist_ok=True)
    TARGET.write_text(source, encoding="utf-8")
    payload = {"source_sha256": FROZEN_HASH, "target_sha256": hashlib.sha256(TARGET.read_bytes()).hexdigest(),
               "hierarchy_file": str(ROOT / "work/reports/FULL_PRODUCT_HIERARCHY.json"),
               "original_interface_usage_count": len(connections), "port_usages": ports,
               "connection_usages": refinements, "relation_routes": route}
    TRACE.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")
    return {"ports": len(ports), "refinements": len(refinements), "original_interfaces": len(connections)}


if __name__ == "__main__":
    print("FULL_BOUNDARY_MODEL=" + json.dumps(build()))
