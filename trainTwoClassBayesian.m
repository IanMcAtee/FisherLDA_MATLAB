%FUNCTION: trainTwoClassBayesian
%AUTHOR: Stein Wiederholt
%DATE: 10/10/2021
%DESCRIPTION: Function to find the parameters for Gaussian Discriminant
    %function classification
%INPUTS: (class1,class2)
    %class1: numSamples x 2 class 1 training data
    %class2: numSamples x 2 class 2 training data
%OUTPUTS: [W1,W2,w1,w2,w10,w20]
    %Equations 67-68 in Duda, Hart, and Stork's "Pattern Classification"
    %Necessary terms to define Bayesian Discriminant function
    
function [W1,W2,w1,w2,w10,w20] = trainTwoClassBayesian(class1,class2)

%find the size of the training data
lenClass1 = length(class1);
lenClass2 = length(class2);

%COMPUTE STATISTICS

%find the priors of the training data
pw1 = lenClass1 / (lenClass1 + lenClass2);
pw2 = lenClass2 / (lenClass2 + lenClass1);

%find the means of the training data
m1 = mean(class1).';
m2 = mean(class2).';

%find covariance matrix of training data
cov1 = cov(class1);
cov2 = cov(class2);

%Calculate necessary terms for class 1
detCov1 = det(cov1);  % determinant
invCov1 = inv(cov1);  % inverse

%calculate remaining class 2 variables
detCov2 = det (cov2);  % determinant
invCov2 = inv(cov2);  % inverse

% compute Bayesian discriminant function components using equations 66, 67, 68, and 69 from text
%eq 67
W1 = -0.5 * invCov1;
W2 = -0.5 * invCov2;
%eq 68
w1 = invCov1 * m1;
w2 = invCov2 * m2;
%eq 69
w10 = -0.5 * m1' * invCov1 * m1 - 0.5 * log(detCov1) + log(pw1);
w20 = -0.5 * m2' * invCov2 * m2 - 0.5 * log(detCov2) + log(pw2);

end