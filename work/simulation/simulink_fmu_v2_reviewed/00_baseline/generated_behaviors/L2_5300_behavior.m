function [out_I_motor_rms, ...
    out_T_shaft, ...
    out_motor_phase_voltage, ...
    out_motor_speed, ...
    out_motor_torque_actual, ...
    out_omega_motor, ...
    internal_Pmechanical, ...
    internal_Pelectrical] = behavior(time_s, ...
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
internal_Pelectrical = 0.0;
persistent torque;
if isempty(torque), torque = 0.0; end
dt = 0.01;
wsync = 2.0*pi*in_f_motor_e/3;
targetT = 30*(wsync-in_omega_shaft);
targetT = min(6000,max(-6000,targetT));
energized = (in_U_motor_ll_rms >= 250);
if ~energized, targetT = 0.0; end
vVehicle = abs(in_omega_shaft)*0.46000000000000002/6.2000000000000002;
xFade = min(1.0,max(0.0,(vVehicle-0.5)/(1.5-0.5)));
regenFade = xFade*xFade*(3.0-2.0*xFade);
if targetT < 0.0, targetT = targetT*regenFade; end
if energized, tau = 0.20000000000000001; else, tau = 0.050000000000000003; end
alpha = 1.0-exp(-dt/tau);
torque = torque + alpha*(targetT-torque);
out_T_shaft = torque;
out_motor_torque_actual = torque;
out_motor_speed = in_omega_shaft;
out_omega_motor = in_omega_shaft;
out_motor_phase_voltage = in_U_motor_ll_rms/sqrt(3.0);
Pshaft = torque*in_omega_shaft;
if Pshaft >= 0.0, Pelec = Pshaft/0.93999999999999995; else, Pelec = Pshaft*0.92000000000000004; end
if abs(in_U_motor_ll_rms) >= 250, out_I_motor_rms = abs(Pelec)/(sqrt(3.0)*abs(in_U_motor_ll_rms)); else, out_I_motor_rms = 0.0; end
internal_Pmechanical = Pshaft;
internal_Pelectrical = Pelec;
end