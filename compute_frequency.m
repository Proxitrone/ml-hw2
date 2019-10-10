function freq_prob = compute_frequency(classes_data,bin_num, class_num, feature_num)
%COMPUTE_FREQUENCY Summary of this function goes here
%   Detailed explanation goes here
% Compute frequency of each pixel belonging to a bin in training set
    freq_prob = cell(class_num, 1);
    for i = 1:class_num
        freq_prob{i} = zeros(feature_num, bin_num);
        class_data_num = size(classes_data{i},2);
        for j=1:class_data_num
            for k=1:feature_num
                freq_prob{i}(k,classes_data{i}(k,j)+1) = freq_prob{i}(k,classes_data{i}(k,j)+1)+1;
            end
        end
        % pseudocount to fill up the 0 values
        freq_prob{i} = pseudocount(freq_prob{i});
        freq_prob{i} = freq_prob{i}./class_data_num;
    end    
end

