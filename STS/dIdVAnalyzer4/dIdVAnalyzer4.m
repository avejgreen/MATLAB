function varargout = dIdVAnalyzer4(varargin)
% DIDVANALYZER4 MATLAB code for dIdVAnalyzer4.fig
%      DIDVANALYZER4, by itself, creates a new DIDVANALYZER4 or raises the existing
%      singleton*.
%
%      H = DIDVANALYZER4 returns the handle to a new DIDVANALYZER4 or the handle to
%      the existing singleton*.
%
%      DIDVANALYZER4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIDVANALYZER4.M with the given input arguments.
%
%      DIDVANALYZER4('Property','Value',...) creates a new DIDVANALYZER4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dIdVAnalyzer4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dIdVAnalyzer4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dIdVAnalyzer4

% Last Modified by GUIDE v2.5 06-Apr-2017 18:11:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @dIdVAnalyzer4_OpeningFcn, ...
    'gui_OutputFcn',  @dIdVAnalyzer4_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before dIdVAnalyzer4 is made visible.
function dIdVAnalyzer4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dIdVAnalyzer4 (see VARARGIN)

% Choose default command line output for dIdVAnalyzer4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dIdVAnalyzer4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dIdVAnalyzer4_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ButtonImport.
function ButtonImport_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonImport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.AxesD0);
cla(handles.AxesD1);

global Spectra

if isfield(Spectra,'PathName');
    Path = horzcat(Spectra.PathName,'/*.txt');
else
    Path = '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/040417 Rd3_2/*.txt';
end

Spectra = struct;
[FileName,PathName,FilterIndex] = uigetfile(...
    Path,'Choose spectra text file(s)','MultiSelect','off');

if FileName == 0
else
    
    if strcmp(PathName(1:69),'/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/')
        StaticSpectraString = horzcat('.../',PathName(70:end),FileName);
    else
        StaticSpectraString=horzcat(PathName,FileName);
    end
    set(handles.StaticSpectraFile,'String',StaticSpectraString);
    
    [A, delimiter, nheaderlines] = importdata(horzcat(PathName,FileName),' ',3);
    test = 1;
    Spectra.data = A.data;
    Spectra.x = A.data(:,1:2:end);
    Spectra.D0 = A.data(:,2:2:end);
    Spectra.D1 = Differentiate(Spectra.x,Spectra.D0);
    Spectra.textdata = A.textdata;
    Spectra.colheaders = A.colheaders;
    Spectra.delimiter = delimiter;
    Spectra.nheaderlines = nheaderlines;
    Spectra.PathName = PathName;
    Spectra.FileName = FileName;
    
    SelectedSpectrum = get(handles.ListSpectra,'Value');
    if SelectedSpectrum > size(Spectra.x,2)
        SelectedSpectrum = size(Spectra.x,2);
    end
    set(handles.ListSpectra,'Value',SelectedSpectrum);
    
    %Operate on first opened file for now
    List1 = cell(size(Spectra.x,2),1);
    List2 = cell(size(Spectra.x,2),1);
    List1(:) = {'Spec '};
    List2(:) = num2cell(uint16(1:size(Spectra.x,2)))';
    List2 = cellfun(@int2str,List2,'UniformOutput',0);
    List = cellfun(@horzcat,List1,List2,'UniformOutput',0);
    
    set(handles.ListSpectra,'String',List);
    
    D0Plotter(handles);
    D1Plotter(handles);
    
    test = 1;
    
end

% --- Executes on selection change in ListSpectra.
function ListSpectra_Callback(hObject, eventdata, handles)
% hObject    handle to ListSpectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListSpectra contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListSpectra
D0Plotter(handles);
D1Plotter(handles);

% --- Executes during object creation, after setting all properties.
function ListSpectra_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ListSpectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ButtonSmoothMF.
function ButtonSmoothMF_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSmoothMF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Spectra;

AverageSpectra;
% Spectra.D1Smooth = Differentiate(Spectra.x,Spectra.D0Smooth);

D0Plotter(handles);
D1Plotter(handles);


% --- Executes on button press in ButtonSmoothSG.
function ButtonSmoothSG_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonSmoothSG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Spectra;

SmoothSG;
Spectra.D1Smooth = Differentiate(Spectra.x,Spectra.D0Smooth);

D0Plotter(handles);
D1Plotter(handles);

% --- Executes on button press in ButtonFit.
function ButtonFit_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FitQuad;

D1Plotter(handles);

test = 1;


function D0Plotter(handles)
global Spectra;

cla(handles.AxesD0);
Colors = get(gca,'ColorOrder');

SpecPlots = get(handles.ListSpectra,'Value');

if isfield(Spectra,'D0Smooth')
    PlotData = Spectra.D0Smooth;
else
    PlotData = Spectra.D0;
end

hold(handles.AxesD0,'on');
for i = 1:length(SpecPlots)
    plot(handles.AxesD0,...
        Spectra.x(:,SpecPlots(i)),...
        PlotData(:,SpecPlots(i)),...
        'Color',Colors(mod(i-1,size(Colors,1))+1,:),...
        'LineWidth',1.5);
end
hold(handles.AxesD0,'off');
% set(handles.AxesD0,'XLim',[-.2,.2]);

xlabel(handles.AxesD0,'Bias [V]','FontName','Arial','FontSize',12);
ylabel(handles.AxesD0,'Current [A]','FontName','Arial','FontSize',12);
title(handles.AxesD0,'IV Spectra','FontName','Arial','FontSize',14);

test = 1;


function D1Plotter(handles)
global Spectra;
cla(handles.AxesD1);

% Figure out which D1 chart type is active, classify type
if get(handles.RadiodIdV,'Value')
    ChartType1 = 'dIdV';
    XStr = 'Bias [V]'; YStr = 'dI/dV [A/V]'; TitleStr = 'dI/dV Spectra';
elseif get(handles.RadioPlotXY,'Value')
    ChartType1 = 'Plot';
    ChartType2 = 'XY';
    XStr = 'Fit Vertex X Position [V]'; YStr = 'Fit Vertex Y Position [A/V]'; TitleStr = 'Fit Vertex Positions';
elseif get(handles.RadioPlotCurvError,'Value')
    ChartType1 = 'Plot';
    ChartType2 = 'CurvError';
    XStr = 'Fit Curvature'; YStr = 'Fit Error/Curvature'; TitleStr = 'Fit Curvature, Error/Curvature';
elseif get(handles.RadioHistX,'Value')
    ChartType1 = 'Hist';
    ChartType2 = 'X';
    XStr = 'Fit Vertex X Position [V]'; YStr = 'Counts'; TitleStr = 'Fit X Position';
elseif get(handles.RadioHistY,'Value')
    ChartType1 = 'Hist';
    ChartType2 = 'Y';
    XStr = 'Fit Vertex Y Position [A/V]'; YStr = 'Counts'; TitleStr = 'Fit Y Position';
elseif get(handles.RadioHistCurv,'Value')
    ChartType1 = 'Hist';
    ChartType2 = 'Curv';
    XStr = 'Fit Curvature'; YStr = 'Counts'; TitleStr = 'Fit Curvature';
elseif get(handles.RadioHistError,'Value')
    ChartType1 = 'Hist';
    ChartType2 = 'Error';
    XStr = 'Fit Error/Curvature'; YStr = 'Counts'; TitleStr = 'Fit Error/Curvature';
end

% Get data based on chart type, throw to plotter
if strcmp(ChartType1,'dIdV')
    
    if isfield(Spectra,'D1Smooth')
        PlotX = Spectra.x;
        PlotData = Spectra.D1Smooth;
    else
        PlotX = Spectra.x;
        PlotData = Spectra.D1;       
    end
    D1DodIdV(handles,PlotX,PlotData,'Data')
    
    if isfield(Spectra,'FitX')
        PlotX = Spectra.FitX;
        PlotData = Spectra.FitData;
        D1DodIdV(handles,PlotX,PlotData,'Fit')
        
        SpecPlots = get(handles.ListSpectra,'Value');
        if length(SpecPlots)==1
            if isfield(Spectra,'FitValid')
                if Spectra.FitValid(SpecPlots)
                    ValidText = 'Yes';
                else
                    ValidText = 'No';
                end
                hold(handles.AxesD1,'on');
                text(.5,.9,sprintf('Valid: %s\nCurv: %0.3e\nE/C: %0.3e' ,...
                    ValidText,...
                    Spectra.FitPolys(1,SpecPlots),...
                    Spectra.FitError(1,SpecPlots)),...
                    'HorizontalAlignment','center',...
                    'Units','normalized',...
                    'Parent',handles.AxesD1);
                hold(handles.AxesD1,'off');
            else
                hold(handles.AxesD1,'on');
                text(.5,.9,sprintf('Curv: %0.3e\nE/C: %0.3e' ,...
                    Spectra.FitPolys(1,SpecPlots),...
                    Spectra.FitError(1,SpecPlots)),...
                    'HorizontalAlignment','center',...
                    'Units','normalized',...
                    'Parent',handles.AxesD1);
                hold(handles.AxesD1,'off');
            end
        end
    end
    
elseif strcmp(ChartType1,'Plot')
    if isfield(Spectra,'FitX');
        if strcmp(ChartType2,'XY');
            PlotX = Spectra.FitPosition(1,:);
            PlotData = Spectra.FitPosition(2,:);            
        elseif strcmp(ChartType2,'CurvError');
            PlotX = Spectra.FitPolys(1,:);
            PlotData = Spectra.FitError;
        end
        if isfield(Spectra,'FitValid')
            PlotX = PlotX(Spectra.FitValid);
            PlotData = PlotData(Spectra.FitValid);
        end
        scatter(handles.AxesD1,PlotX,PlotData,'LineWidth',1.5);
    end
    
elseif strcmp(ChartType1,'Hist')
    if isfield(Spectra,'FitX');
        if strcmp(ChartType2,'X')
            PlotData = Spectra.FitPosition(1,:);
        elseif strcmp(ChartType2,'Y')
            PlotData = Spectra.FitPosition(2,:);
        elseif strcmp(ChartType2,'Curv')
            PlotData = Spectra.FitPolys(1,:);
        elseif strcmp(ChartType2,'Error')
            PlotData = Spectra.FitError;
        end
        if isfield(Spectra,'FitValid')
            PlotData = PlotData(Spectra.FitValid);
        end
        hist(handles.AxesD1,PlotData)
    end
end

xlabel(handles.AxesD1,XStr,'FontName','Arial','FontSize',12);
ylabel(handles.AxesD1,YStr,'FontName','Arial','FontSize',12);
title(handles.AxesD1,TitleStr,'FontName','Arial','FontSize',14);

test = 1;


% --- Executes when selected object is changed in PanelChartType.
function PanelChartType_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in PanelChartType
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

D1Plotter(handles);


function D1DodIdV(handles,PlotX,PlotData,DataOrFit)

if strcmp(DataOrFit,'Data')
    Width = .5;
    Style = '-';
else
    Width = 1.5;
    Style = ':';
end

Colors = get(gca,'ColorOrder');
SpecPlots = get(handles.ListSpectra,'Value');

hold(handles.AxesD1,'on');
for i = 1:length(SpecPlots)
    plot(handles.AxesD1,...
        PlotX(:,SpecPlots(i)),...
        PlotData(:,SpecPlots(i)),...
        'Color',Colors(mod(i-1,size(Colors,1))+1,:),...
        'LineWidth',Width,...
        'LineStyle',Style);
end

hold(handles.AxesD1,'off');
% set(handles.AxesD1,'XLim',[-.2,.2]);


% --- Executes on button press in ButtonCriteria.
function ButtonCriteria_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonCriteria (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Spectra;

FitCriteria;

OldList = get(handles.ListSpectra,'String');
if strcmp(OldList{1}(end),')')
    OldList = cellfun(@(x) x(1:end-6),OldList,'UniformOutput',0);
end


NewList = cell(size(OldList));
NewList(:) = {' - (N)'};
NewList(Spectra.FitValid) = {' - (Y)'};
NewList = cellfun(@horzcat,OldList,NewList,'UniformOutput',0);

set(handles.ListSpectra,'String',NewList);

D1Plotter(handles);

test = 1;


% --- Executes on button press in ButtonExport.
function ButtonExport_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonExport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

DataExporter;

test = 1;
