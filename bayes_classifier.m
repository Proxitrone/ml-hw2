function error = bayes_classifier(trainX, trainY, testX, testY, mode)
%BAYES_CLASSIFIER Use the Naive Bayes classifier to classify images from
%the MNIST dataset
%   There are 2 modes, discrete and continuous
%   We need to compute the prior (what's the probability of each class),
%   likelihood ()

    %% Compute prior for all classes
    class_num = max(trainY)+1;
    prior = zeros(class_num, 1);
    train_data_num = size(trainY, 2);
    test_data_num = size(testY, 2);
%     classes_data = cell(class_num,1);
    for i=1:train_data_num
        prior(trainY(i)+1) =  prior(trainY(i)+1)+1;
        % Separate classes for easibility of processing
%         classes_data{trainY(i)+1} = [classes_data{trainY(i)+1}, trainX(:, i)+1];
    end
    prior = prior./train_data_num;
%     save classes_data.mat classes_data
    load classes_data.mat
    %% Continuous     
    if mode
        %?ompute means and deviation of each pixel belonging to a class in training set
        data_mean = cell(class_num, 1);
        data_vari = cell(class_num, 1);
        likelihood_gauss = cell(class_num, 1);
        for i=1:class_num
            data_mean{i} = mean(classes_data{i}, 2);
            data_vari{i} = var(classes_data{i}, 0,2);
        end
        % Calculate likelihood for the test set
        log_class_estimates = zeros(class_num, test_data_num);
        for k=1: test_data_num
            for i=1:class_num
%                 likelihood_gauss{i} = normpdf(testX(:,k), data_mean{i}, data_vari{i});
                likelihood_gauss{i} = my_Gauss(testX(:,k), data_mean{i}, data_vari{i});
                % Log dcale posterior
                log_class_estimates(i, k) = log(prior(i))+sum(log(likelihood_gauss{i}));
            end
            
        end
        
    %% Discrete
    else
        bin_num = 32;
        feature_num = size(trainX, 1);
        %discrete_trainX =discretize(trainX, bin_num);
        % Discretize each classes data
        discrete_class_data = cell(class_num,1);
        for i=1:class_num
            discrete_class_data{i} = discretize(classes_data{i}, bin_num);
        end
        %?ompute frequency of each pixel belonging to a bin in training set
        freq_prob = cell(class_num, 1);
        for i = 1:class_num
            freq_prob{i} = zeros(feature_num, bin_num);
            class_data_num = size(discrete_class_data{i},2);
            for j=1:class_data_num
                for k=1:feature_num
                    freq_prob{i}(k,discrete_class_data{i}(k,j)+1) = freq_prob{i}(k,discrete_class_data{i}(k,j)+1)+1;
                end
            end
            % pseudocount to fill up the 0 values
            freq_prob{i} = pseudocount(freq_prob{i});
            freq_prob{i} = freq_prob{i}./class_data_num;
        end
        % Compute test set likelihood and marginal
        
        discrete_testX =discretize(testX, bin_num);
        log_class_estimates = zeros(class_num, test_data_num);
        for k=1: test_data_num
            for i=1:class_num
                
                sample_likelihood = compute_likelihood(freq_prob{i}, discrete_testX(:,k));
                % Regular estimate
                %log_class_estimates(i,k) = prior(i) * prod(sample_likelihood);
                % Take a log probability
                log_class_estimates(i,k)= - (log(prior(i)) + sum(log(sample_likelihood)));
            end
            % Marginalize
            log_class_estimates(:,k) = log_class_estimates(:,k)/sum(log_class_estimates(:,k));
        end
        
    end
    
    % Print the posterior and prediction, compute accuracy
    acc = posterior_print(log_class_estimates, testY);
        
    % Print the imagination of numbers in Bayesian classifier
    imagination_print(freq_prob);
        
    error = 1 - acc;
    
end

