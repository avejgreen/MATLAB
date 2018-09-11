function varargout = GenmatGUI(varargin)
% GENMATGUI MATLAB code for GenmatGUI.fig
%      GENMATGUI, by itself, creates a new GENMATGUI or raises the existing
%      singleton*.
%
%      H = GENMATGUI returns the handle to a new GENMATGUI or the handle to
%      the existing singleton*.
%
%      GENMATGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENMATGUI.M with the given input arguments.
%
%      GENMATGUI('Property','Value',...) creates a new GENMATGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GenmatGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GenmatGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GenmatGUI

% Last Modified by GUIDE v2.5 06-Feb-2018 12:28:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GenmatGUI_OpeningFcn, ...
    'gui_OutputFcn',  @GenmatGUI_OutputFcn, ...
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


% --- Executes just before GenmatGUI is made visible.
function GenmatGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GenmatGUI (see VARARGIN)

% Choose default command line output for GenmatGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Plot Distributions
clearvars -global betadists mat
clearvars all -except eventdata hObject handles varargin

global betadists;

betadists(1).name='Seg Angle';betadists(1).min=0;betadists(1).max=2*pi;
betadists(1).q=1;betadists(1).r=30;
betadists(2).name='Seg Radius';betadists(2).min=0;betadists(2).max=3;
betadists(2).q=7;betadists(2).r=11;
betadists(3).name='N Segs';betadists(3).min=0;betadists(3).max=50;
betadists(3).q=7;betadists(3).r=11;
betadists(4).name='Swivel Angle';betadists(4).min=0;betadists(4).max=2*pi;
betadists(4).q=1.5;betadists(4).r=1.5;
betadists(5).name='Fib Radius';betadists(5).min=0;betadists(5).max=.05;
betadists(5).q=3;betadists(5).r=3;
betadists(6).name='Kink Angles';betadists(6).min=0;betadists(6).max=2*pi;
betadists(6).q=1;betadists(6).r=1;
betadists(7).name='Fib Dir';betadists(7).min=0;betadists(7).max=pi;
betadists(7).q=100;betadists(7).r=100;
for i = 1:7
    betadists(i).range=betadists(i).max-betadists(i).min;
end

plot(handles.axesdist,...
    linspace(betadists(1).min,betadists(1).max,51),...
    betapdf(linspace(0,1,51),betadists(1).q,betadists(1).r));
xlim(handles.axesdist,[betadists(1).min,betadists(1).max]);

set(handles.editbetaq,'String',int2str(betadists(1).q));
set(handles.editbetar,'String',int2str(betadists(1).r));
set(handles.editbetamin,'String',num2str(betadists(1).min));
set(handles.editbetamax,'String',num2str(betadists(1).max));

test = 1;

% UIWAIT makes GenmatGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GenmatGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in butgenmat.
function butgenmat_Callback(hObject, eventdata, handles)
% hObject    handle to butgenmat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
test = 1;
global mat;
Genmat(handles);

nfibs = length(mat.fibs);
strlist = cell(1);
for i = 1:nfibs
   strlist{i} = horzcat('Fiber ',int2str(i),...
       ': Length = ',num2str(mat.fibs(i).length)); 
end
set(handles.listfibers,'String',strlist);

Mataxesplotter(handles,mat.plot,'Matrix');

% --- Executes on button press in butgenfib.
function butgenfib_Callback(hObject, eventdata, handles)
% hObject    handle to butgenfib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat;

%Generate fiber
fib = Genfib(handles);

if isempty(mat)
    fib.number = 1;
    
    mat.fibs = fib;
    mat.length = fib.length;
    mat.plot = Makematplot(handles,fib);
%     mat.plot = Makeperplot(handles,fib);
else
    fib.number = length(mat.fibs)+1;
    
    mat.fibs(end+1) = fib;
    mat.length = sum([mat.fibs(:).length]);
    mat.plot(end+1) = Makematplot(handles,fib);
%     mat.plot(end+1) = Makeperplot(handles,fib);
end

Mataxesplotter(handles,fib,'Fiber');

fiberlist = get(handles.listfibers,'String');

if ischar(fiberlist)
    if strcmp(fiberlist,'Fiber List')
        fiberlist = horzcat('Fiber 1: Length = ',num2str(fib.length));
    elseif strcmp(fiberlist(1:8),'Fiber 1:')
        newfiblist = cell(2,1);
        newfiblist{1} = fiberlist;
        newfiblist{2} = horzcat('Fiber 2: Length = ',num2str(fib.length));
        fiberlist = newfiblist;
    end
else
    fibnumber = length(fiberlist)+1;
    fiberlist{end+1,1} = horzcat('Fiber ',int2str(fibnumber),...
        ': Length = ',num2str(fib.length));
end

set(handles.listfibers,'String',fiberlist);

test = 1;

% --- Executes on button press in butplotmat.
function butplotmat_Callback(hObject, eventdata, handles)
% hObject    handle to butplotmat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

test = 1;
global mat;
Mataxesplotter(handles,mat.plot,'Matrix');


% --- Executes on button press in butplotfib.
function butplotfib_Callback(hObject, eventdata, handles)
% hObject    handle to butplotfib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat;
fibnum = get(hObject,'Value');
Mataxesplotter(handles,mat.fibs(fibnum),'Fiber')

% --- Executes on selection change in listfibers.
function listfibers_Callback(hObject, eventdata, handles)
% hObject    handle to listfibers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat;
fibnum = get(hObject,'Value');
Mataxesplotter(handles,mat.fibs(fibnum),'Fiber')
% Hints: contents = cellstr(get(hObject,'String')) returns listfibers contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listfibers


% --- Executes during object creation, after setting all properties.
function listfibers_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listfibers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editrho_Callback(hObject, eventdata, handles)
% hObject    handle to editrho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editrho as text
%        str2double(get(hObject,'String')) returns contents of editrho as a double


% --- Executes during object creation, after setting all properties.
function editrho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editrho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLx_Callback(hObject, eventdata, handles)
% hObject    handle to editLx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLx as text
%        str2double(get(hObject,'String')) returns contents of editLx as a double


% --- Executes during object creation, after setting all properties.
function editLx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLy_Callback(hObject, eventdata, handles)
% hObject    handle to editLy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLy as text
%        str2double(get(hObject,'String')) returns contents of editLy as a double


% --- Executes during object creation, after setting all properties.
function editLy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editLz_Callback(hObject, eventdata, handles)
% hObject    handle to editLz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLz as text
%        str2double(get(hObject,'String')) returns contents of editLz as a double


% --- Executes during object creation, after setting all properties.
function editLz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editplotprec_Callback(hObject, eventdata, handles)
% hObject    handle to editplotprec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editplotprec as text
%        str2double(get(hObject,'String')) returns contents of editplotprec as a double


% --- Executes during object creation, after setting all properties.
function editplotprec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editplotprec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupbetadists.
function popupbetadists_Callback(hObject, eventdata, handles)
% hObject    handle to popupbetadists (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global betadists;
fieldnum = get(hObject,'Value');
plot(handles.axesdist,...
    linspace(betadists(fieldnum).min,betadists(fieldnum).max,51),...
    betapdf(linspace(0,1,51),betadists(fieldnum).q,betadists(fieldnum).r));
xlim(handles.axesdist,[betadists(fieldnum).min,betadists(fieldnum).max]);

set(handles.editbetaq,'String',int2str(betadists(fieldnum).q));
set(handles.editbetar,'String',int2str(betadists(fieldnum).r));
set(handles.editbetamin,'String',num2str(betadists(fieldnum).min));
set(handles.editbetamax,'String',num2str(betadists(fieldnum).max));

% Hints: contents = cellstr(get(hObject,'String')) returns popupbetadists contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupbetadists


% --- Executes during object creation, after setting all properties.
function popupbetadists_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupbetadists (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editbetaq_Callback(hObject, eventdata, handles)
% hObject    handle to editbetaq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global betadists;
fieldnum = get(handles.popupbetadists,'Value');
betadists(fieldnum).q=str2double(get(hObject,'String'));
plot(handles.axesdist,...
    linspace(betadists(fieldnum).min,betadists(fieldnum).max,51),...
    betapdf(linspace(0,1,51),betadists(fieldnum).q,betadists(fieldnum).r));
xlim(handles.axesdist,[betadists(fieldnum).min,betadists(fieldnum).max]);
% Hints: get(hObject,'String') returns contents of editbetaq as text
%        str2double(get(hObject,'String')) returns contents of editbetaq as a double


% --- Executes during object creation, after setting all properties.
function editbetaq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbetaq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editbetar_Callback(hObject, eventdata, handles)
% hObject    handle to editbetar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global betadists;
fieldnum = get(handles.popupbetadists,'Value');
betadists(fieldnum).r=str2double(get(hObject,'String'));
plot(handles.axesdist,...
    linspace(betadists(fieldnum).min,betadists(fieldnum).max,51),...
    betapdf(linspace(0,1,51),betadists(fieldnum).q,betadists(fieldnum).r));
xlim(handles.axesdist,[betadists(fieldnum).min,betadists(fieldnum).max]);
% Hints: get(hObject,'String') returns contents of editbetar as text
%        str2double(get(hObject,'String')) returns contents of editbetar as a double


% --- Executes during object creation, after setting all properties.
function editbetar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbetar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editbetamin_Callback(hObject, eventdata, handles)
% hObject    handle to editbetamin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global betadists;
fieldnum = get(handles.popupbetadists,'Value');
betadists(fieldnum).min=str2double(get(hObject,'String'));
betadists(fieldnum).range=betadists(fieldnum).max-betadists(fieldnum).min;
plot(handles.axesdist,...
    linspace(betadists(fieldnum).min,betadists(fieldnum).max,51),...
    betapdf(linspace(0,1,51),betadists(fieldnum).q,betadists(fieldnum).r));
xlim(handles.axesdist,[betadists(fieldnum).min,betadists(fieldnum).max]);
% Hints: get(hObject,'String') returns contents of editbetamin as text
%        str2double(get(hObject,'String')) returns contents of editbetamin as a double


% --- Executes during object creation, after setting all properties.
function editbetamin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbetamin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editbetamax_Callback(hObject, eventdata, handles)
% hObject    handle to editbetamax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global betadists;
fieldnum = get(handles.popupbetadists,'Value');
betadists(fieldnum).max=str2double(get(hObject,'String'));
betadists(fieldnum).range=betadists(fieldnum).max-betadists(fieldnum).min;
plot(handles.axesdist,...
    linspace(betadists(fieldnum).min,betadists(fieldnum).max,51),...
    betapdf(linspace(0,1,51),betadists(fieldnum).q,betadists(fieldnum).r));
xlim(handles.axesdist,[betadists(fieldnum).min,betadists(fieldnum).max]);
% Hints: get(hObject,'String') returns contents of editbetamax as text
%        str2double(get(hObject,'String')) returns contents of editbetamax as a double


% --- Executes during object creation, after setting all properties.
function editbetamax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbetamax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function Mataxesplotter(handles,obj2draw,type)

Lx = str2double(get(handles.editLx,'String'));
Ly = str2double(get(handles.editLy,'String'));
Lz = str2double(get(handles.editLz,'String'));

if strcmp(type,'Fiber')
    
    axes(handles.axesmatrix)
    cla;
    hold all;
    axis equal;
    %     xlim([0,str2double(get(handles.editLx,'String'))]);
    %     ylim([0,str2double(get(handles.editLy,'String'))]);
    %     zlim([0,str2double(get(handles.editLz,'String'))]);
    grid on;
    view(3);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    cameratoolbar('NoReset');
    
    for i = 1:length(obj2draw.segs);
        plot3(obj2draw.segs(i).plot(:,1),obj2draw.segs(i).plot(:,2),...
            obj2draw.segs(i).plot(:,3),'LineWidth',2);
    end
    
    xlim('auto');
    ylim('auto');
    zlim('auto');
    
    test = 1;
    
elseif strcmp(type,'Matrix')
    
    test =1;
    
    axes(handles.axesmatrix)
    cla;
    axis equal;
    %     xlim([0,str2double(get(handles.editLx,'String'))]);
    %     ylim([0,str2double(get(handles.editLy,'String'))]);
    %     zlim([0,str2double(get(handles.editLz,'String'))]);
    grid on;
    view(3);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    cameratoolbar('NoReset');
    light;
    lighting gouraud;
    
    colornum = 1;
    colors = get(gca,'ColorOrder');
    
    for i = 1:length(obj2draw);
        surf(obj2draw(i).D3.X,obj2draw(i).D3.Y,obj2draw(i).D3.Z,...
            'EdgeAlpha',0,'FaceColor',colors(colornum,:));
        colornum = mod(colornum,7)+1;
    end
    
    xlim([0,Lx]);
    ylim([0,Ly]);
    zlim([0,Lz]);
    
end


% --- Executes on button press in butexport.
function butexport_Callback(hObject, eventdata, handles)
% hObject    handle to butexport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(0,'showhiddenhandles','on'); % Make the GUI figure handle visible
f1 = figure; % Open a new figure with handle f1
s = copyobj(handles.axesmatrix,f1);
path = mfilename('fullpath');
[path, name, ext] = fileparts(path);
[FileName,PathName,FilterIndex] = uiputfile(path,'Save VRML File:',...
    horzcat(path,'/','Fiber Matrix'));
if isa(FileName,'double')
else
    [path, name, ext] = fileparts(horzcat(PathName,'/',FileName));
    vrml(gcf,horzcat(path,name));
end
close(gcf);
set(0,'showhiddenhandles','off')



% --- Executes on button press in butclear.
function butclear_Callback(hObject, eventdata, handles)
% hObject    handle to butclear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mat;
clear global mat;
set(handles.listfibers,'Value',1);
set(handles.listfibers,'String','Fiber List');
cla(handles.axesmatrix);



function editkinkprob_Callback(hObject, eventdata, handles)
% hObject    handle to editkinkprob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editkinkprob as text
%        str2double(get(hObject,'String')) returns contents of editkinkprob as a double


% --- Executes during object creation, after setting all properties.
function editkinkprob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editkinkprob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
