function DrawCurvMap

close all;
clear all;
clc;

x = -1*pi:.01:pi;
y = x;

[X,Y] = meshgrid(x,y);

Chi0Curv = sin(2*X)+sin(Y);
Chi0Curv(1,1)=-4;
Chi0Curv(end,end)=4;

Chi2Curv = 2+cos(X)+sin(Y);
Chi2Curv(1,1)=-4;
Chi2Curv(end,end)=4;

figure;
imagesc(Chi0Curv);

figure;
imagesc(Chi2Curv);

test = 1;