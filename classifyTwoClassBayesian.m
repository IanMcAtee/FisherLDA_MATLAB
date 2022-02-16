%FUNCTION: classifyTwoClassBayesian
%AUTHOR: Ian McAtee and Stein Wiederholt
%DATE: 10/10/2021
%DESCRIPTION: Function to find the classify test data based on trained
    %Bayesian discriminant function parameters
%INPUTS: (class1_test,class2_test,w,decisionPoint,classOrder)
    %class1: numSamples x 2 class 1 test data
    %class2: numSamples x 2 class 2 training data
    %W1,W2,w1,w2,w10,w20: Discriminant function terms
%OUTPUTS: [classification,errors]
    %classification: (numSampsClass1+numSampsClass2)x1 vector containing
        %the classification label (1 or 2) for each sample of test data
    %errors: (numClasses+1)x1 vector containing the percent error of the
        %ith class in the ith row with the last row containing the
        %overall percent error
        
function [classification,errors] = classifyTwoClassBayesian(class1,class2,W1,W2,w1,w2,w10,w20)

%Find the number of test samples for each class
N1 = length(class1);
N2 = length(class2);

%Create a labels matrix
labels = [ones(N1,1);2*ones(N2,1)];

testData = [class1;class2];

%Preallocate a classification vector
classification = zeros((N1+N2),1);

%Perform the classification using the discriminant function
for i = 1:(N1+N2)
    x = [testData(i,1);testData(i,2)];
    g1 = x.' * W1 * x + w1.' * x + w10;
    g2 = x.' * W2 * x + w2.' * x + w20;
    g = g1 - g2;
    if (g >= 0)
        classification(i,1) = 1;
    else
        classification(i,1) = 2;
    end
end

%Find classification errors
errorTotal = (sum((labels - classification).^2)/(N1+N2))*100;
errorClass1 = (sum((labels(1:N1,:) - classification(1:N1)).^2)/(N1))*100;
errorClass2 = (sum((labels(N1+1:N1+N2,:) - classification(N1+1:N1+N2,:)).^2)/(N2))*100;

errors = [errorClass1;errorClass2;errorTotal];

end