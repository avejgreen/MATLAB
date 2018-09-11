function varargout = FitCriteria(varargin)
% FITCRITERIA MATLAB code for FitCriteria.fig
%      FITCRITERIA, by itself, creates a new FITCRITERIA or raises the existing
%      singleton*.
%
%      H = FITCRITERIA returns the handle to a new FITCRITERIA or the handle to
%      the existing singleton*.
%
%      FITCRITERIA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITCRITERIA.M with the given input arguments.
%
%      FITCRITERIA('Property','Value',...) creates a new FITCRITERIA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FitCriteria_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FitCriteria_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FitCriteria

% Last Modified by GUIDE v2.5 06-Apr-2017 15:31:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FitCriteria_OpeningFcn, ...
                   'gui_OutputFcn',  @FitCriteria_OutputFcn, ...
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


% --- Executes just before FitCriteria is made visible.
function FitCriteria_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FitCriteria (see VARARGIN)

% Choose default command line output for FitCriteria
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FitCriteria wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FitCriteria_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);



function EditXMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditXMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXMin as text
%        str2double(get(hObject,'String')) returns contents of EditXMin as a double
xMin = str2double(get(handles.EditXMin,'String'));
xMax = str2double(get(handles.EditXMax,'String'));

if xMin>=xMax
    xMin = xMax-.4;
end

set(handles.EditXMin,'String',num2str(xMin,3));


% --- Executes during object creation, after setting all properties.
function EditXMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditXMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditXMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXMax as text
%        str2double(get(hObject,'String')) returns contents of EditXMax as a double
xMin = str2double(get(handles.EditXMin,'String'));
xMax = str2double(get(handles.EditXMax,'String'));

if xMin>=xMax
    xMax = xMin+.4;
end

set(handles.EditXMax,'String',num2str(xMax,3));

% --- Executes during object creation, after setting all properties.
function EditXMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXMax (see GCBO)
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
CurvMin = str2double(get(handles.EditCurvMin,'String'));
CurvMax = str2double(get(handles.EditCurvMax,'String'));

if CurvMin>=CurvMax
    CurvMin = CurvMax-5;
end

if CurvMin<0
    CurvMin = 0;
end

set(handles.EditCurvMin,'String',num2str(CurvMin,3));

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



function EditCurvMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditCurvMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditCurvMax as text
%        str2double(get(hObject,'String')) returns contents of EditCurvMax as a double
CurvMin = str2double(get(handles.EditCurvMin,'String'));
CurvMax = str2double(get(handles.EditCurvMax,'String'));

if CurvMin>=CurvMax
    CurvMax = CurvMin+5;
end

set(handles.EditCurvMax,'String',num2str(CurvMax,3));

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



function EditYMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditYMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYMin as text
%        str2double(get(hObject,'String')) returns contents of EditYMin as a double
yMin = str2double(get(handles.EditYMin,'String'));
yMax = str2double(get(handles.EditYMax,'String'));

if yMin>=yMax
    yMin = yMax-1e-4;
end

set(handles.EditYMin,'String',num2str(yMin,3));

% --- Executes during object creation, after setting all properties.
function EditYMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditYMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditYMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditYMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYMax as text
%        str2double(get(hObject,'String')) returns contents of EditYMax as a double
yMin = str2double(get(handles.EditYMin,'String'));
yMax = str2double(get(handles.EditYMax,'String'));

if yMin>=yMax
    yMax = yMin+1e-4;
end

set(handles.EditYMax,'String',num2str(yMax,3));

% --- Executes during object creation, after LocalRenderCanvasAveryting all properties.
function EditYMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditYMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditErrorMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditErrorMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditErrorMin as text
%        str2double(get(hObject,'String')) returns contents of EditErrorMin as a double
ErrorMin = str2double(get(handles.EditErrorMin,'String'));
ErrorMax = str2double(get(handles.EditErrorMax,'String'));

if ErrorMin>=ErrorMax
    ErrorMin = ErrorMax-5;
end

if ErrorMin<0
    ErrorMin = 0;
end

set(handles.EditErrorMin,'String',num2str(ErrorMin,3));

% --- Executes during object creation, after setting all properties.
function EditErrorMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditErrorMin (see GCBO)
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
ErrorMin = str2double(get(handles.EditErrorMin,'String'));
ErrorMax = str2double(get(handles.EditErrorMax,'String'));

if ErrorMin>=ErrorMax
    ErrorMax = ErrorMin+5;
end

set(handles.EditErrorMax,'String',num2str(ErrorMax,3));

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


% --- Executes on button press in ButtonOK.
function ButtonOK_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Spectra;
xMin = str2double(get(handles.EditXMin,'String'));
xMax = str2double(get(handles.EditXMax,'String'));
yMin = str2double(get(handles.EditYMin,'String'));
yMax = str2double(get(handles.EditYMax,'String'));
CurvMin = str2double(get(handles.EditCurvMin,'String'));
CurvMax = str2double(get(handles.EditCurvMax,'String'));
ErrorMin = str2double(get(handles.EditErrorMin,'String'));
ErrorMax = str2double(get(handles.EditErrorMax,'String'));

if isfield(Spectra,'FitPolys')
    
    Valid = ones(1,size(Spectra.x,2));
    Valid(Spectra.FitPosition(1,:)<xMin) = 0;
    Valid(Spectra.FitPosition(1,:)>xMax) = 0;
    Valid(Spectra.FitPosition(2,:)<yMin) = 0;
    Valid(Spectra.FitPosition(2,:)>yMax) = 0;
    Valid(Spectra.FitPolys(1,:)<CurvMin) = 0;
    Valid(Spectra.FitPolys(1,:)>CurvMax) = 0;
    Valid(Spectra.FitError<ErrorMin) = 0;
    Valid(Spectra.FitError>ErrorMax) = 0;
    
    Spectra.FitValid = boolean(Valid);
    
end

test = 1;

close(handles.figure1);



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
