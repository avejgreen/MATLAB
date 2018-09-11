function DumbPlotter1

close all;
clear all;
clc;

% [FileName, PathName] = uigetfile('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/*.txt','Select STS .txt data');
% S = importdata(horzcat(PathName,FileName),' ',3);
S = importdata('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/122316 Hinkle1/m1_ori.txt',' ',3);
STSData = S.data;
clear S;

NoSpecs = size(STSData,2)/2;

h = figure;
set(gca,'ColorOrder',jet(625))
hold all;

for i = 1:625
    plot(1000*STSData(:,2*i-1),STSData(:,2*i),'LineWidth',1.5);
end

set(gca,'TickDir','out');
set(gca,'LineWidth',1);
set(gca,'FontSize',14,'FontName','Arial');
set(gca,'XMinorTick','on','YMinorTick','on');
xlabel('E_D-E_F (meV)','fontsize',16);
ylabel('dI/dV (nA/meV)','fontsize',16);


test = 1;