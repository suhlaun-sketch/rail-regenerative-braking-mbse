from __future__ import annotations

import hashlib
import json
from pathlib import Path


PIPELINE_DIR = Path(__file__).resolve().parent
ROOT = PIPELINE_DIR.parents[1]
STANDARDS_DIR = ROOT / "SysML"
WORK_DIR = PIPELINE_DIR / "work"


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for chunk in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def pdf_identity(path: Path) -> dict:
    result = {"title": None, "pages": None, "detected_version": None}
    try:
        from pypdf import PdfReader

        reader = PdfReader(path)
        result["pages"] = len(reader.pages)
        result["title"] = (reader.metadata or {}).get("/Title")
        first = "\n".join((reader.pages[i].extract_text() or "") for i in range(min(2, len(reader.pages))))
        if "Version 2.0" in first or "SysML/2.0" in first:
            result["detected_version"] = "2.0"
        elif "Version 1.7" in first or "SysML/1.7" in first:
            result["detected_version"] = "1.7"
    except Exception as exc:  # Optional inventory enrichment only.
        result["read_note"] = f"PDF metadata unavailable: {type(exc).__name__}"
    return result


def identify_role(path: Path) -> str | None:
    name = path.name.lower()
    known = {
        "sysml.xmi": "sysml_profile",
        "sysmldi.xmi": "sysml_di_profile",
        "uml.xmi": "uml_metamodel",
        "umlpre.xmi": "primitive_types_local_alias",
        "primitivetypes.xmi": "primitive_types",
        "umlstandard.xmi": "standard_profile_local_alias",
        "standardprofile.xmi": "standard_profile",
        "xmi.xsd": "xmi_schema",
    }
    if name in known:
        return known[name]
    if path.suffix.lower() == ".pdf":
        return "specification_pdf"
    return None


def detect_golden_sample(path: Path) -> bool:
    if path.suffix.lower() != ".xmi" or path.name.lower() in {
        "sysml.xmi", "sysmldi.xmi", "uml.xmi", "umlpre.xmi", "umlstandard.xmi"
    }:
        return False
    text = path.read_text(encoding="utf-8", errors="ignore")[:500_000].lower()
    return "magicdraw" in text or "cameo" in text or "nomagic" in text


def build_inventory() -> dict:
    if not STANDARDS_DIR.is_dir():
        raise FileNotFoundError(f"Standards directory not found: {STANDARDS_DIR}")
    records = []
    for path in sorted((p for p in STANDARDS_DIR.rglob("*") if p.is_file()), key=lambda p: p.as_posix().lower()):
        record = {
            "name": path.name,
            "relative_path": path.relative_to(ROOT).as_posix(),
            "size": path.stat().st_size,
            "sha256": sha256(path),
            "role": identify_role(path),
            "cameo_magicdraw_golden_sample": detect_golden_sample(path),
        }
        if path.suffix.lower() == ".pdf":
            record["pdf_identity"] = pdf_identity(path)
        records.append(record)

    by_role: dict[str, list[str]] = {}
    for record in records:
        if record["role"]:
            by_role.setdefault(record["role"], []).append(record["relative_path"])
    golden = [r["relative_path"] for r in records if r["cameo_magicdraw_golden_sample"]]
    sysml17_pdfs = [
        r["relative_path"] for r in records
        if r.get("pdf_identity", {}).get("detected_version") == "1.7"
    ]
    mismatched_pdfs = [
        {"path": r["relative_path"], "detected_version": r["pdf_identity"].get("detected_version")}
        for r in records
        if r.get("pdf_identity", {}).get("detected_version") not in (None, "1.7")
    ]
    return {
        "standards_directory": str(STANDARDS_DIR),
        "files": records,
        "recognized_roles": by_role,
        "sysml_1_7_specification_pdfs": sysml17_pdfs,
        "version_mismatched_pdfs": mismatched_pdfs,
        "golden_samples": golden,
        "golden_sample_status": "FOUND" if golden else "NOT_FOUND",
    }


def main() -> None:
    WORK_DIR.mkdir(parents=True, exist_ok=True)
    inventory = build_inventory()
    out = WORK_DIR / "standards_inventory.json"
    out.write_text(json.dumps(inventory, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"Inventory: {out}")
    print(f"Files: {len(inventory['files'])}; Golden samples: {len(inventory['golden_samples'])}")


if __name__ == "__main__":
    main()
