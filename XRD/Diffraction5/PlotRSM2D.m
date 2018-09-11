function PlotRSM2D

close all;
clear all;
clc;

[AllHeaders, AllData] = ImportFiles;

TRI = delaunay(AllData(:,9),AllData(:,8));
trisurf(TRI,AllData(:,9),AllData(:,8),log10(AllData(:,10)),'EdgeAlpha',0);

test = 1;