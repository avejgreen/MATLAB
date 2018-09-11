function AESAverager

close all;
clear all;
clc;

global FileName
global PathName

% olddir = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/062216');
% [FileName, PathName] = uigetfile('*.csv','MultiSelect','on');
% cd(olddir);

FileName = {'110_Bi3_1.csv','110_Bi3_2.csv','110_Bi3_3.csv','110_Bi3_4.csv','110_C1_1.csv','110_C1_2.csv','110_C1_3.csv','110_C1_4.csv'};
PathName = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/062216/';

TestMap = importdata(strcat(PathName, FileName{1}),',',9);
MapDims = [size(TestMap.data,1), size(TestMap.data,2)];

MapData = cell(1,length(FileName));
NumFiles = length(MapData);
Plots = cell(NumFiles,5);
AverageMap = zeros(MapDims(1),MapDims(2));
for i = 1:NumFiles
    
    NewMap = importdata(strcat(PathName, FileName{i}),',',9);
    
    Plots{i,1} = strcat('h',int2str(i));    
    if i == 1       
        Plots{i,2} = NewMap.textdata{3};
        Plots{i,3} = 1;
        Plots{i,4} = 1;       
    elseif any(strcmp(NewMap.textdata{3},Plots(:,2)))
        %Put at the end of the previous plot col
        Plots{i,3} = max(cell2mat(Plots(strcmp(NewMap.textdata{3},Plots(:,2)),3)))+1;
        Plots{i,4} = max(cell2mat(Plots(strcmp(NewMap.textdata{3},Plots(:,2)),4)));
    else
        %Start a new plot column
        Plots{i,3} = 1;
        Plots{i,4} = max(cell2mat(Plots(:,4)))+1; 
    end
    Plots{i,2} = NewMap.textdata{3};
    
    MapData{i} = NewMap.data;
    AverageMap = AverageMap+MapData{i};    
    Plots{i,5} = MapTailCutter(MapData{i},2);
%     subplot(NumFiles+1,1,i);
%     imagesc(CutMap); colormap gray; colorbar; title(FileName{i},'Interpreter', 'none');
    
end

AllPlots = cell(size(Plots,1)+max(cell2mat(Plots(:,4))),5);
AllPlots(1:size(Plots,1),:) = Plots;
for i = 1:max(cell2mat(Plots(:,4)))
    AllPlots{NumFiles+i,1} = strcat('h',int2str(NumFiles+i));
    AllPlots{NumFiles+i,2} = Plots(cell2mat(Plots(:,4))==i && cell2mat(Plots(:,3))==1,2);
end

AverageMap = AverageMap/NumFiles;
CutMap = MapTailCutter(AverageMap,2);
% subplot(NumFiles+1,1,NumFiles+1);
% imagesc(CutMap); colormap gray; colorbar; title(strcat('Mean ',NewMap.textdata{3}), 'Interpreter', 'none');

test = 1;

end

function NewMap = MapTailCutter(OldMap,TailPct)

MapPtList = zeros(size(OldMap,1)*size(OldMap,2),4);
for i = 1:size(OldMap,2)
    
    MapPtList((i-1)*size(OldMap,1)+1:i*size(OldMap,1),1) = OldMap(:,i);
    MapPtList((i-1)*size(OldMap,1)+1:i*size(OldMap,1),2) = linspace(1,size(OldMap,1),size(OldMap,1))';
    MapPtList((i-1)*size(OldMap,1)+1:i*size(OldMap,1),3) = i*ones(size(OldMap,1),1);
    MapPtList((i-1)*size(OldMap,1)+1:i*size(OldMap,1),4) = (i-1)*size(OldMap,1)+linspace(1,size(OldMap,1),size(OldMap,1));
    
end

MapPtList = sortrows(MapPtList,[1 4]);
NewMapMin = MapPtList(uint16((.01*TailPct)*size(MapPtList,1)),1);
NewMapMax = MapPtList(uint16((1-.01*TailPct)*size(MapPtList,1)),1);
MapPtList(MapPtList(:,1)<=NewMapMin,1)=NewMapMin;
MapPtList(MapPtList(:,1)>=NewMapMax,1)=NewMapMax;

MapPtList = sortrows(MapPtList,4);

NewMap = zeros(size(OldMap,1), size(OldMap,2));
for i = 1:size(NewMap,2)
    
    NewMap(:,i) = MapPtList((i-1)*size(OldMap,1)+1:(i)*size(OldMap,1),1);
    
end

end