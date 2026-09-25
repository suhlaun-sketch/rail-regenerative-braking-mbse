from __future__ import annotations

import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent


def main() -> None:
    for script in (
        "19_parse_magicdraw_gold.py",
        "20_build_magicdraw_native_probe.py",
        "21_validate_magicdraw_native_probe.py",
    ):
        subprocess.run([sys.executable, str(PIPELINE_DIR / script)], check=True)


if __name__ == "__main__":
    main()
