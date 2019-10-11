function error = imagination_print(classifier, fileID, mode)
%IMAGINATION_PRINT Summary of this function goes here
%   Detailed explanation goes here
    error = 1;
    
    feature_num = size(classifier{1},1);
    class_num = size(classifier, 1);
    
    
%     disp('Imagination of numbers in Bayesian classifier:');
%     disp(' ');
    fprintf(fileID, 'Imagination of numbers in Bayesian classifier:\n');
    
    for i=1:class_num
        bayes_representation = zeros(sqrt(feature_num));
        [val, idx] = max(classifier{i},[], 2);
        
        if mode
            bayes_representation(val>128) = 1;
        else
            bayes_representation(idx>15)= 1;
        end
        
%         disp(bayes_representation');
%         disp(' ');
        fprintf(fileID, append(num2str(i-1), ':\n'));
        col_string = '';
        bayes_representation = bayes_representation';
        [row_num,col_num] = size(bayes_representation);
        for r = 1:row_num
            
            for c = 1:col_num
                fprintf(fileID, '%d ', round(bayes_representation(r,c)));
            end
            fprintf(fileID, '\n');
        end
        fprintf(fileID, '\n');
        
    end
    error = 0;
    
end

