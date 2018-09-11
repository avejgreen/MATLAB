function PinchedSphere

close all;
clear all;
clc;

u = -1*pi:pi/50:pi;
v = u;

[U,V] = meshgrid(u,v);

fps = 60;
tottime = 5;

figure
set(gcf,'Color','w');

%% Draw Toruses
for i = 1:120
    
    r = 3;
    R = 5-(1/fps)*i;
    
    x = (R+r*cos(U)).*cos(V);
    y = (R+r*cos(U)).*sin(V);
    z = r*sin(U);
    C = cos(U);
    
    mesh(x,y,z,C,'EdgeAlpha',1,'FaceAlpha',0);
    axis equal;
    F(i) = getframe(gcf);
    
end

%%  Draw Pinch
for i = 121:300
    
    r = 3;
    R = 5-(1/fps)*i;
    ThetaMax = acos(-R/r);
    
    x = (R+r*cos(U)).*cos(V);
    y = (R+r*cos(U)).*sin(V);
    z = r*sin(U);
    C = cos(U);
    
    max = round(length(u)*(.5+ThetaMax/(2*pi)));
    min = round(length(u)*(.5-ThetaMax/(2*pi)));
    
    x = x(:,min:max);
    y = y(:,min:max);
    z = z(:,min:max);
    C = C(:,min:max);
    C(1,1) = -1;
    
    mesh(x,y,z,C,'EdgeAlpha',1,'FaceAlpha',0);
    axis equal;
    F(i) = getframe(gcf);
    
end


%% Draw Sphere

[X,Y,Z] = sphere(100);
C = ones(size(X));
C(1,1)=0;
mesh(X,Y,Z,C,'EdgeAlpha',1,'FaceAlpha',0);
axis equal;
% figure;
% imagesc(C);

for i = 301:420
    F(i) = getframe(gcf);
end

test = 1;


%% Write Movie
fullpath = mfilename('fullpath');
[pathstr, name, ext] = fileparts(fullpath);

writerObj = VideoWriter(horzcat(pathstr,'/Movie.avi'),'Uncompressed AVI');
open(writerObj);
writeVideo(writerObj,F);
close(writerObj)

test = 1;
