function [binom_likelihood, beta_prior, beta_posterior] = online_learning(file, a, b)
%ONLINE_LEARNING Use beta-binomial conjugation to perform online learning
%   Detailed explanation goes here
    fileID = fopen(file);
    p = [];
    new_a = 0;
    new_b = 0;
    case_num = 1;
    file_name = 'answer_online.txt';
    f = fopen(file_name, 'w+');
    while 1
        bin_str  =  fgetl(fileID);
        if bin_str == -1
            break;
        end
        N = numel(bin_str);
        m = sum(bin_str=='1');
        p = m/N;
        %p = [p ; str2bin(bin_str)];
        % Compute likelihood (Binomial distribution)
        binom_likelihood = nchoosek(N, m) * p^m * (1-p)^(N-m);
        % Compute prior probability (Beta distribution)
        beta_prior = (p^(a-1) * (1-p)^(b-1))/beta_function(a,b);
        % Compute posterior probability (Beta distribution)
        beta_posterior = (p^(m+a-1) * (1-p)^((N-m)+b-1))/beta_function(a+m,b + (N-m));
        % Compute parameters of Beta posterior 
        new_a = a+m;
        new_b = b + (N-m);
        % Print stuff out to a file
        online_print(f, binom_likelihood, case_num, bin_str, a, b ,new_a, new_b);
        a = new_a;
        b = new_b;
        case_num = case_num +1;
    end
    
    fclose(fileID);
    fclose(f);
end

