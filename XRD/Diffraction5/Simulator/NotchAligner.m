function varargout = NotchAligner(varargin)
% NotchAligner MATLAB code for NotchAligner.fig
%      NotchAligner, by itself, creates a new NotchAligner or raises the existing
%      singleton*.
%
%      H = NotchAligner returns the handle to a new NotchAligner or the handle to
%      the existing singleton*.
%
%      NotchAligner('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NotchAligner.M with the given input arguments.
%
%      NotchAligner('Property','Value',...) creates a new NotchAligner or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NotchAligner_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NotchAligner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NotchAligner

% Last Modified by GUIDE v2.5 30-Oct-2016 14:13:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NotchAligner_OpeningFcn, ...
                   'gui_OutputFcn',  @NotchAligner_OutputFcn, ...
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


% --- Executes just before NotchAligner is made visible.
function NotchAligner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NotchAligner (see VARARGIN)

test = 1;
%If this is the substrate write it. If not, specify layer number
if varargin{1}.LayerNum == 1
    set(handles.Panel,'Title',...
        horzcat(varargin{1}.Name,' substrate notch aligner:'));
else
    set(handles.Panel,'Title',...
        horzcat(varargin{1}.Name,' layer ',int2str(varargin{1}.LayerNum),' notch aligner:'));
end

handles.Crystal = varargin{1};

% Choose default command line output for NotchAligner
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes NotchAligner wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NotchAligner_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

%FOR SOME REASON, ONLY ONE CELL OUTPUTS. FIGURE IT OUT LATER.
varargout{1} = [str2double(get(handles.hEdit,'String')),...
    str2double(get(handles.kEdit,'String')),...
    str2double(get(handles.lEdit,'String'))];

% varargout{2} = [(str2double(get(handles.hEdit,'String'))),...
%     (str2double(get(handles.kEdit,'String'))),...
%     (str2double(get(handles.lEdit,'String')))];

guidata(handles.figure1,handles);

delete(handles.figure1);


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure1_CloseRequestFcn(handles.figure1, eventdata, handles);
% NotchAligner_OutputFcn(handles.figure1, eventdata, handles) 
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



function uEdit_Callback(hObject, eventdata, handles)
% hObject    handle to uEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of uEdit as text
%        str2double(get(hObject,'String')) returns contents of uEdit as a double
AdjustHKLorUVW(handles,'HKL')

% --- Executes during object creation, after setting all properties.
function uEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vEdit_Callback(hObject, eventdata, handles)
% hObject    handle to vEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vEdit as text
%        str2double(get(hObject,'String')) returns contents of vEdit as a double
AdjustHKLorUVW(handles,'HKL')

% --- Executes during object creation, after setting all properties.
function vEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wEdit_Callback(hObject, eventdata, handles)
% hObject    handle to wEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wEdit as text
%        str2double(get(hObject,'String')) returns contents of wEdit as a double
AdjustHKLorUVW(handles,'HKL')

% --- Executes during object creation, after setting all properties.
function wEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hEdit_Callback(hObject, eventdata, handles)
% hObject    handle to hEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hEdit as text
%        str2double(get(hObject,'String')) returns contents of hEdit as a double
AdjustHKLorUVW(handles,'UVW')

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
AdjustHKLorUVW(handles,'UVW')

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
AdjustHKLorUVW(handles,'UVW')

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


function AdjustHKLorUVW(handles,HKLorUVW)

if strcmp(HKLorUVW,'HKL')
    %Adjust HKL entries
    UVW = [str2double(get(handles.uEdit,'String')),...
        str2double(get(handles.vEdit,'String')),...
        str2double(get(handles.wEdit,'String'))];
    
    v = UVW*handles.Crystal.a;
    
    HKL = handles.Crystal.a*v';
    
    HKL = HKL/max(HKL);
    
    set(handles.hEdit,'String',num2str(HKL(1)));
    set(handles.kEdit,'String',num2str(HKL(2)));
    set(handles.lEdit,'String',num2str(HKL(3)));
    
elseif strcmp(HKLorUVW,'UVW')
    %Adjust UVW entries
    HKL = [str2double(get(handles.hEdit,'String')),...
        str2double(get(handles.kEdit,'String')),...
        str2double(get(handles.lEdit,'String'))];
    
    v = HKL*handles.Crystal.b;
    
    UVW = handles.Crystal.b*v';
    
    UVW = UVW/max(UVW);
    
    set(handles.uEdit,'String',num2str(UVW(1)));
    set(handles.vEdit,'String',num2str(UVW(2)));
    set(handles.wEdit,'String',num2str(UVW(3)));
    
else
 
end

guidata(handles.figure1,handles);
