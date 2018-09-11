function varargout = dIdVAnalyzer2(varargin)
% DIDVANALYZER2 MATLAB code for dIdVAnalyzer2.fig
%      DIDVANALYZER2, by itself, creates a new DIDVANALYZER2 or raises the existing
%      singleton*.
%
%      H = DIDVANALYZER2 returns the handle to a new DIDVANALYZER2 or the handle to
%      the existing singleton*.
%
%      DIDVANALYZER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIDVANALYZER2.M with the given input arguments.
%
%      DIDVANALYZER2('Property','Value',...) creates a new DIDVANALYZER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dIdVAnalyzer2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dIdVAnalyzer2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dIdVAnalyzer2

% Last Modified by GUIDE v2.5 04-Apr-2017 18:19:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @dIdVAnalyzer2_OpeningFcn, ...
    'gui_OutputFcn',  @dIdVAnalyzer2_OutputFcn, ...
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


% --- Executes just before dIdVAnalyzer2 is made visible.
function dIdVAnalyzer2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dIdVAnalyzer2 (see VARARGIN)

% Choose default command line output for dIdVAnalyzer2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dIdVAnalyzer2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dIdVAnalyzer2_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ImportFilesButton.
function ImportFilesButton_Callback(hObject, eventdata, handles)
% hObject    handle to ImportFilesButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.D0Axes);
cla(handles.D1Axes);

global Spectra
Spectra = struct;
[FileName,PathName,FilterIndex] = uigetfile(...
    '/Users/averygreen/Documents/MATLAB/Projects/STS/dIdVAnalyzer2/IV/*.txt',...
    'Choose spectra text file(s)',...
    'MultiSelect','off');

if FileName == 0
else
    if iscell(FileName)
        for i = 1:length(FileName)
            test = 1;
            [A, delimiter, nheaderlines] = importdata(horzcat(PathName,FileName{i}),' ',3);
            Spectra(i).data = A.data;
            Spectra(i).x = A.data(:,1:2:end);
            Spectra(i).D0 = A.data(:,2:2:end);
            Spectra(i).D1 = Differentiate(A.data);
            Spectra(i).textdata = A.textdata;
            Spectra(i).colheaders = A.colheaders;
            Spectra(i).delimiter = delimiter;
            Spectra(i).nheaderlines = nheaderlines;
            Spectra(i).PathName = PathName;
            Spectra(i).FileName = FileName;
        end
    else
        [A, delimiter, nheaderlines] = importdata(horzcat(PathName,FileName),' ',3);
        test = 1;
        Spectra.data = A.data;
        Spectra.x = A.data(:,1:2:end);
        Spectra.D0 = A.data(:,2:2:end);
        Spectra.D1 = Differentiate(A.data);
        Spectra.textdata = A.textdata;
        Spectra.colheaders = A.colheaders;
        Spectra.delimiter = delimiter;
        Spectra.nheaderlines = nheaderlines;
        Spectra.PathName = PathName;
        Spectra.FileName = FileName;
    end
    
    %Operate on first opened file for now
    
    A=char(ones(size(Spectra(1).x,2),1)*double(uint16('Spectrum ')));
    B=int2str(uint16([1:1:size(Spectra(1).x,2)]'));
    C=cellstr(horzcat(A,B));
    
    set(handles.ListSpectra,'String',C);
    
    D0Plotter(handles);
    D1Plotter(handles);
    
    test = 1;
end


function D0Plotter(handles)
global Spectra;

cla(handles.D0Axes);

SpecPlots = get(handles.ListSpectra,'Value');
Colors = get(gca,'ColorOrder');

if isfield(Spectra,'D0Smooth')
    PlotData = Spectra.D0Smooth;
else
    PlotData = Spectra.D0;
end

hold(handles.D0Axes,'all');
for i = 1:length(SpecPlots)
    plot(handles.D0Axes,...
        Spectra.x(:,SpecPlots(i)),...
        PlotData(:,SpecPlots(i)),...
        'Color',Colors(mod(length(size(Colors,1),i)),:));
end
hold(handles.D0Axes,'off');

test = 1;


function D1Plotter(handles)
global Spectra;

cla(handles.D1Axes);

SpecPlots = get(handles.ListSpectra,'Value');
Colors = get(gca,'ColorOrder');

if isfield(Spectra,'D1Smooth')
    PlotData = Spectra.D1Smooth;
else
    PlotData = Spectra.D1;
end 
    
hold(handles.D1Axes,'all');
for i = 1:length(SpecPlots)
    plot(handles.D1Axes,...
        Spectra.x(:,SpecPlots(i)),...
        PlotData(:,SpecPlots(i)),...
        'Color',Colors(mod(length(size(Colors,1),i)),:));
end
hold(handles.D1Axes,'off');

if isfield(Spectra,'FitX');
    hold(handles.D1Axes,'all');
    for i = 1:length(SpecPlots)
        plot(handles.D1Axes,...
            Spectra.FitX(:,SpecPlots(i)),Spectra.FitD1(:,SpecPlots(i)),...
            'LineStyle',':','LineWidth',2);
    end
end

test = 1;


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


% --- Executes on button press in PushButtonNNSmooth.
function PushButtonNNSmooth_Callback(hObject, eventdata, handles)
% hObject    handle to PushButtonNNSmooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%If Button is 1, then update D1Plot, if 0, update D0Plot
Button = NNSmooth;

if Button
    D1Plotter(handles);
else
    D0Plotter(handles);
end

test = 1;


% --- Executes on button press in PushButtonSGSmooth.
function PushButtonSGSmooth_Callback(hObject, eventdata, handles)
% hObject    handle to PushButtonSGSmooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in PushButtonFit.
function PushButtonFit_Callback(hObject, eventdata, handles)
% hObject    handle to PushButtonFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FitPeak;

D1Plotter(handles);


% --- Executes on button press in PushButtonDiff.
function PushButtonDiff_Callback(hObject, eventdata, handles)
% hObject    handle to PushButtonDiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
