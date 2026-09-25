# FMU Interface Validation Report

The frozen executable-interface JSON is the implementation authority. This report validates actual exported FMI 2.0 Co-Simulation archives; it does not redefine the MBSE interface.

- Components valid: 16/16
- Required variables validated: 151/151
- Missing required variables: 0
- Causality mismatches: 0
- Datatype mismatches: 0
- Unit mismatches: 0
- Exporter internal variables: 16 (the standard independent `time` variable, excluded from the required-interface count)
- Result: **PASS**

## Packaging metadata normalization

No normalization was required.

## Component results

| Component | Required | Validated | FMI | CRC | Status |
|---|---:|---:|---|---|---|
| L2_3100 | 6 | 6 | Co-Simulation | PASS | PASS |
| L2_3500 | 4 | 4 | Co-Simulation | PASS | PASS |
| L2_3600 | 4 | 4 | Co-Simulation | PASS | PASS |
| L2_3800 | 1 | 1 | Co-Simulation | PASS | PASS |
| L2_4100 | 5 | 5 | Co-Simulation | PASS | PASS |
| L2_4200 | 15 | 15 | Co-Simulation | PASS | PASS |
| L2_4400 | 0 | 0 | Co-Simulation | PASS | PASS |
| L2_4500 | 9 | 9 | Co-Simulation | PASS | PASS |
| L2_5100 | 19 | 19 | Co-Simulation | PASS | PASS |
| L2_5300 | 9 | 9 | Co-Simulation | PASS | PASS |
| L2_7100 | 1 | 1 | Co-Simulation | PASS | PASS |
| L2_7200 | 14 | 14 | Co-Simulation | PASS | PASS |
| L2_8100 | 46 | 46 | Co-Simulation | PASS | PASS |
| L2_D100 | 4 | 4 | Co-Simulation | PASS | PASS |
| L2_E100 | 2 | 2 | Co-Simulation | PASS | PASS |
| L2_X100 | 12 | 12 | Co-Simulation | PASS | PASS |
