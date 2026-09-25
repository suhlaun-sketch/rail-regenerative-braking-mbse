from __future__ import annotations

import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
STEPS = (
    "10_build_structure_contracts.py",
    "11_audit_xmi_duplicates.py",
    "12_build_structure_probe.py",
    "13_validate_structure_probe.py",
)


def main() -> None:
    for step in STEPS:
        path = PIPELINE_DIR / step
        print(f"[structure-v2] {step}", flush=True)
        subprocess.run([sys.executable, str(path)], cwd=PIPELINE_DIR.parents[1], check=True)


if __name__ == "__main__":
    main()
