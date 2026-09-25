# Rail MBSE Simulink–FMU Co-Simulation v2 Report

## Status

- Simulink models / component tests: 16/16 / 16/16 PASS
- Real FMI 2.0 Co-Simulation FMUs: 16/16; interface-valid 16/16
- Required variables / connection records: 151/151 / 87/87
- Executable SSP: PASS
- Actual all-16 FMPy co-simulation: PASS (explicit Jacobi, 0.05 s)
- Physical V&V: **PASS**

## Key results

- Startup closes the pantograph–HV breaker–transformer–DC-link–motor energy chain.
- HV-unavailable scenario produces no traction power from an internal default source.
- Brake overshoot: 7.025% (limit <10%); steady error 0.576%.
- Stop: 41.55 s; regenerative force/power fade to zero and mechanical hold remains.
- Motor regenerative energy: 4.3027 MJ; supercapacitor stored increase: 3.7241 MJ.
- Recovery efficiency: 86.554%; energy allocation residual: 2.40075e-14%.
- Communication-step overshoot: 0.10 s = 16.052%, 0.05 s = 7.025%, 0.02 s = 1.930%. Therefore 0.05 s is the default.

## Corrections

- Separated breaker command/state/fault startup logic and closed the upstream supply chain.
- Replaced zero-voltage P/U behavior with supply enable and an energy-based DC link.
- Coordinated mechanical braking against actual regenerative force and added low-speed regenerative fade-out.
- Distinguished signed mechanical/DC power, equivalent capacitor voltage, terminal voltage, and energy-based SOC.
- Unified recovered-energy integration to the trapezoidal definition in the authoritative v2 CSV.

## Scope

System-level averaged co-simulation model for MBSE architecture/interface V&V, traction/braking energy-flow study, and regenerative-control concept validation. It is not a switching-transient, inverter hardware, adhesion, braking-safety, homologation, or train-certification model; several parameters remain engineering assumptions or literature-typical values.

FMU hashes and GUIDs are recorded in `Rail_MBSE_FMU_Model_Registry_v2.json`. The authoritative SysML, SSD, executable interface, and SSI source were not modified.
