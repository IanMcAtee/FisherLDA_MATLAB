%FUNCTION: trainLDA
%AUTHOR: Ian McAtee
%DATE: 10/2/2021
%DESCRIPTION: Function to find the Fischer vector and decision points based
    %on the two input class training data sets
%INPUTS: (class1_train,class2_train)
    %class1: numSamples x numFeatures class 1 training data
    %class2: numSamples x numFeatures class 2 training data
%OUTPUTS: [w,decisionPoint,classOrder]
    %w: Fischer Vector
    %descisionPoint: scalar value of decision point along Fischer vector
    %classOrder: Integer value reflecting which class mean is higher than
        %the decision point

function [w,decisionPoint,classOrder] = trainLDA(class1,class2)

%Find the number of training samples for each class
N1 = length(class1);
N2 = length(class2);

%Get training data means
m1 = mean(class1).';
m2 = mean(class2).';

%Get training data covariances
covW1 = cov(class1);
covW2 = cov(class2);

%Compute Scatter Matrices 
S1 = (N1-1)*covW1;
S2 = (N2-1)*covW2;
Sw = S1 + S2;

%Find Fischer's Vector
w = (inv(Sw))*(m1-m2);

%Make w a unit vector
w = w./(sqrt((0-w(1))^2+(0-w(2))^2));

%Constrain w to first quadrant
w = abs(w);

%Project the training class means into the 1D space
m1Proj = w.'*m1;
m2Proj = w.'*m2;

%Decision Point is midway between the means in the 1D space
decisionPoint = (m1Proj + m2Proj)/2;

%Find which class is above decision point and which is below
if (m1Proj > m2Proj)
    classOrder = 1;
else
    classOrder = 2;
end

end 