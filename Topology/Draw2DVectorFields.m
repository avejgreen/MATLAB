function Draw2DVectorFields

close all;
clear all;
clc;

kx = -pi:pi/5:pi;
ky = kx;

[Kx,Ky] = meshgrid(kx,ky);


%% Field #1, (-1,0)

u = -1*ones(size(Kx));
v = zeros(size(Kx));

quiver(Kx,Ky,u,v,.5,'LineWidth',1);
axis equal;
set(gca,'FontName','Arial','FontSize',16,'XLim',[-4,4],'YLim',[-4,4]);


FileName = '2DVF0';
[pathstr, name, ext] = fileparts(mfilename('fullpath'));
FileName = horzcat(pathstr,'/',FileName,'.jpeg');

print(gcf,'-djpeg',FileName)

test = 1;

%% Field #2, (-y,x)
u = zeros(size(Kx));
v = u;
Norms = sqrt(Kx.^2+Ky.^2);

DL = length(Kx);
i = 1;
while i <= numel(Kx)
    row = mod(i,DL)-DL*floor((mod(i,DL)-1)/DL);
    col = ceil(i/DL);
    
    try Norms(row,col)==0
    catch err
        test = 1;
    end
    
    if Norms(row,col)==0;
    else
        u(row,col) = -Ky(row,col)/Norms(row,col);
        v(row,col) = Kx(row,col)/Norms(row,col);
    end
    i = i+1;
end


quiver(Kx,Ky,u,v,.5,'LineWidth',1);
axis equal;
set(gca,'FontName','Arial','FontSize',16,'XLim',[-4,4],'YLim',[-4,4]);

FileName = '2DVF1';
[pathstr, name, ext] = fileparts(mfilename('fullpath'));
FileName = horzcat(pathstr,'/',FileName,'.jpeg');

print(gcf,'-djpeg',FileName)

test = 1;