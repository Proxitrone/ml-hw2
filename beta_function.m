function B = beta_function(a,b)
%BETA_FUNCTION Normalization funciton for beta distribution
%   1/B(a+b) = G(a+b)/(G(a)*G(b))
    B = (gamma_function(a)*gamma_function(b))/gamma_function(a+b);
end

