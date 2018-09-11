function varargout = TPDPlotterGUI(varargin)
% TPDPLOTTERGUI MATLAB code for TPDPlotterGUI.fig
%      TPDPLOTTERGUI, by itself, creates a new TPDPLOTTERGUI or raises the existing
%      singleton*.
%
%      H = TPDPLOTTERGUI returns the handle to a new TPDPLOTTERGUI or the handle to
%      the existing singleton*.
%
%      TPDPLOTTERGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TPDPLOTTERGUI.M with the given input arguments.
%
%      TPDPLOTTERGUI('Property','Value',...) creates a new TPDPLOTTERGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TPDPlotterGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TPDPlotterGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TPDPlotterGUI

% Last Modified by GUIDE v2.5 12-Oct-2016 14:58:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TPDPlotterGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TPDPlotterGUI_OutputFcn, ...
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


% --- Executes just before TPDPlotterGUI is made visible.
function TPDPlotterGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TPDPlotterGUI (see VARARGIN)

% Choose default command line output for TPDPlotterGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TPDPlotterGUI wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TPDPlotterGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in MassFileButton.
function MassFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to MassFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% [FileName,PathName,FilterIndex] = uigetfile('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/');
% MassFile = fopen(horzcat(PathName, FileName));
MassFile = fopen('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/101116/Test10_101116.csv');
MassHeader = textscan(MassFile,'%s',2,'Delimiter','\n');
fclose(MassFile);
nTextLines = textscan(MassHeader{1}{2},'%s%d%s','Delimiter',',');
MassStruct = importdata('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/101116/Test10_101116.csv',',',nTextLines{2}+2);

global MassColHeaders
MassColHeaders = textscan(horzcat(MassStruct.textdata{27,:}),'%q','Delimiter','"','MultipleDelimsAsOne',true);
MassColHeaders = MassColHeaders{1}(2:end);
MassColHeaders{1} = 'Time';

global MassData;
MassData = MassStruct.data;
MassData(:,1) = MassData(:,1)/60000;

test = 1;

global MassRefTime;
MassRefTime = textscan(MassStruct.textdata{3},'%q%s%q%s','Delimiter',',');
MassRefTime = horzcat(MassRefTime{2}{1},' ',MassRefTime{4}{1});
MassRefTime = datevec(MassRefTime,'dd/mm/yyyy HH:MM:SS PM');
% RefTimeString(4) = RefTimeString(4)+12;
MassRefTime = datestr(MassRefTime);
set(handles.MassInitTime,'String',MassRefTime);
set(handles.MassInitTimeCorrected,'String',MassRefTime);

test = 1;

uiresume(handles.figure1);

% MassRefTime = textscan(MassText{1}{3},'%s%s%s%s','Delimiter',',');
% MassRefTime = horzcat(MassRefTime{2}{1},' ',MassRefTime{4}{1});
% MassRefTime = datevec(MassRefTime);
% MassRefTime(2:3) = [MassRefTime(3),MassRefTime(2)];
% MassRefTime = datenum(MassRefTime);


% --- Executes on button press in HeatFileButton.
function HeatFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to HeatFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

HeatFile = fopen('/Users/averygreen/Documents/CNSE/Diebold Lab/Data/101116/Heat_Control_V_16_10_022016_10_11_17_44_52.txt');
global HeatData
HeatData = textscan(HeatFile,'%f%f%f%c%f%f%f%s','delimiter',',');
fclose(HeatFile);

global HeatRefTime
HeatRefTime = datestr(HeatData{8}{1});
set(handles.HeatInitTime,'String',HeatRefTime);
set(handles.HeatInitTimeCorrected,'String',HeatRefTime);

HeatData(8)=cellfun(@(x) datenum(x,'mm/dd/yyyy HH:MM:SS PM'), HeatData(8),'UniformOutput',false);
HeatData{8}=1440*(HeatData{8}-HeatData{8}(1));

HeatMode = HeatData(4);
HeatData(4) = [];
HeatData = cell2mat(HeatData);

global HeatColHeaders
HeatColHeaders = {'Temp';'Current';'Rate';'Mode';'T Want';'R Max';'R In';'Time'};

uiresume(handles.figure1);


% HeatExpTimes = cellfun(@(x) datenum(x), HeatData{8},'UniformOutput',false);
% HeatExpTimes = cell2mat(HeatExpTimes);
% HeatExpTimes = 1440*(HeatExpTimes - HeatExpTimes(1));


% --- Executes on button press in MassAdd12Button.
function MassAdd12Button_Callback(hObject, eventdata, handles)
% hObject    handle to MassAdd12Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global MassRefTime;
MassRefTime = datevec(MassRefTime);
MassRefTime(4) = MassRefTime(4) + 12;
MassRefTime = datestr(MassRefTime);
set(handles.MassInitTimeCorrected,'String',MassRefTime);

uiresume(handles.figure1);


% --- Executes on button press in HeatAdd12Button.
function HeatAdd12Button_Callback(hObject, eventdata, handles)
% hObject    handle to HeatAdd12Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global HeatRefTime;
HeatRefTime = datevec(HeatRefTime);
HeatRefTime(4) = HeatRefTime(4) + 12;
HeatRefTime = datestr(HeatRefTime);
set(handles.HeatInitTimeCorrected,'String',HeatRefTime);

uiresume(handles.figure1);


function [TimeDiff, MassFirstBool] = RefTimeOffset


global MassRefTime;
global HeatRefTime;

MassRefTime = datenum(MassRefTime);
HeatRefTime = datenum(HeatRefTime);

TimeDiff = 1440*(HeatRefTime-MassRefTime);

if TimeDiff >= 0
    MassFirstBool = 1;
else
    MassFirstBool = 0;
    TimeDiff = -TimeDiff;   
end


% --- Executes on button press in PlotButton.
function PlotButton_Callback(hObject, eventdata, handles)
% hObject    handle to PlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global MassRefTime;
global HeatRefTime;

global MassData;
global HeatData;

global MassColHeaders;
global HeatColHeaders;

if or(isempty(MassRefTime), isempty(HeatRefTime));
else
    
    test = 1;
    
    [TimeDiff, MassFirstBool] = RefTimeOffset;
    
    if MassFirstBool == 1
        HeatData(:,end) = HeatData(:,end)+TimeDiff;
    else
        MassData(:,1) = MassData(:,1)+TimeDiff;
    end 

    set(handles.TMassAxes,'Color','none','NextPlot','add');
    xlabel(handles.TMassAxes,'Time (min)');
    ylabel(handles.TMassAxes,'Partial Pressure (Torr)');
    set(handles.CMassAxes,'Color','none','NextPlot','add');
    xlabel(handles.CMassAxes,'Time (min)');
    ylabel(handles.CMassAxes,'Partial Pressure (Torr)');
    
    plot(handles.TempAxes,HeatData(:,end),HeatData(:,1),'Color','k','LineWidth',3)
    plot(handles.CurrentAxes,HeatData(:,end),HeatData(:,2),'Color','k','LineWidth',3)
    
    plotcolor = get(handles.TMassAxes,'ColorOrder');
    OldFolder = cd('/Users/averygreen/Documents/MATLAB/Projects/TPD');
    for i = 2:size(MassData,2)
        if MassQuestionDialog(horzcat('Plot ',MassColHeaders{i},'?'))
            plot(handles.TMassAxes,MassData(:,1),MassData(:,i),'Color',plotcolor(i-1,:),'LineWidth',1);
            plot(handles.CMassAxes,MassData(:,1),MassData(:,i),'Color',plotcolor(i-1,:),'LineWidth',1);
        end
    end
    cd(OldFolder);
    
    set(handles.TempAxes, 'YAxisLocation','Right');
    ylabel(handles.TempAxes,'Temperature (C)');
    set(handles.CurrentAxes,'YAxisLocation','Right');
    ylabel(handles.CurrentAxes,'Current (A)');
    
    test = 1;
end

test = 1;

uiresume(handles.figure1);


