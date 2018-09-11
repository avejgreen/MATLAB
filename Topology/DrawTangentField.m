function DrawTangentField

close all;
clear all;
clc;

x = -1*pi:.5:pi;
y = x;

[X,Y] = meshgrid(x,y);

TanFieldX = sin(X);
TanFieldY = sin(Y);

TanMag = sqrt(TanFieldX.^2+TanFieldY.^2);
TanMag = round(100*TanMag/max(max(TanMag)));
cmap = jet(100);

quiver(X,Y,TanFieldX,TanFieldY,'Color','k');
xlabel('k_x');
ylabel('k_y');

test = 1;
