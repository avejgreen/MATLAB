%% Reads and plots *.msa EELS data

function EELSPlotter

%% Import file, separate to text and data

close all;
clear all;
clc;

%Find File to open
PathName = '/Users/averygreen/Documents/MATLAB/Projects/EELS/';
oldfolder = cd(PathName);
% FileName = dir;
FileName = uigetfile;
% FileName = 'Bi(0-0180eV).msa';
% FileName = 'Se(0-0450eV).msa';

C = importdata(horzcat(PathName,FileName), ',', 14);

Text = cell(length(C.textdata),1);
for i = 1:length(Text)
   Text(i) = textscan(C.textdata{i,1},'%s','Delimiter',' ','MultipleDelimsAsOne', 1);
end


%% Plot, take derivatives, plot again

makelogplot(Text, C.data, 0);
makelinplot(Text, C.data, 0);

DerivOrder = 2;
DerivData = deriv(C.data, 7, DerivOrder);

for i = 1:DerivOrder
    makelinplot(Text, DerivData{i}, i);
end

test = 1;
