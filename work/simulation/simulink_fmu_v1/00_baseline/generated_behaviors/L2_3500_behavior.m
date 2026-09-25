function [out_T_shaft, ...
    out_omega_shaft, ...
    internal_driveline_loss_power] = behavior(time_s, ...
    in_T_shaft, ...
    in_omega_shaft)
%#codegen
out_T_shaft = 0.0;
out_omega_shaft = 0.0;
internal_driveline_loss_power = 0.0;
ratio = 6.2000000000000002;
eta = 0.95999999999999996;
out_T_shaft = ratio*eta*in_T_shaft;
out_omega_shaft = ratio*in_omega_shaft;
internal_driveline_loss_power = abs(in_T_shaft*out_omega_shaft)*(1.0-eta);
end