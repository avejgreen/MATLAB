function TOFSIMSPlotter

close all;
clear all;
clc;

%% Load Data

oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/SIMS/090116');

AllData = struct;

AllData = importdata('1.TXT','\t',5);
AllData(2) = importdata('2.TXT','\t',5);
AllData(3) = importdata('3.TXT','\t',5);
AllData(4) = importdata('4.TXT','\t',5);
AllData(5) = importdata('5.TXT','\t',5);

AllPlotHandles = zeros(9,5);

%% Make Plots
for SampleNumber = 1:5
    
    AllData(SampleNumber).data(:,6)=[];
    AllData(SampleNumber).textdata(:,6)=[];
    AllData(SampleNumber).colheaders(:,6)=[];
    
    %% Make Plot of all elements   
    AllPlotHandles(1,SampleNumber) = figure('Color', 'w',...
        'Name', horzcat('Sample ', int2str(SampleNumber), ': All Data'),...
        'Visible','off');
    
    set(gca,'YScale', 'log',...
        'NextPlot', 'add',...
        'Title', text('String', horzcat('Sample ', int2str(SampleNumber), ': All Data'),'FontSize',14,'FontName','Arial'),...
        'XLabel', text('String', 'Sputter Time (s)','FontSize',12,'FontName','Arial'),...
        'YLabel', text('String', 'Intensity (Background Corrected)','FontSize',12,'FontName','Arial'));
        
    Colors = get(gca,'ColorOrder');
    Colors(end,:) = [.5,0.3137254901960784,0];
    Colors = [Colors;[0,0,0]];
    for i = 2:9
        plot(AllData(SampleNumber).data(:,1),AllData(SampleNumber).data(:,i),'LineWidth',2,'Color',Colors(i-1,:));
    end
    
    IonName = textscan(AllData(SampleNumber).textdata{3},'%s');
    IonName = IonName{1};
    IonName(6) = [];
    IonName(1) = [];
    legend(gca,IonName);
    
    ProjectFolder = cd(horzcat(pwd, '/Sample', int2str(SampleNumber)));
    print(gcf, horzcat('Sample ', int2str(SampleNumber), ' All Data'), '-djpeg');
    close gcf;
    cd(ProjectFolder);
    
    IonMass = textscan(AllData(SampleNumber).textdata{4},'%s');
    IonMass = IonMass{1};
    IonMass(6) = [];
    IonMass(1) = [];
    
    test = 1;
    
    %% Make Plot of O, Ni, Cu, Pt, Ta, and Co
    SelectedPlotHandles(1,SampleNumber) = figure('Color', 'w',...
        'Name', horzcat('Sample ', int2str(SampleNumber), ': Selected Data'),...
        'Visible','off');
    
    set(gca,'YScale', 'log',...
        'NextPlot', 'add',...
        'Title', text('String', horzcat('Sample ', int2str(SampleNumber), ': Selected Data'),'FontSize',14,'FontName','Arial'),...
        'XLabel', text('String', 'Sputter Time (s)','FontSize',12,'FontName','Arial'),...
        'YLabel', text('String', 'Intensity (Background Corrected)','FontSize',12,'FontName','Arial'));
        
    Colors = get(gca,'ColorOrder');
    SelectedDataChannels = [3,4,5,7,8,9];
    for i = SelectedDataChannels
        plot(AllData(SampleNumber).data(:,1),AllData(SampleNumber).data(:,i),'LineWidth',2,'Color',Colors(i-2,:));
    end
    
    legend(gca,IonName(SelectedDataChannels-1));
    
    ProjectFolder = cd(horzcat(pwd, '/Sample', int2str(SampleNumber)));
    print(gcf, horzcat('Sample ', int2str(SampleNumber), ' Selected Data'), '-djpeg');
    close gcf;
    cd(ProjectFolder);

    test = 1;
    
    
    %% Make Plot of each individual element
    for i = 2:9
        
        AllPlotHandles(i,SampleNumber) = figure('Color', 'w',...
            'Name', horzcat('Sample ', int2str(SampleNumber), ': ', IonName{i-1}, ', ', IonMass{i-1}, ' A.U.'),...
            'Visible','off');
        
        plot(gca,AllData(SampleNumber).data(:,1),AllData(SampleNumber).data(:,i),'LineWidth',2,'Color',[0,0,0]);
        
        set(gca,'YScale', 'log',...
            'Title', text('String', horzcat('Sample ', int2str(SampleNumber), ': ', IonName{i-1}, ', ', IonMass{i-1}, ' A.U.'),'FontSize',14,'FontName','Arial'),...
            'XLabel', text('String', 'Sputter Time (s)','FontSize',12,'FontName','Arial'),...
            'YLabel', text('String', 'Intensity (Background Corrected)','FontSize',12,'FontName','Arial'));
        
        ProjectFolder = cd(horzcat(pwd, '/Sample', int2str(SampleNumber)));
        print(gcf, horzcat('Sample ', int2str(SampleNumber), ' ', IonName{i-1}), '-djpeg');
        close gcf;
        cd(ProjectFolder);
        
        test = 1;
        
    end
    
    test = 1;
    
end

test = 1;

cd(oldfolder);

end