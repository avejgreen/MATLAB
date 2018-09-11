function varargout = FitQuad(varargin)
% FITQUAD MATLAB code for FitQuad.fig
%      FITQUAD, by itself, creates a new FITQUAD or raises the existing
%      singleton*.
%
%      H = FITQUAD returns the handle to a new FITQUAD or the handle to
%      the existing singleton*.
%
%      FITQUAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITQUAD.M with the given input arguments.
%
%      FITQUAD('Property','Value',...) creates a new FITQUAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FitQuad_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FitQuad_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FitQuad

% Last Modified by GUIDE v2.5 05-Apr-2017 18:57:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FitQuad_OpeningFcn, ...
                   'gui_OutputFcn',  @FitQuad_OutputFcn, ...
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


% --- Executes just before FitQuad is made visible.
function FitQuad_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FitQuad (see VARARGIN)

% Choose default command line output for FitQuad
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FitQuad wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FitQuad_OutputFcn(hObject, eventdata, handles) 
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

if xMin>xMax
    xMin = xMax-0.2;
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
xMin = str2double(get(handles.EditXMin,'String'));
xMax = str2double(get(handles.EditXMax,'String'));

if xMin>xMax
    xMax = xMin+0.2;
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


% --- Executes on button press in ButtonOK.
function ButtonOK_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonOK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Spectra

x = Spectra.x;
if isfield(Spectra,'D1Smooth')
    Data = Spectra.D1Smooth;
    BoundaryData = Spectra.D0Smooth;
else
    Data = Spectra.D1;
    BoundaryData = Spectra.D0;
end

%%%% Min/Max by input Choice
xCMin = str2double(get(handles.EditXMin,'String'));
xCMax = str2double(get(handles.EditXMax,'String'));

xCMinIndex = find(x(:,1)>xCMin,1,'first');
xCMaxIndex = find(x(:,1)<xCMax,1,'last');

%%%% Min/Max by current saturation Boundary
yBoundary = str2double(get(handles.EditYBoundary,'String'));
xNegLast = find(x(:,1)<0,1,'last');
xPosFirst = xNegLast+1;

%%%% Initial fit to approximate center.
Pos1 = NaN(1,size(x,2));
yBMinMaxIndex = NaN(2,size(x,2));
for i = 1:size(x,2)
    
    yBMin = find(BoundaryData(1:xNegLast,i)<-yBoundary,1,'last')+1;
    if isempty(yBMin)
        yBMinMaxIndex(1,i) = -inf;
    else
        yBMinMaxIndex(1,i) = yBMin;
    end
    yBMax = find(BoundaryData(xPosFirst:end,i)>yBoundary,1,'first')+xNegLast-1;
    if isempty(yBMax)
        yBMinMaxIndex(2,i) = inf;
    else
        yBMinMaxIndex(2,i) = yBMax;
    end

    xMinIndex = max([xCMinIndex,yBMinMaxIndex(1,i)]);
    xMaxIndex = min([xCMaxIndex,yBMinMaxIndex(2,i)]);
    
    xData = x(xMinIndex:xMaxIndex,i);
    yData = Data(xMinIndex:xMaxIndex,i);
    
    p = polyfit(xData,yData,2);
    Pos1(i) = -p(2)/(2*p(1));
    Pos1(isnan(Pos1)) = 0;
    Pos1(Pos1<x(xMinIndex,1)) = x(xMinIndex,1);
    Pos1(Pos1>x(xMaxIndex,1)) = x(xMaxIndex,1);
    
end


Spectra.FitX = NaN(size(x));
Spectra.FitData = NaN(size(x));
Spectra.FitPolys = NaN(3,size(x,2));
Spectra.FitPosition = NaN(2,size(x,2));
Spectra.FitError = NaN(1,size(x,2));

xCRange = xCMax-xCMin;
xCRadius = xCRange/2;

%%%% Second fit for accuracy
for i = 1:size(x,2)
     
    x2MinIndex = find(x(:,1)>Pos1(i)-xCRadius,1,'first');
    x2MaxIndex = find(x(:,1)<Pos1(i)+xCRadius,1,'last');
    
    xMinIndex = max([x2MinIndex,yBMinMaxIndex(1,i)]);
    xMaxIndex = min([x2MaxIndex,yBMinMaxIndex(2,i)]);
    
    xData = x(xMinIndex:xMaxIndex,i);
    yData = Data(xMinIndex:xMaxIndex,i);
    
    Spectra.FitX(xMinIndex:xMaxIndex,i) = xData;
    [p,S] = polyfit(xData,yData,2);
    Spectra.FitData(xMinIndex:xMaxIndex,i) = polyval(p,xData);
    Spectra.FitPolys(:,i) = p';
    Pos = -p(2)/(2*p(1));
    Spectra.FitPosition(1,i) = Pos;
    Spectra.FitPosition(2,i) = polyval(p,Pos);
    Spectra.FitError(i) = S.normr; 
    
end

Spectra.FitError = Spectra.FitError./abs(Spectra.FitPolys(1,:));

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



function EditYBoundary_Callback(hObject, eventdata, handles)
% hObject    handle to EditYBoundary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYBoundary as text
%        str2double(get(hObject,'String')) returns contents of EditYBoundary as a double


% --- Executes during object creation, after setting all properties.
function EditYBoundary_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditYBoundary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
