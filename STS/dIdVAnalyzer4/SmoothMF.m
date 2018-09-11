function varargout = SmoothMF(varargin)
% SMOOTHMF MATLAB code for SmoothMF.fig
%      SMOOTHMF, by itself, creates a new SMOOTHMF or raises the existing
%      singleton*.
%
%      H = SMOOTHMF returns the handle to a new SMOOTHMF or the handle to
%      the existing singleton*.
%
%      SMOOTHMF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SMOOTHMF.M with the given input arguments.
%
%      SMOOTHMF('Property','Value',...) creates a new SMOOTHMF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SmoothMF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SmoothMF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SmoothMF

% Last Modified by GUIDE v2.5 04-Apr-2017 19:36:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @SmoothMF_OpeningFcn, ...
    'gui_OutputFcn',  @SmoothMF_OutputFcn, ...
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


% --- Executes just before SmoothMF is made visible.
function SmoothMF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SmoothMF (see VARARGIN)

% Choose default command line output for SmoothMF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SmoothMF wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SmoothMF_OutputFcn(hObject, eventdata, handles)
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
Points = round(str2double(get(hObject,'String')));
if Points < 1
    Points = 1;
end
if Points/2 == round(Points/2)
    Points = Points+1;
end
set(hObject,'String',int2str(uint16(Points)));
    

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


% --- Executes on button press in ButtonOK.
function ButtonOK_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Spectra

Points = str2double(get(handles.EditPoints,'String'));

Spectra.D0Smooth = medfilt1(Spectra.D0,Points);

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


% --- Executes on key release with focus on figure1 or any of its controls.
function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)

if strcmp(eventdata.Key,'return')
    ButtonOK_Callback(handles, eventdata, handles);
end

test = 1;
