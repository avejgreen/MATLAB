function RSMPlotter3D

close all;
clear all;
clc;


%% GET FILE NAMES
folder = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/XRD/011917_SB1/RSM_01-15';
oldfolder = cd(folder);
list = dir;
list = {list(:).name};
[pathstr, name, ext] = cellfun(@fileparts,list,'UniformOutput',false);
list=list(strcmp('.X01',ext));

% listnum = cellfun(@(x) x(15:18),list,'UniformOutput',0);
% listnumper = cell2mat(cellfun(@(x) strcmp(x(4),'.'),listnum,'UniformOutput',0));
% listnum(listnumper) = cellfun(@(x) x(1:3),listnum(listnumper),'UniformOutput',0);
% listnum = cellfun(@(x) horzcat('uint16(',x,')'),listnum,'UniformOutput',0);
% listnum = cell2mat(cellfun(@(x) str2num(x),listnum,'UniformOutput',0));
% [waste,IX] = sort(listnum);
% list = list(IX);

test = 1;

%% ENTER LOOP SIZES
% ScanPts = 181; 
Loop1Pts = length(list);
FileDims = zeros(1,Loop1Pts);
FileStartEnd = zeros(2,Loop1Pts);
% Loop2Pts = 101; 

plotfig = figure;

%% IMPORT DATA, PLOT, AND LOOP
AllData = zeros(1,5);           % Chi, Phi, Omega, 2Theta, Int
waitb = waitbar(0,horzcat('Importing file 0 of ',num2str(Loop1Pts)));

% for i = 1:Loop2Pts

for FileNum = 1:Loop1Pts
%     FileNum = j+(i-1)*Loop1Pts;
    
    waitbar(FileNum/(Loop1Pts),waitb,...
        horzcat('Importing file ', int2str(uint16(FileNum)),' ',num2str(Loop1Pts)));
    
    NewFile = importdata(list{FileNum},' ',61);
    
    DataCol = ones(size(NewFile.data,1),1);
    FileDims(FileNum) = length(DataCol);
    
    Chi = textscan(NewFile.textdata{16,1},'%*s%f%*s');
    Chi = DataCol*Chi{1};
    
    Phi = textscan(NewFile.textdata{17,1},'%*s%f%*s');
    Phi = DataCol*Phi{1};
    
    Omega = textscan(NewFile.textdata{21,1},'%*s%f%*s');
    Omega = DataCol*Omega{1};
    
    TwoTheta = textscan(NewFile.textdata{22,1},'%*s%f%*s');
    TwoTheta = DataCol*TwoTheta{1};
    
    Int = NewFile.data(:,2);
    Int(Int<1) = 1;
    Int = log10(Int);
    
    NewData = [Chi,Phi,Omega,TwoTheta,Int];
    NewData(:,2) = NewFile.data(:,1);
    
    FileStartEnd(:,FileNum) = [NewFile.data(1,1);NewFile.data(end,1)];
    
    AllData = [AllData;NewData];
end

AllData(1,:)=[];
close(waitb);

test = 1;

% Triangulate Int to Chi, Phi
F = TriScatteredInterp(AllData(:,1),AllData(:,2),AllData(:,4));


%% Set mesh

xmin = median(FileStartEnd(1,:));
xmax = median(FileStartEnd(2,:));
xn   = median(FileDims);

ymin = min(AllData(:,1));
ymax = max(AllData(:,1));
yn   = length(FileDims);

[X,Y] = meshgrid(linspace(xmin,xmax,xn),linspace(ymin,ymax,yn));
Int = F(reshape(X,numel(X),1),reshape(Y,numel(Y),1));
Int = reshape(Int,size(X));

gMags = ones(size(Int))*2*sin((median(AllData(:,4))/2)*(pi/180))/1.5406;

gX = gMags.*cos((pi/180)*X).*sin((pi/180)*Y);
gY = gMags.*sin((pi/180)*X).*sin((pi/180)*Y);
gZ = gMags.*cos((pi/180)*Y);

surf(gX,gY,gZ,Int,'EdgeAlpha',0);
axis equal;

% end
AllData(1,:) = [];
AllData(AllData(:,3)<0,3) = 0;

S = load('/Users/averygreen/Documents/MATLAB/Projects/XRD/RSMPlotter/RSMPlotter3DData.mat');

PlotData = [zeros(size(S.AllData,1),1),zeros(size(S.AllData,1),1),...
    2*sin(.5*S.AllData(:,3)*pi/180)/1.5406,S.AllData(:,4)];

PlotData(:,1:3) = (PlotData(:,3)*[1,1,1]).*...
    [-cos(S.AllData(:,1)*pi/180).*sin(S.AllData(:,2)*pi/180),...
    -sin(S.AllData(:,1)*pi/180).*sin(S.AllData(:,2)*pi/180),...
    cos(S.AllData(:,2)*pi/180)];

plotfig = scatter3(PlotData(:,1),PlotData(:,2),PlotData(:,3),10*PlotData(:,4),PlotData(:,4),'Filled');
xlim([-1 1]);
ylim([-1 1]);
zlim([0 1]);

% close(plotfig);
test = 1;

% cd(oldfolder);

test = 1;