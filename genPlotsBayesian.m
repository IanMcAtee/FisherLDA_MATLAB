%FUNCTION: genPlotsBayesian
%AUTHOR: Ian McAtee and Stein Wiederholt
%DATE: 10/10/2021
%DESCRIPTION: Function to plot data on Bayesian discriminant region plot
%INPUTS: (class1,class2,axisOpt,Title)
    %class1: numSamples x 2 class 1 data
    %class2: numSamples x 2 class 2 data
    %W1,W2,w1,w2,w10,w20: Discriminant function terms
    %axisOpt: row vector specifying the x and y axis for plotting
    %Title: title for the particular data set being used
%OUTPUT: Scatter plot of data superimposed on discriminant function
    %classification regions
    
function genPlotsBayesian(class1,class2,W1,W2,w1,w2,w10,w20,axisOpt,Title)

%Set region to evaluate discriminant funtion over
x = (-20:0.5:20); 
L = length(x);

%Preallocate discriminant functions
g1 = ones(L,L);
g2 = ones(L,L);

for i=1:L
    for j=1:L
        xx = [x(i);x(j)];
        g1(j,i) = xx' * W1 * xx + w1' * xx + w10;
        g2(j,i) = xx' * W2 * xx + w2' * xx + w20;
    end
end

%dichotimize function eq 29
g = g1 - g2;

%find decision regions for plot
gRegion = ones(L,L);
index = find(g < 0);
gRegion(index) = 0;

%Plot the decision boundary with training data superimposed
figure()
imagesc(x,x,gRegion,'AlphaData',1.0)
axis ('xy')
colormap('hot')
hold on
scatter(class1(:,1),class1(:,2),'b.');
hold on
scatter(class2(:,1),class2(:,2),'r.');
axis equal
axis(axisOpt)
box on
hold off
xlabel('x_1')
ylabel('x_2')
text(10,18,'Class 2','color','w')
text(1,2.5,'Class 1','color','k')
legend('Class 1 (\omega_1)','Class 2 (\omega_2)','Location','southeast')
title(strcat(Title,' with Bayesian Decision Regions'))

end