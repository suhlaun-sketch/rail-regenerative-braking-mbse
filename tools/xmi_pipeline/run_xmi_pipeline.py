from __future__ import annotations

import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent


def main() -> None:
    scripts = [
        "01_inventory_standards.py",
        "02_parse_sysml_profile.py",
        "03_build_mapping_contract.py",
        "04_build_xmi_model.py",
        "05_validate_xmi.py",
    ]
    for script in scripts:
        print(f"\n[{script}]")
        subprocess.run([sys.executable, "-X", "utf8", str(PIPELINE_DIR / script)], check=True)
    print("\nSysML 1.7 XMI pipeline completed.")


if __name__ == "__main__":
    main()
