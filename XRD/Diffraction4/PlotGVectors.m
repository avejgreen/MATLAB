function PlotGVectors

close all;
clear all;
clc;

GVectors = AnglesToGVectors;

Phi = -53*pi/180;
Rz = [cos(Phi),-sin(Phi),0;...
    sin(Phi),cos(Phi),0;...
    0,0,1];
GVectors(:,1:3) = GVectors(:,1:3)*(Rz');

% Theta = 3*pi/180;
% Rx = [1,0,0;...
%     0,cos(Theta),-sin(Theta);...
%     0,sin(Theta),cos(Theta)];
% GVectors(:,1:3) = GVectors(:,1:3)*(Rx');

x = GVectors(:,1);
y = GVectors(:,2);
z = GVectors(:,3);
c = GVectors(:,4);
c(c<1)=1;
c = log10(c);
c(c>3) = 3;

% RedFact = 10;
% GVectorsReduced = GVectors(linspace(1,length(GVectors)-mod(length(GVectors),RedFact)+1,ceil(length(GVectors)/RedFact)),:);
% x = GVectorsReduced(:,1);
% y = GVectorsReduced(:,2);
% z = GVectorsReduced(:,3);
% c = log10(GVectorsReduced(:,4));
% 
% F = TriScatteredInterp(x,y,z,c);
% qc = F(x,y,z);
% 
% figure;
% TRI = delaunay(x,y,z);
% trisurf(TRI,x,y,z,c,'EdgeAlpha',0);
% % view(90,0);
% % axis([min(GVectors(:,1)) max(GVectors(:,1)) min(GVectors(:,2)) max(GVectors(:,2)) min(GVectors(:,3)) max(GVectors(:,3))]);
% axis equal;
% colorbar;
% 
% figure;
% trimesh(TRI,x,y,z,c);
% % view(90,0);
% % axis([min(GVectors(:,1)) max(GVectors(:,1)) min(GVectors(:,2)) max(GVectors(:,2)) min(GVectors(:,3)) max(GVectors(:,3))]);
% axis equal;
% colorbar;

figure('Color', [1,1,1]);
scatter3(x,y,z,1,c);
% view(90,0);
set(gca,...
    'XLim',[-.3, .3],...
    'YLim',[-.3, .3],...
    'ZLim',[0 .25],...
    'DataAspectRatio',[1 1 1],...
    'LineWidth', 1,...
    'XGrid', 'on',...
    'YGrid', 'on',...
    'ZGrid', 'on',...
    'XTick', linspace(-.3,.3,7),...
    'YTick', linspace(-.3,.3,7),...
    'ZTick', linspace(0,.25,6),...
    'XMinorTick','on',...
    'YMinorTick','on',...
    'ZMinorTick','on',...
    'GridLineStyle','--',...
    'FontName','times',...
    'FontSize',20);
xlabel('q_x (A^{-1})');
ylabel('q_y (A^{-1})');
zlabel('q_z (A^{-1})');
colorbar;
view([300,25]);



test = 1;

end