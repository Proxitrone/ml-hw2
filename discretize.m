function discrete_X = discretize(X,bin_num)
%DISCRETIZE Discretize the values of X (features)
%   Divide the dataX into bin_num bins
    
    discrete_X = fix(X./(256/bin_num));
end

