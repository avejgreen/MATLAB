function RSMPlotter

close all;
clear all;
clc;


%% GET FILE NAMES
oldfolder = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/112216/112216');
list = dir;
list = {list(:).name};
list(1:5) = [];

listnum = cellfun(@(x) x(15:18),list,'UniformOutput',0);
listnumper = cell2mat(cellfun(@(x) strcmp(x(4),'.'),listnum,'UniformOutput',0));
listnum(listnumper) = cellfun(@(x) x(1:3),listnum(listnumper),'UniformOutput',0);
listnum = cellfun(@(x) horzcat('uint16(',x,')'),listnum,'UniformOutput',0);
listnum = cell2mat(cellfun(@(x) str2num(x),listnum,'UniformOutput',0));
[waste,IX] = sort(listnum);
list = list(IX);

test = 1;

%% ENTER LOOP SIZES
ScanPts = 181; %ScanAxis is Phi, range is -30 to 150
Loop1Pts = 91; %Loop1Axis is Chi, range is -90 to 0
Loop2Pts = 101; %Loop2Axis is omega-2theta, range is 0 to 50

figure;

%% IMPORT DATA, PLOT, AND LOOP
for i = 1:Loop2Pts
    
    AllData = zeros(1,3);
    for j = 1:Loop1Pts
        
        NewFile = importdata(list{j+(i-1)*Loop1Pts},' ',61);
        X = NewFile.data(:,1);
        Y = textscan(NewFile.textdata{16},'%*s%f%*s');
        Y = Y{1}*ones(length(X),1);
        Z = NewFile.data(:,2);
        Z(Z<1) = 1;
        Z = log10(Z);
        NewData = [X,Y,Z];
        AllData = [AllData;NewData];
            
    end
    AllData(1,:) = [];
    
    TRI = delaunay(AllData(:,1),AllData(:,2));
    trisurf(TRI,AllData(:,1),AllData(:,2),AllData(:,3),'EdgeAlpha',0);
    view(2);
    xlim([-30 150]);
    ylim([-90 0]);
    header = NewFile.textdata{22};
    header = textscan(header,'%*s%s%*s');
    header = horzcat('Unscaled: 2Theta = ',header{1}{1});
    title(header);
    colorbar;
     
    print(gcf,horzcat('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/112216/112216/Images_Unscaled/Plot',int2str(uint16(i))),'-djpeg');


    zlim([0 4]);
    caxis([0 4]);
    header = NewFile.textdata{22};
    header = textscan(header,'%*s%s%*s');
    header = horzcat('Scaled: 2Theta = ',header{1}{1});
    title(header);
       
    print(gcf,horzcat('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/112216/112216/Images_Scaled/Plot',int2str(uint16(i))),'-djpeg');
    clf;
    
    test = 1;
    
end

close;
test = 1;

cd(oldfolder);