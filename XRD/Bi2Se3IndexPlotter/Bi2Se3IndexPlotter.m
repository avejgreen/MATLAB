function Bi2Se3IndexPlotter

% close all;
% clear all;
% clc;

a1 = 4.143*[1,0,0];
a2 = 4.143*[cos(2*pi/3),sin(2*pi/3),0];
a3 = 28.636*[0,0,1];
a = [a1;a2;a3];

b1 = cross(a2,a3)/(dot(a1,cross(a2,a3)));
b2 = cross(a3,a1)/(dot(a1,cross(a2,a3)));
b3 = cross(a1,a2)/(dot(a1,cross(a2,a3)));
b = [b1;b2;b3];

% dStar = norm(b1)*cos(atan(dot(b1,b1-b2)/norm(cross(b1,b2))));
dStar = 2*norm(b1);
gMax = 2*sin(50*pi/180)/1.541;
hMax = ceil(gMax/dStar);
lMax = ceil(gMax/norm(b3));

hSpots = linspace(-hMax,hMax,2*hMax+1);
hRange = length(hSpots);
lSpots = linspace(0,lMax,lMax+1);
lRange = length(lSpots);
hklSpots = zeros(length(hSpots)^2*length(lSpots),3);
for i = 1:lRange
    for j = 1:hRange
        if i == 2;
            test = 1;
        end
        hklSpots(1+hRange*(j-1)+hRange^2*(i-1):hRange*j+hRange^2*(i-1),:)=[hSpots',ones(hRange,1)*hSpots(j),ones(hRange,1)*lSpots(i)];
    end
end

hklAbsent = or((-hklSpots(:,1)+hklSpots(:,2)+hklSpots(:,3)+1)/3==round( (-hklSpots(:,1)+hklSpots(:,2)+hklSpots(:,3)+1)/3),...
    (-hklSpots(:,1)+hklSpots(:,2)+hklSpots(:,3)-1)/3==round((-hklSpots(:,1)+hklSpots(:,2)+hklSpots(:,3)-1)/3));
hklSpots = hklSpots(~hklAbsent,:);

qVectors = hklSpots*b;

AllInfo = [hklSpots,qVectors];
% AllInfo = AllInfo(sqrt(AllInfo(:,4).^2+AllInfo(:,5).^2+AllInfo(:,6).^2)<g,:);
AllInfo = AllInfo(sqrt(AllInfo(:,4).^2+AllInfo(:,5).^2)<dStar,:);
AllInfo = AllInfo(AllInfo(:,6)<dStar/2,:);

% figure;
hold on;
for i = 0:2
    scatter3(AllInfo((AllInfo(:,3)+i)/3==round((AllInfo(:,3)+i)/3),4),AllInfo((AllInfo(:,3)+i)/3==round((AllInfo(:,3)+i)/3),5),AllInfo((AllInfo(:,3)+i)/3==round((AllInfo(:,3)+i)/3),6),250,'filled','MarkerEdgeColor','k');
end
set(gca,...
    'XLim',[-.5, .5],...
    'YLim',[-.5, .5],...
    'ZLim',[0 .25],...
    'DataAspectRatio',[1 1 1/3],...
    'LineWidth', 1,...
    'XGrid', 'on',...
    'YGrid', 'on',...
    'ZGrid', 'on',...
    'XTick', linspace(-.4,.4,5),...
    'YTick', linspace(-.4,.4,5),...
    'ZTick', linspace(0,.25,6),...
    'XMinorTick','on',...
    'YMinorTick','on',...
    'ZMinorTick','on',...
    'GridLineStyle','--',...
    'FontName','times',...
    'FontSize',20);
% legend('l=3n Indices', 'l=3n+1 Indices', 'l=3n+2 Indices');
xlabel('q_x (A^{-1})','FontSize',20);
ylabel('q_y (A^{-1})','FontSize',20);
zlabel('q_z (A^{-1})','FontSize',20);
view(240,0);

test = 1;