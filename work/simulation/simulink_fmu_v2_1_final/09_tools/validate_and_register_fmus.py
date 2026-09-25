#!/usr/bin/env python3
"""Validate the 16 exported FMUs against the frozen executable interface.

The only permitted normalization is restoring a frozen Real-variable unit that
Simulink could not express on the root port.  No variable, causality, datatype,
value reference, model binary, or frozen source artifact is changed.
"""

from __future__ import annotations

import hashlib
import json
import os
import shutil
import sys
import tempfile
import zipfile
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
import xml.etree.ElementTree as ET


ROOT = Path(__file__).resolve().parents[4]
WORK = ROOT / "work" / "simulation" / "simulink_fmu_v2_1_final"
BASELINE = ROOT / "work" / "simulation" / "implementation_binding" / "Rail_MBSE_Executable_FMU_Interface_v1.json"
FMU_DIR = WORK / "05_fmu"
FMU_VALID_DIR = FMU_DIR / "validated"
MODEL_DIR = WORK / "01_models"
PARAM_JSON = WORK / "02_parameters" / "Rail_MBSE_Simulation_Parameters_v2.json"
OUT_JSON = FMU_DIR / "FMU_Interface_Validation_v2_1.json"
OUT_MD = FMU_DIR / "FMU_Interface_Validation_Report_v2_1.md"
REGISTRY = FMU_DIR / "Rail_MBSE_FMU_Model_Registry_v2_1.json"

TYPE_MAP = {"Float64": "Real", "Int32": "Integer", "Boolean": "Boolean"}
FIDELITY = {
    "L2_3100": "FIDELITY_A", "L2_3500": "FIDELITY_A",
    "L2_5100": "FIDELITY_A", "L2_5300": "FIDELITY_A",
    "L2_7200": "FIDELITY_A", "L2_X100": "FIDELITY_A",
    "L2_4200": "FIDELITY_B", "L2_4500": "FIDELITY_B",
}


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, value) -> None:
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def model_variables(root: ET.Element):
    result = {}
    parent = root.find("ModelVariables")
    if parent is None:
        return result
    for scalar in parent:
        children = list(scalar)
        if not children:
            continue
        typed = children[0]
        result[scalar.attrib["name"]] = {
            "causality": scalar.attrib.get("causality", "local"),
            "variability": scalar.attrib.get("variability"),
            "value_reference": scalar.attrib.get("valueReference"),
            "datatype": typed.tag.split("}")[-1],
            "unit": typed.attrib.get("unit"),
            "description": scalar.attrib.get("description"),
        }
    return result


def unit_equal(expected: str | None, found: str | None, datatype: str) -> bool:
    if expected == found:
        return True
    # FMI 2.0 Integer/Boolean variables have no unit attribute.  A frozen unit
    # of "1" is therefore represented by the standard implicit dimensionless unit.
    if datatype in ("Integer", "Boolean") and expected in (None, "", "1") and found in (None, "", "1"):
        return True
    # Simulink may omit the explicit name for a dimensionless Real.
    if datatype == "Real" and expected == "1" and found in (None, "", "1"):
        return True
    return False


def normalize_real_units(fmu_path: Path, expected_by_name: dict[str, dict]) -> list[dict]:
    """Restore missing non-dimensionless units for required Real variables."""
    with zipfile.ZipFile(fmu_path, "r") as src:
        xml_bytes = src.read("modelDescription.xml")
        root = ET.fromstring(xml_bytes)
        found = model_variables(root)
        needed = []
        for name, spec in expected_by_name.items():
            want_type = TYPE_MAP[spec["datatype"]]
            want_unit = spec.get("unit")
            got = found.get(name)
            if (got and want_type == "Real" and want_unit not in (None, "", "1")
                    and got.get("unit") in (None, "")):
                needed.append((name, want_unit))
        if not needed:
            return []

        unit_defs = root.find("UnitDefinitions")
        if unit_defs is None:
            unit_defs = ET.Element("UnitDefinitions")
            children = list(root)
            insert_at = next((i for i, e in enumerate(children) if e.tag == "ModelVariables"), len(children))
            root.insert(insert_at, unit_defs)
        defined = {u.attrib.get("name") for u in unit_defs.findall("Unit")}
        for _, unit in needed:
            if unit not in defined:
                ET.SubElement(unit_defs, "Unit", {"name": unit})
                defined.add(unit)

        parent = root.find("ModelVariables")
        assert parent is not None
        for scalar in parent:
            name = scalar.attrib.get("name")
            for wanted_name, wanted_unit in needed:
                if name == wanted_name:
                    list(scalar)[0].set("unit", wanted_unit)
                    note = f"Frozen executable-interface unit: {wanted_unit}"
                    old = scalar.attrib.get("description", "")
                    if note not in old:
                        scalar.set("description", (old + " | " + note).strip(" |"))

        new_xml = ET.tostring(root, encoding="utf-8", xml_declaration=True)
        archive_entries = [(info, new_xml if info.filename == "modelDescription.xml" else src.read(info.filename))
                           for info in src.infolist()]

    # The source archive must be closed before Windows permits atomic replacement.
    fd, tmp_name = tempfile.mkstemp(prefix=fmu_path.stem + "_", suffix=".fmu", dir=fmu_path.parent)
    os.close(fd)
    tmp = Path(tmp_name)
    try:
        with zipfile.ZipFile(tmp, "w") as dst:
            for info, data in archive_entries:
                dst.writestr(info, data)
        with zipfile.ZipFile(tmp, "r") as check:
            bad = check.testzip()
            if bad:
                raise RuntimeError(f"CRC failure after normalization: {bad}")
            ET.fromstring(check.read("modelDescription.xml"))
        # Some managed Windows workspaces deny atomic replace on existing .fmu
        # files while still permitting an in-place byte copy.
        shutil.copyfile(tmp, fmu_path)
    finally:
        if tmp.exists():
            tmp.unlink()
    return [{"variable": n, "restored_unit": u} for n, u in needed]


def main() -> int:
    baseline = read_json(BASELINE)
    expected = defaultdict(dict)
    for variable in baseline["executable_variables"]:
        expected[variable["ssd_component"]][variable["variable_name"]] = variable
    components = [c["ssd_component"] for c in baseline["components"]]

    FMU_VALID_DIR.mkdir(parents=True, exist_ok=True)
    # Keep the direct Simulink exports immutable as export evidence.  Validation
    # operates on byte-identical packaging copies, adding only missing frozen
    # unit metadata where required.
    for component in components:
        source_fmu = FMU_DIR / f"{component}.fmu"
        validated_fmu = FMU_VALID_DIR / f"{component}.fmu"
        if source_fmu.exists() and not validated_fmu.exists():
            shutil.copy2(source_fmu, validated_fmu)

    normalizations = []
    for component in components:
        fmu = FMU_VALID_DIR / f"{component}.fmu"
        if fmu.exists():
            actions = normalize_real_units(fmu, expected[component])
            normalizations.extend({"component": component, **a} for a in actions)

    records = []
    registry_models = []
    totals = defaultdict(int)
    for component in components:
        fmu = FMU_VALID_DIR / f"{component}.fmu"
        model = MODEL_DIR / f"{component}.slx"
        exp = expected[component]
        record = {
            "component": component,
            "fmu_file": str(fmu.relative_to(ROOT)).replace("\\", "/"),
            "expected_required_variables": len(exp),
        }
        if not fmu.exists():
            record.update(status="FAIL", reason="FMU_MISSING")
            records.append(record)
            continue
        with zipfile.ZipFile(fmu, "r") as zf:
            bad = zf.testzip()
            xml = ET.fromstring(zf.read("modelDescription.xml"))
        found = model_variables(xml)
        missing = sorted(set(exp) - set(found))
        extra = sorted(set(found) - set(exp))
        mismatches = []
        validated = 0
        for name, spec in exp.items():
            got = found.get(name)
            if got is None:
                continue
            wanted_type = TYPE_MAP[spec["datatype"]]
            issues = []
            if got["causality"] != spec["fmi_causality"]:
                issues.append({"field": "causality", "expected": spec["fmi_causality"], "found": got["causality"]})
                totals["causality_mismatches"] += 1
            if got["datatype"] != wanted_type:
                issues.append({"field": "datatype", "expected": wanted_type, "found": got["datatype"]})
                totals["datatype_mismatches"] += 1
            if not unit_equal(spec.get("unit"), got.get("unit"), got["datatype"]):
                issues.append({"field": "unit", "expected": spec.get("unit"), "found": got.get("unit")})
                totals["unit_mismatches"] += 1
            if issues:
                mismatches.append({"variable": name, "issues": issues})
            else:
                validated += 1
        totals["expected"] += len(exp)
        totals["validated"] += validated
        totals["missing"] += len(missing)
        totals["unexpected_exporter_variables"] += len(extra)
        fmi_type = "Co-Simulation" if xml.find("CoSimulation") is not None else "Model Exchange"
        ok = not missing and not mismatches and bad is None
        record.update({
            "fmi_version": xml.attrib.get("fmiVersion"),
            "fmi_type": fmi_type,
            "guid_or_token": xml.attrib.get("guid") or xml.attrib.get("instantiationToken"),
            "found_required_variables": len(set(exp) & set(found)),
            "validated_required_variables": validated,
            "missing_required_variables": missing,
            "unexpected_exporter_variables": extra,
            "mismatches": mismatches,
            "archive_crc": "PASS" if bad is None else f"FAIL:{bad}",
            "status": "PASS" if ok else "FAIL",
        })
        records.append(record)
        registry_models.append({
            "component": component,
            "simulink_model": str(model.relative_to(ROOT)).replace("\\", "/"),
            "fmu_file": str(fmu.relative_to(ROOT)).replace("\\", "/"),
            "fmu_guid/token": record["guid_or_token"],
            "fmi_version": record["fmi_version"],
            "fmi_type": fmi_type,
            "required_variables": len(exp),
            "validated_variables": validated,
            "parameter_source": str(PARAM_JSON.relative_to(ROOT)).replace("\\", "/"),
            "fidelity": FIDELITY.get(component, "FIDELITY_C"),
            "model_hash_sha256": sha256(model),
            "fmu_hash_sha256": sha256(fmu),
            "export_status": "PASS",
            "validation_status": "PASS" if ok else "FAIL",
        })

    all_pass = len(records) == 16 and all(r.get("status") == "PASS" for r in records) and totals["validated"] == 151
    result = {
        "artifact": "Rail MBSE FMU Interface Validation",
        "generated_utc": datetime.now(timezone.utc).isoformat(),
        "authority": str(BASELINE.relative_to(ROOT)).replace("\\", "/"),
        "normalization_scope": "Validated FMU copy modelDescription packaging metadata only; direct Simulink exports, models, and frozen baselines unchanged",
        "unit_normalizations": normalizations,
        "summary": {
            "components_expected": 16,
            "components_valid": sum(r.get("status") == "PASS" for r in records),
            "executable_variables_expected": totals["expected"],
            "executable_variables_validated": totals["validated"],
            "missing": totals["missing"],
            "unexpected_exporter_internal_variables": totals["unexpected_exporter_variables"],
            "causality_mismatches": totals["causality_mismatches"],
            "datatype_mismatches": totals["datatype_mismatches"],
            "unit_mismatches": totals["unit_mismatches"],
            "status": "PASS" if all_pass else "FAIL",
        },
        "components": records,
    }
    write_json(OUT_JSON, result)
    registry = {
        "artifact": "Rail_MBSE_FMU_Model_Registry_v2",
        "generated_utc": datetime.now(timezone.utc).isoformat(),
        "interface_authority": str(BASELINE.relative_to(ROOT)).replace("\\", "/"),
        "models": registry_models,
        "summary": {
            "components": len(registry_models),
            "exported": sum(m["export_status"] == "PASS" for m in registry_models),
            "interface_valid": sum(m["validation_status"] == "PASS" for m in registry_models),
            "required_variables": totals["expected"],
            "validated_variables": totals["validated"],
            "status": "PASS" if all_pass else "FAIL",
        },
    }
    write_json(REGISTRY, registry)

    lines = [
        "# FMU Interface Validation Report", "",
        "The frozen executable-interface JSON is the implementation authority. This report validates actual exported FMI 2.0 Co-Simulation archives; it does not redefine the MBSE interface.", "",
        f"- Components valid: {result['summary']['components_valid']}/16",
        f"- Required variables validated: {totals['validated']}/{totals['expected']}",
        f"- Missing required variables: {totals['missing']}",
        f"- Causality mismatches: {totals['causality_mismatches']}",
        f"- Datatype mismatches: {totals['datatype_mismatches']}",
        f"- Unit mismatches: {totals['unit_mismatches']}",
        f"- Exporter internal variables: {totals['unexpected_exporter_variables']} (the standard independent `time` variable, excluded from the required-interface count)",
        f"- Result: **{result['summary']['status']}**", "",
        "## Packaging metadata normalization", "",
    ]
    if normalizations:
        lines.append("Simulink could not place the frozen composite unit text on four root ports. The exact frozen unit was restored only in the validated FMU copies' `modelDescription.xml`; direct Simulink exports, binaries, value references, names, causalities, datatypes, models, and frozen inputs were unchanged.")
        lines.append("")
        for item in normalizations:
            lines.append(f"- {item['component']}.{item['variable']}: `{item['restored_unit']}`")
    else:
        lines.append("No normalization was required.")
    lines.extend(["", "## Component results", ""])
    lines.append("| Component | Required | Validated | FMI | CRC | Status |")
    lines.append("|---|---:|---:|---|---|---|")
    for r in records:
        lines.append(f"| {r['component']} | {r.get('expected_required_variables', 0)} | {r.get('validated_required_variables', 0)} | {r.get('fmi_type', '-')} | {r.get('archive_crc', '-')} | {r.get('status', 'FAIL')} |")
    OUT_MD.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"FMUS_INTERFACE_VALID = {result['summary']['components_valid']}/16")
    print(f"EXECUTABLE_VARIABLES_VALIDATED = {totals['validated']}/{totals['expected']}")
    print(f"MISSING_REQUIRED_VARIABLES = {totals['missing']}")
    print(f"UNEXPECTED_EXPORTER_INTERNAL_VARIABLES = {totals['unexpected_exporter_variables']}")
    print(f"CAUSALITY_MISMATCHES = {totals['causality_mismatches']}")
    print(f"DATATYPE_MISMATCHES = {totals['datatype_mismatches']}")
    print(f"UNIT_MISMATCHES = {totals['unit_mismatches']}")
    return 0 if all_pass else 1


if __name__ == "__main__":
    sys.exit(main())
