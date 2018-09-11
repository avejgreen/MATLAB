function X01stoPoleFig

close all;
close hidden;
clear all;
clc;

Path = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/112415/Scan12';
FileStruct = dir(Path);

Names = {FileStruct.name};
CorrectNames = cellfun(@(x) length(x)>=17,Names);
FileStruct = FileStruct(CorrectNames);

Names = {FileStruct.name};
FileStruct = FileStruct(cellfun(@(x) strcmp(x(1:17),'XRR Test_XRR_01aa'),Names));

% Names = {FileStruct.name};
% Numbers = cellfun(@(x) textscan(x,'%*17c%f%*s'),Names);
% [SortedNumbers,IX] = sort(Numbers);
% FileStruct = sort(FileStruct,IX);

ChiData = cell(1,length(FileStruct));
IntData = ChiData;
PhiData = ChiData;

% FirstData = importdata(horzcat(Path,'/',FileStruct(1).name),' ',61);
% ChiData{1} = FirstData.data(:,1);
% IntData{1} = FirstData.data(:,2);
% 
% FirstPhi = textscan(FirstData.textdata{17,1},'%s%f%s');
% FirstPhi = FirstPhi{2};
% FirstPhi = round(FirstPhi*20)/20;


AllData = [0,0,0];
h = waitbar(1/length(FileStruct),horzcat('File: 1 of ',int2str(length(FileStruct))));

for i = 1:length(FileStruct)
    
    if i/100==round(i/100)
        waitbar(i/length(FileStruct),h,horzcat('File: ',int2str(i),' of ',int2str(length(FileStruct))));
    end
    
    TempData = importdata(horzcat(Path,'/',FileStruct(i).name),' ',61);
    
    PhiTemp = textscan(TempData.textdata{17,1},'%s%f%s');
    PhiData{i} = PhiTemp{2};
    ChiData{i} = TempData.data(:,1);
    IntData{i} = TempData.data(:,2);
    
    
    AllData = [AllData;[PhiTemp{2}*ones(length(TempData.data(:,1)),1),...
        TempData.data(:,1),...
        TempData.data(:,2)]];
    
end

close(h);
AllData(1,:)=[];

% LastPhi = textscan(TempData.textdata{17,1},'%s%f%s');
% LastPhi = LastPhi{2};
% LastPhi = round(LastPhi*20)/20;

PhiRange = linspace(min(cell2mat(PhiData)),max(cell2mat(PhiData)),length(FileStruct));

ChiMin = median(cellfun(@min,ChiData));
ChiMax = median(cellfun(@max,ChiData));
ChiLength = median(cellfun(@length,ChiData));

ChiRange = linspace(ChiMin,ChiMax,ChiLength);

F = TriScatteredInterp(AllData(:,1),AllData(:,2),AllData(:,3));

[MPhi,MChi] = meshgrid(PhiRange,ChiRange);
MInt = F(MPhi,MChi);
MLogInt = MInt;
MLogInt(MLogInt<1)=1;
MLogInt = log10(MLogInt);
imagesc(MPhi(1,:)',MChi(:,1),MLogInt);

test = 1;