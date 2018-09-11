function ScanReader

close all;
clear all;
clc;

%Find File to open
PathName = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/092716/';
oldfolder = cd(PathName);
% FileName = dir;
FileName = '_Ting TiSi S24_X=0.000_Y=0.001_01aa001.X01';

%Open File, get contents into cell
NewFile = fopen(horzcat(PathName,FileName));
C = textscan(NewFile, '%s', 'Delimiter', '\n');
fclose(NewFile);
if strcmp(C{1}{59}(1:8), 'Position')
    LoopScan = 0;
    C = importdata(horzcat(PathName,FileName),' ',59);
else
    LoopScan = 1;
    C = importdata(horzcat(PathName,FileName),' ',61);
end

Text = cell(size(C.textdata,1),1);
for i = 1:length(Text)-1
   Text(i) = textscan(C.textdata{i,1},'%s','Delimiter',' ','MultipleDelimsAsOne', 1);
end
Text{end} = {'Position';'Count'};

Plot = plot(C.data(:,1),log10(C.data(:,2)),...
    'LineWidth', 2,...
    'Color', 'k');
set(gca,...
    'XLim', [0 9000]);
xlabel(horzcat(Text{10}{3},' (',Text{11}{4},')'));
ylabel('Log Intensity')
    

test = 1;