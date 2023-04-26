close all;
clear;
clc;

data_file = 'data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');

indices = [train_C1_indices train_C2_indices];

%% Compute Aspect Ratio

%Computing the aspect Ration of each digit and saving it to the
%corresponding array 

aRatio_C1 = zeros(size(train_C1_indices,2),1)';

for i = 1:size(train_C1_indices,2)
    [aRatio_C1(i), min_row_C1(i), min_col_C1(i), height_C1(i), width_C1(i)] = computeAspectRatio(reshape(train_C1_images(i,:,:),28,28));

end

aRatio_C2 = zeros(size(train_C2_indices,2),1)';

for j = 1:size(train_C2_indices,2)
    [aRatio_C2(j), min_row_C2(j), min_col_C2(j), height_C2(j), width_C2(j)] = computeAspectRatio(reshape(train_C2_images(j,:,:),28,28));
end

%Constructing a new array containing every aRtio and then finding the
%min & max values 
aRatio = [aRatio_C1 aRatio_C2];


minAspectRatio = min(aRatio);
maxAspectRatio = max(aRatio);

R1 = 50;
R2 = 37;

figure 
imagesc(reshape(train_C1_images(R1,:,:),28,28))
colormap("gray")
rectangle('Position', [min_col_C1(R1)-.5, min_row_C1(R1)-.5, width_C1(R1), height_C1(R1)]', 'EdgeColor', 'r', 'LineWidth', 3)
title(sprintf('Digit %d', R1))


figure
imagesc(reshape(train_C2_images(R2,:,:),28,28))
colormap("gray")
rectangle('Position', [ min_col_C2(R2)-.5, min_row_C2(R2)-.5, width_C2(R2), height_C2(R2)], 'EdgeColor', 'r', 'LineWidth', 3)
title(sprintf('Digit %d', R2))



%% Bayesian Classifier


% Prior Probabilities
PC1 = size(train_C1_indices,2)/size(indices,2);
PC2 = size(train_C2_indices,2)/size(indices,2);


mu1 = (1/size(train_C1_indices,2)).*(sum(aRatio_C1));
mu2 = (1/size(train_C2_indices,2)).*(sum(aRatio_C2));
var1 = (1/size(train_C1_indices,2)).*(sum((aRatio_C1-mu1).^2));
var2 = (1/size(train_C2_indices,2)).*(sum((aRatio_C2-mu2).^2));




% Likelihoods - Posterior Probabilities

% Test data, aspect ratio of the test images


count_errors = 0;

for i = 1:size(test_C1_indices,2)
    x_C1(i) = computeAspectRatio(reshape(test_C1_images(i,:,:),28,28));
    PgivenC1(i) = normpdf(x_C1(i),mu1,sqrt(var1));
    PgivenC2(i) = normpdf(x_C1(i),mu2,sqrt(var2));

    PC1givenL(i) = PC1*PgivenC1(i);
    PC2givenL(i) = PC2*PgivenC2(i);
    
    % Classification result
    BayesClass1 = PC1givenL(i) - PC2givenL(i);
    
    % Count misclassified digits
    if BayesClass1 < 0
        count_errors = count_errors +1;
    end

end



for i = 1:size(test_C2_indices,2)
    x_C2(i) = computeAspectRatio(reshape(test_C2_images(i,:,:),28,28));
    PgivenC1(i) = normpdf(x_C2(i),mu1,sqrt(var1));
    PgivenC2(i) = normpdf(x_C2(i),mu2,sqrt(var2));

    PC1givenL(i) = PC1*PgivenC1(i);
    PC2givenL(i) = PC2*PgivenC2(i);
    
    % Classification result
    BayesClass2 = PC2givenL(i) - PC1givenL(i);
    
    % Count misclassified digits
    if BayesClass2 < 0
        count_errors = count_errors +1;
    end

end



% Total Classification Error (percentage)
Error = count_errors/(size(test_C1_indices,2)+size(test_C2_indices,2));