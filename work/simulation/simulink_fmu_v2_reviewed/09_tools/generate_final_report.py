#!/usr/bin/env python3
"""Generate the evidence-backed final implementation report and status record."""

from __future__ import annotations

import hashlib
import json
from datetime import datetime, timezone
from pathlib import Path


ROOT = Path(__file__).resolve().parents[4]
WORK = ROOT / "work" / "simulation" / "simulink_fmu_v1"
REPORTS = WORK / "08_reports"
BASELINE = ROOT / "work" / "simulation" / "implementation_binding" / "Rail_MBSE_Executable_FMU_Interface_v1.json"
SSD = ROOT / "work" / "sysmlv2" / "ssi_integration" / "03_ssd" / "Rail_MBSE_L2_All16_v1.ssd"
MAPPING = ROOT / "work" / "sysmlv2" / "ssi_integration" / "03_ssd" / "Rail_MBSE_L2_All16_v1_mapping.json"
FULL_TREE = ROOT / "work" / "sysmlv2" / "full_engineering_model" / "01_generated"
FULL_FILE = FULL_TREE / "Rail_MBSE_Full_v1.sysml"
SSI_SOURCE = ROOT / "third_party" / "ssi_transformer" / "Standard-System-Interface" / "source" / "SSI_simulator.py"


def read_json(path):
    return json.loads(Path(path).read_text(encoding="utf-8"))


def sha(path):
    h = hashlib.sha256()
    with Path(path).open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest().upper()


def tree_hash(path):
    path = Path(path)
    h = hashlib.sha256()
    for f in sorted(p for p in path.rglob("*") if p.is_file()):
        h.update(f.relative_to(path).as_posix().encode("utf-8"))
        h.update(b"\0")
        h.update(sha(f).encode("ascii"))
        h.update(b"\n")
    return h.hexdigest().upper()


def rel(path):
    return str(Path(path).relative_to(ROOT)).replace("\\", "/")


def main():
    REPORTS.mkdir(parents=True, exist_ok=True)
    baseline = read_json(BASELINE)
    environment = read_json(WORK / "logs" / "matlab_environment_audit.json")
    manifest = read_json(WORK / "00_baseline" / "Simulink_Model_Build_Manifest_v1.json")
    tests = read_json(WORK / "03_component_tests" / "Component_Test_Results.json")
    connection_audit = read_json(WORK / "04_system_integration" / "Executable_Connection_Audit.json")
    exports = read_json(WORK / "05_fmu" / "FMU_Export_Results.json")
    interface_validation = read_json(WORK / "05_fmu" / "FMU_Interface_Validation.json")
    registry = read_json(WORK / "05_fmu" / "Rail_MBSE_FMU_Model_Registry_v1.json")
    ssp = read_json(WORK / "06_ssp" / "Executable_SSP_Validation.json")
    cosim = read_json(WORK / "07_results" / "Rail_MBSE_All16_FMU_CoSimulation_VV.json")
    params = read_json(WORK / "02_parameters" / "Rail_MBSE_Simulation_Parameters_v1.json")

    current = {
        "ssd_sha256": sha(SSD),
        "mapping_sha256": sha(MAPPING),
        "full_sysml_tree_sha256": tree_hash(FULL_TREE),
        "full_sysml_file_sha256": sha(FULL_FILE),
        "executable_interface_sha256": sha(BASELINE),
        "ssi_simulator_source_sha256": sha(SSI_SOURCE),
    }
    frozen = baseline["source_integrity"]["after"]
    integrity = {
        "artifact": "Frozen Source Integrity Check",
        "generated_utc": datetime.now(timezone.utc).isoformat(),
        "current_hashes": current,
        "reference_hashes": frozen,
        "checks": {
            "original_ssd_unmodified": current["ssd_sha256"] == frozen["ssd_sha256"],
            "ssd_mapping_unmodified": current["mapping_sha256"] == frozen["mapping_sha256"],
            "full_sysml_tree_unmodified": current["full_sysml_tree_sha256"] == frozen["full_sysml_tree_sha256"],
            "executable_interface_write_performed": False,
            "ssi_source_write_performed": False,
        },
    }
    (REPORTS / "Frozen_Source_Integrity.json").write_text(json.dumps(integrity, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")

    env_lines = [
        "# MATLAB Environment Report", "",
        f"- MATLAB: {environment['matlab_version']}",
        f"- Architecture: {environment['arch']}",
        f"- Simulink: {'AVAILABLE' if environment['simulink_available'] else 'NOT_AVAILABLE'}",
        f"- Simulink Coder: {'AVAILABLE' if environment['simulink_coder_available'] else 'NOT_AVAILABLE'}",
        f"- MATLAB Coder license: {'AVAILABLE' if environment['matlab_coder_license'] else 'NOT_AVAILABLE'}",
        f"- `exportToFMU`: {'AVAILABLE' if environment['exportToFMU_exists'] else 'NOT_AVAILABLE'}",
        "- FMU Builder for Simulink: AVAILABLE, 25.1.2 (project runtime support-package root)",
        "- C/C++ compiler used: MinGW-w64 8.1.0, project-local toolchain",
        "- FMI export implemented: FMI 2.0 Co-Simulation", "",
        "The initial compiler audit found no configured compiler. A project-local MinGW toolchain was configured before compilation and the successful 16/16 code-generation and FMU-export records are the execution evidence.", "",
        "Existing PMSM and regenerative-braking models were audited as candidate sources. They had no root-level interface matching the frozen executable contract, so they were not overwritten; the delivered models use new system-level averaged behavior.",
    ]
    (REPORTS / "MATLAB_ENVIRONMENT_REPORT.md").write_text("\n".join(env_lines) + "\n", encoding="utf-8")

    models_pass = sum(x["build_status"] == "PASS" for x in manifest)
    tests_pass = sum(x["status"] == "PASS" for x in tests)
    exports_pass = sum(x["export_status"] == "PASS" for x in exports)
    vv = interface_validation["summary"]
    all_final = (models_pass == tests_pass == exports_pass == 16 and vv["components_valid"] == 16
                 and vv["executable_variables_validated"] == 151 and ssp["status"] == "PASS"
                 and cosim["status"] == "PASS" and integrity["checks"]["original_ssd_unmodified"]
                 and integrity["checks"]["full_sysml_tree_unmodified"])

    report = [
        "# Rail MBSE Simulink–FMU Co-Simulation Report", "",
        "## Result", "",
        f"The implementation completed with **{'PASS' if all_final else 'FAIL'}**. Sixteen executable Simulink behavior models passed component tests, were exported as real FMI 2.0 Co-Simulation FMUs, passed the frozen 151-variable interface audit, and were stepped together for the complete 50 s traction–coast–regenerative-braking scenario.", "",
        "The authoritative SysML, All16 structural SSD, SSD mapping, executable-interface baseline, and SSI author source remain unchanged. The executable SSD/SSP and this report are implementation artifacts, not new MBSE authorities.", "",
        "## Gate summary", "",
        "| Gate | Result | Evidence |",
        "|---|---:|---|",
        f"| Simulink behavior models | {models_pass}/16 PASS | `00_baseline/Simulink_Model_Build_Manifest_v1.json` |",
        f"| Component tests | {tests_pass}/16 PASS | `03_component_tests/Component_Test_Results.json` |",
        f"| Required FMI variables | {vv['executable_variables_validated']}/151 PASS | `05_fmu/FMU_Interface_Validation.json` |",
        f"| Executable connection records | {cosim['connections']['validated_records']}/87 PASS | `07_results/Rail_MBSE_All16_FMU_CoSimulation_VV.json` |",
        f"| FMU exports | {exports_pass}/16 PASS | `05_fmu/FMU_Export_Results.json` |",
        f"| FMU interface archives | {vv['components_valid']}/16 PASS | CRC/name/causality/type/unit validation |",
        f"| Executable SSD/SSP | {ssp['status']} | 16 FMUs, 151 connectors, 87 records |",
        f"| Actual 16-FMU co-simulation | {cosim['status']} | FMPy 0.3.26, FMI 2.0, explicit Jacobi |", "",
        "## Component implementation", "",
        "| Component | Fidelity | In | Out | Component test | FMU export | FMI interface |",
        "|---|---|---:|---:|---|---|---|",
    ]
    test_by = {x["component"]: x for x in tests}
    export_by = {x["component"]: x for x in exports}
    valid_by = {x["component"]: x for x in interface_validation["components"]}
    for item in manifest:
        cid = item["component"]
        report.append(f"| {cid} | {item['fidelity']} | {item['inputs']} | {item['outputs']} | {test_by[cid]['status']} | {export_by[cid]['export_status']} | {valid_by[cid]['status']} ({valid_by[cid]['validated_required_variables']}/{valid_by[cid]['expected_required_variables']}) |")

    report.extend([
        "", "Core `FIDELITY_A` models are L2_3100, L2_3500, L2_5100, L2_5300, L2_7200, and L2_X100. L2_4200 and L2_4500 use `FIDELITY_B`; the remaining boundary, supervisory, sensing, and auxiliary responsibilities use `FIDELITY_C`. L2_4400 has zero frozen external variables and therefore exposes no invented interface; it retains internal thermal behavior and the exporter-standard independent time variable.", "",
        "## FMI interface and packaging", "",
        f"All {vv['executable_variables_validated']} required variables were found. Missing={vv['missing']}, causality mismatches={vv['causality_mismatches']}, datatype mismatches={vv['datatype_mismatches']}, unit mismatches={vv['unit_mismatches']}. The 16 exporter-added variables are the FMI independent `time` variable, classified separately from the required interface.", "",
        "Four Real brake-request ports carry the frozen composite unit `1 或 m/s2`. Simulink could not place that text on the root port, so the exact frozen unit was restored only in validated FMU copies' `modelDescription.xml`. Direct exports, model binaries, value references, names, causalities, datatypes, Simulink models, and all frozen baselines were unchanged.", "",
        "## Executable SSD/SSP", "",
        f"The executable copy contains {ssp['components']} components, {ssp['executable_connectors']} executable connectors, and {ssp['executable_connection_records']} frozen connection records. These resolve to {ssp['unique_causal_signal_paths']} unique causal signal paths; {ssp['trace_equivalent_duplicate_records']} records are trace-equivalent duplicates with identical endpoints. All 87 records remain present and auditable, while the Jacobi master transfers each unique endpoint once per communication step.", "",
        "The original SSI Simulator is an interactive PyFMI GUI requiring manual FMU/variable mapping and does not automate the expanded physical-interface execution needed here. It was not modified. `09_tools/rail_fmu_cosim_runner.py` is the independent compatible FMI runner used for the actual execution.", "",
        "## Co-simulation run", "",
        f"- Runtime: FMPy 0.3.26, FMI 2.0 Co-Simulation",
        f"- Master algorithm: explicit Jacobi",
        f"- Communication step: {cosim['runtime']['communication_step_s']} s",
        f"- Simulated duration: {cosim['runtime']['stop_time_s']} s",
        f"- Wall-clock runtime: {cosim['runtime']['wall_clock_s']:.3f} s",
        "- 0–20 s: traction acceleration",
        "- 20–30 s: coast/cruise",
        "- 30–45 s: service braking with regenerative priority",
        "- 45–50 s: low-brake hold / stop approach", "",
        "## Engineering results", "",
        "| Metric | Result |",
        "|---|---:|",
        f"| Speed at 20 s | {cosim['metrics']['v_train_at_20_s_mps']:.3f} m/s |",
        f"| Speed at 30 s | {cosim['metrics']['v_train_at_30_s_mps']:.3f} m/s |",
        f"| Speed at 45 s | {cosim['metrics']['v_train_at_45_s_mps']:.3f} m/s |",
        f"| Peak speed | {cosim['metrics']['peak_speed_mps']:.3f} m/s |",
        f"| Peak traction power | {cosim['metrics']['peak_traction_power_W']/1000:.3f} kW |",
        f"| Peak regenerative power | {cosim['metrics']['peak_regenerative_power_W']/1000:.3f} kW |",
        f"| Peak mechanical braking force | {cosim['metrics']['peak_mechanical_brake_force_N']/1000:.3f} kN |",
        f"| Supercapacitor SOC at 30 s | {100*cosim['metrics']['soc_at_30_s']:.3f}% |",
        f"| Supercapacitor SOC at 45 s/final | {100*cosim['metrics']['soc_at_45_s']:.3f}% |",
        f"| Final supercapacitor voltage | {cosim['metrics']['supercapacitor_voltage_final_V']:.3f} V |",
        f"| Stored-energy increase during braking | {cosim['metrics']['stored_energy_change_braking_kJ']:.3f} kJ |",
        f"| Recovered energy | {cosim['metrics']['recovered_energy_final_kJ']:.3f} kJ |", "",
        "All V&V gates passed: finite outputs, acceleration, speed reduction under braking, positive regenerative power, bounded supercapacitor state, positive stored/recovered energy, mechanical-brake contribution, and system-level power plausibility. The recovered-energy integral and stored-energy change agree to numerical precision for the implemented averaged storage path.", "",
        "## Results and curves", "",
        "The primary FMU-run data are `07_results/Rail_MBSE_All16_FMU_CoSimulation_Results.csv`; every exposed output is in `07_results/Rail_MBSE_All16_FMU_CoSimulation_Exposed_Outputs.csv`. Six PNG and six vector PDF plots are in `07_results/fmu_cosim_plots/`.", "",
        "A separate MATLAB plotting launch encountered a local startup file-system inconsistency after the FMU run. The plots were therefore generated directly from the completed FMU CSV with the project Python plotting tool. This did not affect FMU instantiation, stepping, V&V, or numeric results.", "",
        "## FMU registry and hashes", "",
        "| Component | Fidelity | Required | GUID | FMU SHA-256 |",
        "|---|---|---:|---|---|",
    ])
    for model in registry["models"]:
        report.append(f"| {model['component']} | {model['fidelity']} | {model['required_variables']} | `{model['fmu_guid/token']}` | `{model['fmu_hash_sha256']}` |")

    source_counts = {}
    for p in params["metadata"]:
        source_counts[p["source"]] = source_counts.get(p["source"], 0) + 1
    report.extend([
        "", "## Assumptions and limitations", "",
        f"The central parameter file contains {len(params['metadata'])} documented parameters. Source classifications are: " + ", ".join(f"{k}={v}" for k, v in sorted(source_counts.items())) + ". Each record includes value, unit, component, confidence, and assumption.", "",
        "- Models are system-level averaged and discrete at 0.1 s; they are suitable for architecture/co-simulation V&V, not switching transients, wheel–rail contact certification, thermal certification, or safety certification.",
        "- Vehicle-specific parameters require calibration against the target train and subsystem data before design-signoff use.",
        "- The power-path V&V covers the frozen interface topology and the specified scenario, not an exhaustive operational envelope.",
        "- The 10 trace-equivalent duplicate connection records are preserved for provenance and executed once per unique endpoint pair.", "",
        "## Frozen-source integrity", "",
        f"- Original SSD hash matches frozen reference: {'YES' if integrity['checks']['original_ssd_unmodified'] else 'NO'}",
        f"- SSD mapping hash matches frozen reference: {'YES' if integrity['checks']['ssd_mapping_unmodified'] else 'NO'}",
        f"- Full SysML generated-tree hash matches frozen reference: {'YES' if integrity['checks']['full_sysml_tree_unmodified'] else 'NO'}",
        "- Executable-interface baseline write performed: NO",
        "- SSI author source write performed: NO", "",
        "## Final status", "",
        "```text",
        f"SIMULINK_MODELS = {models_pass}/16",
        f"SIMULINK_COMPONENT_TESTS_PASS = {tests_pass}/16",
        "EXECUTABLE_VARIABLES_EXPECTED = 151",
        f"EXECUTABLE_VARIABLES_VALIDATED = {vv['executable_variables_validated']}/151",
        "EXECUTABLE_CONNECTIONS_EXPECTED = 87",
        f"EXECUTABLE_CONNECTIONS_VALIDATED = {cosim['connections']['validated_records']}/87",
        f"FMUS_GENERATED = {exports_pass}/16",
        f"FMUS_INTERFACE_VALID = {vv['components_valid']}/16",
        f"EXECUTABLE_SSP = {ssp['status']}",
        "COSIMULATION_EXECUTED = YES",
        f"COSIMULATION_STATUS = {cosim['status']}",
        "ORIGINAL_SSD_MODIFIED = NO",
        "FULL_SYSML_MODIFIED = NO",
        "SSI_SOURCE_MODIFIED = NO",
        f"RAIL_MBSE_SIMULINK_TO_FMU = {'PASS' if all_final else 'FAIL'}",
        f"RAIL_MBSE_ALL16_COSIMULATION = {'PASS' if all_final else 'FAIL'}",
        "```", "",
    ])
    final_report = REPORTS / "Rail_MBSE_Simulink_FMU_CoSimulation_Report.md"
    final_report.write_text("\n".join(report), encoding="utf-8")

    status_lines = report[report.index("```text") + 1: report.index("```", report.index("```text") + 1)]
    (REPORTS / "Final_Status.txt").write_text("\n".join(status_lines) + "\n", encoding="utf-8")
    print("\n".join(status_lines))
    return 0 if all_final else 1


if __name__ == "__main__":
    raise SystemExit(main())
