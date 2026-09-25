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

- runtime_s: 9.5043712
- v5_mps: 1.83187113
- v20_mps: 11.3337161
- v30_mps: 11.1643907
- v45_mps: 0
- peak_traction_power_W: 679676.735
- peak_regen_power_W: 540779.38
- peak_mechanical_force_N: 80000
- soc_initial: 0.35
- soc_30s: 0.35
- soc_45s: 0.464890115
- recovered_energy_kJ: 3860.30788
- energy_balance_relative_error: 3.01570045e-15

The energy balance compares supercapacitor stored-energy increase with integrated exposed absorbed power during the braking interval.
