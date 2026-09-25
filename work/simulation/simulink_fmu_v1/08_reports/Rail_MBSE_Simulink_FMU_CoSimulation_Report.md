# Rail MBSE Simulink–FMU Co-Simulation Report

## Result

The implementation completed with **PASS**. Sixteen executable Simulink behavior models passed component tests, were exported as real FMI 2.0 Co-Simulation FMUs, passed the frozen 151-variable interface audit, and were stepped together for the complete 50 s traction–coast–regenerative-braking scenario.

The authoritative SysML, All16 structural SSD, SSD mapping, executable-interface baseline, and SSI author source remain unchanged. The executable SSD/SSP and this report are implementation artifacts, not new MBSE authorities.

## Gate summary

| Gate | Result | Evidence |
|---|---:|---|
| Simulink behavior models | 16/16 PASS | `00_baseline/Simulink_Model_Build_Manifest_v1.json` |
| Component tests | 16/16 PASS | `03_component_tests/Component_Test_Results.json` |
| Required FMI variables | 151/151 PASS | `05_fmu/FMU_Interface_Validation.json` |
| Executable connection records | 87/87 PASS | `07_results/Rail_MBSE_All16_FMU_CoSimulation_VV.json` |
| FMU exports | 16/16 PASS | `05_fmu/FMU_Export_Results.json` |
| FMU interface archives | 16/16 PASS | CRC/name/causality/type/unit validation |
| Executable SSD/SSP | PASS | 16 FMUs, 151 connectors, 87 records |
| Actual 16-FMU co-simulation | PASS | FMPy 0.3.26, FMI 2.0, explicit Jacobi |

## Component implementation

| Component | Fidelity | In | Out | Component test | FMU export | FMI interface |
|---|---|---:|---:|---|---|---|
| L2_3100 | FIDELITY_A | 2 | 4 | PASS | PASS | PASS (6/6) |
| L2_3500 | FIDELITY_A | 2 | 2 | PASS | PASS | PASS (4/4) |
| L2_3600 | FIDELITY_C | 3 | 1 | PASS | PASS | PASS (4/4) |
| L2_3800 | FIDELITY_C | 1 | 0 | PASS | PASS | PASS (1/1) |
| L2_4100 | FIDELITY_C | 2 | 3 | PASS | PASS | PASS (5/5) |
| L2_4200 | FIDELITY_B | 6 | 9 | PASS | PASS | PASS (15/15) |
| L2_4400 | FIDELITY_C | 0 | 0 | PASS | PASS | PASS (0/0) |
| L2_4500 | FIDELITY_B | 5 | 4 | PASS | PASS | PASS (9/9) |
| L2_5100 | FIDELITY_A | 9 | 10 | PASS | PASS | PASS (19/19) |
| L2_5300 | FIDELITY_A | 3 | 6 | PASS | PASS | PASS (9/9) |
| L2_7100 | FIDELITY_C | 0 | 1 | PASS | PASS | PASS (1/1) |
| L2_7200 | FIDELITY_A | 10 | 4 | PASS | PASS | PASS (14/14) |
| L2_8100 | FIDELITY_C | 29 | 17 | PASS | PASS | PASS (46/46) |
| L2_D100 | FIDELITY_C | 0 | 4 | PASS | PASS | PASS (4/4) |
| L2_E100 | FIDELITY_C | 0 | 2 | PASS | PASS | PASS (2/2) |
| L2_X100 | FIDELITY_A | 5 | 7 | PASS | PASS | PASS (12/12) |

Core `FIDELITY_A` models are L2_3100, L2_3500, L2_5100, L2_5300, L2_7200, and L2_X100. L2_4200 and L2_4500 use `FIDELITY_B`; the remaining boundary, supervisory, sensing, and auxiliary responsibilities use `FIDELITY_C`. L2_4400 has zero frozen external variables and therefore exposes no invented interface; it retains internal thermal behavior and the exporter-standard independent time variable.

## FMI interface and packaging

All 151 required variables were found. Missing=0, causality mismatches=0, datatype mismatches=0, unit mismatches=0. The 16 exporter-added variables are the FMI independent `time` variable, classified separately from the required interface.

Four Real brake-request ports carry the frozen composite unit `1 或 m/s2`. Simulink could not place that text on the root port, so the exact frozen unit was restored only in validated FMU copies' `modelDescription.xml`. Direct exports, model binaries, value references, names, causalities, datatypes, Simulink models, and all frozen baselines were unchanged.

## Executable SSD/SSP

The executable copy contains 16 components, 151 executable connectors, and 87 frozen connection records. These resolve to 77 unique causal signal paths; 10 records are trace-equivalent duplicates with identical endpoints. All 87 records remain present and auditable, while the Jacobi master transfers each unique endpoint once per communication step.

The original SSI Simulator is an interactive PyFMI GUI requiring manual FMU/variable mapping and does not automate the expanded physical-interface execution needed here. It was not modified. `09_tools/rail_fmu_cosim_runner.py` is the independent compatible FMI runner used for the actual execution.

## Co-simulation run

- Runtime: FMPy 0.3.26, FMI 2.0 Co-Simulation
- Master algorithm: explicit Jacobi
- Communication step: 0.1 s
- Simulated duration: 50.0 s
- Wall-clock runtime: 1.546 s
- 0–20 s: traction acceleration
- 20–30 s: coast/cruise
- 30–45 s: service braking with regenerative priority
- 45–50 s: low-brake hold / stop approach

## Engineering results

| Metric | Result |
|---|---:|
| Speed at 20 s | 11.334 m/s |
| Speed at 30 s | 11.164 m/s |
| Speed at 45 s | 0.000 m/s |
| Peak speed | 11.626 m/s |
| Peak traction power | 679.677 kW |
| Peak regenerative power | 540.779 kW |
| Peak mechanical braking force | 80.000 kN |
| Supercapacitor SOC at 30 s | 35.000% |
| Supercapacitor SOC at 45 s/final | 46.489% |
| Final supercapacitor voltage | 714.380 V |
| Stored-energy increase during braking | 3860.308 kJ |
| Recovered energy | 3860.308 kJ |

All V&V gates passed: finite outputs, acceleration, speed reduction under braking, positive regenerative power, bounded supercapacitor state, positive stored/recovered energy, mechanical-brake contribution, and system-level power plausibility. The recovered-energy integral and stored-energy change agree to numerical precision for the implemented averaged storage path.

## Results and curves

The primary FMU-run data are `07_results/Rail_MBSE_All16_FMU_CoSimulation_Results.csv`; every exposed output is in `07_results/Rail_MBSE_All16_FMU_CoSimulation_Exposed_Outputs.csv`. Six PNG and six vector PDF plots are in `07_results/fmu_cosim_plots/`.

A separate MATLAB plotting launch encountered a local startup file-system inconsistency after the FMU run. The plots were therefore generated directly from the completed FMU CSV with the project Python plotting tool. This did not affect FMU instantiation, stepping, V&V, or numeric results.

## FMU registry and hashes

| Component | Fidelity | Required | GUID | FMU SHA-256 |
|---|---|---:|---|---|
| L2_3100 | FIDELITY_A | 6 | `{90f9739b-d771-5e90-870f-edbcd80a48a2}` | `a90eb0932d56655082914c12711c277c7c3e5fc0aca5089fd1fef4f03c6fee6c` |
| L2_3500 | FIDELITY_A | 4 | `{21b4132a-a6f3-c9a2-9b65-787f8227020a}` | `c65ab1e1d4fdebd2305e5f0dc31e171136d992b0d7f09c273d68548115d821a8` |
| L2_3600 | FIDELITY_C | 4 | `{d5108dfc-4d4e-10e3-9c0f-b8a2fd71f0ed}` | `8d6a04784505cfefdc06cdcf24df06c86ac452282cc32d02aff7759f63d91b1a` |
| L2_3800 | FIDELITY_C | 1 | `{1897e6d9-ed20-02a3-5703-739d3007a313}` | `fbbe11cb708ae5633b43fdcc745dc0250e52ac973373fc7867d28149a49e37b8` |
| L2_4100 | FIDELITY_C | 5 | `{b39885f1-20c2-ad6e-1db6-c31437bcf96f}` | `23c77defa85c224a72f578c8d33b18fdd4be45e7b9ee2a81963cdd9e36563665` |
| L2_4200 | FIDELITY_B | 15 | `{5d1f59b8-3f76-71dd-868d-cbb95bb43037}` | `99039e9977bd7d0cb7e95ce90110d24e97995e2e4fbbbcd4fbda8a9e05152cba` |
| L2_4400 | FIDELITY_C | 0 | `{4e379e65-a083-a6ee-9dd8-3c988a71600c}` | `475687058479d5b1417958b727de3f7de0e81e86fb25171acda27b25709c492e` |
| L2_4500 | FIDELITY_B | 9 | `{7b263b42-3f4b-c004-d912-36574183abc0}` | `d42e9b9be9efd429687ec971d6693f9b15775c9d574f3d7ecde5a38e7eb4a709` |
| L2_5100 | FIDELITY_A | 19 | `{920120d7-3114-3844-30ad-4b89d9cbdebd}` | `2c8d53b95e19c06ad6922f20b6b09599fe9d8dcff005f061f1a509d01b859739` |
| L2_5300 | FIDELITY_A | 9 | `{e5861db3-6d6f-f420-9d26-c40db4c3edd6}` | `a6cd4f775ca7c5886e53f4fa1a1e8db604ad7ad9bea9cb422bed590e290c2a41` |
| L2_7100 | FIDELITY_C | 1 | `{8c2ba878-d6e9-5a49-d34e-19db890171d4}` | `16c9fb1ebf4a5f236efc795d01b8e151922967d6baa2bcca6d87179b5904c2d3` |
| L2_7200 | FIDELITY_A | 14 | `{2ddea95b-d143-43a0-f89b-2af35fa6b91b}` | `3cdf2a778ca0b8b0871f3def2958a2838f2d50b53fd9bc17dd5498eec3f8c5c8` |
| L2_8100 | FIDELITY_C | 46 | `{3c023527-2b20-1e0e-b67b-eb6382e18f1c}` | `cf6ae6fdef5096611e62c63c49ab81b2f912d4c21e895388f2edcfaa5567b92b` |
| L2_D100 | FIDELITY_C | 4 | `{2231d3e3-9c3a-f322-3b27-889636a4abda}` | `62c86e81f63d15baae378828180b6e4bcdab92e23af7da32c904f6d687c338e4` |
| L2_E100 | FIDELITY_C | 2 | `{4ebb5d73-6ec2-ed4d-5738-8a87deb2d6e8}` | `747226aef400b693034fbbf1445f0c9ce6e535ba99bfd56a7067c73ae66ccd87` |
| L2_X100 | FIDELITY_A | 12 | `{da4aab8c-0a1b-3033-d475-73873215884d}` | `8e51209dd452b2995c1dcd35155d95498ec4ae046d6fed13bf277277aa7c479e` |

## Assumptions and limitations

The central parameter file contains 20 documented parameters. Source classifications are: ENGINEERING_ASSUMPTION=11, LEGACY_CONTRACT=1, LITERATURE_TYPICAL=7, SOURCE_MODEL=1. Each record includes value, unit, component, confidence, and assumption.

- Models are system-level averaged and discrete at 0.1 s; they are suitable for architecture/co-simulation V&V, not switching transients, wheel–rail contact certification, thermal certification, or safety certification.
- Vehicle-specific parameters require calibration against the target train and subsystem data before design-signoff use.
- The power-path V&V covers the frozen interface topology and the specified scenario, not an exhaustive operational envelope.
- The 10 trace-equivalent duplicate connection records are preserved for provenance and executed once per unique endpoint pair.

## Frozen-source integrity

- Original SSD hash matches frozen reference: YES
- SSD mapping hash matches frozen reference: YES
- Full SysML generated-tree hash matches frozen reference: YES
- Executable-interface baseline write performed: NO
- SSI author source write performed: NO

## Final status

```text
SIMULINK_MODELS = 16/16
SIMULINK_COMPONENT_TESTS_PASS = 16/16
EXECUTABLE_VARIABLES_EXPECTED = 151
EXECUTABLE_VARIABLES_VALIDATED = 151/151
EXECUTABLE_CONNECTIONS_EXPECTED = 87
EXECUTABLE_CONNECTIONS_VALIDATED = 87/87
FMUS_GENERATED = 16/16
FMUS_INTERFACE_VALID = 16/16
EXECUTABLE_SSP = PASS
COSIMULATION_EXECUTED = YES
COSIMULATION_STATUS = PASS
ORIGINAL_SSD_MODIFIED = NO
FULL_SYSML_MODIFIED = NO
SSI_SOURCE_MODIFIED = NO
RAIL_MBSE_SIMULINK_TO_FMU = PASS
RAIL_MBSE_ALL16_COSIMULATION = PASS
```
