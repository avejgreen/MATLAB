%=================================%
% Flake Stack Fresnel Contrast    %
% Avery J. Green, SUNY CNSE, 2013 %
%=================================%


function varargout = FlakeContrast10152015(varargin)
%FLAKECONTRAST10152015 M-file for FlakeContrast10152015.fig
%      FLAKECONTRAST10152015, by itself, creates a new FLAKECONTRAST10152015 or raises the existing
%      singleton*.
%
%      H = FLAKECONTRAST10152015 returns the handle to a new FLAKECONTRAST10152015 or the handle to
%      the existing singleton*.
%
%      FLAKECONTRAST10152015('Property','Value',...) creates a new FLAKECONTRAST10152015 using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to FlakeContrast10152015_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      FLAKECONTRAST10152015('CALLBACK') and FLAKECONTRAST10152015('CALLBACK',hObject,...) call the
%      local function named CALLBACK in FLAKECONTRAST10152015.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FlakeContrast10152015

% Last Modified by GUIDE v2.5 15-Oct-2015 19:39:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FlakeContrast10152015_OpeningFcn, ...
                   'gui_OutputFcn',  @FlakeContrast10152015_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before FlakeContrast10152015 is made visible.
function FlakeContrast10152015_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for FlakeContrast10152015
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

set(handles.edit1, 'String', '10');
set(handles.edit2, 'String', '10');
set(handles.edit3, 'String', '10');
set(handles.edit4, 'String', '10');
set(handles.edit5, 'String', '10');
set(handles.edit6, 'String', '10');
set(handles.edit7, 'String', '10');

set(handles.popupmenu1, 'Value', 9);
set(handles.popupmenu2, 'Value', 1);
set(handles.popupmenu3, 'Value', 1);
set(handles.popupmenu4, 'Value', 1);
set(handles.popupmenu5, 'Value', 1);
set(handles.popupmenu6, 'Value', 1);
set(handles.popupmenu7, 'Value', 1);

set(handles.radiobutton1, 'Value', 1);

axes(handles.axes1);
ezplot('0');
grid on
xlabel('Wavelength (nm)');
ylabel('Reflection Contrast');
title('');
axis([250 1000 -2 2])

axes(handles.axes2);
barDat = [10;0];
bar(barDat,'stacked');
ylabel('Stack Thickness (nm)');
set(handles.axes2, 'XTickLabel', {'W/ Contrast Layer', 'W/O Contrast Layer'});

% UIWAIT makes FlakeContrast10152015 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FlakeContrast10152015_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if the input number is within the valid thickness input range
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10');
elseif s < 0.1
    set(hObject, 'String','0.1');
elseif s > 1000
    set(hObject,'String','1000');
end

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if the input number is within the valid thickness input range
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10');
elseif s < 0.1
    set(hObject, 'String','0.1');
elseif s > 1000
    set(hObject,'String','1000');
end

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if the input number is within the valid thickness input range
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10');
elseif s < 0.1
    set(hObject, 'String','0.1');
elseif s > 1000
    set(hObject,'String','1000');
end

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if the input number is within the valid thickness input range
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10');
elseif s < 0.1
    set(hObject, 'String','0.1');
elseif s > 1000
    set(hObject,'String','1000');
end

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if the input number is within the valid thickness input range
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10');
elseif s < 0.1
    set(hObject, 'String','0.1');
elseif s > 1000
    set(hObject,'String','1000');
end

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if the input number is within the valid thickness input range
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10');
elseif s < 0.1
    set(hObject, 'String','0.1');
elseif s > 1000
    set(hObject,'String','1000');
end

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check if the input number is within the valid thickness input range
s = str2double(get(hObject,'String'));
if isnan(s)
    set(hObject,'String','10');
elseif s < 0.1
    set(hObject, 'String','0.1');
elseif s > 1000
    set(hObject,'String','1000');
end

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


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


% --- Executes on button press in plotbutton.
function plotbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plotbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Check the input contrast layer
if get(handles.radiobutton1, 'Value') == 1
    contrastlayer = 1;
elseif get(handles.radiobutton2, 'Value') == 1
    contrastlayer = 2;
elseif get(handles.radiobutton3, 'Value') == 1
    contrastlayer = 3;
elseif get(handles.radiobutton4, 'Value') == 1
    contrastlayer = 4;
elseif get(handles.radiobutton5, 'Value') == 1
    contrastlayer = 5;
elseif get(handles.radiobutton6, 'Value') == 1
    contrastlayer = 6;
elseif get(handles.radiobutton7, 'Value') == 1
    contrastlayer = 7;
else
    contrastlayer = 1;
end

% Input the refractive data for all possible materials ALPHABETICAL ORDER
% IF YOU ADD MATERIAL, INPUT THE NMATERIAL, ADD TO NVALS, CHANGE THE
% DROPDOWN MENU STRINGS IN FIGURE, CLEAR THE NMATERIAL, CHANGE THE SI INDEX
% FOR 2-LAYER VALUES
NAir = 1.0003;
NCuDat = [1.48140400000000 - 1.76625800000000i,1.52847100000000 - 1.70397500000000i,1.51879200000000 - 1.66879100000000i,1.49442800000000 - 1.64442400000000i,1.44734000000000 - 1.63980100000000i,1.39338100000000 - 1.66570700000000i,1.33999300000000 - 1.72055800000000i,1.33974100000000 - 1.77577100000000i,1.33370500000000 - 1.82226700000000i,1.31711100000000 - 1.85541900000000i,1.29856200000000 - 1.89219300000000i,1.27880600000000 - 1.93180000000000i,1.24596900000000 - 2.01256800000000i,1.20606900000000 - 2.12689700000000i,1.18000000000000 - 2.21000000000000i,1.18000000000000 - 2.21000000000000i,1.18000000000000 - 2.21000000000000i,1.17727600000000 - 2.24470600000000i,1.17372600000000 - 2.29580000000000i,1.17074100000000 - 2.34606900000000i,1.16534200000000 - 2.39011200000000i,1.15926400000000 - 2.43151600000000i,1.15361300000000 - 2.47244100000000i,1.14746400000000 - 2.50811800000000i,1.13968300000000 - 2.53339900000000i,1.13211400000000 - 2.55854700000000i,1.12475100000000 - 2.58356300000000i,1.10794700000000 - 2.59836400000000i,1.07230900000000 - 2.59379500000000i,1.03135600000000 - 2.59009900000000i,0.944438700000000 - 2.59250000000000i,0.856800700000000 - 2.59757000000000i,0.735418800000000 - 2.64670100000000i,0.600947000000000 - 2.72394500000000i,0.472977800000000 - 2.80660000000000i,0.397337400000000 - 2.95444400000000i,0.331217700000000 - 3.10025800000000i,0.271791600000000 - 3.24140200000000i,0.252031400000000 - 3.37882000000000i,0.234157800000000 - 3.51110000000000i,0.217858600000000 - 3.63875600000000i,0.214369100000000 - 3.75168000000000i,0.214986300000000 - 3.85790500000000i,0.213814700000000 - 3.96572900000000i,0.213081700000000 - 4.06901900000000i,0.213545500000000 - 4.16281300000000i,0.214702300000000 - 4.25484500000000i,0.219040700000000 - 4.34648000000000i,0.223288000000000 - 4.43653200000000i,0.227363500000000 - 4.52882500000000i,0.231368400000000 - 4.61927400000000i,0.235306300000000 - 4.70798600000000i,0.239180400000000 - 4.79505700000000i,0.242993600000000 - 4.88057500000000i,0.246748700000000 - 4.96462000000000i,0.250448100000000 - 5.04726500000000i,0.254094400000000 - 5.12857900000000i,0.257689500000000 - 5.20862400000000i,0.261940700000000 - 5.29520700000000i,0.267409000000000 - 5.39453200000000i,0.272768600000000 - 5.49206200000000i,0.278025900000000 - 5.58788900000000i,0.283186500000000 - 5.68210000000000i,0.288255300000000 - 5.77477500000000i,0.293237300000000 - 5.86598600000000i,0.298136500000000 - 5.95580000000000i,0.302957100000000 - 6.04428000000000i,0.307702600000000 - 6.13148300000000i,0.312376400000000 - 6.21746300000000i,0.316981800000000 - 6.30227000000000i,0.321521500000000 - 6.38595100000000i,0.325998300000000 - 6.46855000000000i,0.330414800000000 - 6.55010700000000i,0.334773300000000 - 6.63066100000000i,0.339076000000000 - 6.71024800000000i,0.343325000000000 - 6.78890300000000i];
NGrDat = [1.41677000000000 - 2.31002500000000i,1.62164600000000 - 2.47225900000000i,1.91251900000000 - 2.60076000000000i,2.28361600000000 - 2.61614000000000i,2.63222800000000 - 2.45368300000000i,2.83148000000000 - 2.18452700000000i,2.88534200000000 - 1.93877900000000i,2.86970200000000 - 1.76422100000000i,2.83562700000000 - 1.64921400000000i,2.80290300000000 - 1.57281300000000i,2.77657400000000 - 1.51992100000000i,2.75663800000000 - 1.48148500000000i,2.74182300000000 - 1.45233600000000i,2.73081100000000 - 1.42952500000000i,2.72255100000000 - 1.41133100000000i,2.71628300000000 - 1.39670800000000i,2.71148000000000 - 1.38498800000000i,2.70778400000000 - 1.37571500000000i,2.70495700000000 - 1.36856100000000i,2.70284000000000 - 1.36326900000000i,2.70132700000000 - 1.35963300000000i,2.70034400000000 - 1.35747800000000i,2.69984400000000 - 1.35665400000000i,2.69979000000000 - 1.35702600000000i,2.70015500000000 - 1.35847500000000i,2.70091900000000 - 1.36089700000000i,2.70206300000000 - 1.36419300000000i,2.70357200000000 - 1.36827900000000i,2.70543100000000 - 1.37307500000000i,2.70762600000000 - 1.37851200000000i,2.71014500000000 - 1.38452600000000i,2.71297300000000 - 1.39105900000000i,2.71609900000000 - 1.39805800000000i,2.71951000000000 - 1.40547700000000i,2.72319300000000 - 1.41327300000000i,2.72713700000000 - 1.42140800000000i,2.73133000000000 - 1.42984700000000i,2.73576100000000 - 1.43855700000000i,2.74041900000000 - 1.44751100000000i,2.74529300000000 - 1.45668200000000i,2.75037300000000 - 1.46604700000000i,2.75564900000000 - 1.47558400000000i,2.76111300000000 - 1.48527400000000i,2.76675400000000 - 1.49509900000000i,2.77256400000000 - 1.50504400000000i,2.77853500000000 - 1.51509200000000i,2.78465900000000 - 1.52523200000000i,2.79092900000000 - 1.53545200000000i,2.79733700000000 - 1.54573900000000i,2.80387600000000 - 1.55608400000000i,2.81054100000000 - 1.56647800000000i,2.81732400000000 - 1.57691200000000i,2.82422000000000 - 1.58737900000000i,2.83122300000000 - 1.59787100000000i,2.83832800000000 - 1.60838300000000i,2.84553000000000 - 1.61890800000000i,2.85282400000000 - 1.62944100000000i,2.86020600000000 - 1.63997700000000i,2.86767000000000 - 1.65051200000000i,2.87521300000000 - 1.66104200000000i,2.88283100000000 - 1.67156200000000i,2.89052000000000 - 1.68206900000000i,2.89827700000000 - 1.69256100000000i,2.90609800000000 - 1.70303500000000i,2.91398000000000 - 1.71348700000000i,2.92191900000000 - 1.72391500000000i,2.92991300000000 - 1.73431800000000i,2.93796000000000 - 1.74469300000000i,2.94605600000000 - 1.75503800000000i,2.95419800000000 - 1.76535100000000i,2.96238600000000 - 1.77563200000000i,2.97061500000000 - 1.78587900000000i,2.97888400000000 - 1.79609100000000i,2.98719100000000 - 1.80626500000000i,2.99553400000000 - 1.81640200000000i,3.00391100000000 - 1.82650100000000i];
NhBN = 2.2;
NHfO2Dat = [2.28680000000000 - 0.0342060000000000i,2.31910000000000 - 0.0367230000000000i,2.29240000000000 - 0.0336320000000000i,2.26800000000000 - 0.0222150000000000i,2.23330000000000 - 0.0146600000000000i,2.21220000000000 - 0.0164860000000000i,2.19570000000000 - 0.0172490000000000i,2.18740000000000 - 0.0184910000000000i,2.18300000000000 - 0.0166340000000000i,2.17840000000000 - 0.0130100000000000i,2.17310000000000 - 0.0112490000000000i,2.17430000000000 - 0.0116630000000000i,2.17220000000000 + 0.00000000000000i,2.15980000000000 + 0.00000000000000i,2.14800000000000 + 0.00000000000000i,2.13960000000000 + 0.00000000000000i,2.13290000000000 + 0.00000000000000i,2.12270000000000 + 0.00000000000000i,2.11640000000000 + 0.00000000000000i,2.11100000000000 + 0.00000000000000i,2.10580000000000 + 0.00000000000000i,2.10060000000000 + 0.00000000000000i,2.09560000000000 + 0.00000000000000i,2.09100000000000 + 0.00000000000000i,2.08690000000000 + 0.00000000000000i,2.08280000000000 + 0.00000000000000i,2.07860000000000 + 0.00000000000000i,2.07510000000000 + 0.00000000000000i,2.07180000000000 + 0.00000000000000i,2.06920000000000 + 0.00000000000000i,2.06560000000000 + 0.00000000000000i,2.06310000000000 + 0.00000000000000i,2.06060000000000 + 0.00000000000000i,2.05810000000000 + 0.00000000000000i,2.05500000000000 + 0.00000000000000i,2.05280000000000 + 0.00000000000000i,2.05140000000000 + 0.00000000000000i,2.04910000000000 + 0.00000000000000i,2.04740000000000 + 0.00000000000000i,2.04590000000000 + 0.00000000000000i,2.04540000000000 + 0.00000000000000i,2.04280000000000 + 0.00000000000000i,2.04170000000000 + 0.00000000000000i,2.04100000000000 + 0.00000000000000i,2.03970000000000 + 0.00000000000000i,2.04010000000000 + 0.00000000000000i,2.03960000000000 + 0.00000000000000i,2.03570000000000 + 0.00000000000000i,2.03560000000000 + 0.00000000000000i,2.03670000000000 + 0.00000000000000i,2.03410000000000 + 0.00000000000000i,2.03400000000000 + 0.00000000000000i,2.03460000000000 + 0.00000000000000i,2.02970000000000 + 0.00000000000000i,2.03520000000000 + 0.00000000000000i,2.03220000000000 + 0.00000000000000i,2.03290000000000 + 0.00000000000000i,2.03190000000000 + 0.00000000000000i,2.03060000000000 + 0.00000000000000i,2.03050000000000 + 0.00000000000000i,2.02960000000000 + 0.00000000000000i,2.02340000000000 + 0.00000000000000i,2.02640000000000 + 0.00000000000000i,2.02860000000000 + 0.00000000000000i,2.02500000000000 + 0.00000000000000i,2.02570000000000 + 0.00000000000000i,2.02530000000000 + 0.00000000000000i,2.02430000000000 + 0.00000000000000i,2.02410000000000 + 0.00000000000000i,2.02320000000000 + 0.00000000000000i,2.02410000000000 + 0.00000000000000i,2.02470000000000 + 0.00000000000000i,2.02400000000000 + 0.00000000000000i,2.02180000000000 + 0.00000000000000i,2.02430000000000 + 0.00000000000000i,2.01900000000000 + 0.00000000000000i];
NSb2Te3 = [1.39789138488222 - 1.69330060484017i,1.41592643067797 - 1.78956176509438i,1.43773296217373 - 1.88323447693493i,1.46315828897984 - 1.97434607698458i,1.49205202868378 - 2.06292352318414i,1.52426610685009 - 2.14899339479240i,1.55965475702045 - 2.23258189238622i,1.59807452071362 - 2.31371483786046i,1.63938424742548 - 2.39241767442801i,1.68344509462900 - 2.46871546661980i,1.73012052777426 - 2.54263290028477i,1.77927632028846 - 2.61419428258990i,1.83078055357588 - 2.68342354202018i,1.88450361701791 - 2.75034422837866i,1.94031820797306 - 2.81497951278637i,1.99809933177693 - 2.87735218768240i,2.05772430174222 - 2.93748466682385i,2.11907273915875 - 2.99539898528587i,2.18202657329344 - 3.05111679946161i,2.24647004139029 - 3.10465938706225i,2.31228968867045 - 3.15604764711701i,2.37937436833213 - 3.20530209997313i,2.44761524155067 - 3.25244288729587i,2.51690577747850 - 3.29748977206853i,2.58714175324518 - 3.34046213859243i,2.65822125395734 - 3.38137899248691i,2.73004467269873 - 3.42025896068934i,2.80251471053021 - 3.45712029145513i,2.87553637648973 - 3.49198085435770i,2.94901698759237 - 3.52485814028849i,3.02286616883028 - 3.55576926145700i,3.09699585317274 - 3.58473095139072i,3.17132028156612 - 3.61175956493518i,3.24575600293390 - 3.63687107825395i,3.32022187417667 - 3.66008108882861i,3.39463906017211 - 3.68140481545877i,3.46893103377502 - 3.70085709826206i,3.54302357581729 - 3.71845239867416i,3.61684477510793 - 3.73420479944875i,3.69032502843304 - 3.74812800465754i,3.76339704055583 - 3.76023533969030i,3.83599582421661 - 3.77053975125477i,3.90805870013281 - 3.77905380737677i,3.97952529699893 - 3.78578969740011i,4.05033755148662 - 3.79075923198665i,4.12043970824460 - 3.79397384311626i,4.18977831989871 - 3.79544458408684i,4.25830224705188 - 3.79518212951433i,4.32596265828416 - 3.79319677533268i,4.39271303015270 - 3.78949843879387i,4.45850914719174 - 3.78409665846792i,4.52330910191266 - 3.77700059424285i,4.58707329480390 - 3.76821902732474i,4.64976443433103 - 3.75776036023766i,4.71134753693672 - 3.74563261682374i,4.77178992704074 - 3.73184344224312i,4.83106123703997 - 3.71640010297397i,4.88913340730840 - 3.69930948681248i,4.94598068619711 - 3.68057810287287i,5.00157963003429 - 3.66021208158739i,5.05590910312523 - 3.63821717470632i,5.10895027775234 - 3.61459875529796i,5.16068663417511 - 3.58936181774863i,5.21110396063016 - 3.56251097776270i,5.26019035333119 - 3.53405047236253i,5.30793621646902 - 3.50398415988855i,5.35433426221157 - 3.47231551999917i,5.39937951070387 - 3.43904765367087i,5.44306929006805 - 3.40418328319814i,5.48540323640333 - 3.36772475219348i,5.52638329378607 - 3.32967402558743i,5.56601371426969 - 3.29003268962856i,5.60430105788473 - 3.24880195188347i,5.64125419263887 - 3.20598264123677i,5.67688429451684 - 3.16157520789111i,5.71120484748050 - 3.11557972336717i];
NSi3N4Dat = [2.27131300000000 - 0.00434226000000000i,2.23758000000000 - 0.00150376200000000i,2.21186000000000 - 0.000599154700000000i,2.18954400000000 - 0.000160294200000000i,2.17039700000000 - 2.42561400000000e-05i,2.15529700000000 + 0.00000000000000i,2.14100000000000 + 0.00000000000000i,2.13158800000000 + 0.00000000000000i,2.12213500000000 + 0.00000000000000i,2.11264000000000 + 0.00000000000000i,2.10310100000000 + 0.00000000000000i,2.09582900000000 + 0.00000000000000i,2.09026900000000 + 0.00000000000000i,2.08469300000000 + 0.00000000000000i,2.07910300000000 + 0.00000000000000i,2.07349700000000 + 0.00000000000000i,2.06787700000000 + 0.00000000000000i,2.06399500000000 + 0.00000000000000i,2.06098400000000 + 0.00000000000000i,2.05796900000000 + 0.00000000000000i,2.05494900000000 + 0.00000000000000i,2.05192400000000 + 0.00000000000000i,2.04889600000000 + 0.00000000000000i,2.04586200000000 + 0.00000000000000i,2.04282500000000 + 0.00000000000000i,2.04039000000000 + 0.00000000000000i,2.03886400000000 + 0.00000000000000i,2.03733600000000 + 0.00000000000000i,2.03580800000000 + 0.00000000000000i,2.03427800000000 + 0.00000000000000i,2.03274800000000 + 0.00000000000000i,2.03121600000000 + 0.00000000000000i,2.02968300000000 + 0.00000000000000i,2.02814800000000 + 0.00000000000000i,2.02661300000000 + 0.00000000000000i,2.02507700000000 + 0.00000000000000i,2.02353900000000 + 0.00000000000000i,2.02200000000000 + 0.00000000000000i,2.02132500000000 + 0.00000000000000i,2.02064900000000 + 0.00000000000000i,2.01997400000000 + 0.00000000000000i,2.01929800000000 + 0.00000000000000i,2.01862200000000 + 0.00000000000000i,2.01794600000000 + 0.00000000000000i,2.01726900000000 + 0.00000000000000i,2.01659200000000 + 0.00000000000000i,2.01591500000000 + 0.00000000000000i,2.01523800000000 + 0.00000000000000i,2.01456000000000 + 0.00000000000000i,2.01388300000000 + 0.00000000000000i,2.01320500000000 + 0.00000000000000i,2.01252700000000 + 0.00000000000000i,2.01184800000000 + 0.00000000000000i,2.01117000000000 + 0.00000000000000i,2.01049100000000 + 0.00000000000000i,2.00981200000000 + 0.00000000000000i,2.00913300000000 + 0.00000000000000i,2.00845300000000 + 0.00000000000000i,2.00791900000000 + 0.00000000000000i,2.00767800000000 + 0.00000000000000i,2.00743700000000 + 0.00000000000000i,2.00719500000000 + 0.00000000000000i,2.00695400000000 + 0.00000000000000i,2.00671200000000 + 0.00000000000000i,2.00647100000000 + 0.00000000000000i,2.00622900000000 + 0.00000000000000i,2.00598800000000 + 0.00000000000000i,2.00574600000000 + 0.00000000000000i,2.00550500000000 + 0.00000000000000i,2.00526300000000 + 0.00000000000000i,2.00502100000000 + 0.00000000000000i,2.00478000000000 + 0.00000000000000i,2.00453800000000 + 0.00000000000000i,2.00429600000000 + 0.00000000000000i,2.00405400000000 + 0.00000000000000i,2.00381200000000 + 0.00000000000000i];
NSiDat = [1.66361300000000 - 3.66270200000000i,1.75387300000000 - 4.08719800000000i,2.08515200000000 - 4.69581000000000i,2.95736400000000 - 5.29777900000000i,4.38112200000000 - 5.30678400000000i,5.09895700000000 - 4.22985200000000i,5.11768000000000 - 3.62122700000000i,5.13891100000000 - 3.31246100000000i,5.20880200000000 - 3.11373300000000i,5.32199700000000 - 2.98638500000000i,5.52285800000000 - 2.94162400000000i,6.05817900000000 - 2.96689400000000i,6.95857300000000 - 2.09905700000000i,6.65239400000000 - 0.917572100000000i,6.06035500000000 - 0.444374800000000i,5.63171600000000 - 0.285821300000000i,5.34655700000000 - 0.212582900000000i,5.13419000000000 - 0.160634600000000i,4.96260500000000 - 0.122018700000000i,4.81913900000000 - 0.0939212600000000i,4.69728900000000 - 0.0739159300000000i,4.59272700000000 - 0.0598907000000000i,4.50238500000000 - 0.0501741100000000i,4.42391700000000 - 0.0434724500000000i,4.35528000000000 - 0.0387762600000000i,4.29492700000000 - 0.0353747500000000i,4.24152700000000 - 0.0327590300000000i,4.19392100000000 - 0.0305925000000000i,4.15113400000000 - 0.0286754500000000i,4.11249400000000 - 0.0269094600000000i,4.07732400000000 - 0.0252482700000000i,4.04518300000000 - 0.0236772700000000i,4.01567700000000 - 0.0221908900000000i,3.98847100000000 - 0.0207852600000000i,3.96331000000000 - 0.0194575300000000i,3.93996900000000 - 0.0182043800000000i,3.91824200000000 - 0.0170216300000000i,3.89796000000000 - 0.0159055000000000i,3.87901700000000 - 0.0148545100000000i,3.86126100000000 - 0.0138637700000000i,3.84458500000000 - 0.0129302700000000i,3.82889500000000 - 0.0120509300000000i,3.81411400000000 - 0.0112231900000000i,3.80017700000000 - 0.0104448400000000i,3.78699700000000 - 0.00971188900000000i,3.77452000000000 - 0.00902226300000000i,3.76270800000000 - 0.00837446500000000i,3.75149300000000 - 0.00776502500000000i,3.74084000000000 - 0.00719237600000000i,3.73072000000000 - 0.00665514400000000i,3.72107900000000 - 0.00615027000000000i,3.71188900000000 - 0.00567625900000000i,3.70312300000000 - 0.00523163400000000i,3.69475900000000 - 0.00481509900000000i,3.68676700000000 - 0.00442494300000000i,3.67912300000000 - 0.00405951100000000i,3.67181300000000 - 0.00371799800000000i,3.66481300000000 - 0.00339879900000000i,3.65810200000000 - 0.00310060100000000i,3.65166400000000 - 0.00282212400000000i,3.64548000000000 - 0.00256213800000000i,3.63954900000000 - 0.00232062100000000i,3.63385100000000 - 0.00209620800000000i,3.62836200000000 - 0.00188702800000000i,3.62309600000000 - 0.00169400000000000i,3.61801900000000 - 0.00151482200000000i,3.61313200000000 - 0.00134951800000000i,3.60842300000000 - 0.00119702600000000i,3.60388700000000 - 0.00105704400000000i,3.59950400000000 - 0.000928133900000000i,3.59528800000000 - 0.000811176600000000i,3.59120900000000 - 0.000703889600000000i,3.58727200000000 - 0.000606842400000000i,3.58347600000000 - 0.000519527400000000i,3.57980100000000 - 0.000440674200000000i,3.57624400000000 - 0.000369945100000000i];
NSiO2Dat = [1.51352500000000,1.50841300000000,1.50397200000000,1.50008700000000,1.49666500000000,1.49363000000000,1.49092700000000,1.48850600000000,1.48632700000000,1.48435900000000,1.48257200000000,1.48094700000000,1.47946100000000,1.47809900000000,1.47684800000000,1.47569400000000,1.47462800000000,1.47363900000000,1.47272100000000,1.47186700000000,1.47106900000000,1.47032400000000,1.46962500000000,1.46896900000000,1.46835200000000,1.46777100000000,1.46722200000000,1.46670400000000,1.46621200000000,1.46574600000000,1.46530400000000,1.46488300000000,1.46448200000000,1.46409900000000,1.46373300000000,1.46338300000000,1.46304800000000,1.46272700000000,1.46241800000000,1.46212100000000,1.46183500000000,1.46156000000000,1.46129400000000,1.46103700000000,1.46078900000000,1.46054700000000,1.46031400000000,1.46008900000000,1.45986800000000,1.45965500000000,1.45944700000000,1.45924500000000,1.45904700000000,1.45885400000000,1.45866500000000,1.45848200000000,1.45830100000000,1.45812500000000,1.45795200000000,1.45778300000000,1.45761600000000,1.45745200000000,1.45729100000000,1.45713300000000,1.45697700000000,1.45682300000000,1.45667200000000,1.45652200000000,1.45637500000000,1.45622900000000,1.45608500000000,1.45594300000000,1.45580100000000,1.45566200000000,1.45552400000000,1.45538600000000];
NWDat = [3.38758500000000 - 2.78270200000000i,3.31761600000000 - 2.54242900000000i,3.23585900000000 - 2.40505200000000i,3.14725500000000 - 2.32860500000000i,3.05524400000000 - 2.31483400000000i,2.98327500000000 - 2.35659300000000i,2.95000000000000 - 2.43000000000000i,2.97025700000000 - 2.51540600000000i,3.01583000000000 - 2.59445300000000i,3.09256700000000 - 2.65128000000000i,3.18862200000000 - 2.69140900000000i,3.32791300000000 - 2.69539600000000i,3.42925000000000 - 2.60110600000000i,3.44993500000000 - 2.50556500000000i,3.42181700000000 - 2.44182200000000i,3.39000000000000 - 2.41000000000000i,3.35971600000000 - 2.41999300000000i,3.33085700000000 - 2.42956900000000i,3.31665400000000 - 2.45666300000000i,3.30357600000000 - 2.48281700000000i,3.30888000000000 - 2.52557400000000i,3.31091200000000 - 2.55369300000000i,3.32467400000000 - 2.59702600000000i,3.34333300000000 - 2.62668000000000i,3.36177900000000 - 2.65573500000000i,3.39613500000000 - 2.69209900000000i,3.43117000000000 - 2.71371400000000i,3.45929000000000 - 2.71998600000000i,3.48418000000000 - 2.71999500000000i,3.49999900000000 - 2.72075700000000i,3.49999900000000 - 2.72916000000000i,3.49284600000000 - 2.74428300000000i,3.49974300000000 - 2.77942100000000i,3.51724900000000 - 2.81725500000000i,3.53912800000000 - 2.83912800000000i,3.56002800000000 - 2.85334800000000i,3.58035900000000 - 2.87036600000000i,3.60031700000000 - 2.89019000000000i,3.63183900000000 - 2.90909000000000i,3.66255800000000 - 2.92500500000000i,3.69230200000000 - 2.93690800000000i,3.72531700000000 - 2.94417300000000i,3.75932200000000 - 2.94988500000000i,3.79157800000000 - 2.92879400000000i,3.82180900000000 - 2.90694600000000i,3.83697700000000 - 2.88153700000000i,3.84925000000000 - 2.85426600000000i,3.84436400000000 - 2.81589900000000i,3.83811300000000 - 2.77811800000000i,3.81106200000000 - 2.75110500000000i,3.78382800000000 - 2.72383800000000i,3.74008800000000 - 2.70538600000000i,3.69318300000000 - 2.68835700000000i,3.64758200000000 - 2.68993900000000i,3.60358800000000 - 2.70981400000000i,3.55969900000000 - 2.73022100000000i,3.52964100000000 - 2.75245200000000i,3.49969700000000 - 2.77497600000000i,3.46804000000000 - 2.79700000000000i,3.43290800000000 - 2.81783700000000i,3.39784900000000 - 2.83904200000000i,3.36529900000000 - 2.86748200000000i,3.33558000000000 - 2.90339000000000i,3.30625100000000 - 2.93959800000000i,3.27771300000000 - 2.97459900000000i,3.25003200000000 - 3.00796400000000i,3.22269400000000 - 3.04157900000000i,3.19620300000000 - 3.07768600000000i,3.17284100000000 - 3.12577500000000i,3.15011500000000 - 3.17393800000000i,3.12801800000000 - 3.22215200000000i,3.10803800000000 - 3.26471200000000i,3.08939100000000 - 3.30396500000000i,3.07116000000000 - 3.34324300000000i,3.05334000000000 - 3.38253400000000i,3.03913800000000 - 3.43976000000000i];
NMica = 1.6;

NVals = zeros(10,76);

NVals(1,:) = NAir;
NVals(2,:) = NCuDat;
NVals(3,:) = NGrDat;
NVals(4,:) = NhBN;
NVals(5,:) = NHfO2Dat;
NVals(6,:) = NSb2Te3;
NVals(7,:) = NSi3N4Dat;
NVals(8,:) = NSiDat;
NVals(9,:) = NSiO2Dat;
NVals(10,:) = NWDat;
NVals(11,:) = NMica;

clear NAir NSiDat NSiO2Dat NHfO2Dat NSi3N4Dat NCuDat NWDat NGrDat NhBN NSb2Te3;


%Declare wavelengths to be used
wavelengths = linspace(250,1000,76);
wavelengths = wavelengths*10^-9;


%Gather all input data
filledlayers = zeros(3,7);

%First, label ALL layers
for a = 1:7
    filledlayers(1,a) = a;
end

%Then, get ALL layer types
filledlayers(2,1) = get(handles.popupmenu1,'Value');
filledlayers(2,2) = get(handles.popupmenu2,'Value');
filledlayers(2,3) = get(handles.popupmenu3,'Value');
filledlayers(2,4) = get(handles.popupmenu4,'Value');
filledlayers(2,5) = get(handles.popupmenu5,'Value');
filledlayers(2,6) = get(handles.popupmenu6,'Value');
filledlayers(2,7) = get(handles.popupmenu7,'Value');


%Change the type number to the ALPHABETIZED scheme
for a = 1:7
    
    %Account for layers 2+ having 1 more entry
    if a == 1
    else
        filledlayers(2,a) = filledlayers(2,a)-1;
    end
end

%Finally, get ALL layer thicknesses
filledlayers(3,1) = str2double(get(handles.edit1,'String'))*10^-9;
filledlayers(3,2) = str2double(get(handles.edit2,'String'))*10^-9;
filledlayers(3,3) = str2double(get(handles.edit3,'String'))*10^-9;
filledlayers(3,4) = str2double(get(handles.edit4,'String'))*10^-9;
filledlayers(3,5) = str2double(get(handles.edit5,'String'))*10^-9;
filledlayers(3,6) = str2double(get(handles.edit6,'String'))*10^-9;
filledlayers(3,7) = str2double(get(handles.edit7,'String'))*10^-9;


%Check if the contrast layer is invalid
if isempty(contrastlayer) || filledlayers(2,contrastlayer)==0
    contrastlayer = 1;
    set(handles.radiobutton1, 'Value', 1);
end


%Get rid of all empty layers
numempties = 0;
for a = 1:7
    if filledlayers(2,a-numempties) == 0
        filledlayers(:,a-numempties) = [];
        numempties = numempties+1;
    end
end
clear numempties


%Save stack for bar graph
barDat = zeros(2,size(filledlayers,2));
barDat(1,:) = filledlayers(3,:);
barDat(2,:) = filledlayers(3,:);


%Compute beta values
betaVals = zeros(76,size(filledlayers,2));
for a = 1:size(betaVals,2)          %For all filled layers
    for b = 1:size(betaVals,1)      %For all wavelengths
        betaVals(b,a) = (2*pi*filledlayers(3,a)*NVals(filledlayers(2,a),b))/wavelengths(b);
    end
end


%Compute 2 layer values
rVals = zeros(76,size(filledlayers,2)+1);
for b = 1:size(rVals,1)
    %Bottom layer and Si First
    rVals(b,1) = (NVals(8,b)-NVals(filledlayers(2,1),b))/(NVals(8,b)+NVals(filledlayers(2,1),b));
    %Lower layer and upper layer
    for a = 1:size(rVals,2)-2
        rVals(b,a+1) = (NVals(filledlayers(2,a),b)-NVals(filledlayers(2,a+1),b))/(NVals(filledlayers(2,a),b)+NVals(filledlayers(2,a+1),b));        
    end
    %Air and top layer last
    rVals(b,end) = (NVals(filledlayers(2,end),b)-NVals(1,b))/(NVals(filledlayers(2,end),b)+NVals(1,b));
end


%Compute rTot values iteratively (#filledlayers+air+Si-1 =
%#filledlayers+1 iterations)
rTotVals = zeros(76,1);
for b = 1:76
    rTotVals(b) = (rVals(b,2)+rVals(b,1)*exp(-2i*betaVals(b,1)))/(1+rVals(b,2)*rVals(b,1)*exp(-2i*betaVals(b,1)));
end

if size(filledlayers,2) > 1
    for a = 2:size(filledlayers,2)
        for b = 1:76
            rTotVals(b) = (rVals(b,a+1)+rTotVals(b)*exp(-2i*betaVals(b,a)))/(1+rVals(b,a+1)*rTotVals(b)*exp(-2i*betaVals(b,a)));
        end
    end
end


%Compute R values
RVals = zeros(76,1);
for b = 1:76
    RVals(b) = rTotVals(b)*conj(rTotVals(b));
end




%Get rid of contrast layer
numempties = 0;
for a = 1:size(filledlayers,2)
    if filledlayers(1,a-numempties) == contrastlayer
        filledlayers(:,a-numempties) = [];
        barDat(2,a-numempties) = 0;
        numempties = numempties+1;
    end
end
clear numempties


%Compute NAKED beta values
betaVals = zeros(76,size(filledlayers,2));
for a = 1:size(betaVals,2)          %For all filled layers
    for b = 1:size(betaVals,1)      %For all wavelengths
        betaVals(b,a) = (2*pi*filledlayers(3,a)*NVals(filledlayers(2,a),b))/wavelengths(b);
    end
end


if isempty(filledlayers)
    
    rVals = zeros(76,1);
    for b = 1:76
        rVals(b) = (NVals(8,b)-NVals(1,b))/(NVals(8,b)+NVals(1,b));
    end
    
    RNakedVals = zeros(76,1);
    for b = 1:76
        RNakedVals(b) = rVals(b)*conj(rVals(b));
    end
    
else
    %Compute NAKED 2 layer values
    rVals = zeros(76,size(filledlayers,2)+1);
    for b = 1:size(rVals,1)
        %Bottom layer and Si First
        rVals(b,1) = (NVals(8,b)-NVals(filledlayers(2,1),b))/(NVals(8,b)+NVals(filledlayers(2,1),b));
        %Lower layer and upper layer
        for a = 1:size(rVals,2)-2
            rVals(b,a+1) = (NVals(filledlayers(2,a),b)-NVals(filledlayers(2,a+1),b))/(NVals(filledlayers(2,a),b)+NVals(filledlayers(2,a+1),b));
        end
        %Air and top layer last
        rVals(b,end) = (NVals(filledlayers(2,end),b)-NVals(1,b))/(NVals(filledlayers(2,end),b)+NVals(1,b));
    end
    
    
    %Compute NAKED rTot values iteratively (#filledlayers+air+Si-1 =
    %#filledlayers+1 iterations)
    rTotVals = zeros(76,1);
    for b = 1:76
        rTotVals(b) = (rVals(b,2)+rVals(b,1)*exp(-2i*betaVals(b,1)))/(1+rVals(b,2)*rVals(b,1)*exp(-2i*betaVals(b,1)));
    end
    
    if size(filledlayers,2) > 1
        for a = 2:size(filledlayers,2)
            for b = 1:76
                rTotVals(b) = (rVals(b,a+1)+rTotVals(b)*exp(-2i*betaVals(b,a)))/(1+rVals(b,a+1)*rTotVals(b)*exp(-2i*betaVals(b,a)));
            end
        end
    end
    
    
    %Compute NAKED R values
    RNakedVals = zeros(76,1);
    for b = 1:76
        RNakedVals(b) = rTotVals(b)*conj(rTotVals(b));
    end
end


%Compute comparison R values
RCompare = zeros(76,1);
for b = 1:76
    RCompare(b) = (RVals(b)-RNakedVals(b))/(RNakedVals(b));
end

%Make Rmax = 2
for b = 1:76
    if RCompare(b) > 2
        RCompare(b) = 2;
    elseif RCompare(b) < -2
        RCompare(b) = -2;
    end
end


axes(handles.axes1);
plot(wavelengths*10^9,RCompare, '.-');
grid on
xlabel('Wavelength (nm)');
ylabel('Reflection Contrast');
axis([250 1000 -2 2])

axes(handles.axes2);
barDat = barDat*10^9;
bar(barDat,'stacked');
ylabel('Stack Thickness (nm)');
set(handles.axes2, 'XTickLabel', {'W/ Contrast Layer', 'W/O Contrast Layer'});

a = 0;
