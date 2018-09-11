function varargout = RSMSelector(varargin)
% RSMSelector MATLAB code for RSMSelector.fig
%      RSMSelector, by itself, creates a new RSMSelector or raises the existing
%      singleton*.
%
%      H = RSMSelector returns the handle to a new RSMSelector or the handle to
%      the existing singleton*.
%
%      RSMSelector('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RSMSelector.M with the given input arguments.
%
%      RSMSelector('Property','Value',...) creates a new RSMSelector or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before RSMSelector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to RSMSelector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help RSMSelector

% Last Modified by GUIDE v2.5 30-Oct-2016 17:20:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @RSMSelector_OpeningFcn, ...
                   'gui_OutputFcn',  @RSMSelector_OutputFcn, ...
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


% --- Executes just before RSMSelector is made visible.
function RSMSelector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to RSMSelector (see VARARGIN)

handles.AllCrystals = varargin{1};

%Populate layer lists
set(handles.LayerList1,'String',{handles.AllCrystals(:).Name});
set(handles.LayerList2,'String',{handles.AllCrystals(:).Name});

%Only display planes that have SF >= 1 and l nonnegative.
for i = 1:length(handles.AllCrystals)
    handles.AllCrystals(i).hkl = handles.AllCrystals(i).hkl(handles.AllCrystals(i).SF >= 10,:);
    handles.AllCrystals(i).hkl = handles.AllCrystals(i).hkl(handles.AllCrystals(i).hkl(:,3) >= 0,:);
end

hklList = cell(size(handles.AllCrystals(1).hkl,1),1);
for i = 1:length(hklList)
    hklList{i} = sprintf('%d %d %d',handles.AllCrystals(1).hkl(i,:)');
end
set(handles.hklList1,'String',hklList);

hklList = cell(size(handles.AllCrystals(1).hkl,1),1);
for i = 1:length(hklList)
    hklList{i} = sprintf('%d %d %d',handles.AllCrystals(1).hkl(i,:)');
end
set(handles.hklList2,'String',hklList);


% Choose default command line output for RSMSelector
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes RSMSelector wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = RSMSelector_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure

%FOR SOME REASON, ONLY ONE CELL OUTPUTS. FIGURE IT OUT LATER.
varargout{1} = [handles.AllCrystals(get(handles.LayerList1,'Value')).hkl(get(handles.hklList1,'Value'),:),...
    get(handles.LayerList1,'Value');...
    handles.AllCrystals(get(handles.LayerList2,'Value')).hkl(get(handles.hklList2,'Value'),:),...
    get(handles.LayerList2,'Value')];

guidata(handles.figure1,handles);

delete(handles.figure1);


% --- Executes on button press in OKButton.
function OKButton_Callback(hObject, eventdata, handles)
% hObject    handle to OKButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure1_CloseRequestFcn(handles.figure1, eventdata, handles);
% RSMSelector_OutputFcn(handles.figure1, eventdata, handles) 
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



% --- Executes on selection change in LayerList1.
function LayerList1_Callback(hObject, eventdata, handles)
% hObject    handle to LayerList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LayerList1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LayerList1

hklList = cell(size(handles.AllCrystals(get(hObject,'Value')).hkl,1),1);
for i = 1:length(hklList)
    hklList{i} = sprintf('%d %d %d',handles.AllCrystals(get(hObject,'Value')).hkl(i,:)');
end
set(handles.hklList1,'String',hklList);


% --- Executes during object creation, after setting all properties.
function LayerList1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LayerList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in LayerList2.
function LayerList2_Callback(hObject, eventdata, handles)
% hObject    handle to LayerList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns LayerList2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from LayerList2

hklList = cell(size(handles.AllCrystals(get(hObject,'Value')).hkl,1),1);
for i = 1:length(hklList)
    hklList{i} = sprintf('%d %d %d',handles.AllCrystals(get(hObject,'Value')).hkl(i,:)');
end
set(handles.hklList2,'String',hklList);


% --- Executes during object creation, after setting all properties.
function LayerList2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LayerList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hklList1.
function hklList1_Callback(hObject, eventdata, handles)
% hObject    handle to hklList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hklList1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hklList1
test = 1;

% --- Executes during object creation, after setting all properties.
function hklList1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hklList1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in hklList2.
function hklList2_Callback(hObject, eventdata, handles)
% hObject    handle to hklList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns hklList2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from hklList2
test = 1;

% --- Executes during object creation, after setting all properties.
function hklList2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hklList2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
