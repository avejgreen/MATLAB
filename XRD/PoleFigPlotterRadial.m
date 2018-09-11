function PoleFigPlotterRadial

close all;
clear all;
clc;

OldFolder = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/081116 Shane/Pole Fig 111');
[File, Path, FilterIndex] = uigetfile('*.X01','MultiSelect','on');

AllData = zeros(1,3);

for i = 1:length(File);
    
    Data = importdata(strcat(Path,File{i}), ' ', 61);
    ChiText = textscan(Data.textdata{16,1}, '%s %s %s');
    Chi = str2double(ChiText{2});
    Points = [Data.data(:,1),ones(length(Data.data),1)*Chi,Data.data(:,2)];
    AllData = [AllData;Points];
    
end

AllData(1,:) = [];
AllData(AllData(:,3)<1,3) = 1;
AllData(:,3) = log10(AllData(:,3));
AllData(AllData(:,3)>2,3) = 2;
AllData = [-AllData(:,2).*cos(AllData(:,1)*pi/180),-AllData(:,2).*sin(AllData(:,1)*pi/180),AllData(:,3)];  

scatter3(AllData(:,1),AllData(:,2),zeros(size(AllData,1),1),1,AllData(:,3)); 
hold on;
LineMax = max(AllData(:,1));
for i = 1:8
    plot3([0,LineMax*cos(45*i*pi/180)],[0,LineMax*sin(45*i*pi/180)],[1,1],'Color','k','LineStyle','--','LineWidth',1);
end

view(2);
axis equal;

set(gcf,'Units','normalized');
set(gcf,'Position',[0,0,1,1]);
set(gcf,'Color',[1,1,1]);
cbar = colorbar;

set(cbar,'FontSize',14);
set(cbar,'FontName','Arial');
set(cbar,'YTick',linspace(0,3,7));

set(gca,'GridLineStyle','none');
% set(gca,'Position',[.05,.22,.90,.71]);
% set(gca,'TickDir','out');
% set(gca,'TickLength',[.005,.025]);
% set(gca,'LineWidth',1.5);
% set(gca,'XTick',linspace(-60,270,12));
% set(gca,'XMinorTick','on','YMinorTick','on');
% set(gca,'FontSize',14);
% set(gca,'FontName','Arial');
% xlabel('Phi (deg)');
% ylabel('Chi (deg)');
% 
% set(gcf,'PaperPositionMode','auto');
% print(gcf, '-dpng', 'PoleFig','-r300');
% 
% cd(OldFolder)

test = 1;

end