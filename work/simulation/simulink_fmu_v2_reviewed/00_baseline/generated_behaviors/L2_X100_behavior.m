function [out_dcdc_actual_power, ...
    out_ess_absorbed_power, ...
    out_ess_availability, ...
    out_ess_available_charge_power, ...
    out_ess_available_discharge_power, ...
    out_ess_fault, ...
    out_super_cap_soc, ...
    internal_Ucap_equivalent, ...
    internal_Uterminal, ...
    internal_Icap, ...
    internal_SOC_energy, ...
    internal_Esc_kJ, ...
    internal_Eregen_kJ] = behavior(time_s, ...
    in_dcdc_enable_command, ...
    in_ess_contactor_command, ...
    in_ess_fault_reset_command, ...
    in_ess_power_request, ...
    in_ess_precharge_command)
%#codegen
out_dcdc_actual_power = 0.0;
out_ess_absorbed_power = 0.0;
out_ess_availability = false;
out_ess_available_charge_power = 0.0;
out_ess_available_discharge_power = 0.0;
out_ess_fault = int32(0);
out_super_cap_soc = 0.0;
internal_Ucap_equivalent = 0.0;
internal_Uterminal = 0.0;
internal_Icap = 0.0;
internal_SOC_energy = 0.0;
internal_Esc_kJ = 0.0;
internal_Eregen_kJ = 0.0;
persistent E Eregen PstoredPrev;
if isempty(E), E = 26760000; Eregen = 0.0; PstoredPrev = 0.0; end
dt = 0.01;
Emin = 15000000; Emax = 48600000;
PchgLim = 600000; PdisLim = 400000;
enabled = in_dcdc_enable_command && in_ess_contactor_command && ~in_ess_fault_reset_command;
Ucap = sqrt(max(0.0,2.0*E/120));
Preq = in_ess_power_request;
Pactual = 0.0;
PchgCurrentLimit = 900*Ucap/0.95999999999999996;
PdisCurrentLimit = 900*Ucap*0.94999999999999996;
if enabled && Preq >= 0.0, Pactual = min([Preq,PchgLim,PchgCurrentLimit,(Emax-E)/(0.01*0.95999999999999996)]); end
if enabled && Preq < 0.0, Pactual = -min([-Preq,PdisLim,PdisCurrentLimit,(E-Emin)*0.94999999999999996/0.01]); end
Pstored = max(Pactual,0.0)*0.95999999999999996 + min(Pactual,0.0)/0.94999999999999996;
PstoredAvg = 0.5*(PstoredPrev+Pstored);
E = min(Emax,max(Emin,E + PstoredAvg*dt));
Eregen = Eregen + max(PstoredAvg,0.0)*dt;
PstoredPrev = Pstored;
out_dcdc_actual_power = Pactual;
out_ess_absorbed_power = max(Pstored,0.0);
out_ess_availability = enabled && (E > Emin) && (E < Emax);
out_ess_available_charge_power = min([PchgLim,PchgCurrentLimit,max(0.0,(Emax-E)/(0.01*0.95999999999999996))]);
out_ess_available_discharge_power = min([PdisLim,PdisCurrentLimit,max(0.0,(E-Emin)*0.94999999999999996/0.01)]);
out_ess_fault = int32(~isfinite(E));
out_super_cap_soc = (E-Emin)/(Emax-Emin);
internal_Ucap_equivalent = sqrt(2.0*E/120);
if internal_Ucap_equivalent > 0.0, internal_Icap = -Pstored/internal_Ucap_equivalent; else, internal_Icap = 0.0; end
internal_Uterminal = internal_Ucap_equivalent-internal_Icap*0.040000000000000001;
internal_SOC_energy = out_super_cap_soc;
internal_Esc_kJ = E/1000.0;
internal_Eregen_kJ = Eregen/1000.0;
end