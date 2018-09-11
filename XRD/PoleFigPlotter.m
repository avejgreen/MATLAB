function PoleFigPlotter

close all;
clear all;
clc;

OldFolder = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/072216/PoleFig');
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
  
F = TriScatteredInterp(AllData(:,1:2),AllData(:,3));
[qx,qy] = meshgrid(linspace(-68,292,360/.1),linspace(min(AllData(:,2)),max(AllData(:,2)),round(max(AllData(:,2))-min(AllData(:,2)))/.05));
qz = F(qx,qy);
imagesc(qx(1,:),qy(:,1),qz);

set(gcf,'Units','normalized');
set(gcf,'Position',[0,.5,1,.3]);
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