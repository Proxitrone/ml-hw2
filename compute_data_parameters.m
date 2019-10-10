function [data_mean, data_vari] = compute_data_parameters(classes_data, class_num)
%COMPUTE_DATA_PARAMETERS Compute mean and variance of each feature
%Compute means and deviation of each pixel belonging to a class in training set
    data_mean = cell(class_num, 1);
    data_vari = cell(class_num, 1);
    
    for i=1:class_num
        data_mean{i} = mean(classes_data{i}, 2);
        data_vari{i} = var(classes_data{i}, 0, 2);
        class_data_num = size(classes_data{i}, 2);
        % Pseudocount zero mean and the same variance
        [data_mean{i}, indxm] = pseudocount(data_mean{i}');
        [data_vari{i}, indxv] = pseudocount(data_vari{i}');
        
        data_mean{i} = data_mean{i}';
        data_vari{i} = data_vari{i}';
        
    end
    
end

