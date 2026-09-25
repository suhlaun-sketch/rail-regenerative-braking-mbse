function [out_I_sec_rms, ...
    out_U_motor_ll_rms, ...
    out_brake_resistor_dissipated_power, ...
    out_dc_link_current, ...
    out_dc_link_voltage, ...
    out_f_motor_e, ...
    out_grid_acceptable_regenerative_power, ...
    out_grid_returned_power, ...
    out_regenerative_power_actual, ...
    out_traction_converter_fault, ...
    internal_Pdc_signed, ...
    internal_Pmotor_electrical, ...
    internal_Ptransformer_request, ...
    internal_converter_supply_available] = behavior(time_s, ...
    in_I_motor_rms, ...
    in_U_sec_rms, ...
    in_f_sec, ...
    in_line_current, ...
    in_line_voltage, ...
    in_motor_phase_voltage, ...
    in_motor_speed, ...
    in_motor_torque_actual, ...
    in_motor_torque_request)
%#codegen
out_I_sec_rms = 0.0;
out_U_motor_ll_rms = 0.0;
out_brake_resistor_dissipated_power = 0.0;
out_dc_link_current = 0.0;
out_dc_link_voltage = 0.0;
out_f_motor_e = 0.0;
out_grid_acceptable_regenerative_power = 0.0;
out_grid_returned_power = 0.0;
out_regenerative_power_actual = 0.0;
out_traction_converter_fault = int32(0);
internal_Pdc_signed = 0.0;
internal_Pmotor_electrical = 0.0;
internal_Ptransformer_request = 0.0;
internal_converter_supply_available = 0.0;
persistent Edc;
if isempty(Edc), Edc = 0.0; end
dt = 0.01;
pmax = 1200000;
Cdc = 0.40000000000000002; Umax = 2100;
supplyValid = (in_U_sec_rms >= 900) && (in_f_sec >= 45) && (in_f_sec <= 55);
Udc = sqrt(max(0.0,2.0*Edc/Cdc));
inverterReady = supplyValid && (Udc >= 1200) && (Udc <= Umax);
Treq = min(6000,max(-6000,in_motor_torque_request));
if Treq >= 0.0 && ~inverterReady, Treq = 0.0; end
if Treq < 0.0 && Udc >= Umax, Treq = 0.0; end
slip = Treq/30;
if Treq ~= 0.0, out_f_motor_e = 3*(in_motor_speed+slip)/(2.0*pi); else, out_f_motor_e = 0.0; end
if Treq ~= 0.0 && Udc >= 1200, out_U_motor_ll_rms = min(0.9*Udc,max(250,abs(out_f_motor_e)*8.0)); else, out_U_motor_ll_rms = 0.0; end
Pmech = in_motor_torque_actual*in_motor_speed;
if Pmech >= 0.0, PmotorElec = Pmech/0.93999999999999995; else, PmotorElec = Pmech*0.92000000000000004; end
if PmotorElec >= 0.0, PdcSigned = PmotorElec/0.97999999999999998; else, PdcSigned = PmotorElec*0.97999999999999998; end
Ptr = min(pmax,max(PdcSigned,0.0));
Preg = min(pmax,max(-PdcSigned,0.0));
targetU = 1.2*in_U_sec_rms;
Etarget = 0.5*Cdc*targetU*targetU;
if supplyValid, Pprecharge = min(900000,max(0.0,(Etarget-Edc)/0.59999999999999998)); else, Pprecharge = 0.0; end
if supplyValid, PsecondaryRequest = min(pmax,(Ptr+Pprecharge+5000)/0.97999999999999998); else, PsecondaryRequest = 0.0; end
if supplyValid, out_I_sec_rms = PsecondaryRequest/in_U_sec_rms; else, out_I_sec_rms = 0.0; end
PfromSupply = in_U_sec_rms*out_I_sec_rms*0.97999999999999998;
out_grid_acceptable_regenerative_power = 0;
out_grid_returned_power = min(Preg,out_grid_acceptable_regenerative_power);
out_regenerative_power_actual = Preg;
PessSink = min(max(Preg-out_grid_returned_power,0.0),600000);
out_brake_resistor_dissipated_power = max(Preg-out_grid_returned_power-PessSink,0.0);
Pbleed = double(Edc > 0.0)*5000;
Pnet = PfromSupply + Preg - Ptr - PessSink - out_grid_returned_power - out_brake_resistor_dissipated_power - Pbleed;
Edc = min(0.5*Cdc*Umax*Umax,max(0.0,Edc+Pnet*dt));
Udc = sqrt(max(0.0,2.0*Edc/Cdc));
out_dc_link_voltage = Udc;
if Udc >= 300, out_dc_link_current = (Ptr-Preg)/Udc; else, out_dc_link_current = 0.0; end
out_traction_converter_fault = int32(~isfinite(Udc) || Udc > Umax*1.01);
internal_Pdc_signed = Ptr-Preg;
internal_Pmotor_electrical = PmotorElec;
internal_Ptransformer_request = PsecondaryRequest;
internal_converter_supply_available = double(inverterReady);
end