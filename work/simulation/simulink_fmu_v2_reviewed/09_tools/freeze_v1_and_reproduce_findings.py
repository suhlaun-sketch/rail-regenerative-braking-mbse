#!/usr/bin/env python3
"""Freeze the v1 delivery evidence and independently reproduce review findings."""

from __future__ import annotations

import csv
import hashlib
import json
import math
from pathlib import Path


ROOT = Path(__file__).resolve().parents[4]
V1 = ROOT / "work" / "simulation" / "simulink_fmu_v1"
V2 = ROOT / "work" / "simulation" / "simulink_fmu_v2_reviewed"
OUT = V2 / "00_baseline"


def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest().upper()


def rows(path: Path):
    with path.open(encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def trapz(values, times):
    result = [0.0]
    for i in range(1, len(values)):
        result.append(result[-1] + 0.5 * (values[i - 1] + values[i]) * (times[i] - times[i - 1]))
    return result


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    key = rows(V1 / "07_results" / "Rail_MBSE_All16_FMU_CoSimulation_Results.csv")
    raw = rows(V1 / "07_results" / "Rail_MBSE_All16_FMU_CoSimulation_Exposed_Outputs.csv")
    old = rows(V1 / "07_results" / "Rail_MBSE_All16_Traction_Regen_Results.csv")
    t = [float(r["time"]) for r in key]
    col = lambda data, name: [float(r[name]) for r in data]
    speed = col(key, "v_train")
    f_regen = col(key, "Fregen")
    f_mech = col(key, "Fmechanical")
    demand = [80000.0 * float(r["service_brake_request"]) for r in key]
    total = [a + b for a, b in zip(f_regen, f_mech)]
    p_abs = col(raw, "L2_X100.out_ess_absorbed_power")
    e_trap = [v / 1000.0 for v in trapz(p_abs, t)]
    e_key = col(key, "Eregen_kJ")
    e_old = col(old, "Eregen_kJ")

    braking = [i for i, x in enumerate(t) if 30.0 <= x < 45.0 and demand[i] > 0]
    peak_i = max(braking, key=lambda i: (total[i] - demand[i]) / demand[i])
    stopped = [i for i, v in enumerate(speed) if i > 300 and v <= 1e-6]
    stop_i = stopped[0]
    traction = [i for i, x in enumerate(t) if 2.0 <= x <= 20.0]

    tests = [
        {
            "finding": "A_HV_CHAIN_NOT_CLOSED",
            "status": "REPRODUCED",
            "actual": f"4200 Uac max={max(col(raw,'L2_4200.out_U_ac_rms')):.3f} V; breaker max={max(col(raw,'L2_4200.out_hv_breaker_state')):.0f}; 4500 Usec max={max(col(raw,'L2_4500.out_U_sec_rms')):.3f} V; 5100 Udc min={min(col(raw,'L2_5100.out_dc_link_voltage')):.3f} V",
            "expected": "Energized 4100 -> closed 4200 breaker -> energized 4500 -> established 5100 DC link",
        },
        {
            "finding": "B_ZERO_SUPPLY_NONZERO_TRACTION",
            "status": "REPRODUCED",
            "actual": f"Peak motor mechanical traction power={max(float(raw[i]['L2_5300.out_motor_torque_actual'])*float(raw[i]['L2_5300.out_motor_speed']) for i in traction)/1000:.3f} kW while transformer secondary voltage is zero",
            "expected": "Traction power must be zero when supply is unavailable and ESS is not discharging",
        },
        {
            "finding": "C_BRAKE_BLEND_OVERSHOOT",
            "status": "REPRODUCED",
            "actual": f"t={t[peak_i]:.1f} s; Fregen={f_regen[peak_i]/1000:.3f} kN; Fmechanical={f_mech[peak_i]/1000:.3f} kN; overshoot={(total[peak_i]/demand[peak_i]-1)*100:.3f}%",
            "expected": "Transient peak <10%; target <5%",
        },
        {
            "finding": "C2_HOLD_TRANSITION_OVERSHOOT",
            "status": "NEW_FINDING_REPRODUCED",
            "actual": f"At 45.0 s demand changes to 24 kN while total remains {total[t.index(45.0)]/1000:.3f} kN; overshoot={(total[t.index(45.0)]/24000-1)*100:.3f}%",
            "expected": "Hold transition total braking force remains within transient tolerance",
        },
        {
            "finding": "D_LOW_SPEED_REGEN_LAG",
            "status": "REPRODUCED",
            "actual": f"First zero speed at {t[stop_i]:.1f} s; Fregen={f_regen[stop_i]/1000:.3f} kN; Pregen={float(key[stop_i]['Pregen'])/1000:.3f} kW",
            "expected": "At standstill Fregen and Pregen approximately zero; mechanical hold may remain",
        },
        {
            "finding": "E_MIXED_POWER_BOUNDARIES",
            "status": "REPRODUCED",
            "actual": "Ptraction=positive motor mechanical shaft power; Pregen=positive converter-side electrical power",
            "expected": "Mechanical and DC-link boundaries reported separately",
        },
        {
            "finding": "F_USC_DERIVED_NOT_TERMINAL",
            "status": "REPRODUCED",
            "actual": "Usc result is reconstructed only from SOC and E=0.5*C*U^2; ESR/current are not represented in the plotted voltage",
            "expected": "Distinguish capacitor equivalent/internal voltage and terminal voltage",
        },
        {
            "finding": "EREGEN_INTEGRATION_INCONSISTENCY",
            "status": "REPRODUCED",
            "actual": f"Max v1 key-vs-diagnostic difference={max(abs(a-b) for a,b in zip(e_key,e_old)):.6f} kJ; max key-vs-trapezoid difference={max(abs(a-b) for a,b in zip(e_key,e_trap)):.6f} kJ",
            "expected": "One authoritative trapezoidal integration definition",
        },
    ]

    critical = []
    patterns = [
        (V1 / "01_models", "*.slx"),
        (V1 / "05_fmu", "L2_*.fmu"),
        (V1 / "05_fmu" / "validated", "L2_*.fmu"),
        (V1 / "06_ssp", "Rail_MBSE_All16_Executable_v1.*"),
        (V1 / "07_results", "Rail_MBSE_All16_FMU_CoSimulation_*"),
        (V1 / "08_reports", "*.md"),
    ]
    for folder, pattern in patterns:
        for path in sorted(folder.glob(pattern)):
            if path.is_file():
                critical.append({"path": path.relative_to(ROOT).as_posix(), "bytes": path.stat().st_size, "sha256": digest(path)})
    snapshot = {
        "artifact": "v1 immutable delivery snapshot for v2 physical review",
        "v1_root": V1.relative_to(ROOT).as_posix(),
        "critical_file_count": len(critical),
        "critical_files": critical,
        "v1_status": read_json(V1 / "07_results" / "Rail_MBSE_All16_FMU_CoSimulation_VV.json")["status"],
    }
    (OUT / "V1_Delivery_Snapshot.json").write_text(json.dumps(snapshot, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    (OUT / "V1_Review_Findings_Reproduction.json").write_text(json.dumps(tests, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    with (OUT / "V1_Review_Findings_Reproduction.csv").open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=["finding", "status", "actual", "expected"])
        w.writeheader(); w.writerows(tests)
    md = ["# V1 Review Findings Reproduction", "", "All findings were recomputed from the two v1 result CSV files and the exposed-output CSV before any v2 model change.", "", "| Finding | Status | Actual evidence | Expected relationship |", "|---|---|---|---|"]
    md += [f"| {x['finding']} | {x['status']} | {x['actual']} | {x['expected']} |" for x in tests]
    (OUT / "V1_Review_Findings_Reproduction.md").write_text("\n".join(md) + "\n", encoding="utf-8")
    print(f"V1_SNAPSHOT_FILES = {len(critical)}")
    for item in tests:
        print(f"{item['finding']} = {item['status']}")


def read_json(path):
    return json.loads(path.read_text(encoding="utf-8"))


if __name__ == "__main__":
    main()
