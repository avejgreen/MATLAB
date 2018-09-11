function varargout = FitFilterGUI(varargin)
% FITFILTERGUI MATLAB code for FitFilterGUI.fig
%      FITFILTERGUI, by itself, creates a new FITFILTERGUI or raises the existing
%      singleton*.
%
%      H = FITFILTERGUI returns the handle to a new FITFILTERGUI or the handle to
%      the existing singleton*.
%
%      FITFILTERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITFILTERGUI.M with the given input arguments.
%
%      FITFILTERGUI('Property','Value',...) creates a new FITFILTERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FitFilterGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FitFilterGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FitFilterGUI

% Last Modified by GUIDE v2.5 25-Jul-2017 15:51:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @FitFilterGUI_OpeningFcn, ...
    'gui_OutputFcn',  @FitFilterGUI_OutputFcn, ...
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


% --- Executes just before FitFilterGUI is made visible.
function FitFilterGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FitFilterGUI (see VARARGIN)

% Choose default command line output for FitFilterGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FitFilterGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FitFilterGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ButtonImport.
function ButtonImport_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonImport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global UnfilteredFits
global LastDate
global SampleName

% Select files for import
[SelectedFiles,Path,FilterIndex] = uigetfile(...
    '/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM Matlab Analysis_ILimited/*.csv',...
    'MultiSelect','on');
HistDataFileCheck = cellfun(@(x) strcmp('HistData.csv',x(end-11:end)),SelectedFiles);
HistDataFileNames = SelectedFiles(HistDataFileCheck);

LastDate = HistDataFileNames{end}(1:6);
SampleName = textscan(Path,'%s','Delimiter','/');
SampleName = SampleName{1}{end};

nFiles = length(HistDataFileNames);
% hbar = waitbar(0,horzcat('Loading Files: 0 of ',int2str(nFiles)));

% Import Files
% 6. CSVCell
% tic;
CSVCell = cell(1,nFiles);
for i = 1:nFiles
    CSVCell{i} = csvread(horzcat(Path,'/',HistDataFileNames{i}), 6, 0);
end
UnfilteredFits = vertcat(CSVCell{:});
% CSVCellTime = toc;

% figure;
% hist(CSVCell(:,8)); %Hist Ef before filter
% figure;
% hist(CSVCell(:,7)); %Hist Error before filter

%Calculate I(ends)
UnfilteredFits(:,9) = exp(UnfilteredFits(:,1).*(-.5-UnfilteredFits(:,2)))...
    -exp(UnfilteredFits(:,3).*(-.5-UnfilteredFits(:,4)))...
    +UnfilteredFits(:,5)*-.5+UnfilteredFits(:,6);
UnfilteredFits(:,10) = exp(UnfilteredFits(:,1).*(.5-UnfilteredFits(:,2)))...
    -exp(UnfilteredFits(:,3).*(.5-UnfilteredFits(:,4)))...
    +UnfilteredFits(:,5)*.5+UnfilteredFits(:,6);

%Calculate dI/dV at Ef
UnfilteredFits(:,11) = UnfilteredFits(:,1).*exp(UnfilteredFits(:,1).*(UnfilteredFits(:,8)-UnfilteredFits(:,2)))...
    -UnfilteredFits(:,3).*exp(UnfilteredFits(:,3).*(UnfilteredFits(:,8)-UnfilteredFits(:,4)))...
    +UnfilteredFits(:,5);

% FilteredFits = UnfilteredFits;

PlotUnfiltered(handles);
PlotFiltered(handles);



% --- Executes on button press in ButtonExport.
function ButtonExport_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonExport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global UnfilteredFits
global LastDate
global SampleName

if ~isempty(UnfilteredFits)
    
    %%% Statistics. Mean, StD, Median, Quartiles, correlation. Use Ef-Ed
    %%% for statistics.
    FilteredFits = ApplyFilters(handles);
    EfMean = mean(-FilteredFits(:,8));
    EfStD = std(-FilteredFits(:,8));
    EfPctiles = prctile(-FilteredFits(:,8),[0,25,50,75,100]);
    Correlations = corr(FilteredFits);
    
    
    %Want to export FiltData, FiltHist, FiltHistData, FiltStats, FiltCorr

    SaveDir = horzcat('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/Samples Hinkle/STM_FilteredFits/',SampleName);
    mkdir(SaveDir);
    [FileName,PathName,FilterIndex] = uiputfile(horzcat(SaveDir,'/FiltData_',LastDate,'.csv'),'Save Outputs:');
    [PathName,FileName,Ext] = fileparts(horzcat(PathName,'/',FileName));
    FileDate = FileName(end-5:end);
    
    
    ExportFileName = horzcat(PathName,'/','FiltData_',FileDate,'.csv');
    File = fopen(ExportFileName,'w+');
    fprintf(File,'B+,x0+,B-,x0-,m,y0,Error,Ed-Ef,I(-0.5),I(+0.5),dI(Ed-Ef)/dV\n');
    fclose(File);
    dlmwrite(ExportFileName,FilteredFits,'-append');
    
    ExportFileName = horzcat(PathName,'/','FiltHistData_',FileDate,'.csv');
    [Cnts,BinCtrs] = hist(-FilteredFits(:,8),15);
    CntPcts = 100*Cnts/sum(Cnts);
    File = fopen(ExportFileName,'w+');
    fprintf(File,'Bin Center (Ef-Ed),CntPct\n');
    fclose(File);
    dlmwrite(ExportFileName,[BinCtrs',CntPcts'],'-append');
    
    ExportFileName = horzcat(PathName,'/','FiltHist_',FileDate,'.jpg');
    HistPlot = figure('Visible','off');
    HPAxes = gca;
    bar(HPAxes,BinCtrs,CntPcts,'hist');
    xlabel('Ef-Ed (eV)');
    ylabel('% Counts');
    print(HistPlot,'-djpeg',ExportFileName);

    ExportFileName = horzcat(PathName,'/','FiltStats_',FileDate,'.csv');
    File = fopen(ExportFileName,'w+');
    fprintf(File,'nUnfilteredSpec,nFilteredSpec,Mean,StD,Min,Q1,Median,Q3,Max\n');
    fclose(File);
    dlmwrite(ExportFileName,[size(UnfilteredFits,1),size(FilteredFits,1),EfMean,EfStD,EfPctiles],'-append');
    test = 1;
    
    ExportFileName = horzcat(PathName,'/','FiltCorr_',FileDate,'.csv');
    File = fopen(ExportFileName,'w+');
    fprintf(File,'B+,x0+,B-,x0-,m,y0,Error,Ed-Ef,I(-0.5),I(+0.5),dI(Ed-Ef)/dV\n');
    fclose(File);
    dlmwrite(ExportFileName,Correlations,'-append');
    test = 1;
    
end



% --- Executes on button press in ButtonFullProcess.
function ButtonFullProcess_Callback(hObject, eventdata, handles)
% hObject    handle to ButtonFullProcess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ButtonImport_Callback(hObject, eventdata, handles)
ButtonExport_Callback(hObject, eventdata, handles)


function EditBpMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditBpMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBpMin as text
%        str2double(get(hObject,'String')) returns contents of EditBpMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditBpMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBpMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditBpMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditBpMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBpMax as text
%        str2double(get(hObject,'String')) returns contents of EditBpMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditBpMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBpMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Editx0pMin_Callback(hObject, eventdata, handles)
% hObject    handle to Editx0pMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Editx0pMin as text
%        str2double(get(hObject,'String')) returns contents of Editx0pMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function Editx0pMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Editx0pMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Editx0pMax_Callback(hObject, eventdata, handles)
% hObject    handle to Editx0pMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Editx0pMax as text
%        str2double(get(hObject,'String')) returns contents of Editx0pMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function Editx0pMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Editx0pMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditBmMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditBmMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBmMin as text
%        str2double(get(hObject,'String')) returns contents of EditBmMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditBmMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBmMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditBmMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditBmMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditBmMax as text
%        str2double(get(hObject,'String')) returns contents of EditBmMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditBmMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditBmMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Editx0mMin_Callback(hObject, eventdata, handles)
% hObject    handle to Editx0mMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Editx0mMin as text
%        str2double(get(hObject,'String')) returns contents of Editx0mMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function Editx0mMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Editx0mMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Editx0mMax_Callback(hObject, eventdata, handles)
% hObject    handle to Editx0mMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Editx0mMax as text
%        str2double(get(hObject,'String')) returns contents of Editx0mMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function Editx0mMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Editx0mMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditmMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditmMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditmMin as text
%        str2double(get(hObject,'String')) returns contents of EditmMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditmMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditmMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditmMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditmMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditmMax as text
%        str2double(get(hObject,'String')) returns contents of EditmMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditmMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditmMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edity0Min_Callback(hObject, eventdata, handles)
% hObject    handle to Edity0Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edity0Min as text
%        str2double(get(hObject,'String')) returns contents of Edity0Min as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function Edity0Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edity0Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Edity0Max_Callback(hObject, eventdata, handles)
% hObject    handle to Edity0Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Edity0Max as text
%        str2double(get(hObject,'String')) returns contents of Edity0Max as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function Edity0Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Edity0Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditErrorMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditErrorMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditErrorMin as text
%        str2double(get(hObject,'String')) returns contents of EditErrorMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditErrorMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditErrorMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditErrorMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditErrorMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditErrorMax as text
%        str2double(get(hObject,'String')) returns contents of EditErrorMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditErrorMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditErrorMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditEfMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditEfMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditEfMin as text
%        str2double(get(hObject,'String')) returns contents of EditEfMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditEfMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditEfMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditEfMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditEfMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditEfMax as text
%        str2double(get(hObject,'String')) returns contents of EditEfMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditEfMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditEfMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditImp5Min_Callback(hObject, eventdata, handles)
% hObject    handle to EditImp5Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditImp5Min as text
%        str2double(get(hObject,'String')) returns contents of EditImp5Min as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditImp5Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditImp5Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditImp5Max_Callback(hObject, eventdata, handles)
% hObject    handle to EditImp5Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditImp5Max as text
%        str2double(get(hObject,'String')) returns contents of EditImp5Max as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditImp5Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditImp5Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditIpp5Min_Callback(hObject, eventdata, handles)
% hObject    handle to EditIpp5Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditIpp5Min as text
%        str2double(get(hObject,'String')) returns contents of EditIpp5Min as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditIpp5Min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditIpp5Min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditIpp5Max_Callback(hObject, eventdata, handles)
% hObject    handle to EditIpp5Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditIpp5Max as text
%        str2double(get(hObject,'String')) returns contents of EditIpp5Max as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditIpp5Max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditIpp5Max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function EditdIEfMax_Callback(hObject, eventdata, handles)
% hObject    handle to EditdIEfMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditdIEfMax as text
%        str2double(get(hObject,'String')) returns contents of EditdIEfMax as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditdIEfMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditdIEfMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EditdIEfMin_Callback(hObject, eventdata, handles)
% hObject    handle to EditdIEfMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EditdIEfMin as text
%        str2double(get(hObject,'String')) returns contents of EditdIEfMin as a double
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function EditdIEfMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EditdIEfMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupXAxis.
function PopupXAxis_Callback(hObject, eventdata, handles)
% hObject    handle to PopupXAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupXAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupXAxis
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function PopupXAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupXAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in PopupYAxis.
function PopupYAxis_Callback(hObject, eventdata, handles)
% hObject    handle to PopupYAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns PopupYAxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from PopupYAxis
PlotUnfiltered(handles)
PlotFiltered(handles)

% --- Executes during object creation, after setting all properties.
function PopupYAxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PopupYAxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function PlotUnfiltered(handles)

global UnfilteredFits;

if ~isempty(UnfilteredFits)
    
    xAxisSelection = get(handles.PopupXAxis,'Value')-1;
    yAxisSelection = get(handles.PopupYAxis,'Value')-1;
    
    if or(or(xAxisSelection == 0, yAxisSelection == 0), xAxisSelection == yAxisSelection)
        %Don't plot
    else
        scatter(handles.AxesUnfiltered,UnfilteredFits(:,xAxisSelection),UnfilteredFits(:,yAxisSelection));
        
        set(handles.TextUnfilteredTitle,'String',horzcat('Unfiltered Data: ',int2str(size(UnfilteredFits,1)),' Spectra'));
    end
    
end


function PlotFiltered(handles)

global UnfilteredFits;

if ~isempty(UnfilteredFits)
    
    xAxisSelection = get(handles.PopupXAxis,'Value')-1;
    yAxisSelection = get(handles.PopupYAxis,'Value')-1;
    
    if or(or(xAxisSelection == 0, yAxisSelection == 0), xAxisSelection == yAxisSelection)
        %Don't plot
    else
        FilteredFits = ApplyFilters(handles);
        
        scatter(handles.AxesFiltered,FilteredFits(:,xAxisSelection),FilteredFits(:,yAxisSelection));
        
        set(handles.TextFilteredTitle,'String',horzcat('Filtered Data: ',int2str(size(FilteredFits,1)),' Spectra'));
    end
    
end


function FilteredFits = ApplyFilters(handles)

global UnfilteredFits

Limits = zeros(2,11);
Limits(1,1) = str2double(get(handles.EditBpMin,'String'));
Limits(2,1) = str2double(get(handles.EditBpMax,'String'));
Limits(1,2) = str2double(get(handles.Editx0pMin,'String'));
Limits(2,2) = str2double(get(handles.Editx0pMax,'String'));
Limits(1,3) = str2double(get(handles.EditBmMin,'String'));
Limits(2,3) = str2double(get(handles.EditBmMax,'String'));
Limits(1,4) = str2double(get(handles.Editx0mMin,'String'));
Limits(2,4) = str2double(get(handles.Editx0mMax,'String'));
Limits(1,5) = str2double(get(handles.EditmMin,'String'));
Limits(2,5) = str2double(get(handles.EditmMax,'String'));
Limits(1,6) = str2double(get(handles.Edity0Min,'String'));
Limits(2,6) = str2double(get(handles.Edity0Max,'String'));
Limits(1,7) = str2double(get(handles.EditErrorMin,'String'));
Limits(2,7) = str2double(get(handles.EditErrorMax,'String'));
Limits(1,8) = str2double(get(handles.EditEfMin,'String'));
Limits(2,8) = str2double(get(handles.EditEfMax,'String'));
Limits(1,9) = str2double(get(handles.EditImp5Min,'String'));
Limits(2,9) = str2double(get(handles.EditImp5Max,'String'));
Limits(1,10) = str2double(get(handles.EditIpp5Min,'String'));
Limits(2,10) = str2double(get(handles.EditIpp5Max,'String'));
Limits(1,11) = str2double(get(handles.EditdIEfMin,'String'));
Limits(2,11) = str2double(get(handles.EditdIEfMax,'String'));

FilteredFits = UnfilteredFits;
for i = 1:size(Limits,2)
    FilteredFits = FilteredFits(and(FilteredFits(:,i)>Limits(1,i),FilteredFits(:,i)<Limits(2,i)),:);
end

test = 1;
