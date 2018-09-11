function varargout = SimulatorGUI(varargin)
% SIMULATORGUI MATLAB code for SimulatorGUI.fig
%      SIMULATORGUI, by itself, creates a new SIMULATORGUI or raises the existing
%      singleton*.
%
%      H = SIMULATORGUI returns the handle to a new SIMULATORGUI or the handle to
%      the existing singleton*.
%
%      SIMULATORGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIMULATORGUI.M with the given input arguments.
%
%      SIMULATORGUI('Property','Value',...) creates a new SIMULATORGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SimulatorGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SimulatorGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SimulatorGUI

% Last Modified by GUIDE v2.5 02-Nov-2016 18:24:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SimulatorGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @SimulatorGUI_OutputFcn, ...
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


% --- Executes just before SimulatorGUI is made visible.
function SimulatorGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SimulatorGUI (see VARARGIN)
[pathstr, name, ext] = fileparts(mfilename('fullpath'));
oldfolder = cd(horzcat(pathstr,'/SubFcns'));
handles.ScriptFile = {pathstr,name,ext,oldfolder};

%Load elemental information
A=fopen('ElementTable.csv');
handles.ElementInfo=textscan(A,'%d%f%s%s%d%d%f%f%s%d%s%f','Delimiter',',');
fclose(A); clear A;
handles.ElementInfo{12}(109) = handles.ElementInfo{12}(108);

handles.AllCrystals = struct('LayerNum',[],...
    'Name',[],...
    'a',[],...
    'b',[],...
    'S',[],...
    'Atoms',[],...
    'hkl',[],...
    'gVectors',[],...
    'SF',[],...
    'uvw',[],...
    'rVectors',[],...
    'SurfDirNum',[],...
    'NotchDirNum',[],...
    'MeasPlaneNum',[],...
    'aAligned',[],...
    'bAligned',[],...
    'rVectorsAligned',[],...
    'gVectorsAligned',[]);

axes(handles.axes1);
cameratoolbar;
axis equal;
xlim(handles.axes1,[-1,1]);
ylim(handles.axes1,[-1,1]);
zlim(handles.axes1,[0,1]);
xlabel('gx (1/A)');
ylabel('gy (1/A)');
zlabel('gz (1/A)');
view(120,25);
grid;
hold on;

% Choose default command line output for SimulatorGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SimulatorGUI wait for user response (see UIRESUME)
uiwait(handles.figure1);




% --- Outputs from this function are returned to the command line.
function varargout = SimulatorGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

delete(handles.figure1);

cd(handles.ScriptFile{4});


% --- Executes on button press in Layer1Button.
function Layer1Button_Callback(hObject, eventdata, handles)
% hObject    handle to Layer1Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Crystal = struct;

[error,Name,a,b,S,Atoms] = XTLLoader(horzcat(handles.ScriptFile{1},'/XTLFiles'));
if error == 0
    Crystal.LayerNum = 1;
    Crystal.Name=Name;
    Crystal.a=a;
    Crystal.b=b;
    Crystal.S=S;
    Crystal.Atoms=Atoms;
    clear Name a b S Atoms;
    
    set(handles.Layer1Name,'String',Crystal.Name);
    
    %Get available atoms, planes, and structure factors
    Crystal.Atoms = [num2cell(cellfun(@(x) ...
        find(strcmp(x,handles.ElementInfo{4})),Crystal.Atoms(:,1))),Crystal.Atoms];
    [Crystal.hkl,Crystal.gVectors] = gCalculator(Crystal);
    Crystal.SF = SFCalculator(Crystal);
    [Crystal.uvw,Crystal.rVectors] = rCalculator(Crystal);
    
    %Reduce planes to allowed.
    AllowedPlanes = Crystal.SF==0;
    Crystal.hkl(AllowedPlanes,:)=[];
    Crystal.gVectors(AllowedPlanes,:)=[];
    Crystal.uvw(AllowedPlanes,:)=[];
    Crystal.rVectors(AllowedPlanes,:)=[];
    Crystal.SF(AllowedPlanes,:)=[];
    clear AllowedPlanes
    
    %Populate direction lists
    hklList = cell(size(Crystal.hkl,1),1);
    for i = 1:length(hklList)
        hklList{i} = sprintf('%d %d %d',Crystal.hkl(i,:)');
    end
    set(handles.Surface1HKL,'String',hklList,'Value',IdealSurfNum(Crystal));
    set(handles.Notch1HKL,'String',hklList,'Value',IdealNotchNum(Crystal));
    set(handles.ScanPlane1,'String',hklList,'Value',1+round(length(hklList)/2));
    
    Crystal.SurfDirNum = get(handles.Surface1HKL,'Value');
    Crystal.NotchDirNum = get(handles.Notch1HKL,'Value');
    Crystal.MeasPlaneNum = get(handles.ScanPlane1,'Value');
    
    uvwList = cell(size(Crystal.uvw,1),1);
    for i = 1:length(uvwList)
        uvwList{i} = sprintf('%d %d %d',Crystal.uvw(i,:)');
    end
    set(handles.Surface1UVW,'String',uvwList,'Value',IdealSurfNum(Crystal));
    set(handles.Notch1UVW,'String',uvwList,'Value',IdealNotchNum(Crystal));
    
    [Crystal.aAligned,Crystal.bAligned,Crystal.rVectorsAligned,Crystal.gVectorsAligned] = Aligner(Crystal);
    
    handles.AllCrystals(1) = Crystal;
    guidata(handles.figure1,handles)
    PlotgVectors(handles);
end




% --- Executes on button press in Layer2Button.
function Layer2Button_Callback(hObject, eventdata, handles)
% hObject    handle to Layer2Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Crystal = struct;

[error,Name,a,b,S,Atoms] = XTLLoader(horzcat(handles.ScriptFile{1},'/XTLFiles'));
if error == 0
    Crystal.LayerNum = 2;
    Crystal.Name=Name;
    Crystal.a=a;
    Crystal.b=b;
    Crystal.S=S;
    Crystal.Atoms=Atoms;
    clear Name a b S Atoms;
    
    set(handles.Layer2Name,'String',Crystal.Name);
    
    %Get available atoms, planes, and structure factors
    Crystal.Atoms = [num2cell(cellfun(@(x) ...
        find(strcmp(x,handles.ElementInfo{4})),Crystal.Atoms(:,1))),Crystal.Atoms];
    [Crystal.hkl,Crystal.gVectors] = gCalculator(Crystal);
    Crystal.SF = SFCalculator(Crystal);
    [Crystal.uvw,Crystal.rVectors] = rCalculator(Crystal);
    
    %Reduce planes to allowed.
    AllowedPlanes = Crystal.SF==0;
    Crystal.hkl(AllowedPlanes,:)=[];
    Crystal.gVectors(AllowedPlanes,:)=[];
    Crystal.uvw(AllowedPlanes,:)=[];
    Crystal.rVectors(AllowedPlanes,:)=[];
    Crystal.SF(AllowedPlanes,:)=[];
    clear AllowedPlanes
    
    %Populate direction lists
    hklList = cell(size(Crystal.hkl,1),1);
    for i = 1:length(hklList)
        hklList{i} = sprintf('%d %d %d',Crystal.hkl(i,:)');
    end
    set(handles.Surface2HKL,'String',hklList,'Value',IdealSurfNum(Crystal));
    set(handles.Notch2HKL,'String',hklList,'Value',IdealNotchNum(Crystal));
    set(handles.ScanPlane2,'String',hklList,'Value',1+round(length(hklList)/2));
    
    Crystal.SurfDirNum = get(handles.Surface2HKL,'Value');
    Crystal.NotchDirNum = get(handles.Notch2HKL,'Value');
    Crystal.MeasPlaneNum = get(handles.ScanPlane2,'Value');
    
    uvwList = cell(size(Crystal.uvw,1),1);
    for i = 1:length(uvwList)
        uvwList{i} = sprintf('%d %d %d',Crystal.uvw(i,:)');
    end
    set(handles.Surface2UVW,'String',uvwList,'Value',IdealSurfNum(Crystal));
    set(handles.Notch2UVW,'String',uvwList,'Value',IdealNotchNum(Crystal));
    
    [Crystal.aAligned,Crystal.bAligned,Crystal.rVectorsAligned,Crystal.gVectorsAligned] = Aligner(Crystal);
    
    handles.AllCrystals(2) = Crystal;
    guidata(handles.figure1,handles)
    PlotgVectors(handles);
end


% --- Executes on selection change in ScanPlane1.
function ScanPlane1_Callback(hObject, eventdata, handles)
% hObject    handle to ScanPlane1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScanPlane1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScanPlane1
handles.AllCrystals(1).MeasPlaneNum = get(hObject,'Value');
guidata(handles.figure1,handles);
PlotgVectors(handles);


% --- Executes during object creation, after setting all properties.
function ScanPlane1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScanPlane1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ScanPlane2.
function ScanPlane2_Callback(hObject, eventdata, handles)
% hObject    handle to ScanPlane2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScanPlane2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScanPlane2
handles.AllCrystals(2).MeasPlaneNum = get(hObject,'Value');
guidata(handles.figure1,handles);
PlotgVectors(handles);


% --- Executes during object creation, after setting all properties.
function ScanPlane2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScanPlane2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ScanAxis1.
function ScanAxis1_Callback(hObject, eventdata, handles)
% hObject    handle to ScanAxis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScanAxis1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScanAxis1


% --- Executes during object creation, after setting all properties.
function ScanAxis1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScanAxis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ScanAxis2.
function ScanAxis2_Callback(hObject, eventdata, handles)
% hObject    handle to ScanAxis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ScanAxis2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ScanAxis2


% --- Executes during object creation, after setting all properties.
function ScanAxis2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ScanAxis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Notch2HKL.
function Notch2HKL_Callback(hObject, eventdata, handles)
% hObject    handle to Notch2HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Notch2HKL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Notch2HKL
set(handles.Notch2UVW,'Value',get(hObject,'Value'));

handles.AllCrystals(2).NotchDirNum = get(handles.Notch2HKL,'Value');
[handles.AllCrystals(2).aAligned, handles.AllCrystals(2).bAligned, handles.AllCrystals(2).rVectorsAligned, handles.AllCrystals(2).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(2));

PlotgVectors(handles);

guidata(handles.figure1,handles);

% --- Executes during object creation, after setting all properties.
function Notch2HKL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Notch2HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Notch2UVW.
function Notch2UVW_Callback(hObject, eventdata, handles)
% hObject    handle to Notch2UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Notch2UVW contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Notch2UVW
set(handles.Notch2HKL,'Value',get(hObject,'Value'));

handles.AllCrystals(2).NotchDirNum = get(handles.Notch2HKL,'Value');
[handles.AllCrystals(2).aAligned, handles.AllCrystals(2).bAligned, handles.AllCrystals(2).rVectorsAligned, handles.AllCrystals(2).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(2));

PlotgVectors(handles);

guidata(handles.figure1,handles);

% --- Executes during object creation, after setting all properties.
function Notch2UVW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Notch2UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Surface2UVW.
function Surface2UVW_Callback(hObject, eventdata, handles)
% hObject    handle to Surface2UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Surface2UVW contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Surface2UVW
set(handles.Surface2HKL,'Value',get(hObject,'Value'));

handles.AllCrystals(2).SurfDirNum = get(handles.Surface2HKL,'Value');
[handles.AllCrystals(2).aAligned, handles.AllCrystals(2).bAligned, handles.AllCrystals(2).rVectorsAligned, handles.AllCrystals(2).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(2));

PlotgVectors(handles);

guidata(handles.figure1,handles);


% --- Executes during object creation, after setting all properties.
function Surface2UVW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Surface2UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Surface2HKL.
function Surface2HKL_Callback(hObject, eventdata, handles)
% hObject    handle to Surface2HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Surface2HKL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Surface2HKL
set(handles.Surface2UVW,'Value',get(hObject,'Value'));

handles.AllCrystals(2).SurfDirNum = get(handles.Surface2HKL,'Value');
[handles.AllCrystals(2).aAligned, handles.AllCrystals(2).bAligned, handles.AllCrystals(2).rVectorsAligned, handles.AllCrystals(2).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(2));

PlotgVectors(handles);

guidata(handles.figure1,handles);


% --- Executes during object creation, after setting all properties.
function Surface2HKL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Surface2HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Notch1HKL.
function Notch1HKL_Callback(hObject, eventdata, handles)
% hObject    handle to Notch1HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Notch1HKL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Notch1HKL
set(handles.Notch1UVW,'Value',get(hObject,'Value'));

handles.AllCrystals(1).NotchDirNum = get(handles.Notch1HKL,'Value');
[handles.AllCrystals(1).aAligned, handles.AllCrystals(1).bAligned, handles.AllCrystals(1).rVectorsAligned, handles.AllCrystals(1).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(1));

PlotgVectors(handles);

guidata(handles.figure1,handles);


% --- Executes during object creation, after setting all properties.
function Notch1HKL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Notch1HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Notch1UVW.
function Notch1UVW_Callback(hObject, eventdata, handles)
% hObject    handle to Notch1UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Notch1UVW contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Notch1UVW
set(handles.Notch1HKL,'Value',get(hObject,'Value'));

handles.AllCrystals(1).NotchDirNum = get(handles.Notch1HKL,'Value');
[handles.AllCrystals(1).aAligned, handles.AllCrystals(1).bAligned, handles.AllCrystals(1).rVectorsAligned, handles.AllCrystals(1).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(1));

PlotgVectors(handles);

guidata(handles.figure1,handles);

% --- Executes during object creation, after setting all properties.
function Notch1UVW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Notch1UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Surface1UVW.
function Surface1UVW_Callback(hObject, eventdata, handles)
% hObject    handle to Surface1UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Surface1UVW contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Surface1UVW
set(handles.Surface1HKL,'Value',get(hObject,'Value'));

handles.AllCrystals(1).SurfDirNum = get(handles.Surface1HKL,'Value');
[handles.AllCrystals(1).aAligned, handles.AllCrystals(1).bAligned, handles.AllCrystals(1).rVectorsAligned, handles.AllCrystals(1).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(1));

PlotgVectors(handles);

guidata(handles.figure1,handles);

% --- Executes during object creation, after setting all properties.
function Surface1UVW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Surface1UVW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Surface1HKL.
function Surface1HKL_Callback(hObject, eventdata, handles)
% hObject    handle to Surface1HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Surface1HKL contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Surface1HKL
set(handles.Surface1UVW,'Value',get(hObject,'Value'));

handles.AllCrystals(1).SurfDirNum = get(handles.Surface1HKL,'Value');
[handles.AllCrystals(1).aAligned, handles.AllCrystals(1).bAligned, handles.AllCrystals(1).rVectorsAligned, handles.AllCrystals(1).gVectorsAligned] = ...
    Aligner(handles.AllCrystals(1));

PlotgVectors(handles);

guidata(handles.figure1,handles);

% --- Executes during object creation, after setting all properties.
function Surface1HKL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Surface1HKL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject, 'waitstatus'), 'waiting')
    uiresume(hObject);
else
    delete(hObject);
end


% --- Executes on button press in PlotAll1Box.
function PlotAll1Box_Callback(hObject, eventdata, handles)
% hObject    handle to PlotAll1Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotAll1Box
PlotgVectors(handles);

% --- Executes on button press in PlotSPlane1Box.
function PlotSPlane1Box_Callback(hObject, eventdata, handles)
% hObject    handle to PlotSPlane1Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotSPlane1Box
PlotgVectors(handles);

% --- Executes on button press in PlotAll2Box.
function PlotAll2Box_Callback(hObject, eventdata, handles)
% hObject    handle to PlotAll2Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotAll2Box
PlotgVectors(handles);

% --- Executes on button press in PlotSPlane2Box.
function PlotSPlane2Box_Callback(hObject, eventdata, handles)
% hObject    handle to PlotSPlane2Box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of PlotSPlane2Box
PlotgVectors(handles);

% --- Executes on button press in MeasPlaneBox.
function MeasPlaneBox_Callback(hObject, eventdata, handles)
% hObject    handle to MeasPlaneBox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MeasPlaneBox
PlotgVectors(handles);

function PlotgVectors(handles)

%Check which crystals exist. If the structure length is 2, then crystal 2
%exists. If structure 1 is not empty, then structure 1 exists.

cla(handles.axes1);

if ~isempty(handles.AllCrystals(1).LayerNum)
    if get(handles.PlotAll1Box,'Value')
        PlotAllg(handles,1)
    end
    if get(handles.PlotSPlane1Box,'Value')
        PlotSelg(handles,1)
    end
end

if length(handles.AllCrystals) == 2
    if get(handles.PlotAll2Box,'Value')
        PlotAllg(handles,2)
    end
    if get(handles.PlotSPlane2Box,'Value')
        PlotSelg(handles,2)
    end
end

if ~isempty(handles.AllCrystals(1).LayerNum) && length(handles.AllCrystals) == 2

   % Calculate and display selected vectors plane
   SelectedPlane1 = handles.AllCrystals(1).gVectorsAligned(handles.AllCrystals(1).MeasPlaneNum,:);
   SelectedPlane2 = handles.AllCrystals(2).gVectorsAligned(handles.AllCrystals(2).MeasPlaneNum,:);
   
   [error,MeshX,MeshY,MeshZ,Chi,Phi,BraggRange,OmegaRange] = GetMeasPlane(SelectedPlane1,SelectedPlane2);
   
   if ~error && get(handles.MeasPlaneBox,'Value')
           surf(handles.axes1,MeshX,MeshY,MeshZ,'EdgeAlpha',0,'FaceAlpha',.5,'AmbientStrength',0,'BackFaceLighting','unlit','FaceColor',[.3,.7,.3]);
   end
   
   MeasPlane = struct;
   MeasPlane.MeshX = MeshX;
   MeasPlane.MeshY = MeshY;
   MeasPlane.MeshZ = MeshZ;
   MeasPlane.Chi = Chi;
   MeasPlane.Phi = Phi;
   MeasPlane.BraggRange = BraggRange;
   MeasPlane.OmegaRange = OmegaRange;
   handles.MeasPlane = MeasPlane;
   guidata(handles.figure1, handles)
   
   set(handles.ChiText,'String',horzcat('Chi: ',num2str(-Chi*180/pi)));
   set(handles.PhiText,'String',horzcat('Phi: ',num2str(-Phi*180/pi)));
   set(handles.OmegaText,'String',horzcat('Omega: ',num2str(mean(BraggRange)*180/pi)));
   set(handles.TwoThetaText,'String',horzcat('2Theta: ',num2str(2*mean(BraggRange)*180/pi)));
   set(handles.Om2TText,'String',horzcat('Omega-2Theta range: ',...
       num2str((-(max(BraggRange)-min(BraggRange))/2)*180/pi,'%.2f'),' to ',...
       num2str(((max(BraggRange)-min(BraggRange))/2)*180/pi,'%.2f')));
   set(handles.OmRelText,'String',horzcat('Omega_Rel range: ',...
       num2str(min(-OmegaRange)*180/pi,'%.2f'),' to ',...
       num2str(max(-OmegaRange)*180/pi,'%.2f')));
   
end

test = 1;

function PlotAllg(handles,LayerNum)

PtsAbove0 = handles.AllCrystals(LayerNum).gVectorsAligned(:,3)>=0;

if LayerNum == 1
    Col = 'b';
    QLineStyle = '--';
elseif LayerNum == 2
    Col = 'r';
    QLineStyle = ':';
end

scatter3(handles.axes1,...
    handles.AllCrystals(LayerNum).gVectorsAligned(PtsAbove0,1),...
    handles.AllCrystals(LayerNum).gVectorsAligned(PtsAbove0,2),...
    handles.AllCrystals(LayerNum).gVectorsAligned(PtsAbove0,3),...
    50,Col,'filled');


%PLOT b1,b2,b3 for each crystal as arrows
bAlNormed = handles.AllCrystals(LayerNum).bAligned;
MaxNorm = max([norm(bAlNormed(1,:)),norm(bAlNormed(2,:)),norm(bAlNormed(3,:))]);
bAlNormed(1,:) = bAlNormed(1,:)/MaxNorm;
bAlNormed(2,:) = bAlNormed(2,:)/MaxNorm;
bAlNormed(3,:) = bAlNormed(3,:)/MaxNorm;

quiver3(handles.axes1,...
    [0,0,0],[0,0,0],[0,0,0],...
    bAlNormed(:,1)',bAlNormed(:,2)',bAlNormed(:,3)',...
    'Color',Col,'LineStyle',QLineStyle,'MaxHeadSize',.25,'LineWidth',1.5);

test = 1;

function PlotSelg(handles,LayerNum)

SelectedPlane = handles.AllCrystals(LayerNum).gVectorsAligned(handles.AllCrystals(LayerNum).MeasPlaneNum,:);

if LayerNum == 1
    EdgeCol = 'b';
    LineCol = 'c';
elseif LayerNum == 2
    EdgeCol = 'r';
    LineCol = [1,.5,0];
end

scatter3(handles.axes1,...
    SelectedPlane(1),SelectedPlane(2),SelectedPlane(3),...
    250,'y','filled','Marker','p','MarkerEdgeColor',EdgeCol);

plot3(handles.axes1,...
    [0,SelectedPlane(1)],...
    [0,SelectedPlane(2)],...
    [0,SelectedPlane(3)],...
    'Color',LineCol,'LineWidth',3);


% --- Executes on button press in SaveButton.
function SaveButton_Callback(hObject, eventdata, handles)
% hObject    handle to SaveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Make sure these crystals exist first. If not, input dummy info (zeros), get out
%dummy info (zeros)
if ~isempty(handles.AllCrystals(1).LayerNum)
    Vector1Info = GetVectorInfo(handles.AllCrystals(1));
else
    Vector1Info = 0;
end

if length(handles.AllCrystals) == 2
    Vector2Info = GetVectorInfo(handles.AllCrystals(2));
else
    Vector2Info = 0;
end

if isfield(handles,'MeasPlane')
    WriteText(Vector1Info,Vector2Info,handles.MeasPlane,handles.AllCrystals);
else
    WriteText(Vector1Info,Vector2Info,0,handles.AllCrystals);
end
