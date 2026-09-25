function [out_I_motor_rms, ...
    out_T_shaft, ...
    out_motor_phase_voltage, ...
    out_motor_speed, ...
    out_motor_torque_actual, ...
    out_omega_motor, ...
    internal_Pmechanical] = behavior(time_s, ...
    in_U_motor_ll_rms, ...
    in_f_motor_e, ...
    in_omega_shaft)
%#codegen
out_I_motor_rms = 0.0;
out_T_shaft = 0.0;
out_motor_phase_voltage = 0.0;
out_motor_speed = 0.0;
out_motor_torque_actual = 0.0;
out_omega_motor = 0.0;
internal_Pmechanical = 0.0;
persistent torque;
if isempty(torque), torque = 0.0; end
dt = 0.10000000000000001;
wsync = 2.0*pi*in_f_motor_e/3;
targetT = 30*(wsync-in_omega_shaft);
targetT = min(6000,max(-6000,targetT));
torque = torque + dt*(targetT-torque)/0.20000000000000001;
out_T_shaft = torque;
out_motor_torque_actual = torque;
out_motor_speed = in_omega_shaft;
out_omega_motor = in_omega_shaft;
out_motor_phase_voltage = in_U_motor_ll_rms/sqrt(3.0);
Pshaft = torque*in_omega_shaft;
Pelec = max(Pshaft/0.93999999999999995,-Pshaft*0.92000000000000004);
out_I_motor_rms = abs(Pelec)/max(sqrt(3.0)*abs(in_U_motor_ll_rms),100.0);
internal_Pmechanical = Pshaft;
end