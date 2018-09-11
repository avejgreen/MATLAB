function PoleFigPlotter

close all;
clear all;
clc;

OldFolder = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/112415/Scan14');
[File, Path, FilterIndex] = uigetfile('*.X01','MultiSelect','on');

AllData = zeros(1,3);

for i = 1:length(File);
    
    Data = importdata(strcat(Path,File{i}), ' ', 61);
    PhiText = textscan(Data.textdata{17,1}, '%s %s %s');
    Phi = str2double(PhiText{2});
    Points = [ones(length(Data.data),1)*Phi,Data.data(:,1),Data.data(:,2)];
    AllData = [AllData;Points];
    
end

AllData(1,:) = [];
AllData(AllData(:,3)<1,3) = 1;
AllData(:,3) = log10(AllData(:,3));
  
F = TriScatteredInterp(AllData(:,1:2),AllData(:,3));
[qx,qy] = meshgrid(linspace(min(AllData(:,1)),max(AllData(:,1)),round(max(AllData(:,1))-min(AllData(:,1)))/.1),linspace(min(AllData(:,2)),max(AllData(:,2)),round(max(AllData(:,2))-min(AllData(:,2)))/.05));
qz = F(qx,qy);
imagesc(qx(1,:),qy(:,1),qz);

set(gcf,'Units','normalized');
set(gcf,'Position',[0,.5,.3,.3]);
set(gcf,'Color',[1,1,1]);
cbar = colorbar;

set(cbar,'FontSize',14);
set(cbar,'FontName','Arial');
set(cbar,'YTick',linspace(0,3.5,8));

set(gca,'Position',[.05,.22,.90,.71]);
set(gca,'TickDir','out');
set(gca,'TickLength',[.005,.025]);
set(gca,'LineWidth',1.5);
set(gca,'XTick',linspace(-60,270,12));
set(gca,'XMinorTick','on','YMinorTick','on');
set(gca,'FontSize',14);
set(gca,'FontName','Arial');
xlabel('Phi (deg)');
ylabel('Chi (deg)');

set(gcf,'PaperPositionMode','auto');
print(gcf, '-dpng', 'PoleFig','-r300');

cd(OldFolder)

test = 1;

end