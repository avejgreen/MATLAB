% Imports file to matrix that includes all motor positions at all points,
% All headers as cell
% 
% Rows are data points
%
% Columns:
% Chi Phi X Y Z Omega 2Theta Omega-2Theta Omega_Rel Intensity
%
% If RSM, depth is file number

function [AllHeaders, AllData] = ImportFiles

% close all;
% clear all;
% clc;

%% Import data, check if multiple files are loaded

oldfolder = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/101816');
[FileName,PathName,FilterIndex] = uigetfile('*.X01','Select X01 File(s)','MultiSelect','on') ;
cd(oldfolder);

% load('TestRSMFiles.mat');
% load('TestRSMPath.mat');

if iscell(FileName)
    MultiCheck = 1;
else
    MultiCheck = 0;
end

%% If multiple files loaded, check that they're in a loop. If not, return error.

if MultiCheck == 1   
    
    FileID = fopen(strcat(PathName,FileName{1}));
    TestText = textscan(FileID, '%s', 10, 'Delimiter', '\n');
    fclose(FileID); clear FileID;
    TestText = textscan(TestText{1}{9}, '%s');    
    if strcmp(TestText{1}{1}, 'Time:')
        %Recipe exists in single scans. Return Error.
        error('Multiple scans must exist as a loop.')
        
    elseif strcmp(TestText{1}{1}, 'Loop')      
        %Recipe exists as a loop.
        %LOOP IMPORT SINGLE SCAN FUNCTION, BUILD 3D MATRIX OF DATA, 1D CELL
        %OF ALL HEADERS, OPTICS POSITIONS      
        AllHeaders = cell(1,length(FileName));
        AllData = zeros(1,10);
        for i = 1:length(FileName)
            Data = ImportSingleScan(PathName, FileName{i});
            AllHeaders{i} = Data.HeaderText;
            AllData = [AllData;Data.ScanData];
            test = 1;
        end
        AllData(1,:)=[];
        test = 1;
        
    else
        error('Could not read test scan.')
    end
    
else
    
    %Load data.
    Data = ImportSingleScan(PathName, FileName);
    AllHeaders = cell(1);
    AllHeaders{1} = Data.HeaderText;
    AllData = Data.ScanData;
    
end

test = 1;

end







