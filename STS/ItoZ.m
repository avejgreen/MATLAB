close all;
clear all;
clc;

[FileName,PathName,FilterIndex] = uigetfile('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/031017_Rd3_2/*.txt');

I = importdata(strcat(PathName,FileName), '\t');
I = I*1e9;
Z = I;

for i = 2:size(I,2)
    Z(:,i) = I(:,i) + I(:,i-1);
end

test = 1;

