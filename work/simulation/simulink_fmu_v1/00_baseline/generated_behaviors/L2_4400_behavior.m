function [internal_return_temperature] = behavior(time_s)
%#codegen
internal_return_temperature = 0.0;
persistent temperature;
if isempty(temperature), temperature = 25.0; end
temperature = temperature + 0.10000000000000001*(25.0-temperature)/30.0;
internal_return_temperature = temperature;
end