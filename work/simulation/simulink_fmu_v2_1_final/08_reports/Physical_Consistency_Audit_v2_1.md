# Physical Consistency Audit v2.1

| Check | Status | Evidence |
|---|---|---|
| 16-FMU execution | PASS | Actual FMPy FMI 2.0 Co-Simulation completed to 50 s |
| Traction supply chain | PASS | Normal chain energized; HV-unavailable regression produced no hidden traction power |
| Main brake tracking | PASS | Overshoot 7.025%; steady error 0.576% |
| Low-speed takeover | PASS | Under-brake 7.063% |
| Hold transition | PASS | Settling 0.050 s; no sustained residual |
| Standstill regen exit | PASS | Force 485.245 N; power 70.922 W |
| Regenerative energy allocation | PASS | Relative residual 0.000000% |
| Supercapacitor storage | PASS | SOC bounded; final SOC 46.082016% |
| Frozen artifacts | PASS | No authority/interface/source files modified |
