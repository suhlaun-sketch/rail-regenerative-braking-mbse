# V2 to V2.1 Brake Transition Comparison

| Metric | v2 | v2.1 | Classification |
|---|---:|---:|---|
| main_peak_overshoot_percent | 7.02461 | 7.02461 | control correction |
| steady_error_percent | 0.575861 | 0.575861 | control correction |
| low_speed_under_brake_percent | 36.2088 | 7.06268 | control correction |
| hold_transition_error_kN | 56 | 56 | control correction |
| hold_settling_s | 0.1 | 0.05 | control correction |
| stop_time_s | 41.55 | 41.5 | control correction |
| recovered_energy_MJ | 3.72412 | 3.72356 | control correction |
| final_soc_percent | 46.0837 | 46.082 | control correction |

V2.1 changes only brake blending/takeover and automatic standstill hold control. The HV, DC-link, energy-storage and frozen FMI interface definitions are unchanged.
