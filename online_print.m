function error = online_print(fileID, likelihood, case_num, case_str,a, b ,new_a, new_b)
%ONLINE_PRINT Summary of this function goes here
%   Detailed explanation goes here
    error = 1;
    
    txt = append('Case ', num2str(case_num), ': ', case_str, '\n');
    fprintf(fileID, txt);
 
    txt = append('Likelihood: ', num2str(likelihood, 10), '\n');
    fprintf(fileID, txt);
    
    txt = append('Beta prior:     a = ', num2str(a), ' b = ', num2str(b), '\n');
    fprintf(fileID, txt);
    
    txt = append('Beta posterior: a = ', num2str(new_a), ' b = ', num2str(new_b), '\n\n');
    fprintf(fileID, txt);
   
    error =0;
end

