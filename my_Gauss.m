function prob = my_Gauss(X,mu, sigma)
%MY_GAUSS Compute normal pdf
%   Check the 0 case for mu and sigma to avoid division by 0
    prob = zeros(size(X, 1),1);
    for i=1:size(X, 1)
        if (sigma(i)>0)
            prob(i) = exp(-(X(i)-mu(i))^2/(2*sigma(i)^2))/sqrt(2*pi*sigma(i)^2); 
        else
            prob(i) = 1;
        end
    end
end

