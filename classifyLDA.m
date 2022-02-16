%FUNCTION: classifyLDA
%AUTHOR: Ian McAtee
%DATE: 10/2/2021
%DESCRIPTION: Function to find the classify test data based on trained LDA
    %parameters
%INPUTS: (class1_test,class2_test,w,decisionPoint,classOrder)
    %class1: numSamples x numFeatures class 1 test data
    %class2: numSamples x numFeatures class 2 training data
    %w: Fischer Vector
    %descisionPoint: scalar value of decision point along Fischer vector
    %classOrder: Integer value reflecting which class mean is higher than
        %the decision point
%OUTPUTS: [classification,errors]
    %classification: (numSampsClass1+numSampsClass2)x1 vector containing
        %the classification label (1 or 2) for each sample of test data
    %errors: (numClasses+1)x1 vector containing the percent error of the
        %ith class in the ith row with the last row containing the
        %overall percent error
             
function [classification,errors] = classifyLDA(class1,class2,w,decisionPoint,classOrder)

%Find the number of test samples for each class
N1 = length(class1);
N2 = length(class2);

%Form label vector for test data 
labels = [ones(N1,1);2*ones(N2,1)];

%Project test data A into 1D space
yTest1 = (w.'*class1.').'; %Eq. from Chap3Part5 Slide 23
yTest2 = (w.'*class2.').';
yTest = [yTest1;yTest2];

%Classify test data
classification = yTest;
if (classOrder == 1)
    classification(yTest>=decisionPoint) = 1;
    classification(yTest<decisionPoint) = 2;
elseif (classOrder == 2)
    classification(yTest>=decisionPoint) = 2;
    classification(yTest<decisionPoint) = 1;
else 
    error('Classification order must be set to 1 or 2. See help.') 
end

%Find classification errors
errorTotal = (sum((labels - classification).^2)/(N1+N2))*100;
errorClass1 = (sum((labels(1:N1,:) - classification(1:N1)).^2)/(N1))*100;
errorClass2 = (sum((labels(N1+1:N1+N2,:) - classification(N1+1:N1+N2,:)).^2)/(N2))*100;

errors = [errorClass1;errorClass2;errorTotal];

end