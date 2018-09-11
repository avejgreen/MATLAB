%%%%%%%%%%%%%%%%%
% Integrate pressure curves
%%%%%%%%%%%%%%%%%

function Integration

close all;
clear all;
clc;

% AllData = GetData('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/TPD/All_Mass_Spec/');
AllData = load('/Users/averygreen/Documents/MATLAB/Projects/TPD/Data.mat');
AllData = AllData.AllData;

hAxes = axes('ButtonDownFcn', @GetMousePos);

for i = 1:length(AllData)
    
    figure;
    
    try
        plot(hAxes, AllData(i).Data(:,AllData(i).msCol),...
            AllData(i).Data(:,AllData(i).Se80Col));
        hold all;
        plot(hAxes, AllData(i).Data(:,AllData(i).msCol),...
            AllData(i).Data(:,AllData(i).Se78Col));
        hold off;
        
%         plot(AllData(i).Data(:,AllData(i).msCol),...
%             AllData(i).Data(:,AllData(i).Se80Col));
%         hold all;
%         plot(AllData(i).Data(:,AllData(i).msCol),...
%             AllData(i).Data(:,AllData(i).Se78Col));
%         hold off;
    catch
        test = 1;
    end
    
    
    %     [x,y] = ginput(2);
    %
    %     AllData(i).Integral80 = Integrate(AllData(i), x, AllData(i).Se80Col);
    %     AllData(i).Integral78 = Integrate(AllData(i), x, AllData(i).Se78Col);
    %
    %     test = 1;
    
end

close(gcf)

Ints80 = [AllData(:).Integral80];
Ints78 = [AllData(:).Integral78];

h80 = figure;
bar(gca, Ints80);

h78 = figure;
bar(gca, Ints78);


test = 1;

function Integral = Integrate(Data, x, DataCol)

FirstRow = find(Data.Data(:,Data.msCol) >= x(1), 1);
LastRow = find(Data.Data(:,Data.msCol) >= x(2), 1);

X_0 = Data.Data(FirstRow-1:LastRow, Data.msCol);
X_1 = Data.Data(FirstRow:LastRow+1, Data.msCol);
Xdiff = X_1 - X_0;

Y_0 = Data.Data(FirstRow-1:LastRow, DataCol);
Y_1 = Data.Data(FirstRow:LastRow+1, DataCol);
Yavg = (Y_1+Y_0)/2;

Integral = sum(Xdiff.*Yavg);
