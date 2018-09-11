%%% LEED angle, lattice calculator

function LEEDCalculator

close all;
clear all;
clc;

c=2.99792458e8;
h=6.6260755e-34;
m=9.1093897e-31;
q=1.60217733e-19;

% a=4.143e-10;
% theta=48*pi/180;
% theta=36.939*pi/180;
theta0=48*pi/180;
x1=705;
x0=825;
TeV=15.9;
TJ=TeV*q;

% p=2*h/(sqrt(3)*a*sin(theta));
% TJ=-m*c^2+sqrt(m^2*c^4+p^2*c^2);
% TeV=TJ/q;

a=2*h*c*x0/(sqrt(3)*x1*sin(theta0)*sqrt(TJ^2+2*m*c^2*TJ));

test = 1;