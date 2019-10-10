function [trainX, trainY, testX, testY] = parse_data(data_folder)
%PARSE_DATA parse the MNIST data into proper matrix form
%   Detailed explanation goes here
    %Create a path to data string
    trainX_path = append(data_folder, '/train-images.idx3-ubyte');
    trainY_path = append(data_folder, '/train-labels.idx1-ubyte');
    testX_path = append(data_folder, '/t10k-images.idx3-ubyte');
    testY_path = append(data_folder, '/t10k-labels.idx1-ubyte');
    % Big endian format
    data_format = 'b';
    
    trainX = parse_image(trainX_path, data_format);
    testX = parse_image(testX_path, data_format);
    
    trainY = parse_label(trainY_path, data_format);
    testY = parse_label(testY_path, data_format);

end

