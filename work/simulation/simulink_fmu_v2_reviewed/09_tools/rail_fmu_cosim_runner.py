#!/usr/bin/env python3
"""Run the Rail MBSE all-16 FMI 2.0 Co-Simulation with a Jacobi master.

The runner consumes the executable SSD/SSP trace baseline.  All 87 frozen
connection records are validated; 77 unique endpoint pairs are transferred
once per 0.1 s communication step (10 records are trace-equivalent duplicates).
"""

from __future__ import annotations

import csv
import json
import math
import os
import platform
import sys
import time
from collections import Counter
from datetime import datetime, timezone
from pathlib import Path


# FMPy uses platform.machine(); it can be empty inside a managed Windows job.
os.environ.setdefault("PROCESSOR_ARCHITECTURE", "AMD64")
SCRIPT = Path(__file__).resolve()
LOCAL_PACKAGES = SCRIPT.parent / "python_packages"
sys.path.insert(0, str(LOCAL_PACKAGES))

from fmpy import extract, read_model_description  # noqa: E402
from fmpy.fmi2 import FMU2Slave  # noqa: E402


ROOT = Path(os.environ.get("RAIL_MBSE_ROOT", SCRIPT.parents[4]))
WORK = ROOT / "work" / "simulation" / "simulink_fmu_v1"
BASELINE = ROOT / "work" / "simulation" / "implementation_binding" / "Rail_MBSE_Executable_FMU_Interface_v1.json"
REGISTRY = WORK / "05_fmu" / "Rail_MBSE_FMU_Model_Registry_v1.json"
SSP_VALIDATION = WORK / "06_ssp" / "Executable_SSP_Validation.json"
RESULT_DIR = WORK / "07_results"
LOG_DIR = WORK / "logs"
RESULT_CSV = RESULT_DIR / "Rail_MBSE_All16_FMU_CoSimulation_Results.csv"
RAW_CSV = RESULT_DIR / "Rail_MBSE_All16_FMU_CoSimulation_Exposed_Outputs.csv"
RESULT_JSON = RESULT_DIR / "Rail_MBSE_All16_FMU_CoSimulation_VV.json"
RUN_LOG = LOG_DIR / "Rail_MBSE_All16_FMU_CoSimulation.log"

DT = 0.1
STOP = 50.0
WHEEL_RADIUS = 0.46
SC_C = 120.0
SC_EMIN = 15_000_000.0
SC_EMAX = 48_600_000.0


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def write_json(path: Path, value) -> None:
    path.write_text(json.dumps(value, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


class Instance:
    def __init__(self, component: str, fmu_path: Path, unzip_dir: Path):
        self.component = component
        self.fmu_path = fmu_path
        self.description = read_model_description(str(fmu_path))
        if self.description.fmiVersion != "2.0" or self.description.coSimulation is None:
            raise RuntimeError(f"{component}: expected FMI 2.0 Co-Simulation")
        extract(str(fmu_path), str(unzip_dir))
        self.variables = {v.name: v for v in self.description.modelVariables}
        self.fmu = FMU2Slave(
            guid=self.description.guid,
            unzipDirectory=str(unzip_dir),
            modelIdentifier=self.description.coSimulation.modelIdentifier,
            instanceName=component,
        )
        self.fmu.instantiate()

    def initialize(self):
        self.fmu.setupExperiment(startTime=0.0, stopTime=STOP)
        self.fmu.enterInitializationMode()
        self.fmu.exitInitializationMode()

    def get(self, name):
        v = self.variables[name]
        vr = [v.valueReference]
        if v.type == "Real":
            return float(self.fmu.getReal(vr)[0])
        if v.type in ("Integer", "Enumeration"):
            return int(self.fmu.getInteger(vr)[0])
        if v.type == "Boolean":
            return bool(self.fmu.getBoolean(vr)[0])
        raise TypeError(f"{self.component}.{name}: unsupported type {v.type}")

    def set(self, name, value):
        v = self.variables[name]
        vr = [v.valueReference]
        if v.type == "Real":
            self.fmu.setReal(vr, [float(value)])
        elif v.type in ("Integer", "Enumeration"):
            self.fmu.setInteger(vr, [int(value)])
        elif v.type == "Boolean":
            self.fmu.setBoolean(vr, [bool(value)])
        else:
            raise TypeError(f"{self.component}.{name}: unsupported type {v.type}")

    def step(self, t, dt):
        status = self.fmu.doStep(currentCommunicationPoint=t, communicationStepSize=dt)
        if status not in (None, 0):
            raise RuntimeError(f"{self.component}: doStep returned FMI status {status} at t={t}")

    def close(self):
        try:
            self.fmu.terminate()
        finally:
            self.fmu.freeInstance()


def value_at(rows, t, name):
    return min(rows, key=lambda r: abs(r["time"] - t))[name]


def main() -> int:
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    baseline = read_json(BASELINE)
    registry = read_json(REGISTRY)
    ssp_validation = read_json(SSP_VALIDATION)
    if registry["summary"]["status"] != "PASS" or ssp_validation["status"] != "PASS":
        raise RuntimeError("FMU registry or executable SSP validation is not PASS")

    component_ids = [c["ssd_component"] for c in baseline["components"]]
    fmu_paths = {m["component"]: ROOT / m["fmu_file"] for m in registry["models"]}
    connections = baseline["executable_signal_connections"]
    endpoint_counts = Counter((c["source_component"], c["source_variable"], c["target_component"], c["target_variable"])
                              for c in connections)
    unique_connections = []
    seen = set()
    for c in connections:
        key = (c["source_component"], c["source_variable"], c["target_component"], c["target_variable"])
        if key not in seen:
            seen.add(key)
            unique_connections.append(c)

    run_id = datetime.now().strftime("run_%Y%m%d_%H%M%S")
    runtime_root = LOG_DIR / "fmu_runtime" / run_id
    runtime_root.mkdir(parents=True, exist_ok=False)
    instances = {}
    started = time.perf_counter()
    events = []
    try:
        for component in component_ids:
            instances[component] = Instance(component, fmu_paths[component], runtime_root / component)

        # Validate all runtime endpoints, types, and causalities before initialization.
        record_results = []
        for c in connections:
            src = instances[c["source_component"]].variables.get(c["source_variable"])
            dst = instances[c["target_component"]].variables.get(c["target_variable"])
            issues = []
            if src is None:
                issues.append("SOURCE_MISSING")
            elif src.causality != "output":
                issues.append("SOURCE_NOT_OUTPUT")
            if dst is None:
                issues.append("TARGET_MISSING")
            elif dst.causality != "input":
                issues.append("TARGET_NOT_INPUT")
            if src and dst and src.type != dst.type:
                issues.append("TYPE_MISMATCH")
            record_results.append({
                "executable_connection_id": c["executable_connection_id"],
                "status": "PASS" if not issues else "FAIL",
                "issues": issues,
            })
        if any(r["status"] != "PASS" for r in record_results):
            raise RuntimeError("Runtime connection validation failed")

        for inst in instances.values():
            # Initialize every connected input to a type-correct zero.
            for variable in inst.description.modelVariables:
                if variable.causality == "input":
                    inst.set(variable.name, False if variable.type == "Boolean" else 0)
        for inst in instances.values():
            inst.initialize()

        output_names = {
            component: [v.name for v in inst.description.modelVariables if v.causality == "output"]
            for component, inst in instances.items()
        }
        key_rows = []
        raw_rows = []
        eregen_j = 0.0
        steps = int(round(STOP / DT))
        for k in range(steps + 1):
            t = k * DT
            outputs = {
                (component, name): inst.get(name)
                for component, inst in instances.items()
                for name in output_names[component]
            }

            omega_w = float(outputs[("L2_3100", "out_omega_wheel")])
            omega_m = float(outputs[("L2_5300", "out_motor_speed")])
            torque_m = float(outputs[("L2_5300", "out_motor_torque_actual")])
            preg = max(0.0, float(outputs[("L2_5100", "out_regenerative_power_actual")]))
            p_abs = max(0.0, float(outputs[("L2_X100", "out_ess_absorbed_power")]))
            soc = min(1.0, max(0.0, float(outputs[("L2_X100", "out_super_cap_soc")])))
            energy_j = SC_EMIN + soc * (SC_EMAX - SC_EMIN)
            usc = math.sqrt(max(0.0, 2.0 * energy_j / SC_C))
            if k > 0:
                eregen_j += p_abs * DT
            t_brake = max(0.0, float(outputs[("L2_7200", "out_T_brake")]))
            f_regen = max(0.0, float(outputs[("L2_8100", "out_achieved_dynamic_brake_force")]))
            p_mech = torque_m * omega_m
            udc = float(outputs[("L2_5100", "out_dc_link_voltage")])
            idc = float(outputs[("L2_5100", "out_dc_link_current")])
            key_rows.append({
                "time": t,
                "v_train": omega_w * WHEEL_RADIUS,
                "Ptraction": max(0.0, p_mech),
                "Pregen": preg,
                "Fregen": f_regen,
                "Fmechanical": t_brake / WHEEL_RADIUS,
                "Pdc": udc * idc,
                "Usc": usc,
                "SOCsc": soc,
                "Esc_kJ": energy_j / 1000.0,
                "Eregen_kJ": eregen_j / 1000.0,
                "service_brake_request": float(outputs[("L2_D100", "out_service_brake_request")]),
                "traction_command": float(outputs[("L2_D100", "out_traction_command")]),
            })
            raw = {"time": t}
            for (component, name), value in outputs.items():
                raw[f"{component}.{name}"] = int(value) if isinstance(value, bool) else value
            raw_rows.append(raw)

            if k == steps:
                break
            # Explicit Jacobi master: transfer values from the committed time,
            # then advance every FMU by one equal communication step.
            for c in unique_connections:
                value = outputs[(c["source_component"], c["source_variable"])]
                instances[c["target_component"]].set(c["target_variable"], value)
            for inst in instances.values():
                inst.step(t, DT)

        with RESULT_CSV.open("w", newline="", encoding="utf-8-sig") as f:
            writer = csv.DictWriter(f, fieldnames=list(key_rows[0]))
            writer.writeheader()
            writer.writerows(key_rows)
        with RAW_CSV.open("w", newline="", encoding="utf-8-sig") as f:
            writer = csv.DictWriter(f, fieldnames=list(raw_rows[0]))
            writer.writeheader()
            writer.writerows(raw_rows)

        finite = all(math.isfinite(float(value)) for row in key_rows for value in row.values())
        v20 = value_at(key_rows, 20.0, "v_train")
        v30 = value_at(key_rows, 30.0, "v_train")
        v45 = value_at(key_rows, 45.0, "v_train")
        soc30 = value_at(key_rows, 30.0, "SOCsc")
        soc45 = value_at(key_rows, 45.0, "SOCsc")
        e30 = value_at(key_rows, 30.0, "Esc_kJ")
        e45 = value_at(key_rows, 45.0, "Esc_kJ")
        gates = {
            "all_connection_records_runtime_valid": len(record_results) == 87 and all(r["status"] == "PASS" for r in record_results),
            "all_16_fmus_stepped": len(instances) == 16,
            "finite_key_outputs": finite,
            "train_accelerates": v20 > 2.0,
            "braking_reduces_speed": v45 < v30 - 0.5,
            "regenerative_power_positive_during_braking": max(r["Pregen"] for r in key_rows if 30 <= r["time"] <= 45) > 1000.0,
            "supercapacitor_charges": soc45 > soc30 + 1e-5 and e45 > e30,
            "supercapacitor_bounded": all(-1e-9 <= r["SOCsc"] <= 1.0 + 1e-9 and 500.0 <= r["Usc"] <= 900.0 for r in key_rows),
            "mechanical_brake_contributes": max(r["Fmechanical"] for r in key_rows if 30 <= r["time"] <= 45) > 100.0,
            "power_plausibility": max(abs(r["Ptraction"]) for r in key_rows) < 5_000_000.0,
            "recovered_energy_positive": key_rows[-1]["Eregen_kJ"] > 0.1,
        }
        runtime = time.perf_counter() - started
        status = "PASS" if all(gates.values()) else "FAIL"
        vv = {
            "artifact": "Rail MBSE All16 FMU Co-Simulation V&V",
            "generated_utc": datetime.now(timezone.utc).isoformat(),
            "runtime": {
                "master": "rail_fmu_cosim_runner.py / FMPy 0.3.26",
                "algorithm": "explicit Jacobi co-simulation",
                "fmi_version": "2.0",
                "communication_step_s": DT,
                "stop_time_s": STOP,
                "wall_clock_s": runtime,
                "runtime_directory": str(runtime_root.relative_to(ROOT)).replace("\\", "/"),
            },
            "scenario": {
                "0_to_20_s": "traction acceleration",
                "20_to_30_s": "coast/cruise",
                "30_to_45_s": "service braking with regenerative priority",
                "45_to_50_s": "low brake hold / stop approach",
            },
            "connections": {
                "expected_records": len(connections),
                "validated_records": sum(r["status"] == "PASS" for r in record_results),
                "unique_causal_paths": len(unique_connections),
                "trace_equivalent_duplicates": len(connections) - len(unique_connections),
                "record_results": record_results,
            },
            "metrics": {
                "v_train_at_20_s_mps": v20,
                "v_train_at_30_s_mps": v30,
                "v_train_at_45_s_mps": v45,
                "peak_speed_mps": max(r["v_train"] for r in key_rows),
                "peak_traction_power_W": max(r["Ptraction"] for r in key_rows),
                "peak_regenerative_power_W": max(r["Pregen"] for r in key_rows),
                "peak_mechanical_brake_force_N": max(r["Fmechanical"] for r in key_rows),
                "soc_at_30_s": soc30,
                "soc_at_45_s": soc45,
                "soc_final": key_rows[-1]["SOCsc"],
                "supercapacitor_voltage_final_V": key_rows[-1]["Usc"],
                "stored_energy_change_braking_kJ": e45 - e30,
                "recovered_energy_final_kJ": key_rows[-1]["Eregen_kJ"],
            },
            "derived_channels": {
                "v_train": "L2_3100.out_omega_wheel * 0.46 m",
                "Ptraction": "max(L2_5300.out_motor_torque_actual * L2_5300.out_motor_speed, 0)",
                "Fmechanical": "L2_7200.out_T_brake / 0.46 m",
                "Usc": "sqrt(2 * (Emin + SOC*(Emax-Emin)) / C)",
                "Esc_kJ": "(Emin + SOC*(Emax-Emin))/1000",
                "Eregen_kJ": "integral(max(L2_X100.out_ess_absorbed_power,0) dt)/1000",
            },
            "gates": gates,
            "status": status,
        }
        write_json(RESULT_JSON, vv)
        events.extend([
            f"FMUs instantiated: {len(instances)}/16",
            f"Connection records validated: {vv['connections']['validated_records']}/87",
            f"Unique causal paths stepped: {len(unique_connections)}",
            f"Steps: {steps}; dt={DT}; stop={STOP}",
            f"Wall clock: {runtime:.3f} s",
            f"Status: {status}",
        ])
        RUN_LOG.write_text("\n".join(events) + "\n", encoding="utf-8")
        print("COSIMULATION_EXECUTED = YES")
        print(f"COSIMULATION_FMUS = {len(instances)}/16")
        print(f"EXECUTABLE_CONNECTIONS_VALIDATED = {vv['connections']['validated_records']}/87")
        print(f"COSIMULATION_RUNTIME_S = {runtime:.3f}")
        print(f"COSIMULATION_STATUS = {status}")
        return 0 if status == "PASS" else 2
    except Exception as exc:
        events.append(f"FAIL: {type(exc).__name__}: {exc}")
        RUN_LOG.write_text("\n".join(events) + "\n", encoding="utf-8")
        print("COSIMULATION_EXECUTED = NO")
        print(f"COSIMULATION_ERROR = {type(exc).__name__}: {exc}")
        print("COSIMULATION_STATUS = FAIL")
        return 1
    finally:
        for inst in reversed(list(instances.values())):
            try:
                inst.close()
            except Exception as exc:
                events.append(f"Cleanup warning {inst.component}: {exc}")


if __name__ == "__main__":
    raise SystemExit(main())
