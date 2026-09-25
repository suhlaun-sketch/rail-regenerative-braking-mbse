function [out_U_ac_rms, ...
    out_f_ac, ...
    out_pantograph_state, ...
    internal_contact_quality, ...
    internal_pantograph_power] = behavior(time_s, ...
    in_I_ac_rms, ...
    in_pantograph_command)
%#codegen
out_U_ac_rms = 0.0;
out_f_ac = 0.0;
out_pantograph_state = int32(0);
internal_contact_quality = 0.0;
internal_pantograph_power = 0.0;
persistent panto raiseTimer;
if isempty(panto), panto = int32(0); raiseTimer = 0.0; end
dt = 0.01;
if in_pantograph_command > 0, raiseTimer = min(0.20000000000000001,raiseTimer+dt); else, raiseTimer = 0.0; panto = int32(0); end
if raiseTimer >= 0.20000000000000001, panto = int32(1); end
out_U_ac_rms = double(panto)*max(0.0,25000-0.40000000000000002*abs(in_I_ac_rms));
out_f_ac = double(panto)*50;
out_pantograph_state = panto;
internal_contact_quality = double(panto);
internal_pantograph_power = out_U_ac_rms*in_I_ac_rms;
end