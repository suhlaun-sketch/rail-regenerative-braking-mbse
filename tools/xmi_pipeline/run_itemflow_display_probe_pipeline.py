from __future__ import annotations

import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
STEPS = (
    "17_build_itemflow_display_probe.py",
    "18_validate_itemflow_display_probe.py",
)


def main() -> None:
    for step in STEPS:
        print(f"[itemflow-display-v6] {step}", flush=True)
        subprocess.run([sys.executable, str(PIPELINE_DIR / step)], cwd=PIPELINE_DIR.parents[1], check=True)


if __name__ == "__main__":
    main()
