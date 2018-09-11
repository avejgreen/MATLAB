function HistFilter

close all;
close all hidden;
clear all;
clc;

%{
    Need to filter fit histogram data.
    Check Error as a function of various fit parameters.
    Need to come up with a metric for s-shape.
        Could just be fit values at +/- .3 or .5, as well as Ef and m.
        Want:   m = 0, or abs(m) < .5e-10
                abs(Ef) < 0.2
                I(+/-.5) > .5e-9
                I(+/-.3) > .1e-9 ?

    Actual Steps:
    1. Import data. Try importing all histdata from Rd3_6
    2. Plot Error as a function of: B+, x0+, B-, x0-, m, y0, Ef
    3. Try Error(Shapeliness)
        - Already covered m comparison
        - Already covered Ef comparison
        - Could do up to 5d plot. x,y,z,color,size.
            . Want low m, decent Ef, Iend, Error. So 4 axes
            . Least important is m. Other 3 get physical axes.
%}

% Path = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM Matlab Analysis_ILimited/Rd3_6';
% PathFiles = dir(Path);
% DirFileNames = {PathFiles(:).name};
% DirFileNames(ismember(DirFileNames(1:2),{'.','..'})) = [];
% HistDataFileCheck = cellfun(@(x) strcmp('HistData.csv',x(end-11:end)),DirFileNames);
% HistDataFileNames = DirFileNames(HistDataFileCheck);
% 
% clear DirFileNames HistDataFileCheck PathFiles;

% Select files for import
[SelectedFiles,Path,FilterIndex] = uigetfile(...
    '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM Matlab Analysis_ILimited/Rd3_6/*.csv',...
    'MultiSelect','on');
HistDataFileCheck = cellfun(@(x) strcmp('HistData.csv',x(end-11:end)),SelectedFiles);
HistDataFileNames = SelectedFiles(HistDataFileCheck);

clear SelectedFiles HistDataFileCheck

nFiles = length(HistDataFileNames);
% hbar = waitbar(0,horzcat('Loading Files: 0 of ',int2str(nFiles)));


%{ 

% TEST FOR SPEED.
%
% 1.LENGTHEN ONE LARGE MATRIX DYNAMICALLY
tic;
MatData = NaN(1,8);
for i = 1:nFiles
    NewData = importdata(horzcat(Path,'/',HistDataFileNames{i}));
    MatData = [MatData;NewData.data];
end
MatData(1,:) = [];
MatTime = toc;

% 2. CREATE CELL ARRAY, PUT ONE FILE IN EACH CELL, FLATTEN
tic;
CellData = cell(1,nFiles);
for i = 1:nFiles
    NewData = importdata(horzcat(Path,'/',HistDataFileNames{i}));
    CellData{i} = NewData.data;
end
CellData = vertcat(CellData{:});
CellTime = toc;

% 3. CREATE STRUCTURE ARRAY, PUT ONE FILE IN EACH, FLATTEN
tic;
StructData = struct('Data',cell(1,nFiles));
for i = 1:nFiles
    NewData = importdata(horzcat(Path,'/',HistDataFileNames{i}));
    StructData(i).Data = NewData.data;
end
StructData = vertcat(StructData(:).Data);
StructTime = toc;

%4. CSVRead
tic;
CSVData = NaN(1,8);
for i = 1:nFiles
    NewData = csvread(horzcat(Path,'/',HistDataFileNames{i}), 6, 0);
    CSVData = [CSVData;NewData];
end
CSVData(1,:) = [];
CSVTime = toc;

%5. CSVStruct
tic;
CSVStruct = struct('Data',cell(1,nFiles));
for i = 1:nFiles
    CSVStruct(i).Data = csvread(horzcat(Path,'/',HistDataFileNames{i}), 6, 0);
end
CSVStruct = vertcat(CSVStruct(:).Data);
CSVStructTime = toc;

%}

% Import Files
% 6. CSVCell
% tic;
CSVCell = cell(1,nFiles);
for i = 1:nFiles
    CSVCell{i} = csvread(horzcat(Path,'/',HistDataFileNames{i}), 6, 0);
end
CSVCell = vertcat(CSVCell{:});
% CSVCellTime = toc;

figure;
hist(CSVCell(:,8)); %Hist Ef before filter
figure;
hist(CSVCell(:,7)); %Hist Error before filter

CSVCell(:,9) = exp(CSVCell(:,1).*(-.5-CSVCell(:,2)))...
    -exp(CSVCell(:,3).*(-.5-CSVCell(:,4)))...
    +CSVCell(:,5)*-.5+CSVCell(:,6);
CSVCell(:,10) = exp(CSVCell(:,1).*(.5-CSVCell(:,2)))...
    -exp(CSVCell(:,3).*(.5-CSVCell(:,4)))...
    +CSVCell(:,5)*.5+CSVCell(:,6);

% Diagnostic plots
figure;
scatter(CSVCell(:,1),CSVCell(:,7));
title('B+');
figure;
scatter(CSVCell(:,2),CSVCell(:,7));
title('x0+');
figure;
scatter(CSVCell(:,3),CSVCell(:,7));
title('B-');
figure;
scatter(CSVCell(:,4),CSVCell(:,7));
title('x0-');
figure;
scatter(CSVCell(:,5),CSVCell(:,7));
title('m');
figure;
scatter(CSVCell(:,6),CSVCell(:,7));
title('y0');
figure;
scatter(CSVCell(:,8),CSVCell(:,7));
title('Ef');
figure;
scatter(CSVCell(:,9),CSVCell(:,7));
title('I(-0.5)');
figure;
scatter(CSVCell(:,10),CSVCell(:,7));
title('I(0.5)');



%Filters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CSVCell = CSVCell(and(CSVCell(:,10)>0.05e-9,CSVCell(:,10)<10e-9),:);    % I(0.5)
CSVCell = CSVCell(and(CSVCell(:,9)>-10e-9,CSVCell(:,9)<-.05e-9),:);     % I(-0.5)
CSVCell = CSVCell(abs(CSVCell(:,8))<.5,:);                              % Ef
CSVCell = CSVCell(and(CSVCell(:,7)>-9.7,CSVCell(:,7)<-7.25),:);         % Error
CSVCell = CSVCell(abs(CSVCell(:,6))<7e-8,:);                            % y0
CSVCell = CSVCell(and(CSVCell(:,5)>-5e-8,CSVCell(:,5)<5e-8),:);         % m
CSVCell = CSVCell(and(CSVCell(:,4)>-20,CSVCell(:,4)<0),:);              % x0-
CSVCell = CSVCell(and(CSVCell(:,3)>-200,CSVCell(:,3)<0),:);             % B-
CSVCell = CSVCell(and(CSVCell(:,2)>0,CSVCell(:,2)<20),:);               % x0+
CSVCell = CSVCell(and(CSVCell(:,1)>0,CSVCell(:,1)<200),:);              % B+
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
hist(CSVCell(:,8)); % Hist Ef after filter
figure;
hist(CSVCell(:,7)); % Hist Error after filter


% . Want low m, decent Ef, Iend, Error. So 4 axes
% . Least important is m. Other 3 get physical axes.
figure;
scatter3(CSVCell(:,9),CSVCell(:,8),CSVCell(:,7),1,CSVCell(:,5));
xlabel('I(-0.5)')
ylabel('Ef')
zlabel('Error')
colorbar;

test = 1;