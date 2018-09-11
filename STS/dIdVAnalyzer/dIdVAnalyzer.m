function Ed = dIdVAnalyzer(STSData)
%
% close all;
% clear all;
% clc;

% S = importdata('/Users/averygreen/Desktop/TPD Slides/STS Spectra/m5_ori_AllGoodSpectra.txt',' ',3);

STSData = STSData(and(STSData(:,1)>-.5,STSData(:,1)<.5),:);

NoSpecs = size(STSData,2)/2;

Ed = zeros(1,NoSpecs);
C = Ed;
Error = Ed;    %RMS
for i = 1:NoSpecs
    
    x = STSData(:,2*i-1);
    y = STSData(:,2*i);
    
    MinPosition = MinFinder(x,y);
    
    xreduced = x;
    xreduced(or(x<MinPosition-0.075,x>MinPosition+0.075)) = [];
    yreduced = y;
    yreduced(or(x<MinPosition-0.075,x>MinPosition+0.075)) = [];
        
    p = polyfit(xreduced,yreduced,2);
    C(i) = p(1);
    ypoly = polyval(p,xreduced);
    
    Error(i) = norm(ypoly-yreduced)/length(ypoly);
    
    Ed(i) = -p(2)/(2*p(1));
    %Conditions for throwing out spectra:
    %1. Negative Curviture
    %2. Ed extrapolates outside analysis range
    %3. High error
    %4. Curvature too high or too low? (+-5*median)? Do after all spectra
    %finished
    if C(i) <= 0
        Ed(i) = NaN;
    elseif or(Ed(i)<xreduced(1),Ed(i)>xreduced(end))
        Ed(i) = NaN;
    elseif Error(i)>5e-2 %MONITOR
        Ed(i) = NaN;
    end
    
%     test = 1;
%     plot(x,y,...
%         'Color','k',...
%         'LineWidth',2);
%     hold on;
%     plot(xreduced,ypoly,...
%         'LineStyle','--',...
%         'LineWidth',2);
%     title(horzcat('Curvature = ',num2str(p(1),3)));
%     hold off;
    
    test = 1;
    
end

AdjMeanCurv = mean(C(C>0));
AdjMedCurv = median(C(C>AdjMeanCurv/50));
Ed(or(C<.3*AdjMedCurv,C>(10/3)*AdjMedCurv)) = NaN;

test = 1;


function MinPosition = MinFinder(x,y)

%Numerically Differentiate over 7 points
dy = [y;ones(6,1)*y(end)]-[ones(6,1)*y(1);y];
dx = [x;ones(6,1)*x(end)]-[ones(6,1)*x(1);x];

dydx = dy./dx;
dydx(1:3) = [];
dydx(end-2:end) = [];



Positives = dydx>=0;
Negatives = dydx<0;
Negatives = -1*Negatives;
Positives = [Positives;1];
Negatives = [-1;Negatives];
ZeroInds = find(Positives-Negatives==2);
%Zero is between Zeros and Zeros-1. Pick which y val is closer, get x
%position of that val.

%Can't try to access y(0) or y(end+1), which may happen because P/N is
%that size, so zeros can have that value.
ZeroInds(ZeroInds==1)=[];
ZeroInds(ZeroInds==length(dydx)+1)=[];

for j = 1:length(ZeroInds)
    if abs(dydx(ZeroInds(j)))<abs(dydx(ZeroInds(j)-1))
    else
        ZeroInds(j) = ZeroInds(j)-1;
    end
end

MinInd = ZeroInds(y(ZeroInds)==min(y(ZeroInds)));
MinPosition = median(x(MinInd));

% [AX,H1,H2]=plotyy(x,dydx,x,y);
% set(H1,'LineWidth',2);
% set(H2,'LineWidth',2);
% hold on;
% plot(AX(1),[MinPosition,MinPosition],get(AX(1),'ylim'),'LineStyle','--','LineWidth',1,'Color','k');
% plot(AX(1),get(AX(1),'xlim'),[0,0],'LineStyle','--','LineWidth',1,'Color','k')
% hold off;

test = 1;