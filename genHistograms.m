%FUNCTION: genHistograms
%AUTHOR: Stein Wiederholt
%DATE: 10/11/2021
%DESCRIPTION: Function to plot the histograms of training and test data
%INPUTS: (class1_train,class2_train,class1_test_a,class2_test_a,
         %class1_test_b,class2_test_b)
%OUTPUT: Subplots of the histograms of the training and test data

function genHistograms(class1_train,class2_train,class1_test_a,class2_test_a,class1_test_b,class2_test_b)

%set parameters for near-full-screen figures.
%Credit BE_demo, Copyright (c) 2008-2012 Cameron H. G. Wright
scrsz = get(0,'ScreenSize'); % get the screen size 
% Vista and Win7 have a 31 pixel task bar at bottom
Los=10; % left offset
Bos=55; % bottom offset
Ros=20; % right offset
Tos=145; % top ofset
FigPos=[scrsz(1)+Los scrsz(2)+Bos scrsz(3)-Ros scrsz(4)-Tos];

set(0,'DefaultAxesFontSize',14);
set(0,'DefaultTextFontSize',14);
set(0,'DefaultLineLineWidth',2); 

nBins = 100;
%class 1 histograms
figure()
set(gcf,'Position',FigPos)  % set near max figure size
subplot(2,3,1)
histogram(class1_train(:,1),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 1 Train: x_1')
subplot(2,3,4)
histogram(class1_train(:,2),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 1 Train: x_2')
subplot(2,3,2)
histogram(class1_test_a(:,1),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 1 Test A: x_1')
subplot(2,3,5)
histogram(class1_test_a(:,2),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 1 Test A: x_2')
subplot(2,3,3)
histogram(class1_test_b(:,1),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 1 Test B: x_1')
subplot(2,3,6)
histogram(class1_test_b(:,2),nBins)
%axis('tight')
xlabel('Value')
ylabel('Frequency')
title('Class 1 Test B: x_2')

%class 2 histograms
figure()
set(gcf,'Position',FigPos)  % set near max figure size
subplot(2,3,1)
histogram(class2_train(:,1),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 2 Train: x_1')
subplot(2,3,4)
histogram(class2_train(:,2),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 2 Train: x_2')
subplot(2,3,2)
histogram(class2_test_a(:,1),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 2 Test A: x_1')
subplot(2,3,5)
histogram(class2_test_a(:,2),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 2 Test A: x_2')
subplot(2,3,3)
histogram(class2_test_b(:,1),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 2 Test B: x_1')
subplot(2,3,6)
histogram(class2_test_b(:,2),nBins)
xlabel('Value')
ylabel('Frequency')
title('Class 2 Test B: x_2')

%reset default figure properties
set(0,'DefaultAxesFontSize','remove'); 
set(0,'DefaultTextFontSize','remove');
set(0,'DefaultLineLineWidth','remove') 

end