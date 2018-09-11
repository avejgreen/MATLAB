function varargout = SurfSelector(varargin)
% SURFSELECTOR MATLAB code for SurfSelector.fig
%      SURFSELECTOR, by itself, creates a new SURFSELECTOR or raises the existing
%      singleton*.
%
%      H = SURFSELECTOR returns the handle to a new SURFSELECTOR or the handle to
%      the existing singleton*.
%
%      SURFSELECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SURFSELECTOR.M with the given input arguments.
%
%      SURFSELECTOR('Property','Value',...) creates a new SURFSELECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SurfSelector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SurfSelector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SurfSelector

% Last Modified by GUIDE v2.5 27-Oct-2016 18:30:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SurfSelector_OpeningFcn, ...
                   'gui_OutputFcn',  @SurfSelector_OutputFcn, ...
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


% --- Executes just before SurfSelector is made visible.
function SurfSelector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SurfSelector (see VARARGIN)

if varargin{1}.LayerNum==1
    set(handles.uipanel1,'Title',...
        horzcat('Choose surface hkl for substrate, ',varargin{1}.Name));
else
    set(handles.uipanel1,'Title',...
        horzcat('Choose surface hkl for layer ',...
        int2str(varargin{1}.LayerNum),...
        ', ',...
        varargin{1}.Name));
end

% Choose default command line output for SurfSelector
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes SurfSelector wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SurfSelector_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

varargout{1} = [uint8(str2double(get(handles.hEdit,'String'))),...
    uint8(str2double(get(handles.kEdit,'String'))),...
    uint8(str2double(get(handles.lEdit,'String')))];

delete(handles.figure1);



function hEdit_Callback(hObject, eventdata, handles)
% hObject    handle to hEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hEdit as text
%        str2double(get(hObject,'String')) returns contents of hEdit as a double


% --- Executes during object creation, after setting all properties.
function hEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kEdit_Callback(hObject, eventdata, handles)
% hObject    handle to kEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of kEdit as text
%        str2double(get(hObject,'String')) returns contents of kEdit as a double


% --- Executes during object creation, after setting all properties.
function kEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lEdit_Callback(hObject, eventdata, handles)
% hObject    handle to lEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lEdit as text
%        str2double(get(hObject,'String')) returns contents of lEdit as a double


% --- Executes during object creation, after setting all properties.
function lEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure1_CloseRequestFcn(handles.figure1, eventdata, handles);
% SurfSelector_OutputFcn(handles.figure1, eventdata, handles) 
% delete(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
    uiresume(hObject);
else
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
    OKButton_Callback(handles.OKButton, eventdata, handles)
end
