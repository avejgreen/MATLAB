function IVFitter4

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

% Dirs Structure: Dir, Subdirs Added

TopPath = uigetdir('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM');
% TopPath = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM';
Dirs = cell(1,2);
Dirs(1:2)=[{TopPath},{0}];
CSVFiles = cell(0,1);
while Dirs{end,end} == 0
    
    RootDirInd = find(~cell2mat(Dirs(:,2)),1);
    RootDir = Dirs{RootDirInd,1};
    
    if ~isempty(ls(RootDir))
        
        FolderContents = dir(RootDir);
        AllContentNames = {FolderContents(:).name}';
        
        BadContentNames = [{'.'},{'..'},{'.DS_Store'}];
        BadContentNameCheck = ismember(AllContentNames,BadContentNames);
        FolderContents = FolderContents(~BadContentNameCheck);
        
        ContentNames = {FolderContents(:).name}';
        ContentNames = cellfun(@(x) horzcat(RootDir,'/',x),ContentNames,'UniformOutput',0);
        
        [FCPaths,FCFiles,FCExts] = cellfun(@(x) fileparts(x),ContentNames,'UniformOutput',0);
        NewDirCheck = [FolderContents(:).isdir]';
        NewCSVCheck = strcmp('.csv',FCExts);
        
        NewDirs = ContentNames(NewDirCheck);
        Dirs = [Dirs;[NewDirs,num2cell(zeros(length(NewDirs),1))]];
        
        NewCSVs = ContentNames(NewCSVCheck);
        CSVFiles = [CSVFiles;NewCSVs];
        
    end
    
    Dirs{RootDirInd,2} = 1;
    
    test = 1;
    
end

CSVFilesCheck = 1;
Variables = who;
CSVFilesCheck = ~strcmp(Variables,'CSVFiles');
clear(Variables{CSVFilesCheck});
clear Variables;

test = 1;

hbar = waitbar(0,'Initiate processing');
hbarObjs = findall(hbar);
hbarTitle = hbarObjs(5);
set(hbarTitle,'HorizontalAlignment','left',...
    'Interpreter','none',...
    'Position',[15 1.23333 1.00005])

for i = 1:length(CSVFiles)
    
    CSVPathParts = textscan(CSVFiles{i},'%s','Delimiter','/');
    CSVPathParts = CSVPathParts{1};
    
    SampleID = CSVPathParts{10}(8:end);
    
    waitbar(i/length(CSVFiles),hbar,...
        horzcat('Processing file ',int2str(i),'/',int2str(length(CSVFiles)),':   ',CSVPathParts{end-1},'/',CSVPathParts{end}));
    
    SampleFolder = horzcat('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM Matlab Analysis_ILimited/',SampleID);
    mkdir(SampleFolder)
    
    File = importdata(CSVFiles{i});
    
    Headers = File.textdata;
    xData = File.data(1,:)';
    yData = File.data(2:end,:)';
    clear File;
    
    yData(abs(yData)>=40e-9) = NaN;
    

    nSpectra = size(yData,2);
    
    %     2. Get mean spectrum
    yMean = mean(yData,2);
    
    
    %     3. Fit, export data and plot with data scatter and fit line
    FitParams = NaN(nSpectra,8);
    
    kT = 0.026;
    pv = 5e-9;
    pc = 5e-9;
    EfmEv = 0.15;
    EfmEc = -0.15;
    Ef = kT*(log(exp(EfmEv/kT)+1)-(pc/pv)*(log(exp(EfmEc/kT)+1)-1));
    
    yModel=kT*(pv*((xData+Ef)/kT-log(exp((xData+EfmEv)/kT)+1))+pc*(log(exp((xData+EfmEc)/kT)+1)-1));
    
    Model = @(a,x)(exp(a(1)*(x-a(2)))-exp(a(3)*(x-a(4)))+a(5)*x+a(6));
    
    a0 = [5,4.5,-5,-4.5,0,0];
    try Beta0 = nlinfit(xData,yMean,Model,a0);
        GoodAvgFit = 1;
    catch
        Beta0 = a0;
        GoodAvgFit = 0;
    end
    
    DataPlot = figure('Visible','off');
    DPAxes = gca;
    scatter(DPAxes,xData,yMean);
    hold on;
    plot(DPAxes,xData,Model(Beta0,xData),'Color','r','LineWidth',1);
    xlabel('Bias (V)');
    ylabel('Current (A)');
    hold off;
    
    
    %     4. Write analyses with file name: SampleID_yy-mm-dd_hh:mm:ss_ExptType
    
    StdHeader = cell(4,1);
    StdHeader{1} = horzcat('Sample ID:', SampleID);
    StdHeader{2} = horzcat('Data acquired: ',...
        horzcat(Headers{1}(9:10),Headers{1}(4:5),Headers{1}(1:2),' ',Headers{1}(12:16)));
    StdHeader{3} = horzcat('nSpectra: ',int2str(nSpectra));
    StdHeader{4} = horzcat('Model: exp(a(1)*(x-a(2)))-exp(a(3)*(x-a(4)))+a(5)*x+a(6)');
    
    ExportIDTime = horzcat(SampleFolder,'/',...
        horzcat(Headers{1}(9:10),Headers{1}(4:5),Headers{1}(1:2),'_',Headers{1}(12:13),Headers{1}(15:16)));
    
    ExportFileName = horzcat(ExportIDTime,'_AvgPlot.jpg');
    print(DataPlot,'-djpeg',ExportFileName);
    
    ExportFileName = horzcat(ExportIDTime,'_AvgData.csv');
    WriteAvgData(ExportFileName,StdHeader,xData,yMean,Beta0,Model(Beta0,xData));
    
    close(DataPlot);
    
    
    if strcmp(ExportIDTime(end-20:end),'17-07-04_08-19-11-530')
        test = 1;
    end
    
    %     5. Refit individual spectra, export hist plot and hist data
    for j = 1:nSpectra;
        
        qGoodData = ~isnan(yData(:,j));
        
        try [ahat,r] = nlinfit(xData(qGoodData),yData(qGoodData,j),Model,a0);
            FitParams(j,:) = [ahat,log10(norm(r)),0];
        catch err
            %                 test = 1;
        end
        
    end
    
    FitParams(isnan(FitParams(:,1)),:) = [];
    
    Ef = (log(FitParams(:,3).^2)-log(FitParams(:,1).^2)...
        +FitParams(:,1).*FitParams(:,2)-FitParams(:,3).*FitParams(:,4))...
        ./(FitParams(:,1)-FitParams(:,3));
    FitParams(:,end) = Ef;
    
    EfTest = or(Ef < min(xData), Ef > max(xData));
    FitParams(EfTest,:) = [];
    
    if ~isempty(FitParams(:,1))
        
        %     6. Write analyses with file name: SampleID_yymmdd_hh:mm:ss.mmm_ExptType
        
        HistPlot = figure('Visible','off');
        HPAxes = gca;
        hist(HPAxes,FitParams(:,end));
        
        ExportFileName = horzcat(ExportIDTime,'_HistPlot.jpg');
        print(HistPlot,'-djpeg',ExportFileName);
        
        ExportFileName = horzcat(ExportIDTime,'_HistData.csv');
        WriteHistData(ExportFileName,StdHeader,FitParams);
        
        close(DataPlot);
        
        
        %     7. Write file with Date/Time, Mean, Quartiles
        
        EfStats = prctile(FitParams(:,end),[0,25,50,75,100]);    
        ExportFileName = horzcat(ExportIDTime,'_TimeEfStats.csv');
        WriteTimeEfStats(ExportFileName,StdHeader,EfStats);
        
        test = 1;
        
    end
    
    
    
    test = 1;
    
    
end

test = 1;

close(hbar);

beep;
beep;


function WriteAvgData(ExportFileName,StdHeader,xData,yMean,Beta0,ModelData)

File = fopen(ExportFileName,'w+');
for i = 1:length(StdHeader)
    fprintf(File,'%s\n',StdHeader{i});
end
fprintf(File,'Params "a" for Avg: %6e, %6e, %6e, %6e, %6e, %6e\n', Beta0(1),Beta0(2),Beta0(3),Beta0(4),Beta0(5),Beta0(6));
fprintf(File,'\nBias(V),Mean Current Data(I),Model Fit(I)\n');
fclose(File);
DataMatrix = [xData,yMean,ModelData];
dlmwrite(ExportFileName,DataMatrix,'-append','precision','%6e');
test = 1;


function WriteHistData(ExportFileName,StdHeader,FitParams)

File = fopen(ExportFileName,'w+');
for i = 1:length(StdHeader)
    fprintf(File,'%s\n',StdHeader{i});
end
fprintf(File,'\nB+,x0+,B-,x0-,m,y0,Error,Ef\n');
fclose(File);
dlmwrite(ExportFileName,FitParams,'-append','precision','%6e');
test = 1;


function WriteTimeEfStats(ExportFileName,StdHeader,EfStats)
File = fopen(ExportFileName,'w+');
for i = 1:length(StdHeader)
    fprintf(File,'%s\n',StdHeader{i});
end
fprintf(File,'\nDate/Time,Min,Q1,Median,Q3,Max\n');
fprintf(File,'%s',StdHeader{2}(end-11:end));
for i = 1:length(EfStats)
    fprintf(File,',%6e',EfStats(i));
end
fclose(File);
test = 1;



