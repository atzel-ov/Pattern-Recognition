clear
close all
clc


%% EXERCISE 1 %%

mu1 = [3 3];
sigma1 = [1.2 -0.4; -0.4 1.2];

mu2 = [6 6];
sigma2 = [1.2 0.4; 0.4 1.2];

x1 = linspace(-1, 10, 100);
x2 = linspace(-1, 10, 100);

[X1,X2] = meshgrid(x1,x2);


fxw1 = mvnpdf([X1(:) X2(:)], mu1, sigma1);
fxw1 = reshape(fxw1, size(X1));

fxw2 = mvnpdf([X1(:) X2(:)], mu2, sigma2);
fxw2 = reshape(fxw2, size(X1));


figure
hold on
contour(X1,X2,fxw1, 17, 'r.');
contour(X1,X2,fxw2, 17, 'b.');
hold off
grid on
xlabel('x_1')
ylabel('x_2')

figure
hold on
surf(X1, X2, fxw1);
surf(X1, X2, fxw2);
hold off
xlabel('x_1')
ylabel('x_2')
zlabel('f_x_|_w_i')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
close all
clc

Nsamples = 100;

mu1 = [3 3];
mu2 = [6 6];

m = [mu1;mu2];

Sigma1 = [1.2 -0.4; -0.4 1.2];
Sigma2 = [1.2  0.4;  0.4 1.2];


x = mvnrnd(mu1, Sigma1, Nsamples);
y = mvnrnd(mu2, Sigma2, Nsamples);

figure
plot(x(:,1),x(:,2),'r.',y(:,1),y(:,2),'b.')
xlabel('x_1')
ylabel('x_2')
axis equal

% p1 p2 priors
p1 = 0.5;
p2 = 1 - p1;

x = -1:0.01:10;

y = (1.066*log(p1/p2)-46.5)./x + 2;
%%y = (22.5-2*log(p2/p1))./(1.25*x);

hold on 
plot(x,y,'g')
axis ([-1 10 -1 10])
hold off
