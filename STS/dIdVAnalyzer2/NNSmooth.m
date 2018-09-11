function varargout = NNSmooth(varargin)
% NNSMOOTH MATLAB code for NNSmooth.fig
%      NNSMOOTH, by itself, creates a new NNSMOOTH or raises the existing
%      singleton*.
%
%      H = NNSMOOTH returns the handle to a new NNSMOOTH or the handle to
%      the existing singleton*.
%
%      NNSMOOTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NNSMOOTH.M with the given input arguments.
%
%      NNSMOOTH('Property','Value',...) creates a new NNSMOOTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NNSmooth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NNSmooth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NNSmooth

% Last Modified by GUIDE v2.5 30-Mar-2017 18:30:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NNSmooth_OpeningFcn, ...
                   'gui_OutputFcn',  @NNSmooth_OutputFcn, ...
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


% --- Executes just before NNSmooth is made visible.
function NNSmooth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NNSmooth (see VARARGIN)

% Choose default command line output for NNSmooth
handles.output = get(handles.RadioButtonD1,'Value');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NNSmooth wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NNSmooth_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);


function EditPoints_Callback(hObject, eventdata, handles)
% hObject    handle to EditPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPoints as text
%        str2double(get(hObject,'String')) returns contents of EditPoints as a double
pts = str2double(get(hObject,'String'));
pts(pts<1)=1;
pts(pts/2==round(pts/2))=pts+1;
set(hObject,'String',int2str(uint16(pts)));


% --- Executes during object creation, after setting all properties.
function EditPoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RadioButtonD0.
function RadioButtonD0_Callback(hObject, eventdata, handles)
% hObject    handle to RadioButtonD0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RadioButtonD0
set(handles.RadioButtonD1,'Value',0)

% --- Executes on button press in RadioButtonD1.
function RadioButtonD1_Callback(hObject, eventdata, handles)
% hObject    handle to RadioButtonD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RadioButtonD1
set(handles.RadioButtonD0,'Value',0)

% --- Executes on button press in PushButtonOK.
function PushButtonOK_Callback(hObject, eventdata, handles)
% hObject    handle to PushButtonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Spectra;

Points = str2double(get(handles.EditPoints,'String'));
TailLength = (Points-1)/2;

if get(handles.RadioButtonD1,'Value')
    D = Spectra.D1;
else
    D = Spectra.D0;
end

DSmooth = zeros(size(D,1),size(D,2));

for i = 1:TailLength
    DSmooth(i,:) = sum(D(1:i,:),1)/i;
    DSmooth(end-i+1,:) = sum(D(end-i+1:end,:),1)/i;
end

for i = TailLength+1:size(D,1)-TailLength
    
    DSmooth(i,:) = sum(D(i-TailLength:i+TailLength,:),1)/Points;
    
end

if get(handles.RadioButtonD1,'Value')
    Spectra.D1Smooth = DSmooth;
else
    Spectra.D0Smooth = DSmooth;
end

close(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure

if isequal(get(hObject, 'waitstatus'), 'waiting')
% The GUI is still in UIWAIT, us UIRESUME
uiresume(hObject);
else
% The GUI is no longer waiting, just close it
delete(hObject);
end
