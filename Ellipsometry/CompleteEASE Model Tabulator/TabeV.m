% Convert .MAT file into tabulated form.

clear all;
clc;
close all;

% First, get the file name and path

cd('/Users/averygreen/CompleteEASE/MAT')

[FileName,PathName] = uigetfile('*.*', 'Select the CompleteEASE material file');

FullFileName = strcat(PathName, FileName);

MATFileText = fileread(FullFileName);

cd('/Users/averygreen/Documents/MATLAB/CompleteEASE Model Tabulator')

NewFile = fopen('TempMatFile.txt', 'w');

fprintf(NewFile, MATFileText);

fclose(NewFile);

clear MATFileText

Data = importdata('TempMatFile.txt', '\t', 3);

A = zeros(175,6);

for i = 1:175
    
    A(i,1) = .7 + .025*i;

end

if strcmp(Data.textdata(2), 'GENOSC')
    
    C = textscan(Data.textdata{3},'%f %f %f %f %f %f');
    
    NoOsc = C{1};
    Einf = C{2};
    DONTKNOW = C{3};
    UVPA = C{4};
    UVPE = C{5};
    IRPA = C{6};
    
    a = 1;
    
elseif strcmp(Data.textdata(2), 'OSC')
    
    a = 1;
    
elseif strcmp(Data.textdata(2), 'CAUCHY')
    
    a = 1;
    
elseif strcmp(Data.textdata(2), 'eV')
    
    a = 1;
    
    if strcmp(Data.textdata(3), 'NK')
        
        a = 1;
        
    elseif strcmp(Data.textdata(3), 'e1e2')
        
        a = 1;
        
    end
    
elseif strcmp(Data.textdata(2), 'nm')
    
    a = 1;
    
    if strcmp(Data.textdata(3), 'NK')
        
        a = 1;
        
    elseif strcmp(Data.textdata(3), 'e1e2')
        
        a = 1;
        
    end
    
end

% First, detect model type: Pretabulated, Cauchy, Genosc, B-Spline, etc.

a = 1;