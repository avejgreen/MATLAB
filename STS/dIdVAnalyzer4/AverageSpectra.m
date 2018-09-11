function varargout = AverageSpectra(varargin)
% AVERAGESPECTRA MATLAB code for AverageSpectra.fig
%      AVERAGESPECTRA, by itself, creates a new AVERAGESPECTRA or raises the existing
%      singleton*.
%
%      H = AVERAGESPECTRA returns the handle to a new AVERAGESPECTRA or the handle to
%      the existing singleton*.
%
%      AVERAGESPECTRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVERAGESPECTRA.M with the given input arguments.
%
%      AVERAGESPECTRA('Property','Value',...) creates a new AVERAGESPECTRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AverageSpectra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AverageSpectra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AverageSpectra

% Last Modified by GUIDE v2.5 27-Apr-2017 23:14:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AverageSpectra_OpeningFcn, ...
                   'gui_OutputFcn',  @AverageSpectra_OutputFcn, ...
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


% --- Executes just before AverageSpectra is made visible.
function AverageSpectra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AverageSpectra (see VARARGIN)

% Choose default command line output for AverageSpectra
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global Spectra
A = size(Spectra.data,2)/2;
L = sqrt(A);
Pts = 1:1:L;
Pts = (Pts-.5)/L;

[GridX,GridY] = meshgrid(Pts,Pts);
GridX = reshape(GridX,A,1);
GridY = reshape(GridY,A,1);
scatter(handles.axes1,GridX,GridY,'MarkerFaceColor','k','SizeData',16000/(L^2));
xlim(handles.axes1,[0 1]);
ylim(handles.axes1,[0 1]);
scatter(handles.axes3,GridX,GridY,'MarkerFaceColor','k','SizeData',16000/(L^2));
xlim(handles.axes3,[0 1]);
ylim(handles.axes3,[0 1]);

% UIWAIT makes AverageSpectra wait for user response (see UIRESUME)
uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = AverageSpectra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% The figure can be deleted now
delete(handles.figure1);



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

global Spectra
A = size(Spectra.data,2)/2;
BinString = get(hObject,'String');
BinActive = get(hObject,'Value');
BinSize = str2double(BinString{BinActive});
LAvg = sqrt(A)/BinSize;
Pts = 1:1:LAvg;
Pts = (Pts-.5)/LAvg;

[GridX,GridY] = meshgrid(Pts,Pts);
GridX = reshape(GridX,LAvg^2,1);
GridY = reshape(GridY,LAvg^2,1);
scatter(handles.axes3,GridX,GridY,'MarkerFaceColor','k','SizeData',16000/(LAvg^2))
xlim(handles.axes3,[0 1]);
ylim(handles.axes3,[0 1]);

set(handles.text4,'String',horzcat('Average: ',int2str(LAvg),'x',int2str(LAvg),' = ',int2str(LAvg^2)));



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

global Spectra
A = size(Spectra.data,2)/2;
L = sqrt(A);
Factors = GetFactors(L);
BinString = cellfun(@int2str,num2cell(Factors),'UniformOutput',0);
set(hObject,'String',BinString);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Spectra

A = size(Spectra.data,2)/2;
L = sqrt(A);

BinString = get(handles.popupmenu1,'String');
BinActive = get(handles.popupmenu1,'Value');
BinL = str2double(BinString{BinActive});
BinA = BinL^2;
Bins = L/BinL;

if isfield(Spectra,'D1Smooth')
    Data = Spectra.D1Smooth; 
else
    Data = Spectra.D1;
end
D1Avg = zeros(size(Data));

Specs = reshape(linspace(1,A,A),L,L);
for BinX = 1:Bins
    for BinY = 1:Bins
        BinSpecs = Specs(BinL*(BinX-1)+1:BinL*BinX,BinL*(BinY-1)+1:BinL*BinY);
        BinSpecs = reshape(BinSpecs,1,BinA);
        
        BinMean = zeros(size(Data,1),BinA);
        for i = 1:BinA
            BinMean(:,i) = Data(:,BinSpecs(i));
        end
        BinMean = mean(BinMean,2);
        for i = 1:BinA
           D1Avg(:,BinSpecs(i)) = BinMean; 
        end
    end
end

if isfield(Spectra,'D1Smooth')
    Spectra.D1Smooth = D1Avg; 
else
    Spectra.D1 = D1Avg;
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
    pushbutton1_Callback(handles, eventdata, handles);
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


% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

global Spectra
A = size(Spectra.data,2)/2;
L = sqrt(A);
set(hObject,'String',horzcat('Original: ',int2str(L),'x',int2str(L),' = ',int2str(A)));


% --- Executes during object creation, after setting all properties.
function text4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global Spectra
A = size(Spectra.data,2)/2;
L = sqrt(A);
BinSizes = GetFactors(L);
ABS = BinSizes(1);
LA = L/ABS;
AA = LA^2;

set(hObject,'String',horzcat('Average: ',int2str(LA),'x',int2str(LA),' = ',int2str(AA)));


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3



function Factors = GetFactors(Input)
i = 1;
Factors = NaN(1);
while i < sqrt(Input)
    j = Input/i;
    if j==round(j)
        Factors(length(Factors)+1)=i;
        Factors(length(Factors)+1)=j;
    end
    i=i+1;
end
Factors = sort(Factors(2:end));
