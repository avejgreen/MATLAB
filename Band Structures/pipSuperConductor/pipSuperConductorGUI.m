function varargout = pipSuperConductorGUI(varargin)
% PIPSUPERCONDUCTORGUI MATLAB code for pipSuperConductorGUI.fig
%      PIPSUPERCONDUCTORGUI, by itself, creates a new PIPSUPERCONDUCTORGUI or raises the existing
%      singleton*.
%
%      H = PIPSUPERCONDUCTORGUI returns the handle to a new PIPSUPERCONDUCTORGUI or the handle to
%      the existing singleton*.
%
%      PIPSUPERCONDUCTORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPSUPERCONDUCTORGUI.M with the given input arguments.
%
%      PIPSUPERCONDUCTORGUI('Property','Value',...) creates a new PIPSUPERCONDUCTORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipSuperConductorGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipSuperConductorGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipSuperConductorGUI

% Last Modified by GUIDE v2.5 10-Oct-2017 17:20:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipSuperConductorGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @pipSuperConductorGUI_OutputFcn, ...
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


% --- Executes just before pipSuperConductorGUI is made visible.
function pipSuperConductorGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipSuperConductorGUI (see VARARGIN)

% Choose default command line output for pipSuperConductorGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipSuperConductorGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global mu Del
mu = 0;
Del = 0;


% --- Outputs from this function are returned to the command line.
function varargout = pipSuperConductorGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global mu;

mu = get(hObject,'Value')-0.5;

set(handles.edit1,'String',num2str(mu));

UpdatePlot(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global mu;

mu = str2double(get(hObject,'String')); 
if isnan(mu)
    set(handles.edit1,'String','0')
    mu = 0;
elseif mu<-0.5
    set(handles.edit1,'String','-0.5')
    mu = -0.5;
elseif mu>0.5
    set(handles.edit1,'String','0.5')
    mu = 0.5;
end

SliderPos = mu+0.5;
set(handles.slider1,'Value',SliderPos);

UpdatePlot(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function UpdatePlot(hObject, eventdata, handles)

global mu Del;

kx = -1*pi:.1:pi;
ky = kx;

[Kx,Ky] = meshgrid(kx,ky);

t = .1;

Ep = zeros(length(kx));
Em = Ep;

dx = Del*sin(kx);
dy = Del*sin(ky);
dz = 2*t*(cos(Kx)+cos(Ky))+mu;

for i = 1:length(kx)
    for j = 1:length(ky)
        
        Ep(i,j) = sqrt(dx(i)^2+dy(j)^2+dz(i,j)^2);
        Em(i,j) = -Ep(i,j);
        
    end
end

mesh(handles.axes1,kx,ky,Ep);
hold on;
mesh(handles.axes1,kx,ky,Em);
hold off;

test = 1;


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global Del;

Del = get(hObject,'Value')-0.5;

set(handles.edit2,'String',num2str(Del));

UpdatePlot(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
global Del;

Del = str2double(get(hObject,'String')); 
if isnan(Del)
    set(handles.edit1,'String','0')
    Del = 0;
elseif Del<-0.5
    set(handles.edit1,'String','-0.5')
    Del = -0.5;
elseif Del>0.5
    set(handles.edit1,'String','0.5')
    Del = 0.5;
end

SliderPos = Del+0.5;
set(handles.slider2,'Value',SliderPos);

UpdatePlot(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
