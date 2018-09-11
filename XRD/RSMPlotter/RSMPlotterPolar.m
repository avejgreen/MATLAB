function RSMPlotterPolar

close all;
clear all;
clc;


%% GET FILE NAMES, SORT FILES
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
        Phi = NewFile.data(:,1);
        Chi = textscan(NewFile.textdata{16},'%*s%f%*s');
        Chi = Chi{1}*ones(length(Phi),1);
        Int = NewFile.data(:,2);
        Int(Int<1) = 1;
        Int = log10(Int);
        NewData = [Phi,Chi,Int];
        AllData = [AllData;NewData];
            
    end
    AllData(1,:) = [];
    
    PlotData = ...
        [-cos(AllData(:,1)*pi/180).*AllData(:,2)/90,...
        -sin(AllData(:,1)*pi/180).*AllData(:,2)/90,...
        AllData(:,3)];
    PlotData(:,1:2) = PlotData(:,1:2)*[cos(pi/6),sin(pi/6);-sin(pi/6),cos(pi/6)];
    
    TRI = delaunay(PlotData(:,1),PlotData(:,2));
    trisurf(TRI,PlotData(:,1),PlotData(:,2),PlotData(:,3),'EdgeAlpha',0);
    view(2);
    axis equal;
    xlim([-1 1]);
    ylim([0 1]);
    header = NewFile.textdata{22};
    header = textscan(header,'%*s%s%*s');
    header = horzcat('Unscaled: 2Theta = ',header{1}{1});
    title(header);
    colorbar;
     
    print(gcf,horzcat('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/112216/112216/Images_Unscaled/PlotPolar',int2str(uint16(i))),'-djpeg');


    zlim([0 4]);
    caxis([0 4]);
    header = NewFile.textdata{22};
    header = textscan(header,'%*s%s%*s');
    header = horzcat('Scaled: 2Theta = ',header{1}{1});
    title(header);
       
    print(gcf,horzcat('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/112216/112216/Images_Scaled/PlotPolar',int2str(uint16(i))),'-djpeg');
    clf;
    
    test = 1;
    
end

close;
test = 1;

cd(oldfolder);