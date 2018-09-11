clear all;
clc;
close all

a = 2.46;

%Declare kx and ky values to plug in
Dom = [-2*pi/(3*a),2*pi/(3*a),-4*pi/(3*sqrt(3)*a),4*pi/(3*sqrt(3)*a)];

%Functionalize all of CN's equations
syms x y;
fu(x,y) = 2*cos(sqrt(3)*y*a)+4*cos(sqrt(3)*y*a/2)*cos(3*x*a/2); %CN f equation
Ec(x,y) = 2.8*sqrt(3+fu(x,y));                                  %CN Ec Equation

twod = zeros(1,round(100*Dom(2))+round(100*Dom(4)/2)+round(100*2*Dom(2)/sqrt(3)));

for i = 1:round(100*Dom(2))
    twod(i) = Ec(i/100,0);
end
for i = 1:round(100*Dom(4)/2)
    twod(i+round(100*Dom(2))) = Ec(Dom(2),i/100);
end
for i = 1:round(100*2*Dom(2)/sqrt(3))
    twod(403-i) = Ec(i*sqrt(3)/200,i/200);
end

plot(twod);
hold on;
plot(-1*twod);

set(gca,'XTick',[1,round(100*Dom(2)),round(100*Dom(2))+round(100*Dom(4)/2),402]);
set(gca,'XTickLabel',{'G';'M';'K';'G'});
set(gca,'XLim',[0,402]);
set(gca,'XGrid','on');


figure;
ezsurf(Ec,Dom);
hold on;
ezmesh(-1*Ec,Dom);
xlabel('kx [1/Angstroms]');
ylabel('ky [1/Angstroms]');
zlabel('Energy [eV]');
view(20,10);

figure;
ezcontourf(Ec,Dom);
view(2);
colorbar;
xlabel('kx [1/Angstroms]');
ylabel('ky [1/Angstroms]');


dxEcv(x,y) = 2*diff(Ec(x,y),x);                                 %NN approximation, Ev = -Ec, Ec-Ev = 2Ec
dyEcv(x,y) = 2*diff(Ec(x,y),y);                                 %Use del to differentiate, do x diff, then y diff
absdtEcv(x,y) = sqrt((dxEcv(x,y))^2+(dyEcv(x,y))^2);
figure;
ezcontourf(absdtEcv,Dom);
xlabel('kx [1/Angstroms]');
ylabel('ky [1/Angstroms]');
set(gco,'ShowText','on');
colorbar;


invd(x,y) = 1/(absdtEcv(x,y));
figure;
ezsurf(invd,Dom);
xlabel('kx [1/Angstroms]');
ylabel('ky [1/Angstroms]');
zlabel('1/(dE/dk) [1/Angstroms*eV]');
view(15,45);