# Rail MBSE Simulink–FMU Co-Simulation v2.1 Final Report

Actual FMI 2.0 Co-Simulation: 16 FMUs, FMPy explicit Jacobi, 0.05 s communication step, 50 s duration. Fourteen validated v2 FMUs were reused; L2_7200 and L2_8100 were rebuilt and exported incrementally. Required FMI variables are 151/151 and executable connection records are 87/87.

## Final V&V

- Traction power chain: PASS
- Main braking: PASS; peak overshoot 7.025%, steady error 0.576%.
- Low-speed transition: PASS; maximum under-brake 7.063% (5.650 kN).
- Hold transition: PASS; instantaneous error 56.000 kN, settled in 0.050 s (one communication step), with no sustained 80 kN residual.
- Standstill regeneration: 485.245 N, 70.922 W.
- Regenerative energy: PASS; allocation residual 0.000000%.
- Supercapacitor storage: PASS; recovered energy 3.723557 MJ; final SOC 46.082016%.
- System physical V&V: PASS.

The v2→v2.1 change is a brake-control correction: actual-regeneration-based mechanical blending, fast low-speed takeover, demand-decrease clipping, and low-speed regeneration fade. HV supply, DC-link, storage physics, frozen external interfaces, authoritative SSD, Full SysML, and SSI source were not changed.
