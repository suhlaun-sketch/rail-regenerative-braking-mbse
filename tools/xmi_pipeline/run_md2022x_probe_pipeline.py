from __future__ import annotations

import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent


def main() -> None:
    scripts = [
        "06_inventory_magicdraw.py",
        "07_build_magicdraw_compatibility_contract.py",
        "08_build_md2022x_semantic_probe.py",
        "09_validate_md2022x_probe.py",
    ]
    for script in scripts:
        print(f"\n[{script}]")
        subprocess.run([sys.executable, "-X", "utf8", str(PIPELINE_DIR / script)], check=True)
    print("\nMagicDraw 2022x semantic Probe pipeline completed. No full XMI was generated.")


if __name__ == "__main__":
    main()
