close all;
clear all;
clc;


%% Plots
E = 0:.01:1;
EF = 0.5;
kT = 0.026;

fexp = exp((E-EF)/kT);

FD = 1./(fexp+1);

dFD = -(fexp/kT)./(fexp+1).^2;

plot(E,FD);
figure;
plot(E,dFD);

test = 1;


%% Symbolic Solutions
syms E FD dFD

fexp = exp((E-EF)/kT);

FD = 1/(fexp+1);

dFD = diff(FD,1,E);

test = 1;