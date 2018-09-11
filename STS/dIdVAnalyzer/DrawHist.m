function DrawHist

oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/STS/dIdVAnalyzer');

load('Ed');
Ed = 1000*Ed;

xrange = [0, 90];

hist(Ed(and(Ed>xrange(1),Ed<xrange(2))),linspace(xrange(1),xrange(2),21));
 
hpatch = findobj(gca,'Type','patch');
Vertices = get(hpatch,'Vertices');
ymax = 10*ceil(1.1*max(Vertices(:,2))/10);

xlim(xrange);
ylim([0 ymax]);

set(gcf,'Units','inches',...
    'PaperSize',[3.37,3.37],'PaperPosition',[0,0,3.37,3.37]);
set(hpatch,'FaceColor','b');
set(gca,'TickDir','out');
set(gca,'FontSize',8,'FontName','Arial');
set(gca,'XMinorTick','on','YMinorTick','on');
% set(gca,'LineWidth',1);

xlabel('E_d - E_F (meV)','fontsize',10);
ylabel('# Spectra','fontsize',10);

oldfolder2 = cd('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM');
[FileName,PathName] = uiputfile('*.png','Save figure as:','Histogram1');
print(gcf,horzcat(PathName,FileName),'-dpng','-r300');
% print(gcf,'TestFigure','-dtiff','-r300')
cd(oldfolder2);

cd(oldfolder);

test = 1;