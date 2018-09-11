function main

close all;
clear all;
clc;

[FileName, PathName] = uigetfile('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/*.txt','Select STS .txt data');
S = importdata(horzcat(PathName,FileName),' ',3);
% S = importdata('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/121416 SB2/m2_ori.txt',' ',3);
STSData = S.data;
clear S;

NoSpecs = size(STSData,2)/2;
% CMap = jet(NoSpecs);
% figure;
% hold on;
% for i = 1:NoSpecs
%     plot(STSData(:,2*i-1),STSData(:,2*i),'LineWidth',2,'Color',CMap(i,:));
% end

Ed = dIdVAnalyzer(STSData);

save('/Users/averygreen/Documents/MATLAB/Projects/STS/dIdVAnalyzer/Ed','Ed');

test = 1;