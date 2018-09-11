function IVFitter

close all;
close all hidden;
clear all;
clc;

warning('off','all');

%{
    1. Select a folder with data csv files
    2. Make a folder called 'Matlab Analysis'
    3. Go through folder and subfolders
        1. Import csv
        2. Write analysis with file name: SampleID_yymmdd_hh:mm:ss_ExptType
        3. Get mean spectrum
        4. Fit, export data and plot with data scatter and fit line
        5. Refit individual spectra, export hist plot and hist data
%}


%% 1. Select a folder with data csv files
TopDir = uigetdir('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM');
[Up1Dir,TopFolder,ext] = fileparts(TopDir);

if length(TopFolder) < 7
    disp('Invalid folder choice name');
elseif ~ all(isstrprop(TopFolder(1:6),'digit')) && isstrprop(TopFolder(7),'whitespace')
    disp('Invalid folder choice name');
else
    
    SampleID = TopFolder(8:end);
    
    hbar = waitbar(0,'Hello!');
    hbarObjs = findall(hbar);
    hbarTitle = hbarObjs(5);
    set(hbarTitle,'HorizontalAlignment','left',...
        'Interpreter','none',...
        'Position',[20 1.23333 1.00005])
    
    get(hbarObjs(5));
    
    Dirs = {TopDir};
    
    %% 2. Make a folder called 'Matlab Analysis'
    MLAF = 'Matlab Analysis';
    mkdir(TopDir,MLAF)
    ExportFolder = horzcat(TopDir,'/',MLAF);
    
    
    %% 3. Go through folder and subfolders and Do the Thing
    
    while ~isempty(Dirs)
        
        FolderContents = textscan(ls(Dirs{end}),'%s','Delimiter','\t','MultipleDelimsAsOne',1);
        FolderContents = cellfun(@(x) horzcat(Dirs{end},'/',x),FolderContents{1},'UniformOutput',0);
        
        NewCSVs = cellfun(@(x) strcmp('.csv',x(end-3:end)),FolderContents);
        NewCSVs = FolderContents(NewCSVs);
        
        if ~isempty(NewCSVs)
            DoTheThing(SampleID,NewCSVs,ExportFolder,hbar);
        end
        
        NewDirs = cellfun(@isdir,FolderContents);
        NewDirs = FolderContents(NewDirs);
        
        Dirs(end) = [];
        Dirs = [Dirs;NewDirs];
        
    end
    
    close(hbar);
    
end



%% The Thing

function DoTheThing(SampleID,CSVs,RootFolder,hbar)

[FolderName,FileName,Ext] = fileparts(CSVs{1});
FolderParts = textscan(FolderName,'%s','Delimiter','/');
FolderEnd = FolderParts{1}{end};

Model = @(a,x)(exp(a(1)*(x-a(2)))-exp(a(3)*(x-a(4)))+a(5)*x+a(6));

for i = 1:length(CSVs)
    
    %     1. Import csv
    File = importdata(CSVs{i});
    
    Headers = File.textdata;
    xData = File.data(1,:)';
    yData = File.data(2:end,:)';
    clear File;
    
    %Each map has nSpectra spectra and each spectrum has nPoints data points
    nSpectra = size(yData,2);
    nPoints = length(xData);
    
    
    %     2. Get mean spectrum
    yMean = mean(yData,2);
    
    
    %     3. Fit, export data and plot with data scatter and fit line
    FitParams = NaN(nSpectra,8);
    
    a0 = [5,4.5,-5,-4.5,0,0];
    try Beta0 = nlinfit(xData,yMean,Model,a0);
        GoodAvgFit = 1;
    catch
        GoodAvgFit = 0;
    end
    
    if ~GoodAvgFit
        
        DataPlot = figure('Visible','off');
        DPAxes = gca;
        scatter(DPAxes,xData,yMean);
        hold on;
        plot(DPAxes,xData,Model(Beta0,xData),'Color','r','LineWidth',1);
        xlabel('Bias (V)');
        ylabel('Current (A)');
        hold off;
        
        %     4. Write analyses with file name: SampleID_yy-mm-dd_hh:mm:ss_ExptType
        
        StdHeader = cell(3,1);
        StdHeader{1} = horzcat('Sample ID:', SampleID);
        StdHeader{2} = horzcat('Data acquired: ',datestr(Headers{1},'yy-mm-dd_HH-MM-SS'));
        StdHeader{3} = horzcat('nSpectra: ',int2str(nSpectra));
        StdHeader{4} = horzcat('Model: exp(a(1)*(x-a(2)))-exp(a(3)*(x-a(4)))+a(5)*x+a(6)');
        
        ExportIDTime = horzcat(RootFolder,'/',SampleID,'_',datestr(Headers{1},'yy-mm-dd_HH-MM-SS'));
        
        ExportFileName = horzcat(ExportIDTime,'_AvgPlot.jpg');
        print(DataPlot,'-djpeg',ExportFileName);
        
        ExportFileName = horzcat(ExportIDTime,'_AvgData.csv');
        WriteAvgData(ExportFileName,StdHeader,xData,yMean,Beta0,Model(Beta0,xData));
        
        close(DataPlot);
        
        %     5. Refit individual spectra, export hist plot and hist data
        for j = 1:nSpectra;
            
            waitbar(i/length(CSVs),hbar,horzcat('Processing ',FolderEnd,'/',FileName,': ',int2str(j)));
            
            try [ahat,r] = nlinfit(xData,yData(:,j),Model,Beta0);
                FitParams(j,:) = [ahat,log10(norm(r)),0];
            catch err
                test = 1;
            end
            
        end
        
        FitParams(isNaN(FitParams(:,1))) = [];
        
        Ef = (log(FitParams(:,3).^2)-log(FitParams(:,1).^2)...
            +FitParams(:,1).*FitParams(:,2)-FitParams(:,3).*FitParams(:,4))...
            ./(FitParams(:,1)-FitParams(:,3));
        FitParams(:,end) = Ef;
        
        EfTest = or(Ef < min(xData), Ef > max(xData));
        FitParams(EfTest,:) = [];
        
        %     6. Write analyses with file name: SampleID_yymmdd_hh:mm:ss_ExptType
        
        HistPlot = figure('Visible','off');
        HPAxes = gca;
        hist(HPAxes,FitParams(:,end));
        
        ExportFileName = horzcat(ExportIDTime,'_HistPlot.jpg');
        print(DataPlot,'-djpeg',ExportFileName);
        
        ExportFileName = horzcat(ExportIDTime,'_HistData.csv');
        WriteHistData(ExportFileName,StdHeader,FitParams);
        
        close(DataPlot);
        
        %     7. Write file with Date/Time, Mean, Quartiles
        
        EfSet = sort(FitParams(:,end));
        ESLm1 = length(EfSet)+1;
        EfMin = EfSet(1);
        EfMax = EfSet(end);
        
        if ESLm1/2 == round(ESLm1/2)
            EfMedian = EfSet(1+ESLm1/2);
        else
            EfMedian = mean([EfSet(floor(1+ESLm1/2)),EfSet(ceil(1+ESLm1/2))]);
        end
        
        if ESLm1/4 == round(ESLm1/4)
            EfQ1 = EfSet(1+ESLm1/4);
            EfQ3 = EfSet(1+3*ESLm1/4);
        else
            EfQ1 = mean([EfSet(floor(1+ESLm1/4)),EfSet(ceil(1+ESLm1/4))]);
            EfQ3 = mean([EfSet(floor(1+3*ESLm1/4)),EfSet(ceil(1+3*ESLm1/4))]);
        end
        
        EfStats = [EfMin,EfQ1,EfMedian,EfQ3,EfMax];
        
        ExportFileName = horzcat(ExportIDTime,'_TimeEfStats.csv');
        WriteTimeEfStats(ExportFileName,StdHeader,EfStats);
        
        test = 1;
        
    end
    
end

test = 1;


function WriteAvgData(ExportFileName,StdHeader,xData,yMean,Beta0,ModelData)

File = fopen(ExportFileName,'w+');
for i = 1:length(StdHeader)
    fprintf(File,'%s\n',StdHeader{i});
end
fprintf(File,'Params "a" for Avg: %3f, %3f, %3f, %3f, %3f, %3f\n', Beta0(1),Beta0(2),Beta0(3),Beta0(4),Beta0(5),Beta0(6));
fprintf(File,'\nBias(V),Mean Current Data(I),Model Fit(I)\n');
fclose(File);
DataMatrix = [xData,yMean,ModelData];
dlmwrite(ExportFileName,DataMatrix,'-append');
test = 1;


function WriteHistData(ExportFileName,StdHeader,FitParams)

File = fopen(ExportFileName,'w+');
for i = 1:length(StdHeader)
    fprintf(File,'%s\n',StdHeader{i});
end
fprintf(File,'\nB+,x0+,B-,x0-,m,y0,Error,Ef\n');
fclose(File);
dlmwrite(ExportFileName,FitParams,'-append');
test = 1;


function WriteTimeEfStats(ExportFileName,StdHeader,EfStats)
File = fopen(ExportFileName,'w+');
for i = 1:length(StdHeader)
    fprintf(File,'%s\n',StdHeader{i});
end
fprintf(File,'\nDate/Time,Min,Q1,Median,Q3,Max\n');
DateTime = StdHeader{2}(end-16:end);
fprintf(File,'%s',StdHeader{2}(end-16:end));
for i = 1:length(EfStats)
    fprintf(File,',%f',EfStats(i));
end
fclose(File);
test = 1;



