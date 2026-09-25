# Physical Consistency Audit v2

Overall: **PASS**

| Check | Status | Actual | Expected |
|---|---:|---:|---|
| traction_supply_chain | PASS | 24999.1 | >15000 V |
| transformer_integrated_efficiency | PASS | 0.979122 | 0.90..1.00 |
| motor_integrated_efficiency | PASS | 0.94 | 0.85..1.00 |
| dc_power_definition | PASS | 0 | Pdc=Udc*Idc |
| brake_force_sum | PASS | 0 | Ftotal=Fregen+Fmechanical |
| brake_peak_overshoot | PASS | 7.02461 | <10 % |
| brake_steady_error | PASS | 0.575861 | <5 % |
| standstill_regen_exit | PASS | 0 | <1000 N |
| supercap_energy_soc_relation | PASS | 0 | E=Emin+SOC(Emax-Emin) |
| supercap_voltage_energy_relation | PASS | 0 | U=sqrt(2E/C) |
| supercap_terminal_esr_relation | PASS | 0 | Uterminal=Ucap-Icap*ESR |
| supercap_energy_integral | PASS | 1.56299e-12 | <5 % |
| regen_energy_allocation | PASS | 2.40075e-14 | <5 % |
| sign_conventions | PASS | 0 | motoring positive; regen negative |
| finite_bounded_states | PASS | 0 | no NaN/Inf |
