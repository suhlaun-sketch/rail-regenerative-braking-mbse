from __future__ import annotations

import hashlib
import json
import subprocess
import sys
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
XMI = ROOT / "work" / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.xmi"
MDXML = ROOT / "work" / "Rail_MBSE_TractionBrake_Full_UpwardIBD_v1.mdxml"
RUN_MANIFEST = PIPELINE_DIR / "work" / "full_upward_pipeline_run_manifest_v1.json"


def run(script: str) -> None:
    subprocess.run([sys.executable, str(PIPELINE_DIR / script)], check=True)


def hashes() -> dict[str, str]:
    return {
        "xmi_sha256": hashlib.sha256(XMI.read_bytes()).hexdigest(),
        "mdxml_sha256": hashlib.sha256(MDXML.read_bytes()).hexdigest(),
    }


def main() -> None:
    build_scripts = (
        "22_build_upward_inference.py",
        "23_build_full_upward_model.py",
        "24_build_full_native_mdxml.py",
    )
    for script in build_scripts:
        run(script)
    first = hashes()
    for script in build_scripts:
        run(script)
    second = hashes()
    if first != second:
        raise AssertionError(f"Two complete pipeline runs differ: {first} != {second}")
    run("25_validate_full_upward.py")
    manifest = {
        "manifest_id": "RAIL-MBSE-FULL-UPWARD-PIPELINE-RUN-V1",
        "first_run": first,
        "second_run": second,
        "byte_identical": True,
        "MAGICDRAW_FULL_OPEN_TEST": "PENDING",
    }
    RUN_MANIFEST.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(manifest, ensure_ascii=False))


if __name__ == "__main__":
    main()
