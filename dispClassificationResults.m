%FUNCTION: dispClassificationResults
%AUTHOR: Ian McAtee
%DATE: 10/2/2021
%DESCRIPTION: Function to display classification accuracies and errors for
    %each class 
%INPUTS: (errors,numClasses)
    %numClasses: The number of classes in the classification
    %errors: (numClasses+1)x1 vector containing the percent error of the
             %ith class in the ith row with the last row containing the
             %overall error
%OUTPUT: Tabular display of classification erros and accuracies 

function dispClassificationResults(errors,numClasses)

%Compute Classifier Accuracy Metrics
accuracy = 100*ones(1,numClasses+1) - errors;

fprintf('         \t ACCURACY: \t ERROR:\n')
for i = 1:numClasses
    fprintf('Class %u: \t %.2f%% \t %.2f%%\n',i,accuracy(i),errors(i));
end
fprintf('Overall: \t %.2f%% \t %.2f%%\n',accuracy(numClasses+1),errors(numClasses+1));

end