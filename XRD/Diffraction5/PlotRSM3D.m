function PlotRSM3D

close all;
clear all;
clc;

[AllHeaders, AllData] = ImportFiles;

if length(AllHeaders) == 1
    error('You must load a looping RSM to plot');
end

[ScanAxis,LoopAxis] = ParseAxes(AllHeaders{1});

TRI = delaunay(AllData(:,ScanAxis),AllData(:,LoopAxis));

gVectors = AnglesToGVectors(AllData);

trisurf(TRI,gVectors(:,1),gVectors(:,2),gVectors(:,3),log10(AllData(:,end)),'EdgeAlpha',0);

test = 1;

end

