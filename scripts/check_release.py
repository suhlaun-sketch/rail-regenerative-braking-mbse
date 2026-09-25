"""Read-only verification of the published handoff artifacts."""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SIM = ROOT / "work/simulation/simulink_fmu_v2_1_final"
MANIFEST = ROOT / "docs/ARTIFACT_MANIFEST.csv"
PROJECT = ROOT / "artifacts/syson/Rail_Regenerative_Braking_MBSE_FULL.zip"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--hashes", action="store_true", help="Verify every manifest hash")
    args = parser.parse_args()
    errors: list[str] = []
    fmus = sorted((SIM / "05_fmu").glob("L2_*.fmu"))
    models = sorted((SIM / "01_models").glob("L2_*.slx"))
    if len(fmus) != 16:
        errors.append(f"formal FMU count: {len(fmus)} instead of 16")
    if len(models) != 16:
        errors.append(f"formal Simulink count: {len(models)} instead of 16")
    for fmu in fmus:
        try:
            with zipfile.ZipFile(fmu) as archive:
                if "modelDescription.xml" not in archive.namelist():
                    errors.append(f"missing modelDescription.xml: {fmu.name}")
        except zipfile.BadZipFile:
            errors.append(f"invalid FMU ZIP: {fmu.name}")
    if not PROJECT.is_file():
        errors.append("formal SysON Project ZIP is missing")
    else:
        with zipfile.ZipFile(PROJECT) as archive:
            if archive.testzip() is not None:
                errors.append("formal SysON Project ZIP CRC failed")
            ibds = [name for name in archive.namelist()
                    if "/representations/" in name and name.endswith(".json")
                    and json.loads(archive.read(name)).get("label", "").startswith("AUTO_IBD_")]
            if len(ibds) != 57:
                errors.append(f"formal AUTO_IBD representation count: {len(ibds)} instead of 57")
    if args.hashes:
        with MANIFEST.open(encoding="utf-8-sig", newline="") as stream:
            for row in csv.DictReader(stream):
                path = ROOT / row["path"]
                if not path.is_file():
                    errors.append(f"missing: {row['path']}")
                elif sha256(path) != row["sha256"]:
                    errors.append(f"SHA-256 mismatch: {row['path']}")
    status = "PASS" if not errors else "FAIL"
    print(json.dumps({"status": status, "fmus": len(fmus), "simulink_models": len(models),
                      "syson_ibd_representations": len(ibds) if PROJECT.is_file() else None,
                      "manifest_hashes_checked": args.hashes, "errors": errors},
                     ensure_ascii=False, indent=2))
    return 0 if not errors else 1


if __name__ == "__main__":
    sys.exit(main())
