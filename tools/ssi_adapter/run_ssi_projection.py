"""Validate the Rail projection with SSI_v1.0.0 and invoke its SSD generator."""

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
PROJECTION = ROOT / "work/sysmlv2/ssi_integration/02_projection"
SSD_DIR = ROOT / "work/sysmlv2/ssi_integration/03_ssd"
LOG_DIR = ROOT / "work/sysmlv2/ssi_integration/04_logs"
SSD = SSD_DIR / "Rail_RegenerativeBraking_L2_v1.ssd"


def load_ssi():
    spec = importlib.util.spec_from_file_location("ssi_transformer_original", SSI_ENTRY)
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
            interfaces = ssi.parse_interface_definitions(
                (PROJECTION / "interface_definition.sysml").read_text(encoding="utf-8").splitlines()
            )
            components, connections = ssi.parse_system_definitions(
                (PROJECTION / "system_definition.sysml").read_text(encoding="utf-8").splitlines()
            )
            errors = ssi.validate_connections(components, connections, interfaces)
            if errors:
                raise RuntimeError(f"SSI validation failed: {json.dumps(errors, ensure_ascii=False)}")
            connector_kinds = {}
            for conn in connections:
                connector_kinds[f"{conn['start_element']}.{conn['start_connector']}"] = "output"
                connector_kinds[f"{conn['end_element']}.{conn['end_connector']}"] = "input"
            component_info = {
                "system_name": "Rail_RegenerativeBraking_L2_v1",
                "generation_tool": "Standard-System-Interface SSI_v1.0.0",
                "start_time": "0.0",
                "stop_time": "10.0",
                "components": {
                    name: {
                        "new_name": name,
                        "fmu_filename": f"{name}.fmu",
                        "ports": details["ports"],
                    }
                    for name, details in components.items()
                },
                "connections": connections,
            }
            ssi.create_ssp_file(
                str(SSD), components, connections, component_info, connector_kinds
            )

        tree = ET.parse(SSD)
        root = tree.getroot()
        tags = [element.tag.rsplit("}", 1)[-1] for element in root.iter()]
        manifest = json.loads((PROJECTION / "projection_manifest.json").read_text(encoding="utf-8"))
        xml_components = [element for element in root.iter() if element.tag.rsplit("}", 1)[-1] == "Component"]
        xml_connections = [element for element in root.iter() if element.tag.rsplit("}", 1)[-1] == "Connection"]
        default_experiment = next(
            element for element in root.iter() if element.tag.rsplit("}", 1)[-1] == "DefaultExperiment"
        )
        port_mapping = {}
        for conn in manifest["connections_mapping"]:
            port_mapping[conn["source_original"]] = {
                "sysml_component": f"L2_{conn['source_l2']}",
                "sysml_promoted_port": conn["source_port"],
                "ssd_connector": conn["source_port"],
            }
            port_mapping[conn["target_original"]] = {
                "sysml_component": f"L2_{conn['target_l2']}",
                "sysml_promoted_port": conn["target_port"],
                "ssd_connector": conn["target_port"],
            }
        mapping = {
            "component_mapping": [
                {
                    "rail_l2_code": code,
                    "sysml_component": f"L2_{code}",
                    "ssd_component": f"L2_{code}",
                }
                for code in manifest["selected_l2_codes"]
            ],
            "port_mapping": [
                {"rail_leaf_port_path": original, **mapped}
                for original, mapped in sorted(port_mapping.items())
            ],
            "connection_mapping": [
                {
                    "rail_connection_id": conn["connection_id"],
                    "sysml_interface": conn["interface_type"],
                    "ssd_start_element": xml.attrib["startElement"],
                    "ssd_start_connector": xml.attrib["startConnector"],
                    "ssd_end_element": xml.attrib["endElement"],
                    "ssd_end_connector": xml.attrib["endConnector"],
                }
                for conn, xml in zip(manifest["connections_mapping"], xml_connections)
            ],
        }
        (SSD_DIR / "Rail_RegenerativeBraking_L2_v1_mapping.json").write_text(
            json.dumps(mapping, ensure_ascii=False, indent=2), encoding="utf-8"
        )
        result.update(
            {
                "status": "PASS",
                "interface_count": len(interfaces),
                "component_count": tags.count("Component"),
                "connector_count": tags.count("Connector"),
                "connection_count": tags.count("Connection"),
                "system_count": tags.count("System"),
                "start_time": default_experiment.attrib.get("startTime"),
                "stop_time": default_experiment.attrib.get("stopTime"),
                "validation_error_count": 0,
                "component_mapping_count": len(mapping["component_mapping"]),
                "port_mapping_count": len(mapping["port_mapping"]),
                "connection_mapping_count": len(mapping["connection_mapping"]),
            }
        )
    except Exception:
        result.update({"status": "FAIL", "return_code": 1, "traceback": traceback.format_exc()})
    result["stdout"] = stdout.getvalue()
    result["stderr"] = stderr.getvalue()
    (LOG_DIR / "ssi_projection_run_result.json").write_text(
        json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    (LOG_DIR / "ssi_projection_stdout.log").write_text(stdout.getvalue(), encoding="utf-8")
    (LOG_DIR / "ssi_projection_stderr.log").write_text(stderr.getvalue(), encoding="utf-8")
    print(json.dumps({k: v for k, v in result.items() if k not in {"stdout", "stderr"}}, ensure_ascii=False, indent=2))
    return result["return_code"]


if __name__ == "__main__":
    raise SystemExit(main())
