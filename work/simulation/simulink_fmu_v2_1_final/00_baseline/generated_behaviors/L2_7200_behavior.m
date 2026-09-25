function [out_T_brake, ...
    out_brake_availability, ...
    out_brake_cylinder_pressure, ...
    out_dynamic_brake_force_request, ...
    internal_Fmechanical, ...
    internal_Ftotal_actual, ...
    internal_brake_tracking_error] = behavior(time_s, ...
    in_achieved_dynamic_brake_force, ...
    in_available_dynamic_brake_force, ...
    in_brake_cylinder_pressure, ...
    in_brake_safety_loop_state, ...
    in_dynamic_brake_availability, ...
    in_emergency_brake_request, ...
    in_main_reservoir_pressure, ...
    in_omega_wheel, ...
    in_safety_brake_request, ...
    in_service_brake_request)
%#codegen
out_T_brake = 0.0;
out_brake_availability = false;
out_brake_cylinder_pressure = 0.0;
out_dynamic_brake_force_request = 0.0;
internal_Fmechanical = 0.0;
internal_Ftotal_actual = 0.0;
internal_brake_tracking_error = 0.0;
persistent pcyl FmechState prevFtotal;
if isempty(pcyl), pcyl = 0.0; FmechState = 0.0; prevFtotal = 0.0; end
dt = 0.01;
amax = 1.2;
mass = 80000;
demand = min(amax,max(0.0,in_service_brake_request));
if in_emergency_brake_request || in_safety_brake_request > 0, demand = amax; end
Ftotal = mass*demand;
Fdyn = 0.0;
if in_dynamic_brake_availability, Fdyn = min(Ftotal,max(0.0,in_available_dynamic_brake_force)); end
out_dynamic_brake_force_request = Fdyn;
FregenActual = max(0.0,in_achieved_dynamic_brake_force);
Ftarget = max(Ftotal-FregenActual,0.0);
FstateTarget = Ftarget;
vWheel = abs(in_omega_wheel)*0.46000000000000002;
if vWheel < 1.5, FstateTarget = max(FstateTarget,Ftotal-Fdyn); end
if FstateTarget >= FmechState, tauF = 0.25; else, tauF = 0.12; end
if (vWheel < 1.5) && (FstateTarget > FmechState), tauF = 0.014999999999999999; end
if Ftotal < prevFtotal, FmechState = min(FmechState,Ftarget); end
prevFtotal = Ftotal;
alphaF = 1.0-exp(-dt/tauF);
FmechState = FmechState + alphaF*(FstateTarget-FmechState);
Fmech = min(max(FmechState,0.0),Ftarget);
targetP = 600000*min(1.0,Fmech/max(mass*amax,1.0));
pcyl = pcyl + (1.0-exp(-dt/0.40000000000000002))*(targetP-pcyl);
out_brake_cylinder_pressure = pcyl;
out_T_brake = Fmech*0.46000000000000002;
out_brake_availability = (in_main_reservoir_pressure > 600000.0) && (in_brake_safety_loop_state > 0);
internal_Fmechanical = Fmech;
internal_Ftotal_actual = Fmech+FregenActual;
internal_brake_tracking_error = internal_Ftotal_actual-Ftotal;
end