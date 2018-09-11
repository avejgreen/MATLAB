close all;
clear all;
clc;

krange = pi;
kres = 0.1;
k = -krange:kres:krange;

%Gammas are transition energies. Can just use first order or first two.

g1 = 1;

%s-band in FCC crystal has Ek=E0-beta-sig(gamma(R)e^ikR)

%Define the lattice parameter as 1. 12 closest neighbors are at
%(a/2)*(pm1,pm1,0) and permutations.

a = 1;
R1 = a*[1,1,0;1,-1,0];
R1 = [R1;-R1];
R1temp1 = circshift(R1,[0,1]);
R1temp2 = circshift(R1,[0,2]);
R1 = [R1;R1temp1;R1temp2];

test = 1;