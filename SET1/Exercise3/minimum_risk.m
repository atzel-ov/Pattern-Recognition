clc; clear; close all;

x = [0:0.01:10];

fxw1 = raylpdf(x,1);
fxw2 = raylpdf(x,2);

figure
plot(x,fxw1,'b-')
hold on
plot(x,fxw2,'r-')
xlabel('x')
title('Rayleigh PDFs')