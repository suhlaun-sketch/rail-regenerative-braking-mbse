"""Run unmodified SSI_v1.0.0 validation and SSD generation for all 16 L2s."""

from __future__ import annotations

import contextlib
import importlib.util
import io
import json
import sys
import traceback
import xml.etree.ElementTree as ET
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SSI_ENTRY = ROOT / "third_party/ssi_transformer/Standard-System-Interface/source/SSI_transformer.py"
PROJECTION = ROOT / "work/sysmlv2/ssi_integration/02_projection_all16"
SSD_DIR = ROOT / "work/sysmlv2/ssi_integration/03_ssd"
LOG_DIR = ROOT / "work/sysmlv2/ssi_integration/04_logs"
SSD = SSD_DIR / "Rail_MBSE_L2_All16_v1.ssd"
MAPPING = SSD_DIR / "Rail_MBSE_L2_All16_v1_mapping.json"


def load_ssi():
    spec = importlib.util.spec_from_file_location("ssi_transformer_all16", SSI_ENTRY)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load SSI Transformer: {SSI_ENTRY}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def main() -> int:
    SSD_DIR.mkdir(parents=True, exist_ok=True)
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    stdout, stderr = io.StringIO(), io.StringIO()
    result = {
        "ssi_entry": str(SSI_ENTRY),
        "interface_input": str(PROJECTION / "interface_definition.sysml"),
        "system_input": str(PROJECTION / "system_definition.sysml"),
        "ssd": str(SSD),
        "command": f"{Path(sys.executable)} {Path(__file__).resolve()}",
        "return_code": 0,
    }
    try:
        ssi = load_ssi()
        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            interfaces = ssi.parse_interface_definitions((PROJECTION / "interface_definition.sysml").read_text(encoding="utf-8").splitlines())
            components, connections = ssi.parse_system_definitions((PROJECTION / "system_definition.sysml").read_text(encoding="utf-8").splitlines())
            errors = ssi.validate_connections(components, connections, interfaces)
            if errors:
                raise RuntimeError(json.dumps(errors, ensure_ascii=False))
            connector_kinds = {}
            for conn in connections:
                connector_kinds[f"{conn['start_element']}.{conn['start_connector']}"] = "output"
                connector_kinds[f"{conn['end_element']}.{conn['end_connector']}"] = "input"
            component_info = {
                "system_name": "Rail_MBSE_L2_All16_v1",
                "generation_tool": "Standard-System-Interface SSI_v1.0.0",
                "start_time": "0.0",
                "stop_time": "10.0",
                "components": {
                    name: {"new_name": name, "fmu_filename": f"{name}.fmu", "ports": details["ports"]}
                    for name, details in components.items()
                },
                "connections": connections,
            }
            ssi.create_ssp_file(str(SSD), components, connections, component_info, connector_kinds)

        manifest = json.loads((PROJECTION / "projection_manifest.json").read_text(encoding="utf-8"))
        tree = ET.parse(SSD)
        root = tree.getroot()
        by_local = lambda name: [element for element in root.iter() if element.tag.rsplit("}", 1)[-1] == name]
        xml_components = by_local("Component")
        xml_connectors = by_local("Connector")
        xml_connections = by_local("Connection")
        default_experiment = by_local("DefaultExperiment")[0]

        component_mapping = [
            {"rail_l2_code": row["code"], "full_sysml_path": row["full_sysml_path"], "projection_component": f"L2_{row['code']}", "ssd_component": f"L2_{row['code']}"}
            for row in manifest["l2_inventory"]
        ]
        connector_names = {
            (component.attrib["name"], connector.attrib["name"])
            for component in xml_components
            for connector in component.iter()
            if connector.tag.rsplit("}", 1)[-1] == "Connector"
        }
        port_mapping = []
        for port in manifest["promoted_port_mapping"]:
            component = f"L2_{port['l2_code']}"
            port_mapping.append({**port, "ssd_component": component, "ssd_connector": port["promoted_port"], "mapped": (component, port["promoted_port"]) in connector_names})
        connection_mapping = []
        for original, xml in zip(manifest["connection_mapping"], xml_connections):
            connection_mapping.append(
                {
                    **original,
                    "ssd_start_element": xml.attrib["startElement"],
                    "ssd_start_connector": xml.attrib["startConnector"],
                    "ssd_end_element": xml.attrib["endElement"],
                    "ssd_end_connector": xml.attrib["endConnector"],
                    "mapped": True,
                }
            )
        mapping = {"component_mapping": component_mapping, "port_mapping": port_mapping, "connection_mapping": connection_mapping}
        MAPPING.write_text(json.dumps(mapping, ensure_ascii=False, indent=2), encoding="utf-8")

        result.update(
            {
                "status": "PASS",
                "components_parsed": len(components),
                "ports_parsed": sum(len(v["ports"]) for v in components.values()),
                "interface_definitions_parsed": len(interfaces),
                "connections_parsed": len(connections),
                "validation_error_count": 0,
                "ssd_system_count": len(by_local("System")),
                "ssd_component_count": len(xml_components),
                "ssd_connector_count": len(xml_connectors),
                "ssd_connection_count": len(xml_connections),
                "start_time": default_experiment.attrib.get("startTime"),
                "stop_time": default_experiment.attrib.get("stopTime"),
                "component_mapping_count": sum(x["ssd_component"] in {c.attrib["name"] for c in xml_components} for x in component_mapping),
                "port_mapping_count": sum(x["mapped"] for x in port_mapping),
                "connection_mapping_count": sum(x["mapped"] for x in connection_mapping),
            }
        )
        if result["ssd_component_count"] != 16 or result["component_mapping_count"] != 16:
            raise RuntimeError(f"All16 component invariant failed: {result}")
        if result["port_mapping_count"] != len(port_mapping) or result["connection_mapping_count"] != len(connection_mapping):
            raise RuntimeError(f"Mapping invariant failed: {result}")
    except Exception:
        result.update({"status": "FAIL", "return_code": 1, "traceback": traceback.format_exc()})
    result["stdout"] = stdout.getvalue()
    result["stderr"] = stderr.getvalue()
    (LOG_DIR / "ssi_all16_run_result.json").write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8")
    (LOG_DIR / "ssi_all16_stdout.log").write_text(stdout.getvalue(), encoding="utf-8")
    (LOG_DIR / "ssi_all16_stderr.log").write_text(stderr.getvalue(), encoding="utf-8")
    print(json.dumps({k: v for k, v in result.items() if k not in {"stdout", "stderr"}}, ensure_ascii=False, indent=2))
    return result["return_code"]


if __name__ == "__main__":
    raise SystemExit(main())
