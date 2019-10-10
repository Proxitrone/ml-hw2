function d_data = discrete_class_data(classes_data, bin_num, class_num)
%DISCRETE_CLASS_DATA Discretize each classes data
%   Detailed explanation goes here
    d_data = cell(class_num,1);
    for i=1:class_num
        d_data{i} = discretize(classes_data{i}, bin_num);
    end
end

