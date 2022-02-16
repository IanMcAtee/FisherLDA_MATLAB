%Project 1: Bayesian Discriminant and LDA Classifiers
%Authors: Ian McAtee and Stein Wiederholt
%Class: EE5650
%Professor: Dr. Wright
%Institution: University of Wyoming
%Date: 10/11/2021
%DESCRIPTION:
    %MATLAB program to perform the Bayesian Discriminant Function 
    %classification and LDA classification of two classes of two 
    %dimensional sample data 

function Main()
%% PRELIMINARY SETUP
%Load in the training and test data
load('test1.mat')
load('training1.mat')
axisOpt = [0,20,0,20];

%% PLOT DATA, STATISTICS, AND HISTOGRAMS
Title = 'Training Data';
genGaussStatisticsPlots(class1_train,class2_train,axisOpt,Title)
genHistograms(class1_train,class2_train,class1_test_a,class2_test_a,class1_test_b,class2_test_b)

%% BAYESIAN CLASSIFIER
%Train Bayesian classifier
[W1,W2,w1,w2,w10,w20] = trainTwoClassBayesian(class1_train,class2_train);

%Generate Plots of Trained Bayesian with Training data
genPlotsBayesian(class1_train,class2_train,W1,W2,w1,w2,w10,w20,axisOpt,Title)

%Bayesian Classification of Test Data A and B 
[classificationA_Bayes,errorsA_Bayes] = classifyTwoClassBayesian(class1_test_a,class2_test_a,W1,W2,w1,w2,w10,w20);
[classificationB_Bayes,errorsB_Bayes] = classifyTwoClassBayesian(class1_test_b,class2_test_b,W1,W2,w1,w2,w10,w20);

%Generate Plots of Trained Bayesian with Test data
Title = 'Test A Data';
genPlotsBayesian(class1_test_a,class2_test_a,W1,W2,w1,w2,w10,w20,axisOpt,Title)
Title = 'Test B Data';
genPlotsBayesian(class1_test_b,class2_test_b,W1,W2,w1,w2,w10,w20,axisOpt,Title)

%% LDA CLASSIFIER
%Train LDA Classifier
[w,decisionPoint,classOrder] = trainLDA(class1_train,class2_train);

%Generate Plots of LDA with Training data
numSamps = 30;
genPlotsLDA(class1_train,class2_train,w,decisionPoint,axisOpt,Title,numSamps)

%LDA Classification of Test Data A and B 
[classificationA_LDA,errorsA_LDA] = classifyLDA(class1_test_a,class2_test_a,w,decisionPoint,classOrder);
[classificationB_LDA,errorsB_LDA] = classifyLDA(class1_test_b,class2_test_b,w,decisionPoint,classOrder);

%Generate Plots of LDA with Test Data
Title = 'Test Data A';
genPlotsLDA(class1_test_a,class2_test_a,w,decisionPoint,axisOpt,Title,numSamps)
Title = 'Test Data B';
genPlotsLDA(class1_test_b,class2_test_b,w,decisionPoint,axisOpt,Title,numSamps)

%% DISPLAY CLASSIFICATION RESULTS
%Bayesian Results
fprintf('BAYESIAN CLASSFICATION RESULTS\n')
fprintf('--------------------------------\n')
fprintf('TEST DATA A:\n')
dispClassificationResults(errorsA_Bayes,2);
fprintf('\n')
fprintf('TEST DATA B:\n')
dispClassificationResults(errorsB_Bayes,2);

%LDA Results
fprintf('LDA CLASSFICATION RESULTS\n')
fprintf('--------------------------------\n')
fprintf('TEST DATA A:\n')
dispClassificationResults(errorsA_LDA,2);
fprintf('\n')
fprintf('TEST DATA B:\n')
dispClassificationResults(errorsB_LDA,2);

end
