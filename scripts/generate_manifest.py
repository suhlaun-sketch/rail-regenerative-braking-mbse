"""Generate a complete SHA-256 manifest for publishable files (author-side)."""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import subprocess
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
DOCS = ROOT / "docs"
SIM = ROOT / "work/simulation/simulink_fmu_v2_1_final"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def category(path: str) -> str:
    if path.startswith("artifacts/syson/"):
        return "Formal SysON Project"
    if path.startswith("Req/"):
        return "Requirements"
    if path.startswith("ui/frontend/"):
        return "UI frontend"
    if path.startswith("ui/backend/"):
        return "UI backend"
    if "/05_fmu/" in path:
        return "FMU"
    if "/01_models/" in path and path.endswith(".slx"):
        return "Simulink"
    if "/06_ssp/" in path:
        return "Executable SSP"
    if "/07_results/" in path or "/08_reports/" in path:
        return "Simulation result"
    if "ssi_integration" in path or "ssi_transformer" in path or "ssi_adapter" in path:
        return "SSI/SSD"
    if "implementation_binding" in path:
        return "FMI binding"
    if "full_engineering_model" in path or "requirements_traceability_v2" in path:
        return "SysML"
    if "kg_pipeline" in path:
        return "Knowledge graph"
    return "Supporting source/data"


def status(path: str) -> str:
    formal = (
        path.startswith("Req/") and path.endswith(".xlsx")
        or path.endswith(("Rail_MBSE_Full_v1.sysml", "Rail_MBSE_Full_v3_FullBoundary.sysml"))
        or "RequirementTraceability_AllInOne_v2.sysml" in path
        or path.startswith("artifacts/syson/")
        or path.endswith("Rail_MBSE_L2_All16_v1.ssd")
        or path.endswith("Rail_MBSE_Executable_FMU_Interface_v1.json")
        or path.endswith(("Rail_MBSE_All16_Executable_v2_1.ssp",
                          "Rail_MBSE_All16_Executable_v2_1.ssd"))
        or path.startswith("work/simulation/simulink_fmu_v2_1_final/01_models/") and path.endswith(".slx")
        or path.startswith("work/simulation/simulink_fmu_v2_1_final/05_fmu/") and path.endswith(".fmu") and "/validated/" not in path
        or path.startswith("work/simulation/simulink_fmu_v2_1_final/07_results/")
        or path.startswith("work/simulation/simulink_fmu_v2_1_final/08_reports/")
    )
    return "FROZEN" if formal else "SUPPORT"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--source-root", type=Path)
    args = parser.parse_args()
    raw = subprocess.check_output(
        ["git", "ls-files", "--cached", "--others", "--exclude-standard", "-z"], cwd=ROOT
    )
    paths = sorted({p.decode("utf-8") for p in raw.split(b"\0") if p})
    excluded = {"docs/ARTIFACT_MANIFEST.csv", "docs/ARTIFACT_MANIFEST.md",
                "docs/artifacts/FMU_MANIFEST.csv", "docs/publishing/GITHUB_PUBLISH_REPORT.md"}
    rows = []
    source_errors = []
    for rel in paths:
        if rel in excluded:
            continue
        path = ROOT / rel
        if not path.is_file():
            continue
        mode = "repository-lfs" if (
            path.suffix.lower() in {".fmu", ".slx", ".ssp", ".ssd", ".mat", ".mdxml"}
            or rel.startswith("artifacts/syson/") and path.suffix.lower() == ".zip"
            or rel == "02_SC_v1_results/SC_v1_signals.csv"
        ) else "repository-git"
        origin = "SOURCE/" + rel
        if rel.startswith("artifacts/syson/"):
            origin = "SysON 2026.7.0 GET /api/projects/{projectId}"
        elif rel.startswith(("docs/", "scripts/")) or rel in {".gitignore", ".gitattributes", "README.md", "SECURITY.md", "CONTRIBUTING.md", "requirements-fmu.txt"}:
            origin = "handoff-created"
        digest = sha256(path)
        if args.source_root and status(rel) == "FROZEN" and not rel.startswith("artifacts/syson/"):
            original = args.source_root / rel
            if not original.is_file() or sha256(original) != digest:
                source_errors.append(rel)
        rows.append({
            "path": rel, "purpose": category(rel), "size_bytes": path.stat().st_size,
            "sha256": digest, "origin": origin, "state": status(rel), "download": mode
        })
    DOCS.mkdir(exist_ok=True)
    with (DOCS / "ARTIFACT_MANIFEST.csv").open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    from collections import Counter
    counts = Counter(row["purpose"] for row in rows)
    md = ["# 发布资产清单", "",
          f"共 {len(rows)} 个发布文件，其中 {sum(r['state']=='FROZEN' for r in rows)} 个标记为 FROZEN。",
          "逐文件相对路径、用途、字节数、SHA-256、来源、冻结状态、下载方式见 [CSV](ARTIFACT_MANIFEST.csv)。",
          "所有 LFS 文件须在 clone 后执行 git lfs pull；运行 python scripts/check_release.py --hashes 校验。",
          "", "| 类别 | 文件数 |", "|---|---:|"]
    md.extend(f"| {kind} | {count} |" for kind, count in sorted(counts.items()))
    md += ["", "正式 SysON ZIP 来自 Project export；57 张 IBD 位于 ZIP 的 representations 内。",
           "正式 16 FMU 和 16 SLX 仅计 05_fmu 目录一级与 01_models；validated/ 历史副本不计。",
           "排除目录/文件见 [排除项](EXCLUDED_THIRD_PARTY_MATERIALS.md)。",
           f"本次冻结副本 SHA-256 对源文件比较：{'PASS' if not source_errors else 'FAIL'}；不一致 {len(source_errors)} 项。"]
    (DOCS / "ARTIFACT_MANIFEST.md").write_text("\n".join(md)+"\n", encoding="utf-8")
    artifact_dir = DOCS / "artifacts"
    artifact_dir.mkdir(exist_ok=True)
    fmu_rows = []
    for fmu in sorted((SIM / "05_fmu").glob("L2_*.fmu")):
        with zipfile.ZipFile(fmu) as archive:
            xml = ET.fromstring(archive.read("modelDescription.xml"))
            variables = xml.find("ModelVariables")
            names = list(variables) if variables is not None else []
            fmu_rows.append({
                "component": fmu.stem, "path": fmu.relative_to(ROOT).as_posix(),
                "fmi_version": xml.attrib.get("fmiVersion", ""),
                "variables": len(names),
                "inputs": sum(v.attrib.get("causality") == "input" for v in names),
                "outputs": sum(v.attrib.get("causality") == "output" for v in names),
                "sha256": sha256(fmu)
            })
    with (artifact_dir / "FMU_MANIFEST.csv").open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(fmu_rows[0]))
        writer.writeheader()
        writer.writerows(fmu_rows)
    print(json.dumps({"files": len(rows), "frozen": sum(r["state"] == "FROZEN" for r in rows),
                      "fmu": len(fmu_rows), "source_hash_mismatch": source_errors},
                     ensure_ascii=False))
    if source_errors:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
