function [out_U_ac_rms, ...
    out_f_ac, ...
    out_pantograph_state, ...
    internal_contact_quality] = behavior(time_s, ...
    in_I_ac_rms, ...
    in_pantograph_command)
%#codegen
out_U_ac_rms = 0.0;
out_f_ac = 0.0;
out_pantograph_state = int32(0);
internal_contact_quality = 0.0;
persistent panto;
if isempty(panto), panto = int32(0); end
if in_pantograph_command > 0, panto = int32(1); else, panto = int32(0); end
out_U_ac_rms = double(panto)*max(0.0,25000-0.4*abs(in_I_ac_rms));
out_f_ac = double(panto)*50;
out_pantograph_state = panto;
internal_contact_quality = double(panto);
end