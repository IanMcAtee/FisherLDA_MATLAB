%FUNCTION: genPlotsLDA
%AUTHOR: Ian McAtee
%DATE: 10/2/2021
%DESCRIPTION: Function to plot a variety of parameters based on a trained
    %LDA classifier and two input data sets
%INPUTS: (class1_test,class2_test,w,decisionPoint,axisOpt,Title,numSamps)
    %class1_test: numSamples x numFeatures class 1 test data
    %class2_test: numSamples x numFeatures class 2 training data
    %w: Fischer Vector
    %descisionPoint: scalar value of decision point along Fischer vector
    %axisOpt: row vector specifying the x and y axis for plotting
    %Title: title for the particular data set being used
    %numSamps: number of samples to be plotted for certain plots
%OUTPUT: Plots of the various parameters of the LDA classifier to
        %illustrate operation
        
function genPlotsLDA(class1,class2,w,decisionPoint,axisOpt,Title,numSamps)

%Set preliminary variables
lWidth = 2.5;
x_ticks = [0:2:20];
ww = [0,0;w(1),w(2)];
ww = ww*100; %off the plot

%Plot the Training Data with the Fisher Vector
figure()
scatter(class1(:,1),class1(:,2),'b.')
hold on
scatter(class2(:,1),class2(:,2),'r.')
hold on
plot(ww(:,1),ww(:,2),'g','LineWidth',lWidth);
hold off
axis equal
axis(axisOpt)
xticks(x_ticks)
box on
xlabel('x_1')
ylabel('x_2')
legend('Class 1','Class 2','Fisher Vector','Location','southeast')
title(strcat(Title,' with Fisher Vector'))

%Project test data A into 1D space
y1 = (w.'*class1.').'; %Eq. from Chap3Part5 Slide 23
y2 = (w.'*class2.').';

%Find angle of fisher vector
angle = atan(w(2)/w(1));

%Find x_1, x_2 coordinates of projections for plottng
class1Proj2D = [cos(angle).*y1,sin(angle).*y1];
class2Proj2D = [cos(angle).*y2,sin(angle).*y2];

%Plot the Training Data Projected onto Fischer Vector
figure()
plot(ww(:,1),ww(:,2),'g','LineWidth',lWidth);
hold on
scatter(class1Proj2D(1:numSamps,1),class1Proj2D(1:numSamps,2),'b*')
hold on
scatter(class2Proj2D(1:numSamps,1),class2Proj2D(1:numSamps,2),'r*')
hold on
scatter(class1(1:numSamps,1),class1(1:numSamps,2),'b.')
hold on
scatter(class2(1:numSamps,1),class2(1:numSamps,2),'r.')
hold off
axis equal
axis(axisOpt)
xticks(x_ticks)
box on
xlabel('x_1')
ylabel('x_2')
legend('Fisher Vector','Projected Class 1','Projected Class 2','Class 1','Class 2','Location','southeast')
title(strcat(Title, ' Projected onto Fisher Vector (',num2str(2*numSamps),' Samples)'))

%Find the decision line that is orthogonal to decision point
decisionLine = [decisionPoint*cos(angle)+((decisionPoint*sin(angle))/(tan(pi/2-angle))),0;
                0,decisionPoint/(cos(pi/2-angle))];
            
%Scatter plot of data with fisher vector, decision point, and line
figure()
scatter(class1(:,1),class1(:,2),'b.')
hold on
scatter(class2(:,1),class2(:,2),'r.')
hold on
plot(ww(:,1),ww(:,2),'g','LineWidth',lWidth);
hold on
plot(decisionLine(:,1),decisionLine(:,2),'m','LineWidth',lWidth)
hold on
scatter(decisionPoint*cos(angle),decisionPoint*sin(angle),1000,'k.')
hold off 
axis equal
axis(axisOpt)
xticks(x_ticks)
box on
xlabel('x_1')
ylabel('x_2')
legend('Class 1','Class 2','Fisher Vector','Decision Line','Decision Point','Location','southeast')
title(strcat(Title,' with Fisher Vector, Decision Line, and Decision Point'))

%Plot the data projected onto fisher vector with decision point
figure()
plot(ww(:,1),ww(:,2),'g','LineWidth',lWidth);
hold on
scatter(class1Proj2D(:,1),class1Proj2D(:,2),'b*')
hold on
scatter(class2Proj2D(:,1),class2Proj2D(:,2),'r*')
hold on
scatter(decisionPoint*cos(angle),decisionPoint*sin(angle),1000,'k.')
hold off
axis equal
axis(axisOpt)
xticks(x_ticks)
box on
xlabel('x_1')
ylabel('x_2')
legend('Fisher Vector','Projected Class 1','Projected Class 1','Decision Point','Location','southeast')
title(strcat(Title, ' Projected onto Fisher Vector with Decision Point'))

%Plot numSamps of data projected on fisher vector with decision point/line
figure()
plot(ww(:,1),ww(:,2),'g','LineWidth',lWidth);
hold on
plot(decisionLine(:,1),decisionLine(:,2),'m','LineWidth',lWidth)
hold on
scatter(class1Proj2D(1:numSamps,1),class1Proj2D(1:numSamps,2),'b*')
hold on
scatter(class2Proj2D(1:numSamps,1),class2Proj2D(1:numSamps,2),'r*')
hold on
scatter(class1(1:numSamps,1),class1(1:numSamps,2),'b.')
hold on
scatter(class2(1:numSamps,1),class2(1:numSamps,2),'r.')
hold on
scatter(decisionPoint*cos(angle),decisionPoint*sin(angle),1000,'k.')
hold off
axis equal
axis(axisOpt)
xticks(x_ticks)
xlabel('x_1')
ylabel('x_2')
legend('Fisher Vector','Decision Line','Projected Class 1','Projected Class 2','Class 1','Class 2','Decision Point','Location','southeast')
title(strcat(Title, ' Projected onto Fisher Vector with Decision Line and Point (',num2str(2*numSamps),' Samples)'))

end