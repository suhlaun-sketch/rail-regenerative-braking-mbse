#!/usr/bin/env python3
"""Build the executable SSD/SSP copy from the frozen executable interface."""

from __future__ import annotations

import hashlib
import json
import zipfile
from collections import Counter, defaultdict
from datetime import datetime, timezone
from pathlib import Path
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parents[4]
WORK = ROOT / "work" / "simulation" / "simulink_fmu_v2_reviewed"
BASELINE = ROOT / "work" / "simulation" / "implementation_binding" / "Rail_MBSE_Executable_FMU_Interface_v1.json"
AUTHORITATIVE_SSD = ROOT / "work" / "sysmlv2" / "ssi_integration" / "03_ssd" / "Rail_MBSE_L2_All16_v1.ssd"
FMU_DIR = WORK / "05_fmu" / "validated"
OUT = WORK / "06_ssp"
SSD = OUT / "Rail_MBSE_All16_Executable_v2.ssd"
SSP = OUT / "Rail_MBSE_All16_Executable_v2.ssp"
TRACE = OUT / "Executable_SSP_Traceability_v2.json"
VALIDATION = OUT / "Executable_SSP_Validation_v2.json"

NS_SSD = "http://ssp-standard.org/SSP1/SystemStructureDescription"
NS_SSC = "http://ssp-standard.org/SSP1/SystemStructureCommon"
NS_XSI = "http://www.w3.org/2001/XMLSchema-instance"
NS_RAIL = "urn:rail-mbse:executable-trace:v1"
ET.register_namespace("ssd", NS_SSD)
ET.register_namespace("ssc", NS_SSC)
ET.register_namespace("xsi", NS_XSI)
ET.register_namespace("rail", NS_RAIL)


def tag(ns: str, name: str) -> str:
    return f"{{{ns}}}{name}"


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, value) -> None:
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def scalar(parent, variable):
    connector = ET.SubElement(parent, tag(NS_SSD, "Connector"), {
        "name": variable["variable_name"],
        "kind": variable["fmi_causality"],
    })
    dt = variable["datatype"]
    if dt == "Float64":
        typed = ET.SubElement(connector, tag(NS_SSC, "Real"))
        if variable.get("unit"):
            typed.set("unit", variable["unit"])
    elif dt == "Int32":
        ET.SubElement(connector, tag(NS_SSC, "Integer"))
    elif dt == "Boolean":
        ET.SubElement(connector, tag(NS_SSC, "Boolean"))
    else:
        raise ValueError(f"Unsupported datatype {dt}")
    return connector


def main() -> int:
    OUT.mkdir(parents=True, exist_ok=True)
    baseline = read_json(BASELINE)
    variables = defaultdict(list)
    by_endpoint = {}
    for variable in baseline["executable_variables"]:
        component = variable["ssd_component"]
        variables[component].append(variable)
        by_endpoint[(component, variable["variable_name"])] = variable
    component_ids = [c["ssd_component"] for c in baseline["components"]]
    connections = baseline["executable_signal_connections"]

    root = ET.Element(tag(NS_SSD, "SystemStructureDescription"), {
        "version": "1.0",
        "name": "Rail_MBSE_All16_Executable_v2",
        "generationTool": "Rail MBSE executable SSP builder",
        "generationDateAndTime": datetime.now(timezone.utc).isoformat(),
        tag(NS_XSI, "schemaLocation"): f"{NS_SSD} http://ssp-standard.org/SSP/1.0/SystemStructureDescription.xsd",
    })
    system = ET.SubElement(root, tag(NS_SSD, "System"), {"name": "Rail_MBSE_All16_Executable_v2"})
    elements = ET.SubElement(system, tag(NS_SSD, "Elements"))
    for component in component_ids:
        comp = ET.SubElement(elements, tag(NS_SSD, "Component"), {
            "name": component,
            "type": "application/x-fmu-sharedlibrary",
            "source": f"resources/{component}.fmu",
        })
        conns = ET.SubElement(comp, tag(NS_SSD, "Connectors"))
        for variable in sorted(variables[component], key=lambda v: (v["fmi_causality"], v["variable_name"])):
            scalar(conns, variable)

    conn_parent = ET.SubElement(system, tag(NS_SSD, "Connections"))
    endpoint_counts = Counter()
    connection_audit = []
    invalid = []
    for connection in connections:
        source = (connection["source_component"], connection["source_variable"])
        target = (connection["target_component"], connection["target_variable"])
        source_spec = by_endpoint.get(source)
        target_spec = by_endpoint.get(target)
        issues = []
        if source_spec is None:
            issues.append("SOURCE_VARIABLE_MISSING")
        elif source_spec["fmi_causality"] != "output":
            issues.append("SOURCE_NOT_OUTPUT")
        if target_spec is None:
            issues.append("TARGET_VARIABLE_MISSING")
        elif target_spec["fmi_causality"] != "input":
            issues.append("TARGET_NOT_INPUT")
        if source_spec and target_spec:
            if source_spec["datatype"] != target_spec["datatype"]:
                issues.append("DATATYPE_MISMATCH")
            if source_spec.get("unit") != target_spec.get("unit"):
                issues.append("UNIT_MISMATCH")
        endpoint_counts[(source, target)] += 1
        attrs = {
            "startElement": source[0],
            "startConnector": source[1],
            "endElement": target[0],
            "endConnector": target[1],
        }
        ET.SubElement(conn_parent, tag(NS_SSD, "Connection"), attrs)
        row = {
            "executable_connection_id": connection["executable_connection_id"],
            "structural_connection_id": connection["structural_connection_id"],
            "source_component": source[0], "source_variable": source[1],
            "target_component": target[0], "target_variable": target[1],
            "quantity": connection.get("quantity"), "unit": connection.get("unit"),
            "datatype": connection.get("datatype"),
            "status": "PASS" if not issues else "FAIL",
            "issues": issues,
        }
        connection_audit.append(row)
        if issues:
            invalid.append(row)

    annotations = ET.SubElement(system, tag(NS_SSD, "Annotations"))
    annotation = ET.SubElement(annotations, tag(NS_SSC, "Annotation"), {"type": "rail-mbse-executable-trace-v1"})
    trace_root = ET.SubElement(annotation, tag(NS_RAIL, "ExecutableTrace"), {
        "authoritativeSSD": str(AUTHORITATIVE_SSD.relative_to(ROOT)).replace("\\", "/"),
        "executableInterface": str(BASELINE.relative_to(ROOT)).replace("\\", "/"),
        "structuralConnectors": "138",
        "executableVariables": "151",
        "structuralConnections": "74",
        "executableConnectionRecords": "87",
        "uniqueCausalPaths": str(len(endpoint_counts)),
    })
    for variable in baseline["executable_variables"]:
        v = ET.SubElement(trace_root, tag(NS_RAIL, "Variable"), {
            "component": variable["ssd_component"],
            "name": variable["variable_name"],
            "id": variable["executable_variable_id"],
        })
        for connector in variable.get("source_ssd_connectors", []):
            ET.SubElement(v, tag(NS_RAIL, "StructuralConnector"), {"ref": connector})
        for sysml in variable.get("source_sysml_elements", []):
            ET.SubElement(v, tag(NS_RAIL, "SysMLElement"), {"ref": sysml})

    ET.indent(root, space="    ")
    ET.ElementTree(root).write(SSD, encoding="utf-8", xml_declaration=True)

    # Package executable SSD and validated FMUs.  Duplicate trace-equivalent
    # records remain visible as 87 SSD Connection elements; the runtime uses a
    # Jacobi update once per unique endpoint pair and audits all 87 records.
    with zipfile.ZipFile(SSP, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=6) as zf:
        zf.write(SSD, "SystemStructure.ssd")
        for component in component_ids:
            zf.write(FMU_DIR / f"{component}.fmu", f"resources/{component}.fmu")

    traceability = {
        "artifact": "Executable SSP Traceability",
        "authority": {
            "structural_ssd": str(AUTHORITATIVE_SSD.relative_to(ROOT)).replace("\\", "/"),
            "executable_interface": str(BASELINE.relative_to(ROOT)).replace("\\", "/"),
        },
        "counts": {
            "components": len(component_ids),
            "structural_connectors": baseline["statistics"]["structural_connectors"],
            "executable_variables": len(baseline["executable_variables"]),
            "structural_connections": baseline["statistics"]["structural_connections"],
            "executable_connection_records": len(connections),
            "unique_causal_signal_paths": len(endpoint_counts),
            "trace_equivalent_duplicate_records": len(connections) - len(endpoint_counts),
        },
        "variables": [{
            "component": v["ssd_component"],
            "executable_variable": v["variable_name"],
            "executable_variable_id": v["executable_variable_id"],
            "structural_ssd_connectors": v.get("source_ssd_connectors", []),
            "sysml_elements": v.get("source_sysml_elements", []),
        } for v in baseline["executable_variables"]],
        "connections": connection_audit,
    }
    write_json(TRACE, traceability)

    with zipfile.ZipFile(SSP, "r") as zf:
        zip_bad = zf.testzip()
        names = set(zf.namelist())
        packaged_fmus = sum(f"resources/{c}.fmu" in names for c in component_ids)
        packaged_ssd_root = ET.fromstring(zf.read("SystemStructure.ssd"))
    parsed_components = len(packaged_ssd_root.findall(f".//{tag(NS_SSD, 'Component')}"))
    parsed_connectors = len(packaged_ssd_root.findall(f".//{tag(NS_SSD, 'Connector')}"))
    parsed_connections = len(packaged_ssd_root.findall(f".//{tag(NS_SSD, 'Connection')}"))
    ok = (not invalid and zip_bad is None and packaged_fmus == 16 and parsed_components == 16
          and parsed_connectors == 151 and parsed_connections == 87)
    validation = {
        "artifact": "Executable SSP Validation",
        "ssd_sha256": sha256(SSD),
        "ssp_sha256": sha256(SSP),
        "components": parsed_components,
        "executable_connectors": parsed_connectors,
        "executable_connection_records": parsed_connections,
        "unique_causal_signal_paths": len(endpoint_counts),
        "trace_equivalent_duplicate_records": len(connections) - len(endpoint_counts),
        "packaged_fmus": packaged_fmus,
        "connection_records_valid": len(connections) - len(invalid),
        "invalid_connection_records": invalid,
        "zip_crc": "PASS" if zip_bad is None else f"FAIL:{zip_bad}",
        "status": "PASS" if ok else "FAIL",
        "note": "The executable SSD/SSP is an implementation artifact. The authoritative structural SSD is unchanged.",
    }
    write_json(VALIDATION, validation)
    print(f"EXECUTABLE_SSP_COMPONENTS = {parsed_components}/16")
    print(f"EXECUTABLE_SSP_VARIABLES = {parsed_connectors}/151")
    print(f"EXECUTABLE_CONNECTIONS_VALIDATED = {len(connections) - len(invalid)}/87")
    print(f"EXECUTABLE_UNIQUE_CAUSAL_PATHS = {len(endpoint_counts)}")
    print(f"EXECUTABLE_SSP = {validation['status']}")
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
