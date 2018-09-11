function PoleFigToXYZ

close all;
clear all;
clc;

[FileName,PathName,FilterIndex] = uigetfile('*.*','MultiSelect','on');

test = 1;

S = importdata(horzcat(PathName,FileName{1}),' ',61);
for i = 2:length(FileName)
    S(i) = importdata(horzcat(PathName,FileName{i}),' ',61);
end

xyzRows = 0;
for i = 1:length(FileName)
    xyzRows = xyzRows + size(S(i).data,1);
end

xyz = zeros(xyzRows,3);
CurrentRow = 1;
for i = 1:length(FileName)
    ChiStrings = textscan(S(i).textdata{16,1},'%s%s%s','Delimiter',' ','MultipleDelimsAsOne',1);
    Y = ones(size(S(i).data,1),1);
    Y = Y*str2double(ChiStrings{2});
    xyz(CurrentRow:CurrentRow+size(S(i).data,1)-1,:) = [S(i).data(:,1),Y,S(i).data(:,2)];
    CurrentRow = CurrentRow+size(S(i).data,1);
end

xyz(xyz(:,3)==0,3)=1;

csvwrite(horzcat(PathName,'XYZ.csv'),xyz);

test = 1;
    



