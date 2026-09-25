function [internal_adhesion_coefficient] = behavior(time_s, ...
    in_sanding_request)
%#codegen
internal_adhesion_coefficient = 0.0;
persistent mu;
if isempty(mu), mu = 0.25; end
target = 0.25;
if in_sanding_request, target = 0.33; end
mu = mu + 0.10000000000000001*(target-mu)/1.0;
internal_adhesion_coefficient = mu;
end