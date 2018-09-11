function AllData = DataFilestoScanData

close all;
clear all;
clc;

olddir = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/070816_SB1/PoleFig2');
[FileName, PathName] = uigetfile('*.X01','MultiSelect','on');
cd(olddir);

%NOTE: CHECK FOR MULTIPLE FILES. IF THERE ARE, THEY MUST BE IN A LOOP. IF
%NOT, RETURN ERROR. IF IT'S ONE FILE, CHECK IF IT'S PART OF A LOOP. THEN
%PROCEED TO GRAB SCAN DATA.

%Check out scans. See what axis and unit are used. Select for angle
%analysis protocol
if iscell(FileName)
    MultiCheck = 1;
else
    MultiCheck = 0;
    FileNameTemp = cell(1,1);
    FileNameTemp{1} = FileName;
    FileName = FileNameTemp;
    clear FileNameTemp;
end

FileID = fopen(strcat(PathName,FileName{1}));
TestText = textscan(FileID, '%s', 10, 'Delimiter', '\n');
fclose(FileID);
TestText = textscan(TestText{1}{9}, '%s');
if strcmp(TestText{1}{1}, 'Time:')
    %Recipe exists in single scans. Don't add any extra header lines
    LoopCheck = 0;
    ExtraHeaders = 0;
elseif strcmp(TestText{1}{1}, 'Loop')
    %Recipe exists as a loop. Add 2 extra header lines
    LoopCheck = 1;
    ExtraHeaders = 2;
end


%%% FOUND OUT WHAT DATA IS LOADED LOAD UP A FILE IF APPROPRIATE
if [MultiCheck, LoopCheck] == [0,0]
    
    OnlyFile = importdata(strcat(PathName,FileName{1}), ' ', 61);
    [ScanAxis,ScanUnit] = GetScanAxisInfo(OnlyFile);
%     AllData = 
    
elseif [MultiCheck, LoopCheck] == [0,1]
    
    OnlyFile = importdata(strcat(PathName,FileName{1}), ' ', 61);
    [LoopAxis,LoopUnit,LoopLine] = GetLoopAxisInfo(OnlyFile);
    AllData = ImportLoopScanFile(PathName,FileName,LoopAxis,LoopUnit,LoopLine);
    
elseif [MultiCheck, LoopCheck] == [1,0]
    
    disp('ERROR: IF MULTIPLE FILES ARE LOADED, THEY MUST BE IN A LOOP');
  
elseif [MultiCheck, LoopCheck] == [1,1]
    
    FirstFile = importdata(strcat(PathName,FileName{1}), ' ', 61);
    [LoopAxis,LoopUnit,LoopLine] = GetLoopAxisInfo(FirstFile);
    for i = length(FileName)
        Data = ImportLoopScanFile(PathName,FileName,LoopAxis,LoopUnit,LoopLine);
        AllData = [AllData;Data];
    end
    
end

test = 1;

end

function [LoopAxis, LoopUnit, LoopLine] = GetLoopAxisInfo(NewFile)

LoopAxis = textscan(NewFile.textdata{10}, '%*s %*s %s %*s %*s %*s');
LoopAxis = LoopAxis{1}{1};

switch LoopAxis
    
    case 'Omega-2Theta'
        LoopUnit = 'sec';
        LoopLine = 37;
    case 'Omega_Rel'
        LoopUnit = 'sec';
        LoopLine = 47;
    case '2Theta'
        LoopUnit = 'deg';
        LoopLine = 22;
    case 'Omega'
        LoopUnit = 'deg';
        LoopLine = 21;
    case 'Chi'
        LoopUnit = 'deg';
        LoopLine = 16;
    case 'Phi'
        LoopUnit = 'deg';
        LoopLine = 17;
end

end

function [ScanAxis,ScanUnit] = GetScanAxisInfo(OnlyFile);

ScanAxis = textscan(NewFile.textdata{10+ExtraHeaders}, '%*s %*s %s %*s %*s %*s');
ScanAxis = ScanAxis{1}{1};
ScanUnit = textscan(NewFile.textdata{11+ExtraHeaders}, '%*s %*s %*f %s');
ScanUnit = ScanUnit{1}{1};

test = 1;

end

