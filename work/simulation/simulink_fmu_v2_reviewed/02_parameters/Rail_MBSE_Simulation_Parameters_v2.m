function [P, metadata] = Rail_MBSE_Simulation_Parameters_v2()
%RAIL_MBSE_SIMULATION_PARAMETERS_V2 Reviewed system-level parameters.
% Every implementation value is classified; none is a certified vehicle value.

P.sample_time_s = 0.01;
P.default_communication_step_s = 0.05;

P.vehicle.wheel_radius_m = 0.46;
P.vehicle.equivalent_rotational_inertia_kgm2 = 18000;
P.vehicle.rolling_resistance_torque_Nm = 1500;
P.vehicle.aero_torque_coefficient = 0.8;

P.driveline.gear_ratio = 6.2;
P.driveline.efficiency = 0.96;

P.motor.pole_pairs = 3;
P.motor.torque_slip_gain_Nm_per_radps = 30;
P.motor.torque_limit_Nm = 6000;
P.motor.time_constant_s = 0.20;
P.motor.deenergized_time_constant_s = 0.05;
P.motor.minimum_operating_voltage_V = 250;
P.motor.efficiency_motoring = 0.94;
P.motor.efficiency_generating = 0.92;

P.converter.dc_voltage_nominal_V = 1800;
P.converter.dc_voltage_min_operating_V = 1200;
P.converter.dc_voltage_max_V = 2100;
P.converter.dc_link_capacitance_F = 0.40;
P.converter.dc_link_bleed_power_W = 5000;
P.converter.precharge_power_limit_W = 900000;
P.converter.precharge_time_constant_s = 0.60;
P.converter.secondary_voltage_min_V = 900;
P.converter.secondary_frequency_min_Hz = 45;
P.converter.secondary_frequency_max_Hz = 55;
P.converter.rectifier_voltage_gain = 1.20;
P.converter.power_limit_W = 1.2e6;
P.converter.grid_regen_acceptance_W = 0;
P.converter.front_end_efficiency = 0.98;
P.converter.inverter_efficiency_motoring = 0.98;
P.converter.inverter_efficiency_generating = 0.98;

P.transformer.ratio_secondary_to_primary = 0.06;
P.transformer.efficiency = 0.97;
P.transformer.primary_voltage_min_V = 15000;
P.transformer.frequency_min_Hz = 45;
P.transformer.frequency_max_Hz = 55;

P.line.voltage_V = 25000;
P.line.frequency_Hz = 50;
P.line.pantograph_raise_delay_s = 0.20;
P.line.voltage_drop_V_per_A = 0.40;

P.hv.primary_voltage_min_V = 15000;
P.hv.frequency_min_Hz = 45;
P.hv.frequency_max_Hz = 55;
P.hv.breaker_close_delay_s = 0.30;
P.hv.breaker_open_delay_s = 0.05;

P.brake.vehicle_mass_kg = 80000;
P.brake.max_service_deceleration_mps2 = 1.2;
P.brake.max_dynamic_force_N = 77000;
P.brake.wheel_radius_m = P.vehicle.wheel_radius_m;
P.brake.cylinder_pressure_max_Pa = 600000;
P.brake.cylinder_time_constant_s = 0.40;
P.brake.mechanical_force_build_time_s = 0.25;
P.brake.mechanical_force_release_time_s = 0.12;
P.brake.regen_cutoff_low_mps = 0.50;
P.brake.regen_cutoff_high_mps = 1.50;
P.brake.total_force_tolerance = 0.05;

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
    entry('sample_time_s',P.sample_time_s,'s','ALL','ENGINEERING_ASSUMPTION','high','Internal fixed step supports communication-step sensitivity at 0.10, 0.05 and 0.02 s.');
    entry('default_communication_step_s',P.default_communication_step_s,'s','ALL','ENGINEERING_ASSUMPTION','high','Selected after brake-transient communication-step comparison.');
    entry('wheel_radius_m',P.vehicle.wheel_radius_m,'m','L2_3100/L2_7200','LITERATURE_TYPICAL','medium','Representative rail wheel rolling radius.');
    entry('equivalent_rotational_inertia_kgm2',P.vehicle.equivalent_rotational_inertia_kgm2,'kg*m^2','L2_3100','ENGINEERING_ASSUMPTION','high','Consistent with the 80000 kg equivalent mass and 0.46 m wheel radius with driveline allowance.');
    entry('gear_ratio',P.driveline.gear_ratio,'1','L2_3500','LITERATURE_TYPICAL','medium','Representative rail final-drive ratio.');
    entry('driveline_efficiency',P.driveline.efficiency,'1','L2_3500','LITERATURE_TYPICAL','medium','Averaged gearbox efficiency.');
    entry('motor_torque_limit_Nm',P.motor.torque_limit_Nm,'N*m','L2_5300','SOURCE_MODEL','medium','Scale retained from the v1 PMSM-oriented implementation.');
    entry('motor_time_constant_s',P.motor.time_constant_s,'s','L2_5300','ENGINEERING_ASSUMPTION','medium','Averaged energized torque response.');
    entry('motor_deenergized_time_constant_s',P.motor.deenergized_time_constant_s,'s','L2_5300','ENGINEERING_ASSUMPTION','medium','Fast torque decay when inverter voltage is unavailable or speed is below regeneration cutoff.');
    entry('motor_minimum_operating_voltage_V',P.motor.minimum_operating_voltage_V,'V','L2_5300','ENGINEERING_ASSUMPTION','medium','Prevents torque production without a valid inverter voltage.');
    entry('motor_efficiency_motoring',P.motor.efficiency_motoring,'1','L2_5300','LITERATURE_TYPICAL','medium','Average PMSM motoring efficiency.');
    entry('motor_efficiency_generating',P.motor.efficiency_generating,'1','L2_5300','LITERATURE_TYPICAL','medium','Average PMSM generating efficiency.');
    entry('dc_voltage_nominal_V',P.converter.dc_voltage_nominal_V,'V','L2_5100','ENGINEERING_ASSUMPTION','medium','Nominal traction DC-link voltage.');
    entry('dc_voltage_min_operating_V',P.converter.dc_voltage_min_operating_V,'V','L2_5100','ENGINEERING_ASSUMPTION','medium','Minimum DC voltage for inverter torque production.');
    entry('dc_voltage_max_V',P.converter.dc_voltage_max_V,'V','L2_5100','ENGINEERING_ASSUMPTION','medium','Averaged DC-link over-voltage limit.');
    entry('dc_link_capacitance_F',P.converter.dc_link_capacitance_F,'F','L2_5100','LITERATURE_TYPICAL','low','Equivalent system-level DC-link capacitance; requires vehicle calibration.');
    entry('dc_link_bleed_power_W',P.converter.dc_link_bleed_power_W,'W','L2_5100','ENGINEERING_ASSUMPTION','low','Equivalent auxiliary/bleed load used only in the DC energy balance.');
    entry('precharge_power_limit_W',P.converter.precharge_power_limit_W,'W','L2_5100','ENGINEERING_ASSUMPTION','medium','Limits DC-link startup energy transfer.');
    entry('precharge_time_constant_s',P.converter.precharge_time_constant_s,'s','L2_5100','ENGINEERING_ASSUMPTION','medium','System-level DC-link establishment response.');
    entry('secondary_voltage_min_V',P.converter.secondary_voltage_min_V,'V','L2_5100','ENGINEERING_ASSUMPTION','high','Functional enable threshold separated from numerical epsilon.');
    entry('front_end_efficiency',P.converter.front_end_efficiency,'1','L2_5100','LITERATURE_TYPICAL','medium','Average rectifier/front-end efficiency.');
    entry('inverter_efficiency_motoring',P.converter.inverter_efficiency_motoring,'1','L2_5100','LITERATURE_TYPICAL','medium','Average inverter motoring efficiency.');
    entry('inverter_efficiency_generating',P.converter.inverter_efficiency_generating,'1','L2_5100','LITERATURE_TYPICAL','medium','Average inverter regenerative efficiency.');
    entry('transformer_ratio',P.transformer.ratio_secondary_to_primary,'1','L2_4500','ENGINEERING_ASSUMPTION','medium','Retained system-level voltage ratio.');
    entry('transformer_efficiency',P.transformer.efficiency,'1','L2_4500','LITERATURE_TYPICAL','medium','Average traction-transformer efficiency.');
    entry('line_voltage_V',P.line.voltage_V,'V','L2_4100/L2_4200','ENGINEERING_ASSUMPTION','medium','25 kV AC railway supply boundary.');
    entry('pantograph_raise_delay_s',P.line.pantograph_raise_delay_s,'s','L2_4100','ENGINEERING_ASSUMPTION','medium','Startup sequencing delay; not a hardware certification value.');
    entry('hv_primary_voltage_min_V',P.hv.primary_voltage_min_V,'V','L2_4200','ENGINEERING_ASSUMPTION','high','Breaker may close only with a valid pantograph supply.');
    entry('hv_breaker_close_delay_s',P.hv.breaker_close_delay_s,'s','L2_4200','ENGINEERING_ASSUMPTION','medium','Averaged breaker command-to-state delay.');
    entry('vehicle_mass_kg',P.brake.vehicle_mass_kg,'kg','L2_7200','ENGINEERING_ASSUMPTION','medium','Representative train-unit equivalent mass.');
    entry('max_service_deceleration_mps2',P.brake.max_service_deceleration_mps2,'m/s^2','L2_7200','LEGACY_CONTRACT','medium','Frozen service-brake request interpreted as demanded deceleration.');
    entry('mechanical_force_build_time_s',P.brake.mechanical_force_build_time_s,'s','L2_7200','ENGINEERING_ASSUMPTION','medium','First-order friction-brake buildup.');
    entry('mechanical_force_release_time_s',P.brake.mechanical_force_release_time_s,'s','L2_7200','ENGINEERING_ASSUMPTION','medium','Coordinated release plus total-force safety limiting.');
    entry('regen_cutoff_low_mps',P.brake.regen_cutoff_low_mps,'m/s','L2_8100/L2_5300','ENGINEERING_ASSUMPTION','medium','Regenerative capability is zero at and below this speed.');
    entry('regen_cutoff_high_mps',P.brake.regen_cutoff_high_mps,'m/s','L2_8100/L2_5300','ENGINEERING_ASSUMPTION','medium','Regenerative capability is fully available at and above this speed.');
    entry('brake_total_force_tolerance',P.brake.total_force_tolerance,'1','L2_7200','ENGINEERING_ASSUMPTION','high','V&V limit for total-force overshoot.');
    entry('reservoir_pressure_nominal_Pa',P.pneumatic.reservoir_pressure_nominal_Pa,'Pa','L2_7100','LITERATURE_TYPICAL','medium','Representative main-reservoir pressure.');
    entry('supercap_capacitance_F',P.supercap.capacitance_F,'F','L2_X100','ENGINEERING_ASSUMPTION','medium','Equivalent bank capacitance.');
    entry('supercap_esr_Ohm',P.supercap.esr_Ohm,'Ohm','L2_X100','LITERATURE_TYPICAL','low','Equivalent bank ESR; requires calibration.');
    entry('supercap_voltage_min_V',P.supercap.voltage_min_V,'V','L2_X100','ENGINEERING_ASSUMPTION','medium','Lower capacitor internal-voltage limit.');
    entry('supercap_voltage_max_V',P.supercap.voltage_max_V,'V','L2_X100','ENGINEERING_ASSUMPTION','medium','Upper capacitor internal-voltage limit.');
    entry('supercap_current_limit_A',P.supercap.current_limit_A,'A','L2_X100','ENGINEERING_ASSUMPTION','medium','Bidirectional capacitor current limit.');
    entry('supercap_charge_power_limit_W',P.supercap.charge_power_limit_W,'W','L2_X100','ENGINEERING_ASSUMPTION','medium','Bidirectional DC/DC charge limit.');
    entry('supercap_discharge_power_limit_W',P.supercap.discharge_power_limit_W,'W','L2_X100','ENGINEERING_ASSUMPTION','medium','Bidirectional DC/DC discharge limit.')
];
end

function s = entry(parameter,value,unit,component,source,confidence,assumption)
s = struct('parameter',parameter,'value',value,'unit',unit,'component',component, ...
    'source',source,'confidence',confidence,'assumption',assumption);
end
