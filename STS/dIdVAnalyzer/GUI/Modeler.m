function STSData = Modeler(STSData,DiffPts,FitRange,ErrorMax,CurvRange,...
    PosNegBias,CheckXLimit,XRange,CheckYLimit,YRange)
%
% close all;
% clear all;
% clc;

% S = importdata('/Users/averygreen/Desktop/TPD Slides/STS Spectra/m5_ori_AllGoodSpectra.txt',' ',3);

% STSData = STSData(and(STSData(:,1)>-.5,STSData(:,1)<.5),:);

% Ed = zeros(1,length(STSData));
% C = Ed;
% Error = Ed;    %RMS
for i = 1:length(STSData)
    
    x = STSData(i).xData;
    y = STSData(i).yData;
    
    [PeakPosition,dydx] = MinFinder(x,y,DiffPts,PosNegBias,CheckXLimit,XRange);

    xreduced = x(and(x>PeakPosition-FitRange/2,x<PeakPosition+FitRange/2));
    yreduced = y(and(x>PeakPosition-FitRange/2,x<PeakPosition+FitRange/2));
    
    p = polyfit(xreduced,yreduced,2);
    C = p(1);
    ypoly = polyval(p,xreduced);
    
    Error = norm(ypoly-yreduced)/sqrt(length(ypoly));
    
    EdX = -p(2)/(2*p(1));
    EdY = -p(2)^2/(4*p(1))+p(3);
    
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
    
    %Conditions for throwing out spectra:
    %1. Curvature too high or too low?
    %2. Ed extrapolates outside analysis range
    %3. High error
    %finished
    if or(C<CurvRange(1),C>CurvRange(2))
        STSData(i).ValidEd = 'No';
    elseif Error>ErrorMax %MONITOR
        STSData(i).ValidEd = 'No';
    elseif and(CheckXLimit,or(EdX<XRange(1),EdX>XRange(2)))
        STSData(i).ValidEd = 'No';
    elseif and(CheckYLimit,or(EdY<YRange(1),EdY>YRange(2)))
        STSData(i).ValidEd = 'No';
    else
        STSData(i).ValidEd = 'Yes';
    end
    
    STSData(i).dydxData = dydx;
    STSData(i).Curvature = C;
    STSData(i).Error = Error;
    STSData(i).EdX = EdX;
    STSData(i).xReduced = xreduced;
    STSData(i).yPoly = ypoly;
end

% AdjMeanCurv = mean(C(C>0));
% AdjMedCurv = median(C(C>AdjMeanCurv/50));
% Ed(or(C<CurvRange(1),C>CurvRange(2))) = NaN;

test = 1;


function [PeakPosition,dydx] = MinFinder(x,y,DiffPts,PosNegBias,CheckXLimit,XRange)

%Numerically Differentiate over DiffPts points
dy = [y;ones(DiffPts-1,1)*y(end)]-[ones(DiffPts-1,1)*y(1);y];
dx = [x;ones(DiffPts-1,1)*x(end)]-[ones(DiffPts-1,1)*x(1);x];

dydx = dy./dx;
dydx(1:round(.5*(DiffPts-1))) = [];
dydx(end-round(.5*(DiffPts-1))+1:end) = [];

Signdydx = sign(dydx);
dSign = [0;Signdydx(2:end)-Signdydx(1:end-1)];
ZeroInds = find(dSign);


%Zero is between Zeros(i) and Zeros(i-1). Pick which y val is closer, get x
%position of that val.

for j = 1:length(ZeroInds)
    if abs(dydx(ZeroInds(j)))<abs(dydx(ZeroInds(j)-1))
    else
        ZeroInds(j) = ZeroInds(j)-1;
    end
end

%Remove zeros outside x range
if CheckXLimit
    ZeroInds(or(x(ZeroInds)<XRange(1),x(ZeroInds)>XRange(2)))=[];
end

if PosNegBias == 1
    PeakInd = ZeroInds(y(ZeroInds)==min(y(ZeroInds)));
elseif PosNegBias == 0
    PeakInd = ZeroInds(y(ZeroInds)==max(y(ZeroInds)));
end

PeakPosition = median(x(PeakInd));

if isnan(PeakPosition)
    PeakPosition = median(x);
end

% [AX,H1,H2]=plotyy(x,dydx,x,y);
% set(H1,'LineWidth',2);
% set(H2,'LineWidth',2);
% hold on;
% plot(AX(1),[MinPosition,MinPosition],get(AX(1),'ylim'),'LineStyle','--','LineWidth',1,'Color','k');
% plot(AX(1),get(AX(1),'xlim'),[0,0],'LineStyle','--','LineWidth',1,'Color','k')
% hold off;

test = 1;