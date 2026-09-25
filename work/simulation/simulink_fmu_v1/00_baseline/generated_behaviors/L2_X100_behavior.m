function [out_dcdc_actual_power, ...
    out_ess_absorbed_power, ...
    out_ess_availability, ...
    out_ess_available_charge_power, ...
    out_ess_available_discharge_power, ...
    out_ess_fault, ...
    out_super_cap_soc, ...
    internal_Usc, ...
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
internal_Usc = 0.0;
internal_Esc_kJ = 0.0;
internal_Eregen_kJ = 0.0;
persistent E Eregen;
if isempty(E), E = 26760000; Eregen = 0.0; end
dt = 0.10000000000000001;
Emin = 15000000; Emax = 48600000;
PchgLim = 600000; PdisLim = 400000;
enabled = in_dcdc_enable_command && in_ess_contactor_command && ~in_ess_fault_reset_command;
Preq = in_ess_power_request;
Pactual = 0.0;
if enabled && Preq >= 0.0, Pactual = min([Preq,PchgLim,(Emax-E)/(0.10000000000000001*0.95999999999999996)]); end
if enabled && Preq < 0.0, Pactual = -min([-Preq,PdisLim,(E-Emin)*0.94999999999999996/0.10000000000000001]); end
Pstored = max(Pactual,0.0)*0.95999999999999996 + min(Pactual,0.0)/0.94999999999999996;
E = min(Emax,max(Emin,E + Pstored*dt));
Eregen = Eregen + max(Pactual,0.0)*0.95999999999999996*dt;
out_dcdc_actual_power = Pactual;
out_ess_absorbed_power = max(Pstored,0.0);
out_ess_availability = enabled && (E > Emin) && (E < Emax);
out_ess_available_charge_power = min(PchgLim,max(0.0,(Emax-E)/(0.10000000000000001*0.95999999999999996)));
out_ess_available_discharge_power = min(PdisLim,max(0.0,(E-Emin)*0.94999999999999996/0.10000000000000001));
out_ess_fault = int32(~isfinite(E));
out_super_cap_soc = (E-Emin)/(Emax-Emin);
internal_Usc = sqrt(2.0*E/120);
internal_Esc_kJ = E/1000.0;
internal_Eregen_kJ = Eregen/1000.0;
end