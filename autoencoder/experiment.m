
load('mnist2k/MNIST_train2k.mat');
data = X;

inputSize = size(X, 1);
numTrainingExamples = size(X, 2);

% Draw examples from uniform random distribution
% data = rand(inputSize, numTrainingExamples);

% Draw data from gaussian distribution
% Sigma = [2, 1; 1, 3]; R = chol(Sigma);
% R = [sqrt(2), sqrt(2); -sqrt(2), sqrt(2)] * diag([1, 5]);
% data = randn(numTrainingExamples, 2) * R;
% data = data';

hiddenSize = 25;
lambda = 0.05;
beta = 5;
rho = 1.0;

theta = initializeParameters(hiddenSize, inputSize);

addpath minFunc/
options.Method = 'lbfgs';
options.maxIter = 300;
options.display = 'on';
[opttheta, cost] = minFunc(@(p) sparseLinearAutoencoderCost(p, inputSize, hiddenSize, lambda, rho, beta, data), ...
                           theta, options);
                       
[W1, W2, b1, b2] = unrollParameters(opttheta, inputSize, hiddenSize);

display_network(W1');