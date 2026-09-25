%% Rail_RegenerativeBraking_SC_v1 centralized parameters
% Baseline values for the first executable Gold Model. They are starting
% values for validation and are not claimed to be optimized train data.

Ts = 10e-6;

SCv1.meta.version = '1.0';
SCv1.meta.description = 'PMSM traction, regenerative braking and supercapacitor V1';

%% Vehicle and driveline
SCv1.vehicle.mass = 295900;              % kg
SCv1.vehicle.wheel_radius = 0.46;        % m
SCv1.vehicle.gear_ratio = 6.2;
SCv1.vehicle.gear_efficiency = 0.97;
SCv1.vehicle.drive_units = 36;           % identical PMSM drive units represented
SCv1.vehicle.A = 5000;                   % N, Davis resistance
SCv1.vehicle.B = 50;                     % N/(m/s)
SCv1.vehicle.C = 1.0;                    % N/(m/s)^2
SCv1.vehicle.grade = 0;                  % decimal slope
SCv1.vehicle.mu = 0.20;
SCv1.vehicle.g = 9.81;                   % m/s^2

%% PMSM / control interface
SCv1.motor.Kt = 4.5;                     % N*m/A, inherited baseline value
SCv1.motor.torque_limit = 750;           % N*m per drive unit
SCv1.motor.J_motor = 1.87e-2;            % kg*m^2
SCv1.motor.B_motor = 0.008;
SCv1.motor.inverter_efficiency = 0.96;
SCv1.motor.J_equivalent = SCv1.motor.J_motor + ...
    (SCv1.vehicle.mass / SCv1.vehicle.drive_units) * ...
    (SCv1.vehicle.wheel_radius / SCv1.vehicle.gear_ratio)^2;

%% DC bus and traction source
SCv1.dc.Vsource = 1500;                  % V
SCv1.dc.line_R = 0.02;                   % ohm
SCv1.dc.line_L = 2e-3;                   % H
SCv1.dc.Cdc = 0.05;                      % F
SCv1.dc.Udc_initial = 1500;              % V
SCv1.dc.Udc_charge_on = 1510;            % V
SCv1.dc.Udc_target = 1505;               % V
SCv1.dc.Udc_regen_reduce = 1580;         % V
SCv1.dc.Udc_max = 1650;                  % V
SCv1.dc.current_limit = 2500;            % A, aggregate source equivalent

%% Supercapacitor bank
SCv1.supercap.C = 200;                   % F, aggregate bank
SCv1.supercap.ESR = 0.015;               % ohm
SCv1.supercap.leakage_R = 5000;          % ohm
SCv1.supercap.Umin = 400;                 % V
SCv1.supercap.Umax = 500;                 % V
SCv1.supercap.Uinit = 420;                % V, Case B default
SCv1.supercap.Imax = 1200;                % A
SCv1.supercap.SOCmax = 0.98;
SCv1.supercap.SOCmin = 0.05;

%% Average bidirectional DC/DC
SCv1.dcdc.eff_charge = 0.96;
SCv1.dcdc.eff_discharge = 0.95;
SCv1.dcdc.Kp_charge = 60;                 % A/V
SCv1.dcdc.current_tau = 2e-3;             % s
SCv1.dcdc.enable_discharge = false;       % V1 prioritizes regenerative charge
SCv1.dcdc.Udc_discharge_on = 1470;        % V

%% Braking and blending
SCv1.brake.deceleration = 0.9;            % m/s^2
SCv1.brake.regen_full_speed = 10/3.6;     % m/s
SCv1.brake.regen_zero_speed = 5/3.6;      % m/s
SCv1.brake.mechanical_force_max = 1.20 * SCv1.vehicle.mass * SCv1.vehicle.g;
SCv1.brake.mechanical_tau = 0.15;         % s
SCv1.brake.no_sc_regen_power = 120e3;     % W, short DC-link absorption only

%% Test scenario: 0 -> 80 km/h -> 0
SCv1.scenario.target_speed = 80/3.6;      % m/s
SCv1.scenario.acceleration = 0.75;        % m/s^2 reference ramp
SCv1.scenario.start_time = 1.0;           % s
SCv1.scenario.brake_start = 35.0;         % s
SCv1.scenario.stop_time = 63.0;           % s
SCv1.scenario.log_decimation = 100;       % 1 ms at Ts = 10 us

%% Case definitions
SCv1.cases.A.enable_sc = 0;
SCv1.cases.A.Uinit = 420;
SCv1.cases.B.enable_sc = 1;
SCv1.cases.B.Uinit = 420;
SCv1.cases.C.enable_sc = 1;
SCv1.cases.C.Uinit = 495;

% Default model state when the SLX is opened and Run is pressed.
SCv1.case.name = 'B';
SCv1.case.enable_sc = SCv1.cases.B.enable_sc;
SCv1.supercap.Uinit = SCv1.cases.B.Uinit;
