function varargout = DataExporter(varargin)
% DATAEXPORTER MATLAB code for DataExporter.fig
%      DATAEXPORTER, by itself, creates a new DATAEXPORTER or raises the existing
%      singleton*.
%
%      H = DATAEXPORTER returns the handle to a new DATAEXPORTER or the handle to
%      the existing singleton*.
%
%      DATAEXPORTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATAEXPORTER.M with the given input arguments.
%
%      DATAEXPORTER('Property','Value',...) creates a new DATAEXPORTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DataExporter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DataExporter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DataExporter

% Last Modified by GUIDE v2.5 06-Apr-2017 18:30:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DataExporter_OpeningFcn, ...
                   'gui_OutputFcn',  @DataExporter_OutputFcn, ...
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


% --- Executes just before DataExporter is made visible.
function DataExporter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DataExporter (see VARARGIN)

% Choose default command line output for DataExporter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DataExporter wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DataExporter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);


% --- Executes on button press in CheckD0.
function CheckD0_Callback(hObject, eventdata, handles)
% hObject    handle to CheckD0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckD0


% --- Executes on button press in CheckD0Smooth.
function CheckD0Smooth_Callback(hObject, eventdata, handles)
% hObject    handle to CheckD0Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckD0Smooth
if isfield(Spectra,'D0Smooth')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end

% --- Executes on button press in CheckD1.
function CheckD1_Callback(hObject, eventdata, handles)
% hObject    handle to CheckD1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckD1


% --- Executes on button press in CheckD1Smooth.
function CheckD1Smooth_Callback(hObject, eventdata, handles)
% hObject    handle to CheckD1Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CheckD1Smooth
global Spectra;
if isfield(Spectra,'D1Smooth')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end

% --- Executes on button press in CheckCurves.
function CheckCurves_Callback(hObject, eventdata, handles)
% hObject    handle to CheckCurves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of CheckCurves
global Spectra
if isfield(Spectra,'FitX')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end

% --- Executes on button press in CheckStats.
function CheckStats_Callback(hObject, eventdata, handles)
% hObject    handle to CheckStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of CheckStats
global Spectra
if isfield(Spectra,'FitX')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end

% --- Executes on button press in ButtonOK.
function ButtonOK_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Spectra

CheckD0 = get(handles.CheckD0,'Value');
CheckD1 = get(handles.CheckD1,'Value');
CheckD0Smooth = get(handles.CheckD0Smooth,'Value');
CheckD1Smooth = get(handles.CheckD1Smooth,'Value');
CheckCurves = get(handles.CheckCurves,'Value');
CheckStats = get(handles.CheckStats,'Value');

ValidSpectra = 1:1:size(Spectra.x,2);
if isfield(Spectra,'FitValid')
    FitValid = Spectra.FitValid;   
    ValidSpectra = ValidSpectra(FitValid);
else
    FitValid = ones(1,size(Spectra.x,2));
end
xWrite = Spectra.x(:,FitValid);
D0Write = Spectra.D0(:,FitValid);
D1Write = Spectra.D1(:,FitValid);
D0SmoothWrite = Spectra.D0Smooth(:,FitValid);
D1SmoothWrite = Spectra.D1Smooth(:,FitValid);
FitXWrite = Spectra.FitX(:,FitValid);
FitDataWrite = Spectra.FitData(:,FitValid);
FitPositionWrite = Spectra.FitPosition(:,FitValid);
FitPolysWrite = Spectra.FitPolys(:,FitValid);
FitErrorWrite = Spectra.FitError(:,FitValid);


FullFileName = horzcat(Spectra.PathName,Spectra.FileName);
[Path, Name, Ext] = fileparts(FullFileName);

NewDir = horzcat(Path,'/',Name,'_Data');
if isdir(NewDir)
else
    mkdir(NewDir);
end  

if CheckD0
    WriteSpectra(FullFileName,'D0',xWrite,D0Write,ValidSpectra)
end
if CheckD1
    WriteSpectra(FullFileName,'D1',xWrite,D1Write,ValidSpectra)
end
if CheckD0Smooth
    WriteSpectra(FullFileName,'D0Smooth',xWrite,D0SmoothWrite,ValidSpectra)
end
if CheckD1Smooth
    WriteSpectra(FullFileName,'D1Smooth',xWrite,D1SmoothWrite,ValidSpectra)
end
if CheckCurves
    WriteSpectra(FullFileName,'D1Fit',FitXWrite,FitDataWrite,ValidSpectra)
end
if CheckStats
    WriteStats(FullFileName,'FitX',FitPositionWrite(1,:),ValidSpectra);
    WriteStats(FullFileName,'FitY',FitPositionWrite(2,:),ValidSpectra);
    WriteStats(FullFileName,'FitCurv',FitPolysWrite(1,:),ValidSpectra);
    WriteStats(FullFileName,'FitError',FitErrorWrite,ValidSpectra);
end

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


% --- Executes during object creation, after setting all properties.
function CheckD0Smooth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CheckD0Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global Spectra
if isfield(Spectra,'D0Smooth')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end


% --- Executes during object creation, after setting all properties.
function CheckD1Smooth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CheckD1Smooth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global Spectra
if isfield(Spectra,'D1Smooth')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end


% --- Executes during object creation, after setting all properties.
function CheckCurves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CheckCurves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global Spectra
if isfield(Spectra,'FitX')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end


% --- Executes during object creation, after setting all properties.
function CheckStats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CheckStats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global Spectra
if isfield(Spectra,'FitX')
    set(hObject,'Value',1);
else
    set(hObject,'Value',0);
end


function WriteSpectra(DataFile,DataType,DataX,DataY,ValidSpectra)
NumSpectra = size(DataX,2);

[Path, Name, Ext] = fileparts(DataFile);
NewDir = horzcat(Path,'/',Name,'_Data');

FileName = horzcat(NewDir,'/',DataType,'.txt');
FID = fopen(FileName,'w+');

Data = nan(size(DataX,1),2*NumSpectra);
Data(:,1:2:end) = DataX;
Data(:,2:2:end) = DataY;

xTitle = 'Bias';
xUnits = 'V';
switch DataType
    case 'D0'
        yTitle = 'Current';
        yUnits = 'A';
    case 'D1'
        yTitle = 'dI/dV';
        yUnits = 'A/V';
    case 'D0Smooth'
        yTitle = 'Smoothed Current';
        yUnits = 'A';
    case 'D1Smooth'
        yTitle = 'Smoothed dI/dV';
        yUnits = 'A/V';
    case 'D1Fit'
        yTitle = 'Parabolic Fit';
        yUnits = 'A/V';
end


for i = 1:NumSpectra
    fprintf(FID,'%s,%s,',xTitle,yTitle);
end
fprintf(FID,'\n');
for i = 1:NumSpectra
    fprintf(FID,'%s,%s,',xUnits,yUnits);
end
fprintf(FID,'\n');
for i = 1:NumSpectra
    fprintf(FID,' ,Spectrum %u,',ValidSpectra(i));
end

fprintf(FID,'\n');
fclose(FID);

dlmwrite(FileName,Data,'-append')


function WriteStats(DataFile,DataType,Data,ValidSpectra)
NumSpectra = size(Data,2);

[Path, Name, Ext] = fileparts(DataFile);
NewDir = horzcat(Path,'/',Name,'_Data');

FileName = horzcat(NewDir,'/',DataType,'.txt');
FID = fopen(FileName,'w+');

xTitle = 'Spectrum';
switch DataType
    case 'FitX'
        yTitle = 'Fit Vertex X';
        yUnits = 'V';
    case 'FitY'
        yTitle = 'Fit Vertex Y';
        yUnits = 'A/V';
    case 'FitCurv'
        yTitle = 'Fit Curvature';
        yUnits = 'A/V^3';
    case 'FitError'
        yTitle = 'Fit Error/Curvature';
        yUnits = 'V^2';
end

fprintf(FID,'%s,%s,\n',xTitle,yTitle);
fprintf(FID,' ,%s,\n',yUnits);

for i = 1:NumSpectra
    fprintf(FID,'%u,%e,\n',ValidSpectra(i),Data(i));
end


fclose(FID);

