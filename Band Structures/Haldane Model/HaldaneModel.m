function HaldaneModel

close all;
clear all;
clc;

%% Initialize Parameters

phi = 0;
M = 0;
t1 = 2;
t2 = 1;


% Phase variables
Mmax = 3*sqrt(3)*t2;
s1 = [linspace(0,pi,51);linspace(0,0,51)];
s2 = [linspace(pi,pi,51);linspace(0,Mmax,51)];
s3 = [linspace(pi,0,51);linspace(Mmax,Mmax,51)];
s4 = [linspace(0,0,51);linspace(Mmax,0,51)];
S1 = [s1,s2,s3,s4];
S = [S1,fliplr(-S1)]';


%% Generate K-space

Kx = -2*pi:.1:2*pi;
Ky = Kx;

[kx,ky] = meshgrid(Kx,Ky);


%% Calculate off-diagonals

dx = 0;
dy = 0;

a1 = [1,0];
a = zeros(2,3);
for n = 1:3
    a(:,n) = (1/sqrt(3))*R(n*2*pi/3-pi/2)*a1';
    
    dx = dx + t1*(cos(kx*a(1,n)+ky*a(2,n)));
    dy = dy + t1*(sin(kx*a(1,n)+ky*a(2,n)));
end


%% Set up plots and writer objects

path = mfilename('fullpath');
[pathstr, name, ext] = fileparts(path);

zrange = 21;

axes;


%% Calculate Diagonals and take frame
% 1: Phase
% 2: E
% 3: dz

for type = 1:3
% type = 2;
    
    b = zeros(2,3);
    
    switch type
        case 1
            Writer = VideoWriter(horzcat(pathstr,'/','Phase.avi'));
            open(Writer);
        case 2
            Writer = VideoWriter(horzcat(pathstr,'/','E.avi'));
            open(Writer);
        case 3
            Writer = VideoWriter(horzcat(pathstr,'/','dz.avi'));
            open(Writer);
    end
    
    for m = 1:size(S,1);
        
        d0 = 0;
        dz = 0;
        
        for n = 1:3
            b(:,n) = R(2*n*pi/3)*a1';
            
            %             d0 = d0 + 2*t2*cos(S(m,1))*cos(kx*b(1,n)+ky*b(2,n));
            dz = dz - 2*t2*sin(S(m,1))*sin(kx*b(1,n)+ky*b(2,n));
        end
        dz = S(m,2) - dz;
        
        %         d0(abs(d0)<1e-6)=0;
        dz(abs(dz)<1e-6)=0;
        
        Ep = sqrt(dx.^2+dy.^2+dz.^2);
        Em = -Ep;
        
        
        switch type
            case 1
                scatter(S(m,1),S(m,2),'filled');
                xlim([-pi-.1 pi+.1]);
                ylim([-Mmax-.1 Mmax+.1]);
            case 2               
                cmap = jet(201);
                cmap = cmap(1+round(min(min(Em+zrange/2))*200/zrange):1+round(max(max(Ep+zrange/2))*200/zrange),:);
                colormap(cmap);
                surf(Kx,Ky,Ep,'FaceAlpha',1,'EdgeAlpha',0);
                hold on;
                cmap = jet(201);
                cmap = cmap(1+round(min(min(Em+zrange/2))*200/zrange):1+round(max(max(Ep+zrange/2))*200/zrange),:);
                colormap(cmap);
                surf(Kx,Ky,Em,'FaceAlpha',1,'EdgeAlpha',0);
                
                view(30,20);
                camproj('perspective');
                
                hold off;
                xlim([-2*pi 2*pi]);
                ylim([-2*pi 2*pi]);
                zlim([-zrange/2 zrange/2]);
                
                shading interp
                lightangle(-45,30)
                
                set(gcf,'Renderer','zbuffer')
                set(findobj(gca,'type','surface'),...
                    'FaceLighting','phong',...
                    'AmbientStrength',.3,'DiffuseStrength',.8,...
                    'SpecularStrength',.9,'SpecularExponent',25,...
                    'BackFaceLighting','unlit')
                
            case 3
                cmap = jet(201);
                cmap = cmap(1+round(min(min(dz+zrange/2))*200/zrange):1+round(max(max(dz+zrange/2))*200/zrange),:);
                colormap(cmap);
                surf(Kx,Ky,dz,dz/20,'FaceAlpha',1,'EdgeAlpha',0);
                
                view(30,20);
                camproj('perspective');
                
                xlim([-2*pi 2*pi]);
                ylim([-2*pi 2*pi]);
                zlim([-zrange/2 zrange/2]);
                                
                shading interp
                lightangle(-45,30)
                
                set(gcf,'Renderer','zbuffer')
                set(findobj(gca,'type','surface'),...
                    'FaceLighting','phong',...
                    'AmbientStrength',.3,'DiffuseStrength',.8,...
                    'SpecularStrength',.9,'SpecularExponent',25,...
                    'BackFaceLighting','unlit')
        end
        
        frame = getframe;
        writeVideo(Writer,frame);
        
        test = 1;
        
    end

    close(Writer);
    
    test = 1;
    
end

test = 1;


function RMat = R(theta)
RMat = [cos(theta),-sin(theta);sin(theta),cos(theta)];
