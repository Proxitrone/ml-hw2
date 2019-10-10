function [new_X, idx] = pseudocount(X)
%PSEUDOCOUNT Pseudocount to fill up the 0 values
%   Find the minimum element greater than 0 and assign it to the 0 elements

    new_X = zeros(size(X));
    for i=1:size(X,1)
        x_row = X(i, :);
        [pseudo_min,idx] = min(x_row(x_row>0));
        x_row(x_row==0) = pseudo_min;
        new_X(i,:) = x_row;
    end

end

