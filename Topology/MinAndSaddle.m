close all;
clear all;
clc;

xlim = 1;
xn = 21;
xrange = linspace(-xlim,xlim,xn);

[X,Y] = meshgrid(xrange,xrange);

Zmin = X.^2+Y.^2;

Zsaddle = X.^2-Y.^2;

LW = 3;
MHS = .4;

filename = mfilename('fullpath');
[pathstr, name, ext] = fileparts(filename);

figure;
surf(X,Y,Zmin,'EdgeAlpha',.5,'FaceAlpha',.5);

hold on;
quiver3(0,0,0,1,0,0,'LineWidth',LW,'Color','r',...
    'MaxHeadSize',MHS,'AutoScaleFactor',.8)
quiver3(0,0,0,0,1,0,'LineWidth',LW,'Color','b',...
    'MaxHeadSize',MHS,'AutoScaleFactor',.8)
quiver3(0,0,0,0,0,1,'LineWidth',LW,'Color','r',...
    'MaxHeadSize',MHS,'AutoScaleFactor',1)
quiver3(0,0,0,0,0,1,'LineWidth',LW,'Color','b','LineStyle','--',...
    'MaxHeadSize',MHS,'AutoScaleFactor',.8)
view(165,30);

set(gca,'FontSize',12)
set(gcf,'Units','inches')
set(gcf,'Position',[1,1,3.3,2.8])

print(gcf,'-djpeg','-r300',horzcat(pathstr,'/Min.jpg'))

hold off;
figure;
surf(X,Y,Zsaddle,'EdgeAlpha',.5,'FaceAlpha',.5);

hold on;
quiver3(0,0,0,1,0,0,'LineWidth',LW,'Color','r',...
    'MaxHeadSize',MHS,'AutoScaleFactor',.8)
quiver3(0,0,0,0,1,0,'LineWidth',LW,'Color','b',...
    'MaxHeadSize',MHS,'AutoScaleFactor',.8)
quiver3(0,0,0,0,0,1,'LineWidth',LW,'Color','r','LineStyle','--',...
    'MaxHeadSize',MHS,'AutoScaleFactor',.8)
quiver3(0,0,0,0,0,-1,'LineWidth',LW,'Color','b','LineStyle','--',...
    'MaxHeadSize',MHS,'AutoScaleFactor',.8)
view(165,30);

set(gca,'FontSize',12);
set(gcf,'Units','inches')
set(gcf,'Position',[1,1,3.3,2.8])

print(gcf,'-djpeg','-r300',horzcat(pathstr,'/Saddle.jpg'))

test = 1;