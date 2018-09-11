%%% Ewald Sphere Image

close all;
close all hidden;
clear all;
clc;

%% Generate data for Si diff spots

%HKL spots
hRange = -5:1:5;
[h,k,l] = meshgrid(hRange,hRange,hRange);
h = reshape(h,numel(h),1,1);
k = reshape(k,numel(k),1,1);
l = reshape(l,numel(l),1,1);

%Si Structure factor given by inversion center at 1/8,1/8,1/8
F=cos((pi/4)*(-h-k-l))+...
    cos((pi/4)*(3*h+3*k-l))+...
    cos((pi/4)*(3*h-k+3*l))+...
    cos((pi/4)*(-h+3*k+3*l));
F(abs(F)<.1)=0;

R = sqrt(h.^2+k.^2+l.^2);

C = zeros(length(R),3);
C(:,3)=1;
C(and(R>4.85,R<4.95),1)=1;
C(and(R>4.85,R<4.95),3)=0;

hkl = [h,k,l,R,F,C];
hkl(hkl(:,5)==0,:)=[];


%% Draw 3D Ewald Image

%Sphere
sRadius = 4.89897948556636;

[sX,sY,sZ] = sphere(50);
sX = sRadius*sX;
sY = sRadius*sY;
sZ = sRadius*sZ;

%Sphere ring
sRing = 0:.01:2*pi;
sRX = sRadius*cos(sRing)';
sRY = sRadius*sin(sRing)';
sRZ = zeros(length(sRing),1);

scatter3(hkl(:,1),hkl(:,2),hkl(:,3),5*abs(hkl(:,5)).^2,hkl(:,6:8),'filled');
hold on;
surf(sX,sY,sZ,...
    'EdgeAlpha',0,...
    'FaceColor',[.5,.5,.5],...
    'FaceAlpha',.5,...
    'FaceLighting','phong');
plot3(sRX,sRY,sRZ,'Color',[0,.5,0]);

set(gca,'Projection', 'perspective');
axis equal;
view([110,20]);

light('Position',[5 10 10])

xlabel('h');
ylabel('k');
zlabel('l');


%% Draw Tomograph

hklTomo = hkl(hkl(:,1)==hkl(:,2),:);
Tomo = [sqrt(hklTomo(:,1).^2+hklTomo(:,2).^2),hklTomo(:,3),hklTomo(:,4:end)];
Tomo(:,1) = sign(hklTomo(:,1)).*Tomo(:,1);
figure;
rectangle('Position',[-sRadius,-sRadius,2*sRadius,2*sRadius],...
    'Curvature',[1,1],...
    'EdgeColor',[0,.5,0],...
    'FaceColor',[.8,.8,.8]);
hold on;
scatter(Tomo(:,1),Tomo(:,2),8*abs(Tomo(:,4)).^2,Tomo(:,5:7),'filled');

axis equal;


test = 1;