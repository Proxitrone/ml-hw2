function error = bayes_classifier(trainX, trainY, testX, testY, mode)
%BAYES_CLASSIFIER Use the Naive Bayes classifier to classify images from
%the MNIST dataset
%   There are 2 modes, discrete and continuous
%   We need to compute the prior (what's the probability of each class),
%   likelihood ()

    %% Compute prior for all classes
    class_num = max(trainY)+1;
    train_data_num = size(trainY, 2);
    test_data_num = size(testY, 2);
    feature_num = size(trainX, 1);
    bin_num = 32;
    
    prior = zeros(class_num, 1);
    for i=1:train_data_num
        prior(trainY(i)+1) =  prior(trainY(i)+1)+1;
        % Separate classes for easibility of processing
%         classes_data{trainY(i)+1} = [classes_data{trainY(i)+1}, trainX(:, i)+1];
    end
    prior = prior./train_data_num;
%     save classes_data.mat classes_data
    load classes_data.mat
    
    log_class_estimates = zeros(class_num, test_data_num);
    %% Continuous     
    if mode
        
        %Compute means and deviation of each pixel belonging to a class in training set
        [data_mean, data_vari] = compute_data_parameters(classes_data, class_num);
        
    %% Discrete
    else
        %bin_num = 32;    
        % Discretize
        classes_data = discrete_class_data(classes_data, bin_num, class_num);
        
        freq_prob = compute_frequency(classes_data,bin_num, class_num, feature_num);
        discrete_testX =discretize(testX, bin_num);
    end
    %% Both
    % Calculate likelihood for the test set
    for k=1: test_data_num
        sample_likelihood = zeros(size(testX(:,k)));
        for i=1:class_num
            if mode
               %sample_likelihood = normpdf(testX(:,k), data_mean{i}', data_vari{i}');
               %compute log of it to prevent overflow
               pdf_mean = data_mean{i};
               pdf_vari = data_vari{i};
%                sample_likelihood = lognpdf(testX(:,k), pdf_mean, pdf_vari);
               sample_likelihood = my_Gauss(testX(:,k), pdf_mean, pdf_vari);
%                sample_likelihood = log(normpdf(testX(:,k), pdf_mean, pdf_vari));
            else
               sample_likelihood =log(compute_likelihood(freq_prob{i}, discrete_testX(:,k)));
            
            end
             
            % Regular estimate
            %log_class_estimates(i,k) = prior(i) * prod(sample_likelihood);
            % Log dcale posterior
            log_class_estimates(i, k) = - (log(prior(i))+sum(sample_likelihood));
        end
            
    end
                
    
    % Marginalize
    log_class_estimates = log_class_estimates./sum(log_class_estimates);
    
    file_name = 'answer_bayes.txt';
    f = fopen(file_name, 'w+');
   
    if mode
        tmp = data_mean;
        %log_class_estimates = log_class_estimates';
    else
        tmp = freq_prob;
    end
    % Print the posterior and prediction, compute accuracy
    acc = posterior_print(log_class_estimates, testY, f);
    error = 1 - acc;
    % Print the imagination of numbers in Bayesian classifier
    imagination_print(tmp, f, mode);
    fprintf(f, append('Error rate: ', num2str(error)), '\n');
    fclose(f);
    
end

