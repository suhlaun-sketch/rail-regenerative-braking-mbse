"""Generate a Port-enhanced copy from explicit X100/8100 connector evidence."""
from __future__ import annotations

import hashlib
import json
import re
import xml.etree.ElementTree as ET
from collections import defaultdict
from pathlib import Path

from audit_port_gaps import MODEL, ROOT, SSD, BINDING, build_audit

OUT = ROOT / "work/sysmlv2/full_engineering_model/02_port_enhanced"
TARGET = OUT / "Rail_MBSE_Full_v2_PortEnhanced.sysml"
TRACE = OUT / "PORT_TRACEABILITY.json"
ORIGINAL_HASH = "a15cf7170dc5458738080a146c391e438fe57b85f9687857f34a081b8efdf0d5"


def _owner_path(product: str) -> str:
    if product == "X100":
        return "p_X000.p_X100"
    if product == "8100":
        return "p_N_8000.p_N_8100"
    return "p_X000.p_X100.p_" + product


def main() -> None:
    if hashlib.sha256(MODEL.read_bytes()).hexdigest() != ORIGINAL_HASH:
        raise RuntimeError("Frozen v1 hash mismatch")
    source = MODEL.read_text(encoding="utf-8")
    audit = build_audit()
    ssd_connections = [x.attrib for x in ET.parse(SSD).getroot().iter()
                       if x.tag.rsplit("}", 1)[-1] == "Connection"]
    binding_connections = {x["connection_id"] for x in json.loads(BINDING.read_text(encoding="utf-8"))["structural_connections"]}
    links = audit["x100_8100_connections"]
    if len(links) != 12:
        raise RuntimeError(f"Expected 12 explicit X100/8100 leaf connectors, found {len(links)}")
    inserts = defaultdict(list)
    trace_ports = []
    trace_connections = []
    for link in links:
        connector = link["connector_ref"]
        interface = link["interface_ref"]
        port_definition = interface.replace("IF_IF_", "PT_PT_", 1)
        if f"port def {port_definition} " not in source:
            raise RuntimeError(f"No real port type for {interface}")
        short = connector.removeprefix("CG_")[:12].lower()
        ssd_matches = [x for x in ssd_connections if
                       (link["source_element_id"] in x.get("startConnector", "") and
                        link["target_element_id"] in x.get("endConnector", "")) or
                       (link["target_element_id"] in x.get("startConnector", "") and
                        link["source_element_id"] in x.get("endConnector", ""))]
        if len(ssd_matches) != 1 or connector not in binding_connections:
            raise RuntimeError(f"SSD/binding cross-L2 evidence missing or ambiguous for {connector}")
        ssd_ref = (ssd_matches[0]["startElement"] + "." + ssd_matches[0]["startConnector"] + " -> " +
                   ssd_matches[0]["endElement"] + "." + ssd_matches[0]["endConnector"])
        boundary = {}
        for product in ("X100", "8100"):
            outgoing = (link["source_product_id"].startswith("X") == (product == "X100"))
            name = f"bp_{product}_{short}"
            typed = port_definition if outgoing else "~" + port_definition
            inserts[product].append(f"        port {name} : {typed} {{\n"
                                    f"            attribute sourceConnectorId : String = \"{connector}\";\n"
                                    f"            attribute interfaceRef : String = \"{interface}\";\n"
                                    f"            attribute direction : String = \"{'out' if outgoing else 'in'}\";\n"
                                    f"        }}")
            boundary[product] = name
            trace_ports.append({"port_id": name, "port_name": name, "owner_product": product,
                                "owner_part_usage": _owner_path(product),
                                "direction": "out" if outgoing else "in",
                                "interface_group": interface, "interface_type": port_definition,
                                "external_neighbor": "8100" if product == "X100" else "X100",
                                "flow_refs": ["flow::" + connector], "connector_refs": [connector],
                                "interface_refs": [interface], "ssd_refs": [ssd_ref], "binding_refs": [connector],
                                "derived_from": "EXPLICIT_CONNECTOR", "confidence": 1.0})
        xport = _owner_path("X100") + "." + boundary["X100"]
        nport = _owner_path("8100") + "." + boundary["8100"]
        source_leaf, target_leaf = link["source_path"], link["target_path"]
        source_boundary, target_boundary = (xport, nport) if link["source_product_id"].startswith("X") else (nport, xport)
        for suffix, a, b in (("inner", source_leaf, source_boundary),
                             ("outer", source_boundary, target_boundary),
                             ("receive", target_boundary, target_leaf)):
            name = f"pc_{short}_{suffix}"
            trace_connections.append({"connection_id": name, "source_path": a, "target_path": b,
                                      "derived_from_connector_id": connector,
                                      "derived_from_flow_refs": ["flow::" + connector],
                                      "replaces_or_refines": connector,
                                      "evidence_type": "DERIVED_BOUNDARY"})
    parents = audit["product_parent"]
    def child_branch(code: str) -> str | None:
        while code and parents.get(code) != "X100":
            code = parents.get(code)
        return code
    internal = []
    for link in audit["interface_connections"]:
        source_child = child_branch(link["source_product_id"])
        target_child = child_branch(link["target_product_id"])
        if source_child and target_child and source_child != target_child:
            internal.append((link, source_child, target_child))
    if len(internal) != 9:
        raise RuntimeError(f"Expected 9 explicit X100 internal connectors, found {len(internal)}")
    for link, source_child, target_child in internal:
        connector, interface = link["connector_ref"], link["interface_ref"]
        port_definition = interface.replace("IF_IF_", "PT_PT_", 1)
        short = connector.removeprefix("CG_")[:12].lower()
        boundary = {}
        for product, outgoing, neighbor in ((source_child, True, target_child),
                                            (target_child, False, source_child)):
            name = f"bp_{product}_{short}"
            typed = port_definition if outgoing else "~" + port_definition
            inserts[product].append(f"        port {name} : {typed} {{\n"
                                    f"            attribute sourceConnectorId : String = \"{connector}\";\n"
                                    f"            attribute interfaceRef : String = \"{interface}\";\n"
                                    f"            attribute direction : String = \"{'out' if outgoing else 'in'}\";\n"
                                    f"        }}")
            boundary[product] = name
            trace_ports.append({"port_id": name, "port_name": name, "owner_product": product,
                                "owner_part_usage": _owner_path(product),
                                "direction": "out" if outgoing else "in",
                                "interface_group": interface, "interface_type": port_definition,
                                "external_neighbor": neighbor, "flow_refs": ["flow::" + connector],
                                "connector_refs": [connector], "interface_refs": [interface],
                                "ssd_refs": [], "binding_refs": [],
                                "derived_from": "EXPLICIT_CONNECTOR", "confidence": 1.0})
        a = _owner_path(source_child) + "." + boundary[source_child]
        b = _owner_path(target_child) + "." + boundary[target_child]
        for suffix, start, end in (("inner", link["source_path"], a),
                                   ("internal", a, b),
                                   ("receive", b, link["target_path"])):
            trace_connections.append({"connection_id": f"pc_{short}_{suffix}",
                                      "source_path": start, "target_path": end,
                                      "derived_from_connector_id": connector,
                                      "derived_from_flow_refs": ["flow::" + connector],
                                      "replaces_or_refines": connector,
                                      "evidence_type": "DERIVED_BOUNDARY"})
    for product in ("X100", "8100", "X110", "X120", "X130"):
        if not inserts[product]:
            continue
        definition = "P_N_8100" if product == "8100" else "P_" + product
        needle = f"    part def {definition} {{"
        if source.count(needle) != 1:
            raise RuntimeError(f"Definition {definition} not unique")
        source = source.replace(needle, needle + "\n" + "\n".join(inserts[product]), 1)
    needle = "    part railSystem : RailSystemContext {"
    if source.count(needle) != 1:
        raise RuntimeError("SystemDefinition root not unique")
    relations = "\n".join(f"        connection {c['connection_id']} connect {c['source_path']} to {c['target_path']};"
                          for c in trace_connections)
    source = source.replace(needle, needle + "\n" + relations, 1)
    OUT.mkdir(parents=True, exist_ok=True)
    TARGET.write_text(source, encoding="utf-8")
    TRACE.write_text(json.dumps({"source_sha256": ORIGINAL_HASH,
                                 "target_sha256": hashlib.sha256(TARGET.read_bytes()).hexdigest(),
                                 "port_usages": trace_ports,
                                 "connection_usages": trace_connections,
                                 "scope": "Explicit X100/8100 leaf interface connectors only"},
                                ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"PORT_ENHANCED_V2=GENERATED PORTS={len(trace_ports)} CONNECTIONS={len(trace_connections)}")


if __name__ == "__main__":
    main()
