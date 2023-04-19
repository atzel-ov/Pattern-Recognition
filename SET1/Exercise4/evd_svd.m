clear; close all; clc; 

X = [ 1 0 1; -1 1 0];

% Covariance matrix

Cx = X'*X;

[Q,Lamda] = eig(Cx);

% Singular Values of X

[U,Sigma,V] = svd(X);

XX = X*X';

[Qx,LamdaX] = eig(XX);

% Best rank-1 estimation of X
% The larger eigenvalue of Cx is lamda3 = 3 corresponding to q3 eigenvector

W = Q(:,3);

X_hat = X*W;
