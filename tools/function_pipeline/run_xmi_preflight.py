"""Run XMI preflight, export the frozen workbook copy, and finalize QA."""
from __future__ import annotations

import json
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]


def main():
    preflight = HERE / "09_xmi_preflight.py"
    subprocess.run([sys.executable, str(preflight)], cwd=ROOT, check=True)
    builder = (HERE / "10_export_preflight_workbook.py").read_text(encoding="utf-8")
    subprocess.run(["node", "--input-type=module", "--eval", builder], cwd=HERE, check=True)
    subprocess.run([sys.executable, str(preflight), "--finalize"], cwd=ROOT, check=True)
    for name in ("Rail_MBSE_Function_Interface_v1_final.xlsx.inspect.ndjson",):
        sidecar = ROOT / name
        if sidecar.exists():
            sidecar.unlink()
    state = json.loads((HERE / "work" / "xmi_preflight_state.json").read_text(encoding="utf-8"))
    print(json.dumps({"pipeline_status": state["status"], "coverage": state["coverage_counts"], "renamed": state["aggregated_function_renames"], "qa": state["qa"]}, ensure_ascii=False))
    if state["status"] != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
