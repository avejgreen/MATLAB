close all;
clear all;
clc;

krange = pi;
kn = 501;
k = linspace(-krange,krange,kn);

%Gammas are transition energies. Can just use first order or first two.

g1 = 1;

%s-band in FCC crystal has Ek=E0-beta-sig(gamma(R)e^ikR)

%Define the lattice parameter as 1. 12 closest neighbors are at
%(a/2)*(pm1,pm1,0) and permutations.

a = 1;
R1 = a*[1,1;1,-1];
R1 = [R1;-R1];

test = 1;

%Generate k field in 2 dims
[X,Y] = meshgrid(k,k);
pts = size(R1,1);
E = zeros([size(X),pts]);
for ind = 1:pts
    E(:,:,ind) = g1*exp(1i*(X*R1(ind,1)+Y*R1(ind,2)));
end
E = sum(E,3);
E = real(E);

surf(X,Y,E,'EdgeAlpha',0);
view(2)
axis equal;
xlim([-pi,pi]);
ylim([-pi,pi]);


%Wrap x-axis and y-axis into a donut shape (R=1,r=.75)
Rtor = 1;
rtor = 0.75;
Xtor = (Rtor+rtor*cos(Y)).*cos(X);
Ytor = (Rtor+rtor*cos(Y)).*sin(X);
Ztor = rtor*sin(Y);

figure;

surf(Xtor,Ytor,Ztor,E,'EdgeAlpha',0);

view(20,70);
% shading interp;
% light;
lightangle(-45,30);
set(findobj(gca,'type','surface'),...
    'AmbientStrength',.7,'DiffuseStrength',.4,...
    'SpecularStrength',.4,'SpecularExponent',25,...
    'BackFaceLighting','unlit')

% 'FaceLighting','phong',...

test = 1;