function varargout = FitPoly(varargin)
% FITPOLY MATLAB code for FitPoly.fig
%      FITPOLY, by itself, creates a new FITPOLY or raises the existing
%      singleton*.
%
%      H = FITPOLY returns the handle to a new FITPOLY or the handle to
%      the existing singleton*.
%
%      FITPOLY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITPOLY.M with the given input arguments.
%
%      FITPOLY('Property','Value',...) creates a new FITPOLY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FitPoly_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FitPoly_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FitPoly

% Last Modified by GUIDE v2.5 12-Apr-2017 14:58:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FitPoly_OpeningFcn, ...
                   'gui_OutputFcn',  @FitPoly_OutputFcn, ...
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


% --- Executes just before FitPoly is made visible.
function FitPoly_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FitPoly (see VARARGIN)

% Choose default command line output for FitPoly
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FitPoly wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FitPoly_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);



function EditXCMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditXCMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXCMin as text
%        str2double(get(hObject,'String')) returns contents of EditXCMin as a double
xMin = str2double(get(handles.EditXCMin,'String'));
xMax = str2double(get(handles.EditXCMax,'String'));

if xMin>=xMax
    xMin = xMax-.2;
end

set(hObject,'String',num2str(xMin,4));


% --- Executes during object creation, after setting all properties.
function EditXCMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXCMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditXCMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditXCMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditXCMax as text
%        str2double(get(hObject,'String')) returns contents of EditXCMax as a double
xMin = str2double(get(handles.EditXCMin,'String'));
xMax = str2double(get(handles.EditXCMax,'String'));

if xMin>=xMax
    xMax = xMax+.2;
end

set(hObject,'String',num2str(xMax,4));

% --- Executes during object creation, after setting all properties.
function EditXCMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditXCMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditYBoundary_Callback(hObject, eventdata, handles)
% hObject    handle to EditYBoundary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditYBoundary as text
%        str2double(get(hObject,'String')) returns contents of EditYBoundary as a double
yBoundary = str2double(get(hObject,'String'));

if yBoundary <= 0
    yBoundary = 10e-9;
end

set(hObject,'String',num2str(yBoundary,4));

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



function EditPolyOrder_Callback(hObject, eventdata, handles)
% hObject    handle to EditPolyOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditPolyOrder as text
%        str2double(get(hObject,'String')) returns contents of EditPolyOrder as a double
PolyOrder = round(str2double(get(hObject,'String')));

if PolyOrder < 2
    PolyOrder = 2;
end

set(hObject,'String',num2str(PolyOrder));

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

PolyOrder = uint16(str2double(get(handles.EditPolyOrder,'String')));

%%%% Min/Max by input Choice
xCMin = str2double(get(handles.EditXCMin,'String'));
xCMax = str2double(get(handles.EditXCMax,'String'));

xCMinIndex = find(x(:,1)>xCMin,1,'first');
xCMaxIndex = find(x(:,1)<xCMax,1,'last');

xNegLast = find(x(:,1)<0,1,'last');
xPosFirst = xNegLast+1;

%%%% Min/Max by current saturation Boundary
yBoundary = str2double(get(handles.EditYBoundary,'String'));


for i = 1:size(x,2)
    
    yBMinIndex = find(BoundaryData(1:xNegLast,i)<-yBoundary,1,'last')+1;
    yBMaxIndex = find(BoundaryData(xPosFirst:end,i)>yBoundary,1,'first')+xNegLast-1;
    
    xMinIndex = max([xCMinIndex,yBMinIndex]);
    xMaxIndex = min([xCMaxIndex,yBMaxIndex]);
    
    xData = x(xMinIndex:xMaxIndex,i);
    yData = Data(xMinIndex:xMaxIndex,i);
    
    [p,S] = polyfit(xData,yData,PolyOrder);
    
    %{ 
    To find true min:
    1. Take 2nd derivative of polys (n)(n-1)x^(n-2)
    2. Find zeros in range, add boundaries
    3. Fit pts with line
    4. Integrate areas above/below line
    5. Find most negative area
    6. Find minimum in this area
    %}
    
    %1. Take 2nd derivative of polys (n)(n-1)x^(n-2)
    pD2 = p.*fliplr(linspace(0,PolyOrder,PolyOrder+1)).*fliplr(linspace(-1,PolyOrder-1,PolyOrder+1));
    pD2 = pD2(1:end-2);
    
    syms xPow;
    xPow = xPow.^fliplr(linspace(0,PolyOrder-2,PolyOrder-1));
    
    %2. Find zeros in range, add boundaries
    Zeros = double(solve(dot(xPow,pD2)))';
    Zeros = Zeros(Zeros==real(Zeros));
    Zeros = Zeros(and(Zeros>xData(1),Zeros<xData(end)));
    [Temp1,ZerosIndex] = min(abs(ones(size(xData))*Zeros-xData*ones(size(Zeros))));
    ZerosIndex = sort(ZerosIndex)';
    InfPts = xData(ZerosIndex);
    
    if any(InfPts == xData(1)) && any(InfPts==xData(end))
    elseif any(InfPts == xData(1))
        ZerosIndex = [1;ZerosIndex];
        InfPts = [InfPts;xData(end)];
    elseif any(InfPts == xData(end))
        ZerosIndex = [ZerosIndex;length(xData)];
        InfPts = [xData(1);InfPts];
    else
        ZerosIndex = [1;ZerosIndex;length(xData)];
        InfPts = [xData(1);InfPts;xData(end)];
    end
    
    %3. Fit pts with line
    LinPolys = NaN(length(InfPts)-1,2);
    LinLines = NaN(size(xData));
    for j = 1:length(InfPts)-1
        LinPolys(j,:) = polyfit(xData(ZerosIndex(j):ZerosIndex(j+1)),...
            yData(ZerosIndex(j):ZerosIndex(j+1)),1);
        LinLines(ZerosIndex(j):ZerosIndex(j+1)) = polyval(LinPolys(j,:),...
            xData(ZerosIndex(j):ZerosIndex(j+1)));     
    end
    
    
    test = 1;
    
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
