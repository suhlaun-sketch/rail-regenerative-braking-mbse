function [out_external_safety_system_state, ...
    out_safety_brake_request, ...
    internal_safety_permit] = behavior(time_s)
%#codegen
out_external_safety_system_state = int32(0);
out_safety_brake_request = int32(0);
internal_safety_permit = 0.0;
out_external_safety_system_state = int32(1);
out_safety_brake_request = int32(0);
internal_safety_permit = 1.0;
end