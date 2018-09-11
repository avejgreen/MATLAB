function varargout = PlotterGUI(varargin)
% PLOTTERGUI MATLAB code for PlotterGUI.fig
%      PLOTTERGUI, by itself, creates a new PLOTTERGUI or raises the existing
%      singleton*.
%
%      H = PLOTTERGUI returns the handle to a new PLOTTERGUI or the handle to
%      the existing singleton*.
%
%      PLOTTERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOTTERGUI.M with the given input arguments.
%
%      PLOTTERGUI('Property','Value',...) creates a new PLOTTERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PlotterGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PlotterGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PlotterGUI

% Last Modified by GUIDE v2.5 30-Sep-2016 18:20:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PlotterGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @PlotterGUI_OutputFcn, ...
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


% --- Executes just before PlotterGUI is made visible.
function PlotterGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PlotterGUI (see VARARGIN)

% Choose default command line output for PlotterGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PlotterGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PlotterGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadButton.
function LoadButton_Callback(hObject, eventdata, handles)
% hObject    handle to LoadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Data
global Text

PathName = '/Users/averygreen/Documents/MATLAB/Projects/EELS/';
oldfolder = cd(PathName);
% FileName = dir;
[FileName,PathName,FilterIndex] = uigetfile('*.msa','Select *.msa EELS Data');
% FileName = 'Bi(0-0180eV).msa';
% FileName = 'Se(0-0450eV).msa';

C = importdata(horzcat(PathName,FileName), ',', 14);

Data = C.data;

Text = cell(length(C.textdata),1);
for i = 1:length(Text)
   Text(i) = textscan(C.textdata{i,1},'%s','Delimiter',' ','MultipleDelimsAsOne', 1);
end

set(handles.FileTitle,'String',Text{3}{3});

test = 1;


% --- Executes on button press in PlotButton.
function PlotButton_Callback(hObject, eventdata, handles)
% hObject    handle to PlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Data;

PlotData = deriv(Data, uint8(str2double(get(handles.PointsInput,'String'))), uint8(str2double(get(handles.DerivInput,'String'))));

plot(handles.axes1, PlotData{end}(:,1), PlotData{end}(:,2),...
    'LineWidth', 2,...
    'Color', 'k');
xlabel(handles.axes1, 'Energy (eV)');
PlotRange = max(PlotData{end}(:,2))-min(PlotData{end}(:,2));
set(gca,...
    'XLim', [min(PlotData{end}(:,1)), max(PlotData{end}(:,1))],...
    'YLim', [min(PlotData{end}(:,2))-0.1*PlotRange max(PlotData{end}(:,2))+0.1*PlotRange]);

set(handles.YMinInput, 'String', min(get(gca, 'YLim')));
set(handles.YMaxInput, 'String', max(get(gca, 'YLim')));


function DerivInput_Callback(hObject, eventdata, handles)
% hObject    handle to DerivInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DerivInput as text
%        str2double(get(hObject,'String')) returns contents of DerivInput as a double

value = uint8(str2double(get(hObject,'String')));
set(hObject, 'String', int2str(value));

% --- Executes during object creation, after setting all properties.
function DerivInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DerivInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function PointsInput_Callback(hObject, eventdata, handles)
% hObject    handle to PointsInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of PointsInput as text
%        str2double(get(hObject,'String')) returns contents of PointsInput as a double

value = uint8(str2double(get(hObject,'String')));
set(hObject, 'String', int2str(value));

% --- Executes during object creation, after setting all properties.
function PointsInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PointsInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YMinInput_Callback(hObject, eventdata, handles)
% hObject    handle to YMinInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YMinInput as text
%        str2double(get(hObject,'String')) returns contents of YMinInput as a double

CurrentYLim = get(handles.axes1, 'YLim');
NewYLim = [str2double(get(hObject, 'String')), CurrentYLim(2)];
set(handles.axes1, 'YLim', NewYLim);


% --- Executes during object creation, after setting all properties.
function YMinInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YMinInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function YMaxInput_Callback(hObject, eventdata, handles)
% hObject    handle to YMaxInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of YMaxInput as text
%        str2double(get(hObject,'String')) returns contents of YMaxInput as a double

CurrentYLim = get(handles.axes1, 'YLim');
NewYLim = [CurrentYLim(1), str2double(get(hObject, 'String'))];
set(handles.axes1, 'YLim', NewYLim);


% --- Executes during object creation, after setting all properties.
function YMaxInput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to YMaxInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
