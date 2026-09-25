function [out_motor_speed, ...
    internal_sensor_residual] = behavior(time_s, ...
    in_omega_axle, ...
    in_omega_gearbox, ...
    in_omega_motor)
%#codegen
out_motor_speed = 0.0;
internal_sensor_residual = 0.0;
persistent sensed;
if isempty(sensed), sensed = 0.0; end
sensed = sensed + 0.10000000000000001*(in_omega_motor-sensed)/0.15;
out_motor_speed = sensed;
internal_sensor_residual = in_omega_motor-sensed;
end