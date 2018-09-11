function makelogplot(text, data, dorder)
LogPlot = figure;
Plot = plot(data(:,1),log10(data(:,2)),...
    'LineWidth', 2,...
    'Color', 'k');
title(horzcat('Derivative ',int2str(dorder),' ',text{1}{3},' ',text{1}{4},' ',text{1}{5},' ',text{1}{6},': ',...
    text{3}{3}));
set(gca,...
    'XLim', [min(data(:,1)), max(data(:,1))],...
    'YLim', [2 log10(2*max(data(:,2)))]);
    
xlabel(horzcat('Energy (',text{9}{3},')'));
ylabel(horzcat('Derivative ',int2str(dorder),' Log Intensity'))