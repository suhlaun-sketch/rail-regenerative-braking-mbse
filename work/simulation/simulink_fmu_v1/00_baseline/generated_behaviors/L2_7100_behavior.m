function [out_main_reservoir_pressure, ...
    internal_compressor_duty] = behavior(time_s)
%#codegen
out_main_reservoir_pressure = 0.0;
internal_compressor_duty = 0.0;
persistent pressure;
if isempty(pressure), pressure = 900000; end
pressure = pressure + 0.10000000000000001*(900000-pressure)/8.0;
out_main_reservoir_pressure = pressure;
internal_compressor_duty = double(pressure < 810000);
end