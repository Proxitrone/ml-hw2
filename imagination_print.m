function error = imagination_print(classifier)
%IMAGINATION_PRINT Summary of this function goes here
%   Detailed explanation goes here
    error = 1;
    
    feature_num = size(classifier{1},1);
    class_num = size(classifier, 1);
    
    
    disp('Imagination of numbers in Bayesian classifier:');
    disp(' ');
    for i=1:class_num
        bayes_representation = zeros(sqrt(feature_num));
        [val, idx] = max(classifier{i},[], 2);
        
        bayes_representation(idx>15)= 1;
        disp(bayes_representation');
        disp(' ');
    end
    error = 0;
end

