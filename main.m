%% Machine Learning Fall 2019 
%  Homework 2
%  Sergiy Shelekh 0760822

%% Parse Data

    data_folder = 'MNIST';
    [trainX, trainY, testX, testY] = parse_data(data_folder);
    
 %% Show sample images
    for i=1:10
       subplot(2, 5, i);
       imgMat = reshape(trainX(:, i), [28, 28]);
       % Normalize pixels from 0 to 1
       imgMat = imgMat/256;
       imshow(imgMat');
    end
    
 %% Naive Bayes
 
    mode = 1;
    error = bayes_classifier(trainX, trainY, testX, testY, mode);
    
%% Online Learning

    a=10;
    b = 1;
    file_name = 'testfile.txt';
    [b_like, beta_prior, posterior] = online_learning(file_name, a, b);