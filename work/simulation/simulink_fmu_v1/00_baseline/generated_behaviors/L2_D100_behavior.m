function [out_emergency_brake_request, ...
    out_service_brake_request, ...
    out_traction_command, ...
    out_train_direction_command, ...
    internal_scenario_phase] = behavior(time_s)
%#codegen
out_emergency_brake_request = false;
out_service_brake_request = 0.0;
out_traction_command = 0.0;
out_train_direction_command = int32(0);
internal_scenario_phase = 0.0;
out_train_direction_command = int32(1);
out_emergency_brake_request = false;
if time_s < 20.0
    out_traction_command = min(1.0,time_s/3.0);
    out_service_brake_request = 0.0;
    internal_scenario_phase = 1.0;
elseif time_s < 30.0
    out_traction_command = 0.0;
    out_service_brake_request = 0.0;
    internal_scenario_phase = 2.0;
elseif time_s < 45.0
    out_traction_command = 0.0;
    out_service_brake_request = 1.0;
    internal_scenario_phase = 3.0;
else
    out_traction_command = 0.0;
    out_service_brake_request = 0.3;
    internal_scenario_phase = 4.0;
end
end