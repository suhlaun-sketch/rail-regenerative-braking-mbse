# Rail MBSE System V&V Report

Scenario: 0-20 s traction; 20-30 s coast; 30-45 s regenerative braking; 45-50 s stop hold.

Overall status: **PASS**

| Check | Result |
|---|---|
| acceleration | true |
| braking_deceleration | true |
| regen_power_direction | true |
| supercap_charging | true |
| soc_bounds | true |
| mechanical_brake_supplement | true |
| finite | true |
| power_plausibility | true |
| energy_balance | true |

## Key metrics

- runtime_s: 9.5635157
- v5_mps: 1.99202969
- v20_mps: 11.5941427
- v30_mps: 11.1368307
- v45_mps: 0
- peak_traction_power_W: 702027.28
- peak_regen_power_W: 540854.889
- peak_mechanical_force_N: 79999.9985
- soc_initial: 0.35
- soc_30s: 0.35
- soc_45s: 0.463719282
- recovered_energy_kJ: 3820.96787
- energy_balance_relative_error: 8.16528882e-15

The energy balance compares supercapacitor stored-energy increase with integrated exposed absorbed power during the braking interval.
