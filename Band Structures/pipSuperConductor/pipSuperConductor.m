function pipSuperConductor

close all;
clear all;
clc;

kx = -1*pi:.1:pi;
ky = kx;

[Kx,Ky] = meshgrid(kx,ky);

Del = .1;
t = .1;
mu = .1;

Ep = zeros(length(kx));
Em = Ep;

dx = Del*sin(kx);
dy = Del*sin(ky);
dz = 2*t*(cos(Kx)+cos(Ky))+mu;

for i = 1:length(kx)
    for j = 1:length(ky)
        
        Ep(i,j) = sqrt(dx(i)^2+dy(j)^2+dz(i,j)^2);
        Em(i,j) = -Ep(i,j);
        
    end
end

mesh(kx,ky,Ep);
hold on;
mesh(kx,ky,Em);
hold off;

test = 1;

