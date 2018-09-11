%%% Bi2Se3 Diffraction Points %%%
function [Planes,b,FileName] = DiffractionPts

% close all;
% clear all;
% clc;

oldFolder = cd('/Users/averygreen/Desktop/VESTA/Files xtl');

[FileName,PathName,FilterIndex] = uigetfile('*.xtl','Select xtl File') ;
LatticeParameters = importdata(strcat(PathName,FileName), ' ', 2);
Atoms = importdata(strcat(PathName,FileName), ' ', 7);
% LatticeParameters = importdata('/Users/averygreen/Desktop/VESTA/xtl Files/Bismuth.xtl', ' ', 2);
% Atoms = importdata('/Users/averygreen/Desktop/VESTA/xtl Files/Bismuth.xtl', ' ', 7);

cd(oldFolder);
[ndata, text] = xlsread('/Users/averygreen/Documents/MATLAB/Projects/XRD/Diffraction4/ElementTable.xlsx');
cd(oldFolder)

Lattice = LatticeParameters.data;

AtomData = zeros(size(Atoms.data,1),4);
AtomData(:,1:3) = Atoms.data;
for i = 1:size(Atoms.data,1);
    AtomData(i,4) = find(strcmp(text(:,4),Atoms.textdata{i+7,1}));
end

for i = 1:3
    AtomData(AtomData(:,i)==1,:) = [];
end

%%% Limit planes to Bede tool max

a1 = [Lattice(1),0,0];
a2 = [Lattice(2)*cos(Lattice(6)*pi/180),Lattice(2)*sin(Lattice(6)*pi/180),0];
a3 = zeros(1,3);
a3(1) = Lattice(3)*cos(Lattice(5)*pi/180);
a3(2) = (norm(a2)*Lattice(3)*cos(Lattice(5)*pi/180)-a2(1)*a3(1))/a2(2);
a3(3) = sqrt(Lattice(3)^2-a3(1)^2-a3(2)^2);
a3(a3<1E-6) = 0;

Vol = dot(a1,cross(a2,a3));

b1 = cross(a2,a3)/Vol;
b2 = cross(a3,a1)/Vol;
b3 = cross(a1,a2)/Vol;
b3(b3<1E-6) = 0;
b = [b1;b2;b3];

% Find minimum nonzero elements of b vectors for h,k,lmax 
dStar = norm(b1)*cos(atan(dot(b1,b1-b2)/norm(cross(b1,b2))));
gMax = 2*sin(50*pi/180)/1.541;
hMax = ceil(gMax/dStar);
kMax = hMax;
lMax = ceil(gMax/norm(b3));

hRange = linspace(-hMax,hMax,2*hMax+1);
kRange = linspace(-kMax,kMax,2*kMax+1);
lRange = linspace(-lMax,lMax,2*lMax+1);

Planes = zeros(length(hRange)*length(kRange)*length(lRange),7);

for l = -lMax:lMax
    for k = -kMax:kMax
        for h = -hMax:hMax
            Planes(1+length(hRange)*length(kRange)*(l+lMax)+length(hRange)*(k+kMax)+(h+hMax),1:3) = [h,k,l];
        end
    end
end

Planes(Planes(:,1)==0 & Planes(:,2)==0 & Planes(:,3)==0,:) = [];

SFTemp = Planes(:,1:3)*AtomData(:,1:3)';
SFTemp = exp(2i*pi*SFTemp);
SFTemp = SFTemp*AtomData(:,4);
SFTemp = SFTemp.*conj(SFTemp);
Planes(:,4) = SFTemp;
Planes = Planes(Planes(:,4)>1e-3,:);


% IntZeros = Int(:,4)<1e-3;
% Int(:,4) = Int(:,4).*(1-IntZeros);

% Patterson = Int(:,1:4);
% Patterson(:,4) = 0;
% for m = 1:length(Patterson)
%     for n = 1:length(Atoms)
%         PattersonTemp = Int(m,4)^2*cos(2*pi*dot(Atoms(n,1:3),Patterson(m,1:3)));
%         Patterson(m,4) = Patterson(m,4)+PattersonTemp;
%     end
% end
% Patterson = Patterson(Patterson(:,4)>0,:);


%Figure out d-Spacing
S11 = (norm(a2)*norm(a3)*sin(Lattice(4)*pi/180))^2;
S22 = (norm(a3)*norm(a1)*sin(Lattice(5)*pi/180))^2;
S33 = (norm(a1)*norm(a2)*sin(Lattice(6)*pi/180))^2;
S23 = norm(a1)^2*norm(a2)*norm(a3)*(cos(Lattice(5)*pi/180)*cos(Lattice(6)*pi/180)-cos(Lattice(4)*pi/180));
S31 = norm(a1)*norm(a2)^2*norm(a3)*(cos(Lattice(6)*pi/180)*cos(Lattice(4)*pi/180)-cos(Lattice(5)*pi/180));
S12 = norm(a1)*norm(a2)*norm(a3)^2*(cos(Lattice(4)*pi/180)*cos(Lattice(5)*pi/180)-cos(Lattice(6)*pi/180));
Planes(:,5) = Vol./sqrt(S11*Planes(:,1).^2+S22*Planes(:,2).^2+S33*Planes(:,3).^2+2*S23*Planes(:,2).*Planes(:,3)+2*S31*Planes(:,3).*Planes(:,1)+2*S12*Planes(:,1).*Planes(:,2));
Planes = Planes(Planes(:,5)>1/gMax,:);

%Get Omega position
Planes(:,6) = (180/pi)*asin(1.5406./(2*Planes(:,5)));

%Get Chi Position
bvectors = Planes(:,1:3)*b;
Planes(:,7) = (180/pi)*acos(bvectors(:,3).*Planes(:,5));

Planes = real(Planes);
Planes(Planes(:,7)<1e-3,7) = 0;
% Planes = Planes(Planes(:,7)<=90,:);

% bPlot = Int(:,1:4);
% bPlot = bPlot(bPlot(:,4)>0,:);
% bPlot = bPlot(bPlot(:,3)>0,:);
% bPlot(:,4) = log10(bPlot(:,4));
% for m = 1:length(bPlot);
%     bPlot(m,1:3) = b1*bPlot(m,1)+b2*bPlot(m,2)+b3*bPlot(m,3);
% end
% 
% scatter3(bPlot(:,1),bPlot(:,2),bPlot(:,3),bPlot(:,4));

% Find 006, 015, -105, 1-15

% Int2 = zeros(4,7);
% if Only105
%     
%     Int2(1,:) = Int((Int(:,1)==0&Int(:,2)==0&Int(:,3)==3)==1,:);
%     Int2(2,:) = Int((Int(:,1)==0&Int(:,2)==0&Int(:,3)==6)==1,:);
%     Int2(3,:) = Int((Int(:,1)==0&Int(:,2)==0&Int(:,3)==9)==1,:);
%     Int2(4,:) = Int((Int(:,1)==0&Int(:,2)==0&Int(:,3)==12)==1,:);
%     Int2(5,:) = Int((Int(:,1)==0&Int(:,2)==0&Int(:,3)==15)==1,:);
%     Int2(6,:) = Int((Int(:,1)==0&Int(:,2)==1&Int(:,3)==5)==1,:);
%     Int2(7,:) = Int((Int(:,1)==1&Int(:,2)==-1&Int(:,3)==5)==1,:);
%     Int2(8,:) = Int((Int(:,1)==-1&Int(:,2)==0&Int(:,3)==5)==1,:);
%     Int = Int2;
%     
% end
% 
% a = 1;




% bPlot = Int(:,1:4);
% bPlot = bPlot(bPlot(:,4)>0,:);
% bPlot = bPlot(bPlot(:,3)>0,:);
% S = sqrt(bPlot(:,4))/10;
% C = log10(bPlot(:,4));
% for m = 1:length(bPlot);
%     bPlot(m,1:3) = b(1,:)*bPlot(m,1)+b(2,:)*bPlot(m,2)+b(3,:)*bPlot(m,3);
% end



% hold on;
% bScatter = bvectors(sqrt(bvectors(:,1).^2+bvectors(:,2).^2)<.3,:);
% bScatter = bScatter(and(bScatter(:,3)>=0,bScatter(:,3)<=.3),:);
% scatter3(bScatter(:,1),bScatter(:,2),bScatter(:,3),250,'filled','Marker','p','MarkerEdgeColor','k','MarkerFaceColor','y');
% set(gca,...
%     'XLim',[-.3, .3],...
%     'YLim',[-.3, .3],...
%     'ZLim',[0 .3],...
%     'DataAspectRatio',[1 1 1/2],...
%     'LineWidth', 1,...
%     'XGrid', 'on',...
%     'YGrid', 'on',...
%     'ZGrid', 'on',...
%     'XTick', linspace(-.3,.3,7),...
%     'YTick', linspace(-.3,.3,7),...
%     'ZTick', linspace(0,.3,4),...
%     'XMinorTick','on',...
%     'YMinorTick','on',...
%     'ZMinorTick','on',...
%     'GridLineStyle','--',...
%     'FontName','times',...
%     'FontSize',20);
% % legend('l=3n Indices', 'l=3n+1 Indices', 'l=3n+2 Indices');
% xlabel('q_x (A^{-1})','FontSize',20);
% ylabel('q_y (A^{-1})','FontSize',20);
% zlabel('q_z (A^{-1})','FontSize',20);
% view(240,0);


test = 1;


end