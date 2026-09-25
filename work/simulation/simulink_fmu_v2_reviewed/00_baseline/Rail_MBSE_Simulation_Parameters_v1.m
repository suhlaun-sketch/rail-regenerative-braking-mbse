function [P, metadata] = Rail_MBSE_Simulation_Parameters_v1()
%RAIL_MBSE_SIMULATION_PARAMETERS_V1 System-level co-simulation parameters.
% Values are implementation assumptions unless a source is stated explicitly.

P.sample_time_s = 0.1;
P.vehicle.wheel_radius_m = 0.46;
P.vehicle.equivalent_rotational_inertia_kgm2 = 18000;
P.vehicle.rolling_resistance_torque_Nm = 1500;
P.vehicle.aero_torque_coefficient = 0.8;
P.driveline.gear_ratio = 6.2;
P.driveline.efficiency = 0.96;
P.motor.pole_pairs = 3;
P.motor.torque_slip_gain_Nm_per_radps = 30;
P.motor.torque_limit_Nm = 6000;
P.motor.time_constant_s = 0.2;
P.motor.efficiency_motoring = 0.94;
P.motor.efficiency_generating = 0.92;
P.converter.dc_voltage_nominal_V = 1800;
P.converter.power_limit_W = 1.2e6;
P.converter.grid_regen_acceptance_W = 0;
P.converter.efficiency_motoring = 0.96;
P.converter.efficiency_generating = 0.95;
P.transformer.ratio_secondary_to_primary = 0.06;
P.transformer.efficiency = 0.97;
P.line.voltage_V = 25000;
P.line.frequency_Hz = 50;
P.brake.vehicle_mass_kg = 80000;
P.brake.max_service_deceleration_mps2 = 1.2;
P.brake.max_dynamic_force_N = 77000;
P.brake.wheel_radius_m = P.vehicle.wheel_radius_m;
P.brake.cylinder_pressure_max_Pa = 600000;
P.brake.cylinder_time_constant_s = 0.4;
P.pneumatic.reservoir_pressure_nominal_Pa = 900000;
P.supercap.capacitance_F = 120;
P.supercap.esr_Ohm = 0.04;
P.supercap.voltage_min_V = 500;
P.supercap.voltage_max_V = 900;
P.supercap.initial_soc = 0.35;
P.supercap.charge_power_limit_W = 600000;
P.supercap.discharge_power_limit_W = 400000;
P.supercap.current_limit_A = 900;
P.supercap.dcdc_efficiency_charge = 0.96;
P.supercap.dcdc_efficiency_discharge = 0.95;

metadata = [
    entry('sample_time_s',P.sample_time_s,'s','ALL','ENGINEERING_ASSUMPTION','high','System-level averaged co-simulation step.');
    entry('wheel_radius_m',P.vehicle.wheel_radius_m,'m','L2_3100/L2_7200','LITERATURE_TYPICAL','medium','Representative rail wheel rolling radius.');
    entry('equivalent_rotational_inertia_kgm2',P.vehicle.equivalent_rotational_inertia_kgm2,'kg*m^2','L2_3100','ENGINEERING_ASSUMPTION','high','Consistent with m*r^2 for the 80000 kg equivalent mass and 0.46 m wheel radius, with drivetrain allowance.');
    entry('gear_ratio',P.driveline.gear_ratio,'1','L2_3500','LITERATURE_TYPICAL','medium','Representative single-stage rail final drive ratio.');
    entry('driveline_efficiency',P.driveline.efficiency,'1','L2_3500','LITERATURE_TYPICAL','medium','System-level gearbox efficiency.');
    entry('motor_torque_limit_Nm',P.motor.torque_limit_Nm,'N*m','L2_5300','SOURCE_MODEL','medium','Consistent with the reusable PMSM traction-model scale; not a certified vehicle value.');
    entry('motor_efficiency_motoring',P.motor.efficiency_motoring,'1','L2_5300','LITERATURE_TYPICAL','medium','Average PMSM motoring efficiency.');
    entry('motor_efficiency_generating',P.motor.efficiency_generating,'1','L2_5300','LITERATURE_TYPICAL','medium','Average PMSM generating efficiency.');
    entry('dc_voltage_nominal_V',P.converter.dc_voltage_nominal_V,'V','L2_5100','ENGINEERING_ASSUMPTION','medium','Representative traction DC-link voltage.');
    entry('converter_power_limit_W',P.converter.power_limit_W,'W','L2_5100','ENGINEERING_ASSUMPTION','medium','System-level converter power limit.');
    entry('line_voltage_V',P.line.voltage_V,'V','L2_4100/L2_4200','ENGINEERING_ASSUMPTION','medium','25 kV AC railway supply boundary.');
    entry('vehicle_mass_kg',P.brake.vehicle_mass_kg,'kg','L2_7200','ENGINEERING_ASSUMPTION','medium','Representative single train-unit equivalent mass.');
    entry('max_service_deceleration_mps2',P.brake.max_service_deceleration_mps2,'m/s^2','L2_7200','LEGACY_CONTRACT','medium','Interprets frozen service-brake request as demanded deceleration.');
    entry('reservoir_pressure_nominal_Pa',P.pneumatic.reservoir_pressure_nominal_Pa,'Pa','L2_7100','LITERATURE_TYPICAL','medium','Representative main-reservoir pressure.');
    entry('supercap_capacitance_F',P.supercap.capacitance_F,'F','L2_X100','ENGINEERING_ASSUMPTION','medium','Equivalent bank capacitance for system-level energy dynamics.');
    entry('supercap_esr_Ohm',P.supercap.esr_Ohm,'Ohm','L2_X100','LITERATURE_TYPICAL','low','Equivalent bank ESR; requires vehicle-specific calibration.');
    entry('supercap_voltage_min_V',P.supercap.voltage_min_V,'V','L2_X100','ENGINEERING_ASSUMPTION','medium','Lower operating voltage assumption.');
    entry('supercap_voltage_max_V',P.supercap.voltage_max_V,'V','L2_X100','ENGINEERING_ASSUMPTION','medium','Upper operating voltage assumption.');
    entry('supercap_charge_power_limit_W',P.supercap.charge_power_limit_W,'W','L2_X100','ENGINEERING_ASSUMPTION','medium','Bidirectional DC/DC charge limit.');
    entry('supercap_discharge_power_limit_W',P.supercap.discharge_power_limit_W,'W','L2_X100','ENGINEERING_ASSUMPTION','medium','Bidirectional DC/DC discharge limit.')
];
end

function s = entry(parameter,value,unit,component,source,confidence,assumption)
s = struct('parameter',parameter,'value',value,'unit',unit,'component',component, ...
    'source',source,'confidence',confidence,'assumption',assumption);
end
