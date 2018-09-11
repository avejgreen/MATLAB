function JDOS_Extractor

close all;
clear all;
clc;

data = importdata('/Users/averygreen/Documents/MATLAB/Projects/JDOS 061616/Dataset.csv');
% scatter(data(:,1),data(:,2));


firstcol = and(data(:,1)>.106,data(:,1)<.109);
secondcol = and(data(:,1)>.405,data(:,1)<.410);
thirdcol = and(data(:,1)>.704,data(:,1)<.712);
fourthcol = data(:,1)>.99;

data2 = data(~or(or(firstcol,secondcol),or(thirdcol,fourthcol)),:);
% figure;
% scatter(data2(:,1),data2(:,2));


zerorow = and(data2(:,2)>-.05,data2(:,2)<.05);

data3 = data2(~zerorow,:);
% figure;
% scatter(data3(:,1),data3(:,2));

TLData = data3(and(data3(:,1)<.5,data3(:,2)>0),:);
TRData = data3(and(data3(:,1)>.5,data3(:,2)>0),:);
BLData = data3(and(data3(:,1)<.5,data3(:,2)<0),:);
BRData = data3(and(data3(:,1)>.5,data3(:,2)<0),:);

pTL = FitQuarterAndPlot(TLData);
pTR = FitQuarterAndPlot(TRData);
pBL = FitQuarterAndPlot(BLData);
pBR = FitQuarterAndPlot(BRData);

syms fTL fTR fBL fBR x;
fTL = 0;
fTR = 0;
fBL = 0;
fBR = 0;
for i = 0:length(pTL)-1
    fTL = fTL+pTL(length(pTL)-i)*x^i;
    fTR = fTR+pTR(length(pTL)-i)*x^i;
    fBL = fBL+pBL(length(pTL)-i)*x^i;
    fBR = fBR+pBR(length(pTL)-i)*x^i;
end;

JDOSL = fTL-fBL;
% figure;
% ezplot(JDOSL,[0,.5]);
JDOSR = fTR-fBR;
% figure;
% ezplot(JDOSR,[.5,1]);

diffJDOSL = diff(JDOSL);
% figure;
% ezplot(diffJDOSL,[0,.5]);
diffJDOSR = diff(JDOSR);
% figure;
% ezplot(diffJDOSR,[.5,1]);

CPLs = solve(diffJDOSL == 0,x,'Real',true);
CPRs = solve(diffJDOSR == 0,x,'Real',true);
CPLs = double(CPLs);
CPRs = double(CPRs);
CPLs = CPLs(imag(CPLs)==0);
CPRs = CPRs(imag(CPRs)==0);
CPLs = [CPLs,subs(JDOSL,CPLs)];
CPRs = [CPRs,subs(JDOSR,CPRs)];

CPs = [CPLs;CPRs];
CPs = sortrows(CPs,1);

figure;
scatter(TLData(:,1),TLData(:,2));
hold on;
scatter(TRData(:,1),TRData(:,2));
scatter(BLData(:,1),BLData(:,2));
scatter(BRData(:,1),BRData(:,2));
ezplot(fTL,linspace(min(TLData(:,1)),max(TLData(:,1))));
ezplot(fTR,linspace(min(TRData(:,1)),max(TRData(:,1))));
ezplot(fBL,linspace(min(BLData(:,1)),max(BLData(:,1))));
ezplot(fBR,linspace(min(BRData(:,1)),max(BRData(:,1))));
axis([min(TLData(:,1)) max(TRData(:,1)) -1.5 1.5]);

for i = 1:length(CPs)
    plot(CPs(i,1)*[1;1],[-1.5;1.5]);
end

test = 1;

end

function p = FitQuarterAndPlot(Quarter)

p = polyfit(Quarter(:,1),Quarter(:,2),12);
% fDomain = linspace(min(Quarter(:,1)),max(Quarter(:,1)),100);
% f = polyval(p, fDomain);
% figure;
% scatter(Quarter(:,1),Quarter(:,2));
% hold on;
% plot(fDomain, f, 'Color', 'Red');

test = 1;
end