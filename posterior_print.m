function accuracy = posterior_print(posteriors, labels, fileID)
%POSTERIOR_PRINT Summary of this function goes here
%   Detailed explanation goes here
    format long
    accuracy = 0;
    class_num = size(posteriors,1);
    data_num = size(labels,2);
%     disp('Posterior (in log scale):');
    fprintf(fileID, 'Posterior (in log scale):\n');
    for k=1:data_num
        for i=1:class_num
            text = append(num2str(i-1), ': ', num2str(posteriors(i, k)), '\n');
%             disp(text);
            fprintf(fileID, text);
        end
        [val, idx] = min(posteriors(:,k));
        true_class = labels(k);
        prediction_text = append('Prediction: ', num2str(idx-1), ', Ans: ', num2str(true_class), '\n\n');
        if (idx-1 == true_class)
            accuracy = accuracy+1;
        end
%         disp(prediction_text);
%         disp(' ');
        fprintf(fileID, prediction_text);
    end
    accuracy = accuracy/data_num;
    
end

