%%% Tomograph

close all;
close all hidden;
clear all;
clc;

%HKL spots
hRange = -5:1:5;
[h,k,l] = meshgrid(hRange,hRange,hRange);
h = reshape(h,numel(h),1,1);
k = reshape(k,numel(k),1,1);
l = reshape(l,numel(l),1,1);

%Si Structure factor given by inversion center at 1/8,1/8,1/8
F=cos((pi/4)*(-h-k-l))+...
    cos((pi/4)*(3*h+3*k-l))+...
    cos((pi/4)*(3*h-k+3*l))+...
    cos((pi/4)*(-h+3*k+3*l));
F(abs(F)<.1)=0;

hkl = [h,k,l];
hkl = hkl(h==k,:)

test = 1;