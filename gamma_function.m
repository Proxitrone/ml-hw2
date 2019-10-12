function res = gamma_function(x)
%GAMMA_FUNCTION Gamma function
%   G = (x-1)!
    res = 1;
    multiplier = x-1;
    for i=1:x-1
        res = res*multiplier;
        multiplier = multiplier-1;
    end
end

