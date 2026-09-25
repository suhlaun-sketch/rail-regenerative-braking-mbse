from __future__ import annotations

import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
STEPS = (
    "14_build_itemflow_contracts.py",
    "15_build_itemflow_probe.py",
    "16_validate_itemflow_probe.py",
)


def main() -> None:
    for step in STEPS:
        print(f"[itemflow-v2] {step}", flush=True)
        subprocess.run([sys.executable, str(PIPELINE_DIR / step)], cwd=PIPELINE_DIR.parents[1], check=True)


if __name__ == "__main__":
    main()
