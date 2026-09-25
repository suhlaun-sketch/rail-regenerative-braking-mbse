# V1 vs V2 Comparison

| Metric | v1 | v2 | Change classification |
|---|---:|---:|---|
| peak_speed_mps | 11.6262 | 11.5619 | physics-consistent recomputation |
| traction_energy_MJ | 5.96246 | 6.12122 | physics-consistent recomputation |
| peak_traction_power_kW | 679.677 | 688.965 | physics-consistent recomputation |
| peak_regen_power_kW | 540.779 | 526.441 | physics-consistent recomputation |
| stopping_time_s | 41.5 | 41.55 | bug/physics/control correction |
| peak_total_brake_force_kN | 106.531 | 85.6197 | physics-consistent recomputation |
| brake_overshoot_percent | 33.164 | 7.02461 | bug/physics/control correction |
| motor_regen_energy_MJ | 4.23279 | 4.30268 | physics-consistent recomputation |
| ess_stored_recovered_MJ | 3.86031 | 3.72412 | physics-consistent recomputation |
| overall_recovery_percent | 91.2 | 86.5536 | physics-consistent recomputation |
| soc_initial_percent | 35 | 35 | physics-consistent recomputation |
| soc_final_percent | 46.489 | 46.0837 | physics-consistent recomputation |
| voltage_initial_V | 667.832 | 667.832 | physics-consistent recomputation |
| voltage_final_V | 714.38 | 712.789 | physics-consistent recomputation |
| hv_chain | FAIL | PASS | bug/physics/control correction |

The supply-chain closure is a bug/physics correction; brake-force changes are control corrections; energy and power changes use consistent physical boundaries and trapezoidal integration.
