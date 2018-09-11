function GrapheneBandStructure

close all;
close all hidden;
clear all;
clc;

E0 = 0;
gamma0p = 0;
gamma0 = 0.9;

kx = -1:.01:1;
ky = kx;

[gkx,gky] = meshgrid(kx,ky);

H11 = E0-2*gamma0p*(cos(2*pi*gky)+2*cos(pi*sqrt(3)*gkx).*cos(pi*gky));
H12 = gamma0*sqrt(1+4*cos(pi*gky).^2+4*cos(pi*gky).*cos(pi*gkx*sqrt(3)));

Bandp = H11+H12;
Bandm = H11-H12;

p = mfilename('fullpath');
[PATH,NAME,EXT] = fileparts(p);

figure;
surfc(kx,ky,Bandp,'EdgeAlpha',0);
ApplyLabels
print(gcf,'-djpeg',horzcat(PATH,'/TopBand.jpg'));
figure;
surfc(kx,ky,Bandm,'EdgeAlpha',0);
ApplyLabels
print(gcf,'-djpeg',horzcat(PATH,'/BottomBand.jpg'));
figure
surfc(kx,ky,Bandm,'EdgeAlpha',0);
hold on;
surfc(kx,ky,Bandp,'EdgeAlpha',0);
ApplyLabels
print(gcf,'-djpeg',horzcat(PATH,'/BothBands.jpg'));

test = 1;

function ApplyLabels
xlabel('kx*a');
ylabel('ky*a');
zlabel('Energy (eV)');