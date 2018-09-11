function varargout = dIdVAnalyzerGUI(varargin)
% DIDVANALYZERGUI MATLAB code for dIdVAnalyzerGUI.fig
%      DIDVANALYZERGUI, by itself, creates a new DIDVANALYZERGUI or raises the existing
%      singleton*.
%
%      H = DIDVANALYZERGUI returns the handle to a new DIDVANALYZERGUI or the handle to
%      the existing singleton*.
%
%      DIDVANALYZERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIDVANALYZERGUI.M with the given input arguments.
%
%      DIDVANALYZERGUI('Property','Value',...) creates a new DIDVANALYZERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dIdVAnalyzerGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dIdVAnalyzerGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dIdVAnalyzerGUI

% Last Modified by GUIDE v2.5 23-Jan-2017 05:24:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @dIdVAnalyzerGUI_OpeningFcn, ...
    'gui_OutputFcn',  @dIdVAnalyzerGUI_OutputFcn, ...
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


% --- Executes just before dIdVAnalyzerGUI is made visible.
function dIdVAnalyzerGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dIdVAnalyzerGUI (see VARARGIN)

% Choose default command line output for dIdVAnalyzerGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dIdVAnalyzerGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dIdVAnalyzerGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadSpectraButton.
function LoadSpectraButton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadSpectraButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global STSData;
STSData = struct;

if get(handles.CheckLastSpectra,'Value')
    LastSpectraFile = fopen('/Users/averygreen/Documents/MATLAB/Projects/STS/dIdVAnalyzer/GUI/LastSpectra.txt');
    SpectraFile = textscan(LastSpectraFile,'%s','Delimiter','\n');
    fclose(LastSpectraFile);
    SpectraFile = SpectraFile{1}{1};
    
    S = importdata(SpectraFile,' ',3);
    
else
    [FileName, PathName] = uigetfile('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM/*.txt','Select STS .txt data');
    SpectraFile = horzcat(PathName,FileName);
    S = importdata(SpectraFile,' ',3);
    
    oldfolder = cd('/Users/averygreen/Documents/MATLAB/Projects/STS/dIdVAnalyzer/GUI');
    LastSpectraFile = fopen('LastSpectra.txt','w');
    fprintf(LastSpectraFile,'%s',horzcat(PathName,FileName));
    fclose(LastSpectraFile);
    cd(oldfolder);
end

[pathstr, name, ext] = fileparts(SpectraFile);
set(handles.StaticFileName,'String',horzcat('File: ',name,ext));

for i = 1:size(S.data,2)/2;
    STSData(i).xData = S.data(:,i*2-1);
    STSData(i).yData = S.data(:,i*2);
    
    STSData(i).FileName = horzcat(pathstr,'/',name,'_',int2str(i),ext);
end
clear S;

Spectra = 1:1:length(STSData);
SpecRow = floor((Spectra-1)/sqrt(length(Spectra)))+1;
SpecCol = mod(Spectra-1,sqrt(length(Spectra)))+1;
SpecPos = [SpecRow;SpecCol];
SpecPos = cellstr(num2str(SpecPos'));
set(handles.ListboxSpectra,'String',SpecPos);
set(handles.ListboxSpectra,'Min',0);
set(handles.ListboxSpectra,'Max',length(STSData));

STSData = DoModel(handles);
Plot2D(handles);
Plot3D(handles);

test = 1;


function EditDiffPts_Callback(hObject, eventdata, handles)
% hObject    handle to EditDiffPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditDiffPts as text
%        str2double(get(hObject,'String')) returns contents of EditDiffPts as a double

val = str2double(get(hObject,'String'));
if val<1
    val=1;
else
    val = ceil(val/2)*2-1;
end
set(hObject,'String',num2str(val,1));

global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end


% --- Executes during object creation, after setting all properties.
function EditDiffPts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditDiffPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditFitRange_Callback(hObject, eventdata, handles)
% hObject    handle to EditFitRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditFitRange as text
%        str2double(get(hObject,'String')) returns contents of EditFitRange as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditFitRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditFitRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditErrorMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditErrorMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditErrorMax as text
%        str2double(get(hObject,'String')) returns contents of EditErrorMax as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditErrorMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditErrorMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditCurvMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditCurvMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditCurvMin as text
%        str2double(get(hObject,'String')) returns contents of EditCurvMin as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditCurvMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditCurvMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditHistBins_Callback(hObject, eventdata, handles)
% hObject    handle to EditHistBins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditHistBins as text
%        str2double(get(hObject,'String')) returns contents of EditHistBins as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditHistBins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditHistBins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditCurvMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditCurvMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditCurvMax as text
%        str2double(get(hObject,'String')) returns contents of EditCurvMax as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditCurvMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditCurvMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditXPlotMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditXPlotMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXPlotMin as text
%        str2double(get(hObject,'String')) returns contents of EditXPlotMin as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditXPlotMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXPlotMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EditXPlotMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditXPlotMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXPlotMax as text
%        str2double(get(hObject,'String')) returns contents of EditXPlotMax as a double
global STSData;

if isstruct(STSData);
    Plot2D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditXPlotMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXPlotMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditYPlotMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditYPlotMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYPlotMin as text
%        str2double(get(hObject,'String')) returns contents of EditYPlotMin as a double
global STSData;

if isstruct(STSData);
    Plot2D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditYPlotMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditYPlotMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditYPlotMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditYPlotMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYPlotMax as text
%        str2double(get(hObject,'String')) returns contents of EditYPlotMax as a double
global STSData;

if isstruct(STSData);
    Plot2D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditYPlotMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditYPlotMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CheckAutoX.
function CheckAutoX_Callback(hObject, eventdata, handles)
% hObject    handle to CheckAutoX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckAutoX
global STSData;

if isstruct(STSData);
    Plot2D(handles);
end

% --- Executes on button press in CheckAutoY.
function CheckAutoY_Callback(hObject, eventdata, handles)
% hObject    handle to CheckAutoY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckAutoY
global STSData;

if isstruct(STSData);
    Plot2D(handles);
end


function Plot2D(handles)

global STSData;

%Check which plot type is selected
spect = get(handles.ListboxSpectra,'Value');
spect = spect(end);
qnHist = [get(handles.RadiodIdV,'Value'),...
    get(handles.RadioMinFinder,'Value'),...
    get(handles.RadioErrorCurv,'Value')];
if any(qnHist)
    if qnHist(1)
        plot(handles.Axes2D,STSData(spect).xData,STSData(spect).yData,'LineWidth',2);
        LimitPlot(handles);
        if get(handles.CheckDisplayFit,'Value')
            hold(handles.Axes2D,'all');
            plot(handles.Axes2D,STSData(spect).xReduced,STSData(spect).yPoly,...
                'LineWidth',3,'LineStyle','--','Color','r')
            if get(handles.CheckXFitLimit,'Value')
                AxesYLims = get(handles.Axes2D,'YLim');
                plot(handles.Axes2D,...
                    [str2double(get(handles.EditXFitMin,'String')),...
                    str2double(get(handles.EditXFitMin,'String'))],...
                    [AxesYLims(1),AxesYLims(2)],...
                    'LineWidth',1,'LineStyle','--','Color','k');
                plot(handles.Axes2D,...
                    [str2double(get(handles.EditXFitMax,'String')),...
                    str2double(get(handles.EditXFitMax,'String'))],...
                    [AxesYLims(1),AxesYLims(2)],...
                    'LineWidth',1,'LineStyle','--','Color','k');
            end
            if get(handles.CheckYFitLimit,'Value')
                AxesXLims = get(handles.Axes2D,'XLim');
                plot(handles.Axes2D,...
                    [AxesXLims(1),AxesXLims(2)],...
                    [str2double(get(handles.EditYFitMin,'String')),...
                    str2double(get(handles.EditYFitMin,'String'))],...
                    'LineWidth',1,'LineStyle','--','Color','k');
                plot(handles.Axes2D,...
                    [AxesXLims(1),AxesXLims(2)],...
                    [str2double(get(handles.EditYFitMax,'String')),...
                    str2double(get(handles.EditYFitMax,'String'))],...
                    'LineWidth',1,'LineStyle','--','Color','k');
            end
            hold(handles.Axes2D,'off');
        end
        xlabel(handles.Axes2D,'Bias (V)');
        ylabel(handles.Axes2D,'dI/dV (nA/V)');
        title(handles.Axes2D,strcat(...
            'Ed-Ef: ',num2str(STSData(spect).EdX),...
            '   Curvature: ',num2str(STSData(spect).Curvature),...
            '   Error: ',num2str(STSData(spect).Error),...
            '   Valid: ',STSData(spect).ValidEd));
    elseif qnHist(2)
        test = 1;
        plot(handles.Axes2D,STSData(spect).xData,STSData(spect).dydxData,'LineWidth',2)
        LimitPlot(handles);
        xlabel(handles.Axes2D,'Bias (V)');
        ylabel(handles.Axes2D,'d^2I/dV^2 (nA/V^2)');
        title(handles.Axes2D,strcat(...
            'Ed-Ef: ',num2str(STSData(spect).EdX),...
            '   Curvature: ',num2str(STSData(spect).Curvature),...
            '   Error: ',num2str(STSData(spect).Error),...
            '   Valid: ',STSData(spect).ValidEd));
    elseif qnHist(3)
        test = 1;
        Error = [STSData(:).Error];
        Curvature = [STSData(:).Curvature];
        if get(handles.CheckValidEd,'Value')
            ValidSpecs = strcmp({STSData(:).ValidEd},'Yes');
            Error = Error(ValidSpecs);
            Curvature = Curvature(ValidSpecs);
        end
        scatter(handles.Axes2D,Curvature,Error);
        LimitPlot(handles);
        xlabel(handles.Axes2D,'Quadratic Fit Curvature');
        ylabel(handles.Axes2D,'Error');
    end
end

qHist = [get(handles.RadioHistogram,'Value'),...
    get(handles.RadioErrorHist,'Value'),...
    get(handles.RadioCurvHist,'Value')];
if any(qHist)
    
    if qHist(1) == 1
        HistData = [STSData(:).EdX];
    elseif qHist(2)==1
        HistData = [STSData(:).Error];
    elseif qHist(3)==1
        HistData = [STSData(:).Curvature];
    end
    
    if get(handles.CheckValidEd,'Value')
        ValidSpecs = strcmp({STSData(:).ValidEd},'Yes');
        HistData = HistData(ValidSpecs);
    end  
    
    if ~get(handles.CheckAutoHistBins,'Value')
        hist(handles.Axes2D,HistData,str2double(get(handles.EditHistBins,'String')));
    else
        hist(handles.Axes2D,HistData);
    end
    LimitPlot(handles);
    
    [mu,sig] = normfit(HistData);
        HistGauss = normpdf(linspace(min(get(handles.Axes2D,'xlim')),...
            max(get(handles.Axes2D,'xlim')),100),mu,sig);
        HistGauss = HistGauss/max(HistGauss);
        
        hpatch = findobj(handles.Axes2D,'Type','patch');
        Vertices = get(hpatch,'Vertices');
        ymax = max(Vertices(:,2));
        HistGauss = HistGauss*ymax;
        hold(handles.Axes2D,'on')
        plot(handles.Axes2D,linspace(min(get(handles.Axes2D,'xlim')),...
            max(get(handles.Axes2D,'xlim')),100),HistGauss);
        hold(handles.Axes2D,'off');

    xlabel(handles.Axes2D,'E_d-E_f (eV)');
    ylabel(handles.Axes2D,'# Spectra');
end

test = 1;

function LimitPlot(handles)

if ~get(handles.CheckAutoX,'Value')
    set(handles.Axes2D,'XLim',...
        [str2double(get(handles.EditXPlotMin,'String')),...
        str2double(get(handles.EditXPlotMax,'String'))])
end
if ~get(handles.CheckAutoY,'Value')
    set(handles.Axes2D,'YLim',...
        [str2double(get(handles.EditYPlotMin,'String')),...
        str2double(get(handles.EditYPlotMax,'String'))])
end


% --- Executes on button press in CheckAutoHistBins.
function CheckAutoHistBins_Callback(hObject, eventdata, handles)
% hObject    handle to CheckAutoHistBins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckAutoHistBins
global STSData;
if isstruct(STSData);
    Plot2D(handles);
end

% --- Executes when selected object is changed in Panel2DPlotType.
function Panel2DPlotType_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel2DPlotType
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

global STSData;
if isstruct(STSData);
    Plot2D(handles);
end

%---------------------------
function ShowLocation(handles)
%---------------------------


% --- Executes when selected object is changed in Panel3DPlotType.
function Panel3DPlotType_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in Panel3DPlotType
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global STSData;
if isstruct(STSData);
    Plot3D(handles);
end


function Plot3D(handles)
global STSData;

test = 1;

MapDim = sqrt(length(STSData));

if get(handles.RadioEdEfMap,'Value')
    MapData = [STSData.EdX];
elseif get(handles.RadioErrorMap,'Value')
    MapData = [STSData.Error];
else
    MapData = [STSData.Curvature];
    
end
MapData = reshape(MapData,MapDim,MapDim);
% MapData = MapData';

if get(handles.CheckValidEd,'Value')
    ValidMapData = {STSData.ValidEd};
    ValidMapData = reshape(ValidMapData,MapDim,MapDim);
    %     ValidMapData = ValidMapData';
    
    ValidMapData = strcmp(ValidMapData,'Yes');
    MapData(~ValidMapData) = NaN;
end

if get(handles.CheckAutoZ,'Value')==0
    MapData(MapData<str2double(get(handles.EditZMin,'String'))) = NaN;
    MapData(MapData>str2double(get(handles.EditZMax,'String'))) = NaN;
end

if and(any(any(isnan(MapData))),~all(all(isnan(MapData))));
    MapData = inpaintn(MapData);
end

[MapX,MapY] = ndgrid(1:1:MapDim,1:1:MapDim);
if MapDim>=4
    F = griddedInterpolant(MapX,MapY,MapData,'cubic');
elseif MapDim >=2
    F = griddedInterpolant(MapX,MapY,MapData);
end
[MapX,MapY] = ndgrid(linspace(1,MapDim,101),linspace(1,MapDim,101));
MapData = F(MapX,MapY);

if get(handles.CheckAutoZ,'Value')
    contourf(handles.Axes3D,MapX,MapY,MapData,20,'LineStyle','none')
else
    contourf(handles.Axes3D,MapX,MapY,MapData,linspace(...
        str2double(get(handles.EditZMin,'String')),...
        str2double(get(handles.EditZMax,'String')),...
        21),'LineStyle','none')
end
xlabel(handles.Axes3D,'X Position (INDEX, NOT REAL SPACE VALUE)');
ylabel(handles.Axes3D,'Y Position (INDEX, NOT REAL SPACE VALUE)');

colorbar('peer',handles.Axes3D);

test = 1;



function EditZMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditZMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditZMin as text
%        str2double(get(hObject,'String')) returns contents of EditZMin as a double
global STSData;

if isstruct(STSData);
    Plot3D(handles);
end


% --- Executes during object creation, after setting all properties.
function EditZMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditZMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditZMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditZMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditZMax as text
%        str2double(get(hObject,'String')) returns contents of EditZMax as a double
global STSData;

if isstruct(STSData);
    Plot3D(handles);
end


% --- Executes during object creation, after setting all properties.
function EditZMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditZMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CheckAutoZ.
function CheckAutoZ_Callback(hObject, eventdata, handles)
% hObject    handle to CheckAutoZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckAutoZ
global STSData;

if isstruct(STSData);
    Plot3D(handles);
end


% --- Executes on selection change in ListboxSpectra.
function ListboxSpectra_Callback(hObject, eventdata, handles)
% hObject    handle to ListboxSpectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ListboxSpectra contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ListboxSpectra
global STSData;

if isstruct(STSData);
    Plot2D(handles);
end

% --- Executes during object creation, after setting all properties.
function ListboxSpectra_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MapDim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CheckValidEd.
function CheckValidEd_Callback(hObject, eventdata, handles)
% hObject    handle to CheckValidEd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckValidEd
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end


% --- Executes on button press in CheckLastSpectra.
function CheckLastSpectra_Callback(hObject, eventdata, handles)
% hObject    handle to CheckLastSpectra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckLastSpectra


% --- Executes when selected object is changed in PanelBiasDir.
function PanelBiasDir_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in PanelBiasDir
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

function NewData = DoModel(handles)
global STSData;

NewData = Modeler(STSData,...
    str2double(get(handles.EditDiffPts,'String')),...
    str2double(get(handles.EditFitRange,'String')),...
    str2double(get(handles.EditErrorMax,'String')),...
    [str2double(get(handles.EditCurvMin,'String')),str2double(get(handles.EditCurvMax,'String'))],...
    get(handles.RadioPosBias,'Value'),...
    get(handles.CheckXFitLimit,'Value'),...
    [str2double(get(handles.EditXFitMin,'String')),str2double(get(handles.EditXFitMax,'String'))],...
    get(handles.CheckYFitLimit,'Value'),...
    [str2double(get(handles.EditYFitMin,'String')),str2double(get(handles.EditYFitMax,'String'))]);


% --- Executes on button press in CheckXFitLimit.
function CheckXFitLimit_Callback(hObject, eventdata, handles)
% hObject    handle to CheckXFitLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckXFitLimit
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end



function EditXFitMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditXFitMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXFitMin as text
%        str2double(get(hObject,'String')) returns contents of EditXFitMin as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditXFitMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXFitMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditXFitMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditXFitMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXFitMax as text
%        str2double(get(hObject,'String')) returns contents of EditXFitMax as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end


% --- Executes during object creation, after setting all properties.
function EditXFitMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXFitMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PushExportSpectrum.
function PushExportSpectrum_Callback(hObject, eventdata, handles)
% hObject    handle to PushExportSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global STSData;

if isstruct(STSData)
    
    test = 1;
    ActiveSpec = get(handles.ListboxSpectra(1),'Value');
    [pathstr, name, ext] = fileparts(STSData(ActiveSpec(1)).FileName);
    
    if ~isdir(horzcat(pathstr,'/Spectra'))
        mkdir(horzcat(pathstr,'/Spectra'));
    end
    
    for i = 1:length(ActiveSpec)
        [pathstr, name, ext] = fileparts(STSData(ActiveSpec(i)).FileName);
        yExport = STSValid(i).yData;
        if get(handles.CheckNegative,'Value')
            yExport = -1*STSData(ActiveSpec(i)).yData;
        end
        if get(handles.CheckPlus10,'Value')
            yExport = 10+STSData(ActiveSpec(i)).yData;
        end
        csvwrite(horzcat(pathstr,'/Spectra/',name,'.csv'),[STSData(ActiveSpec(i)).xData,yExport]);
    end
    
end

test = 1;


% --- Executes on button press in CheckDisplayFit.
function CheckDisplayFit_Callback(hObject, eventdata, handles)
% hObject    handle to CheckDisplayFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckDisplayFit
global STSData;

if isstruct(STSData)
    Plot2D(handles);
end

% --- Executes on button press in PushExportValid.
function PushExportValid_Callback(hObject, eventdata, handles)
% hObject    handle to PushExportValid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global STSData;

if isstruct(STSData)
    test = 1;
    ValidSpecs = strcmp({STSData(:).ValidEd},'Yes');
    STSValid = STSData(ValidSpecs);
    [pathstr, name, ext] = fileparts(STSValid(1).FileName);
    
    if ~isdir(horzcat(pathstr,'/Spectra'))
        mkdir(horzcat(pathstr,'/Spectra'));
    end
    
    for i = 1:length(STSValid)
        [pathstr, name, ext] = fileparts(STSValid(i).FileName);
        yExport = STSValid(i).yData;
        if get(handles.CheckNegative,'Value')
            yExport = -1*yExport;
        end
        if get(handles.CheckPlus10,'Value')
            yExport = 10+yExport;
        end
        csvwrite(horzcat(pathstr,'/Spectra/',name,'.csv'),[STSValid(i).xData,yExport]);
    end
end

test = 1;


% --- Executes on button press in CheckNegative.
function CheckNegative_Callback(hObject, eventdata, handles)
% hObject    handle to CheckNegative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckNegative


% --- Executes on button press in CheckPlus10.
function CheckPlus10_Callback(hObject, eventdata, handles)
% hObject    handle to CheckPlus10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckPlus10


% --- Executes on button press in PushExportHist.
function PushExportHist_Callback(hObject, eventdata, handles)
% hObject    handle to PushExportHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global STSData;

if isstruct(STSData)
    test = 1;
    ValidSpecs = strcmp({STSData(:).ValidEd},'Yes');
    EdValid = [STSData(ValidSpecs).EdX];
    
    [pathstr, name, ext] = fileparts(STSData(find(ValidSpecs,1,'first')).FileName);
    NameParts = textscan(name,'%s','Delimiter','_');
    NameParts = NameParts{1};
    ScanName = NameParts{1};
    for i = 1:length(NameParts)-2
        ScanName = horzcat(ScanName,'_',NameParts{i+1});
    end
    
    csvwrite(horzcat(pathstr,'/',ScanName,'_','Hist.csv'),EdValid');
    
    test = 1;
    
end



function EditYFitMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditYFitMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYFitMin as text
%        str2double(get(hObject,'String')) returns contents of EditYFitMin as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditYFitMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditYFitMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in CheckYFitLimit.
function CheckYFitLimit_Callback(hObject, eventdata, handles)
% hObject    handle to CheckYFitLimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckYFitLimit
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end


function EditYFitMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditYFitMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYFitMax as text
%        str2double(get(hObject,'String')) returns contents of EditYFitMax as a double
global STSData;

if isstruct(STSData)
    STSData = DoModel(handles);
    Plot2D(handles);
    Plot3D(handles);
end

% --- Executes during object creation, after setting all properties.
function EditYFitMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditYFitMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
