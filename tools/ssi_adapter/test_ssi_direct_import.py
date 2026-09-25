"""Run the unmodified SSI_v1.0.0 parsers against the frozen Rail SysML files."""

from __future__ import annotations

import contextlib
import importlib.util
import io
import json
import sys
import traceback
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
SSI_ENTRY = ROOT / "third_party/ssi_transformer/Standard-System-Interface/source/SSI_transformer.py"
GENERATED = ROOT / "work/sysmlv2/full_engineering_model/01_generated"
INTERFACE_FILE = GENERATED / "04_InterfaceDefinitions.sysml"
SYSTEM_FILE = GENERATED / "07_SystemDefinition.sysml"
OUT_DIR = ROOT / "work/sysmlv2/ssi_integration/04_logs"


def load_ssi():
    spec = importlib.util.spec_from_file_location("ssi_transformer_original", SSI_ENTRY)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load SSI Transformer: {SSI_ENTRY}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def main() -> int:
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    stdout = io.StringIO()
    stderr = io.StringIO()
    result = {
        "ssi_entry": str(SSI_ENTRY),
        "interface_input": str(INTERFACE_FILE),
        "system_input": str(SYSTEM_FILE),
        "command": f"{Path(sys.executable)} {Path(__file__).resolve()}",
        "return_code": 0,
        "gui_state": "NOT_USED_FOR_PARSER_PROBE",
    }
    try:
        ssi = load_ssi()
        with contextlib.redirect_stdout(stdout), contextlib.redirect_stderr(stderr):
            interface_text = INTERFACE_FILE.read_text(encoding="utf-8")
            system_text = SYSTEM_FILE.read_text(encoding="utf-8")
            interfaces = ssi.parse_interface_definitions(
                interface_text.splitlines()
            )
            components, connections = ssi.parse_system_definitions(
                system_text.splitlines()
            )
            errors = ssi.validate_connections(components, connections, interfaces)
        declared_connections = sum(
            1 for line in system_text.splitlines() if line.strip().startswith("interface ") and " connect " in line
        )
        compatible = bool(components) and sum(len(v["ports"]) for v in components.values()) > 0 and len(connections) == declared_connections
        result.update(
            {
                "interface_count": len(interfaces),
                "component_count": len(components),
                "port_count": sum(len(v["ports"]) for v in components.values()),
                "connection_count": len(connections),
                "source_connection_declaration_count": declared_connections,
                "validation_error_count": len(errors),
                "validation_errors": errors,
                "status": "PASS" if compatible and not errors else "FAIL",
                "failure_reason": None if compatible and not errors else (
                    "SSI_v1.0.0 parsed only the root part and rejected all deep hierarchical endpoint paths; "
                    "the empty validation result is not a successful import."
                ),
            }
        )
    except Exception:
        result["return_code"] = 1
        result["status"] = "FAIL"
        result["traceback"] = traceback.format_exc()
    result["stdout"] = stdout.getvalue()
    result["stderr"] = stderr.getvalue()
    (OUT_DIR / "direct_ssi_import_result.json").write_text(
        json.dumps(result, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    (OUT_DIR / "direct_ssi_import_stdout.log").write_text(stdout.getvalue(), encoding="utf-8")
    (OUT_DIR / "direct_ssi_import_stderr.log").write_text(stderr.getvalue(), encoding="utf-8")
    print(json.dumps({k: v for k, v in result.items() if k not in {"stdout", "stderr", "validation_errors"}}, ensure_ascii=False, indent=2))
    return result["return_code"]


if __name__ == "__main__":
    raise SystemExit(main())
