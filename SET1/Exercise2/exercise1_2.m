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


% Compute the aspect ratios of all images and store the value of the i-th image in aRatios(i)

%    num_C1 =  size(train_C1_images,1);
%    num_C2 =  size(train_C2_images,1);
%    
%    images = num_C1 + num_C2;

minAspectRatio = ...
maxAspectRatio = ...


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