%FUNCTION: genGaussStatisticsPlots
%AUTHOR: Ian McAtee and Stein Wiederholt
%DATE: 10/10/2021
%DESCRIPTION: Function to plot two class training data and the associated 
    %bivariate and marginal gaussian distributions
%INPUTS: (class1,class2,axisOpt,Title)
    %class1: numSamples x 2 class 1 data
    %class2: numSamples x 2 class 2 data
    %axisOpt: row vector specifying the x and y axis for plotting
    %Title: title for the particular data set being used
%OUTPUT: Scatter plot of data, marginal gaussian distributions of x_1 
    %and x_2, contour line plot of gaussian PDF, 3D plot of gaussian PDF 
    
function genGaussStatisticsPlots(class1,class2,axisOpt,Title)

x_ticks = [0:2:20];

%Get Statistics 
numFeat1 = size(class1,2);
numFeat2 = size(class2,2);

%Calculate means and covariences 
m1 = mean(class1).';
m2 = mean(class2).';
cov1 = cov(class1);
cov2 = cov(class2);

%Pre-calculate univariate gaussian components
sqrtTwoPiVar1_x1 = sqrt(2*pi*cov1(1,1)); %sqrt(2*pi*var)
sqrtTwoPiVar1_x2 = sqrt(2*pi*cov1(2,2));
sqrtTwoPiVar2_x1 = sqrt(2*pi*cov2(1,1));
sqrtTwoPiVar2_x2 = sqrt(2*pi*cov2(2,2));
oneHalf_var1_x1 = -0.5/cov1(1,1); %-1/(2var)
oneHalf_var1_x2 = -0.5/cov1(2,2);
oneHalf_var2_x1 = -0.5/cov2(1,1);
oneHalf_var2_x2 = -0.5/cov2(2,2);

%Pre-calculate multivariate gaussian components
twoPiD21 = (2*pi)^(numFeat1/2); %Class 1: 2pi^(d/2)
twoPiD22 = (2*pi)^(numFeat2/2); %Class 2: 2pi^(d/2)
sqrtDetCov1 = sqrt(det(cov1)); %Class 1: |Sigma|^(1/2) 
sqrtDetCov2 = sqrt(det(cov2)); %Class 2: |Sigma|^(1/2) 
invCov1 = inv(cov1); %Class 1: (Sigma)^(1/2)
invCov2 = inv(cov2); %Clsas 2: (Sigma)^(1/2)

%Create temp x data to evaluate over
x = (-20:0.1:20); %Reduce the step size to for higher res. plots
L = length(x); %Get number of temp samples

%Preallocate matrices to hold probability
%Multivariate distributions
pX1 = zeros(L,L);  
pX2 = zeros(L,L);
%Marginal distributions
pX1_x1 = zeros(1,L);
pX1_x2 = zeros(1,L);
pX2_x1 = zeros(1,L);
pX2_x2 = zeros(1,L);

%Evaluate the Gaussian PDFs for training data of each class
for i=1:L  % loop columns
    %Marginal distributions of each dimension for each class
    pX1_x1(i) = (1/sqrtTwoPiVar1_x1)*exp(oneHalf_var1_x1*(x(i)-m1(1))^2); 
    pX1_x2(i) = (1/sqrtTwoPiVar1_x2)*exp(oneHalf_var1_x2*(x(i)-m1(2))^2);
    pX2_x1(i) = (1/sqrtTwoPiVar2_x1)*exp(oneHalf_var2_x1*(x(i)-m2(1))^2);
    pX2_x2(i) = (1/sqrtTwoPiVar2_x2)*exp(oneHalf_var2_x2*(x(i)-m2(2))^2);
    for j=1:L  % loop rows
        x_vector = [x(i); x(j)]; %Form vector
        %Calculate Gaussian eq. terms
        xm1 = x_vector - m1;
        xm2 = x_vector - m2;
        arg1 = xm1.'*invCov1*xm1;
        arg2 = xm2.'*invCov2*xm2;
        %Calculate Multivariate Gaussian
        pX1(j,i)=(1/(twoPiD21*sqrtDetCov1))*exp(-0.5*arg1);
        pX2(j,i)=(1/(twoPiD22*sqrtDetCov2))*exp(-0.5*arg2);
    end
end

%Scatter plot of data
figure()
scatter(class1(:,1),class1(:,2),'b.')
hold on
scatter(class2(:,1),class2(:,2),'r.')
hold off
axis equal
axis(axisOpt)
xticks(x_ticks)
box on
xlabel('x_1')
ylabel('x_2')
legend('Class 1','Class 2','Location','southeast')
title(Title)

%Plot Marginal PDF of x1 Dimension for Both Classes
figure()
plot(x,pX1_x1,'b')
hold on
plot(x,pX2_x1,'r')
hold off
xlim([0,20])
box on
xlabel('x_1')
ylabel('p(x_1)')
legend('p(x_1|\omega_1)','p(x_1|\omega_2)','Location','northeast')
title(strcat(Title,': Marginal PDFs of x_1 For Class 1 and Class 2'))

%Plot Marginal PDF of x2 Dimension for Both Classes
figure()
plot(x,pX1_x2,'b')
hold on
plot(x,pX2_x2,'r')
hold off
xlim([0,20])
box on
xlabel('x_2')
ylabel('p(x_2)')
legend('p(x_2|\omega_1)','p(x_2|\omega_2)','Location','northeast')
title(strcat(Title,': Marginal PDFs of x_2 For Class 1 and Class 2'))

%Plot Contour Lines of Multivariate Gaussian of Both Classes
figure()
contour(x,x,pX1,'b')
hold on
contour(x,x,pX2,'r')
axis equal
axis(axisOpt)
xticks(x_ticks)
box on
hold off
xlabel('x_1')
ylabel('x_2')
legend('p(x|\omega_1)','p(x|\omega_2)','Location','southeast')
title(strcat(Title, ': PDFs as Equiprobable Lines'))

%Plot 3D PDFs of both classes
figure()
mesh(x,x,pX1)
hold on
mesh(x,x,pX2)
axis('tight')
xlim([0 20])
ylim([0 20])
hold off
xlabel('x_1')
ylabel('x_2')
zlabel('p(x|\omega)')
hold off
view(9,18)
title(strcat(Title,': PDFs of Class 1 and Class 2'))

end 