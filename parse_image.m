function imageMat = parse_image(file_path, data_format)
%PARSE_IMAGE Parse the image idx3 format into a matrix
%   Each image bytefile contains a magic number, followed by number of
%   images, number of rows, number of columns, and the pixels

    fileID = fopen(file_path,'r', data_format);
    magic_num = fread(fileID, 1,'uint');
    datapoints_num = fread(fileID, 1,'uint');
    row_num  = fread(fileID, 1,'uint');
    col_num  = fread(fileID, 1,'uint');
    data_size = [row_num*col_num, datapoints_num];
    imageMat = fread(fileID, data_size, 'uchar');
    fclose(fileID);
    
end

