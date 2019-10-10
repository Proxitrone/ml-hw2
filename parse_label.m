function labelMat = parse_label(file_path, data_format)
%PARSE_LABEL Parse the label idx1 format into a matrix
%   Each label bytefile contains a magic number, followed by number of
%   labels, and the labels
    fileID = fopen(file_path,'r', data_format);
    magic_num = fread(fileID, 1,'uint');
    datapoints_num = fread(fileID, 1,'uint');
    data_size =[1, datapoints_num];
    labelMat = fread(fileID, data_size, 'uchar');
    fclose(fileID);
end

