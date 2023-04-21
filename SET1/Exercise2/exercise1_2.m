close all;
clear;
clc;

data_file = 'data/mnist.mat';

data = load(data_file);

% Read the train data
[train_C1_indices, train_C2_indices,train_C1_images,train_C2_images] = read_data(data.trainX,data.trainY.');

% Read the test data
[test_C1_indices, test_C2_indices,test_C1_images,test_C2_images] = read_data(data.testX,data.testY.');


%% Compute Aspect Ratio

%Computing the aspect Ration of each digit and saving it to the
%corresponding aray 

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

figure 
imagesc(reshape(train_C1_images(25,:,:),28,28))
colormap("gray")

rectangle('Position', [min_col_C1(25), min_row_C1(25), width_C1(25), height_C1(25)]', 'EdgeColor', 'r', 'LineWidth', 2)


title(sprintf('Digit %d', 25))


figure
imagesc(reshape(train_C2_images(29,:,:),28,28))
colormap("gray")
rectangle('Position', [ min_col_C2(29), min_row_C2(29), width_C2(29), height_C2(29)], 'EdgeColor', 'r', 'LineWidth', 2)
title(sprintf('Digit %d', 29))



%% Bayesian Classifier


% Prior Probabilities
PC1 = ...
PC2 = ...


% Likelihoods
PgivenC1 = ...
PgivenC2 = ...



% Posterior Probabilities
PC1givenL = ...
PC2givenL = ...

% Classification result
BayesClass = ...

% Count misclassified digits
count_errors = ...

% Total Classification Error (percentage)
Error = ...