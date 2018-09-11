function varargout = FitPeak(varargin)
% FITPEAK MATLAB code for FitPeak.fig
%      FITPEAK, by itself, creates a new FITPEAK or raises the existing
%      singleton*.
%
%      H = FITPEAK returns the handle to a new FITPEAK or the handle to
%      the existing singleton*.
%
%      FITPEAK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITPEAK.M with the given input arguments.
%
%      FITPEAK('Property','Value',...) creates a new FITPEAK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FitPeak_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FitPeak_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FitPeak

% Last Modified by GUIDE v2.5 03-Apr-2017 10:42:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FitPeak_OpeningFcn, ...
    'gui_OutputFcn',  @FitPeak_OutputFcn, ...
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


% --- Executes just before FitPeak is made visible.
function FitPeak_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FitPeak (see VARARGIN)

% Choose default command line output for FitPeak
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FitPeak wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FitPeak_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);


% --- Executes on button press in PushButtonOK.
function PushButtonOK_Callback(hObject, eventdata, handles)
% hObject    handle to PushButtonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Spectra;

if isfield(Spectra,'D1Smooth')
    Data = Spectra.D1Smooth;
else
    Data = Spectra.D1; 
end

PolyOrder = str2double(get(handles.EditPolyOrder,'String'));
CoarsePeakLocation(handles);
xRange = str2double(get(handles.EditXRange,'String'));

Spectra.PolyCoeffs = zeros(PolyOrder+1,size(Data,2));
Spectra.FitX = NaN(size(Data,1),size(Data,2));
Spectra.FitD1 = Spectra.FitX;

for i = 1:size(Data,2)
    
    xMinRange = Spectra.CoarsePeakLocation(i)-xRange/2;
    xMaxRange = Spectra.CoarsePeakLocation(i)+xRange/2;
    
    xMinRangeIndex = find(Spectra.x(:,i)>xMinRange,1,'first');
    xMaxRangeIndex = find(Spectra.x(:,i)<xMaxRange,1,'last');
    
    FitX = Spectra.x(xMinRangeIndex:xMaxRangeIndex,i);
    DataTemp = Data(xMinRangeIndex:xMaxRangeIndex,i);
    
    p = polyfit(FitX,DataTemp,PolyOrder);
    Spectra.PolyCoeffs(:,i) = p';
    FitData = polyval(p,FitX);
    
    Spectra.FitX(1:length(FitX),i) = FitX;
    Spectra.FitD1(1:length(FitData),i) = FitData;
    
end

LastRow = find(all(isnan(Spectra.FitD1),2),1,'first')-1;
Spectra.FitX = Spectra.FitX(1:LastRow,:);
Spectra.FitD1 = Spectra.FitD1(1:LastRow,:);

if PolyOrder==2
   Spectra.FitCenter = -Spectra.PolyCoeffs(2,:)./(2*Spectra.PolyCoeffs(1,:));
end

close(handles.figure1);


function EditXMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditXMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXMin as text
%        str2double(get(hObject,'String')) returns contents of EditXMin as a double
global Spectra

xMax = str2double(get(handles.EditXMax,'String'));
xMin = str2double(get(handles.EditXMin,'String'));

if xMin < Spectra.x(1,1) || xMax < xMin
    xMin = Spectra.x(1,1);
end

set(hObject,'String',num2str(xMin,4));

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
global Spectra

xMax = str2double(get(handles.EditXMax,'String'));
xMin = str2double(get(handles.EditXMin,'String'));

if xMax > Spectra.x(end,1) || xMax < xMin
    xMax = Spectra.x(end,1);
end

set(hObject,'String',num2str(xMax,4));


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



function EditPolyOrder_Callback(hObject, eventdata, handles)
% hObject    handle to EditPolyOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPolyOrder as text
%        str2double(get(hObject,'String')) returns contents of EditPolyOrder as a double
pts = round(str2double(get(hObject,'String')));
pts(pts<0)=0;
set(hObject,'String',int2str(uint16(pts)));

% --- Executes during object creation, after setting all properties.
function EditPolyOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditPolyOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
    % The GUI is no longer waiting, just close it
    delete(hObject);
end


function CoarsePeakLocation(handles)

global Spectra;

xMin = str2double(get(handles.EditXMin,'String'));
xMax = str2double(get(handles.EditXMax,'String'));
xMinIndex = find(Spectra.x(:,1)>xMin,1,'first');
xMaxIndex = find(Spectra.x(:,1)<xMax,1,'last');

Spectra.CoarsePeakLocation = zeros(1,size(Spectra.x,2));

for i = 1:length(Spectra.CoarsePeakLocation) 
    p = polyfit(Spectra.x(xMinIndex:xMaxIndex,i),Spectra.D0(xMinIndex:xMaxIndex,i),3);
    PeakLoc = -p(2)/(3*p(1));
    PeakLoc(PeakLoc<Spectra.x(xMinIndex,i))=Spectra.x(xMinIndex,i);
    PeakLoc(PeakLoc>Spectra.x(xMaxIndex,i))=Spectra.x(xMaxIndex,i);
    Spectra.CoarsePeakLocation(i) = PeakLoc;
end



function EditXRange_Callback(hObject, eventdata, handles)
% hObject    handle to EditXRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXRange as text
%        str2double(get(hObject,'String')) returns contents of EditXRange as a double
Range = str2double(get(hObject,'String'));
Range(Range<=0) = 0.2;
set(hObject,'String',num2str(Range,4));

% --- Executes during object creation, after setting all properties.
function EditXRange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXRange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
