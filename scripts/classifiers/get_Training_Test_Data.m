function [X_train, X_test] = get_Training_Test_Data(X,per)
% function [X_train, X_test] = get_Training_Test_Data(X,per)
% 
% Randomly separate the input into per% training and (1 - per)% test data
% 
% Inputs:
%       X = m x 784 matrix of input data
%       per = percentage of training data
% 
% Outputs:
%       X_train = per%*m x 784 of training data
%       X_test = (1-per)%*m x 784 of test data
m = size(X,1);
ind = randperm(m).';
X_train = X(ind(1:floor(per*m)),:);
X_test = X(ind(floor(per*m)+1:end),:);