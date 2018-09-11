function TPDPlotter

close all;
clear all;
clc;

% oldfolder = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/100516');

%% Gather mass data, get initial time reference, get relative exp times
MassFile = fopen('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/101116/Test10_101116.csv');
MassText = textscan(MassFile,'%s',25,'Delimiter','\n');
MassData = textscan(MassFile,'%s%d%f%f%f%f','Delimiter',',');
fclose(MassFile);

RefTimeString = textscan(MassText{1}{3},'%s%s%s%s','Delimiter',',');
RefTimeString = horzcat(RefTimeString{2}{1},' ',RefTimeString{4}{1});
RefTimeString = datestr(RefTimeString,'dd/mm/yyyy HH:MM:SS PM');

MassRefTime = textscan(MassText{1}{3},'%s%s%s%s','Delimiter',',');
MassRefTime = horzcat(MassRefTime{2}{1},' ',MassRefTime{4}{1});
MassRefTime = datevec(MassRefTime);
MassRefTime(2:3) = [MassRefTime(3),MassRefTime(2)];
MassRefTime = datenum(MassRefTime);

MassExpTimes = cellfun(@(x) datenum(x), MassData{1},'UniformOutput',false);
MassExpTimes = cell2mat(MassExpTimes);
FirstMassExpTime = datevec(MassExpTimes(1));
FirstMassExpTime(1:3) = 0;
FirstMassExpTime = datenum(FirstMassExpTime);
MassExpTimes = 1440*(MassExpTimes - MassExpTimes(1)+FirstMassExpTime);

%% Gather heat data, get initial time reference, get relative exp times
HeatFile = fopen('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/101116/Heat_Control_V_16_10_022016_10_11_17_44_52.txt');
HeatData = textscan(HeatFile,'%f%f%f%c%f%f%f%s','delimiter',',');
fclose(HeatFile);

HeatRefTime = datenum(HeatData{8}{1});

clear HeatText;
HeatExpTimes = cellfun(@(x) datenum(x), HeatData{8},'UniformOutput',false);
HeatExpTimes = cell2mat(HeatExpTimes);
HeatExpTimes = 1440*(HeatExpTimes - HeatExpTimes(1));

%% Compare time references, correct data times
CompareTimes = 1440*(HeatRefTime - MassRefTime);
if any(CompareTimes<0)
    %if HeatRefTime - MassRefTime is negative, Heat initiailized first. Add
    %the diference to all the mass exp times    
    MassExpTimes = MassExpTimes - CompareTimes;    
else
    %if HeatRefTime - MassRefTime is positive, Mass initiailized first. Add
    %the diference to all the heat exp times    
    HeatExpTimes = HeatExpTimes + CompareTimes;   
end


%% Make a yy plot

PlotHandle = plot(HeatExpTimes,HeatData{1},'Color','k','LineWidth',3);
HeatAxes = gca;
MassAxes = axes('Position',get(HeatAxes,'Position'));
plot(MassExpTimes,MassData{3},...
    MassExpTimes,MassData{4},...
    MassExpTimes,MassData{5},...
    MassExpTimes,MassData{6},...
    'LineWidth',2);

set(MassAxes,...
    'YAxisLocation','right',...
    'Color','none');
set(MassAxes, 'XLim', [min(min(get(HeatAxes,'XLim')),min(get(MassAxes,'XLim'))) max(max(get(HeatAxes,'XLim')),max(get(MassAxes,'XLim')))]);
set(HeatAxes, 'XLim', [min(min(get(HeatAxes,'XLim')),min(get(MassAxes,'XLim'))) max(max(get(HeatAxes,'XLim')),max(get(MassAxes,'XLim')))]);
set(HeatAxes, 'TickLength', [0;0]);

MassLegendStrings = textscan(MassText{1}{25},'%*s%*s%q%q%q%q','Delimiter',',');
legend(MassAxes, MassLegendStrings{1}{1},...
MassLegendStrings{2}{1},...
MassLegendStrings{3}{1},...
MassLegendStrings{4}{1});

xlabel(HeatAxes,'Time (min)','fontsize',12);
xlabel(MassAxes,'Time (min)','fontsize',12);
ylabel(HeatAxes,'Temperature (C)','fontsize',12);
ylabel(MassAxes,'Partial Pressure (torr)','fontsize',12);

test = 1;



% MassTimes = cellfun(@(x) datevec(x),MassData(1),'UniformOutput',false);
% MassTimes = [zeros(size(MassTimes{1},1),3),MassTimes{1}(:,4:6)];
% MassTimes = MassTimes+ones(size(MassTimes,1),1)*datevec(RefTimeString);
% MassTimes = mat2cell(MassTimes,ones(1,size(MassTimes,1)),6);
% MassTimes = cellfun(@(x) datestr(x, 'mm/dd/yyyy HH:MM:SS PM'), MassTimes, 'UniformOutput', false);
% MassData = [cell2mat(MassData(3)),cell2mat(MassData(4)),cell2mat(MassData(5)),cell2mat(MassData(6))];
% 
% MassSeries = timeseries(MassData, MassTimes);
% 
% % plot(MassSeries);
% 
% 
% HeatText = fileread('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/100516/Heat_Control_V_16_10_022016_10_05_14_02_27.txt');
% HeatData = textscan(HeatText,'%f%f%f%c%f%f%f%s','delimiter',',');
% clear HeatText;
% HeatTimes = cellfun(@(x) datestr(x, 'mm/dd/yyyy HH:MM:SS PM'), HeatData{8}, 'UniformOutput', false);
% HeatData = cell2mat(HeatData(1));
% HeatSeries = timeseries(HeatData,HeatTimes);
% 
% % hold on;
% % plot(HeatSeries);
% 
% hl1 = plot(MassSeries);
% ax1 = gca;
% 
% ax2 = axes('Position',get(ax1,'Position'));
% 
% plot(HeatSeries);
% 
% set(ax2,'XAxisLocation','top',...
%     'YAxisLocation','right',...
%     'Color','none');
% 
% test = 1;