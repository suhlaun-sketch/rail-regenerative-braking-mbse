function [out_omega_axle, ...
    out_omega_gearbox, ...
    out_omega_shaft, ...
    out_omega_wheel, ...
    internal_v_train] = behavior(time_s, ...
    in_T_brake, ...
    in_T_shaft)
%#codegen
out_omega_axle = 0.0;
out_omega_gearbox = 0.0;
out_omega_shaft = 0.0;
out_omega_wheel = 0.0;
internal_v_train = 0.0;
persistent omega_w
if isempty(omega_w), omega_w = 0.0; end
dt = 0.01;
J = 18000;
T_res = 1500 + 0.80000000000000004*omega_w*omega_w;
T_net = in_T_shaft - max(in_T_brake,0.0) - T_res;
if omega_w <= 0.0 && T_net < 0.0, T_net = 0.0; end
omega_w = max(0.0,omega_w + dt*T_net/J);
out_omega_axle = omega_w;
out_omega_gearbox = omega_w;
out_omega_shaft = omega_w;
out_omega_wheel = omega_w;
internal_v_train = 0.46000000000000002*omega_w;
end