function MakeMAT

close all;
clear all;
clc;

% FullFileName = uigetfile('*.*');
FullFileName = '/Users/averygreen/CompleteEASE/MAT/Other/a-C Larruquert.txt';
[Path, File, Ext] = fileparts(FullFileName);

Data = importdata(FullFileName);

NewFileName = horzcat(Path,'/',File,'.mat');
NewFile = fopen(NewFileName,'w+');

fprintf(NewFile,'a-C Larruquert, ta-C: tetrahedral amorphous carbon. Density: 3.25 g/cm<sup>3</sup>.\n');
fprintf(NewFile,'nm\n');
fprintf(NewFile,'NK\n');
dlmwrite(NewFileName, Data.data, 'delimiter', '\t', '-append')

fclose(NewFile);

test = 1;