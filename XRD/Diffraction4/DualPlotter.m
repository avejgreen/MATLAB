function varargout = DualPlotter(varargin)
% DUALPLOTTER MATLAB code for DualPlotter.fig
%      DUALPLOTTER, by itself, creates a new DUALPLOTTER or raises the existing
%      singleton*.
%
%      H = DUALPLOTTER returns the handle to a new DUALPLOTTER or the handle to
%      the existing singleton*.
%
%      DUALPLOTTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DUALPLOTTER.M with the given input arguments.
%
%      DUALPLOTTER('Property','Value',...) creates a new DUALPLOTTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DualPlotter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DualPlotter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DualPlotter

% Last Modified by GUIDE v2.5 13-Jul-2016 17:58:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DualPlotter_OpeningFcn, ...
                   'gui_OutputFcn',  @DualPlotter_OutputFcn, ...
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

end

% --- Executes just before DualPlotter is made visible.
function DualPlotter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DualPlotter (see VARARGIN)

% Choose default command line output for DualPlotter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DualPlotter wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end

% --- Outputs from this function are returned to the command line.
function varargout = DualPlotter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

end


% --- Executes on button press in pushbutton.
function pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

AllAngles = DataFilesToAngles;
GVectors = AnglesToGVectors(AllAngles);

Plotter3D(hObject, handles, GVectors);
hklPlotter(hObject, handles);
Plotter2D(hObject, handles, AllAngles);

test = 1;

end


function Plotter3D(hObject, handles, GVectors)

axes(handles.Axes3D);

c = GVectors(:,4);
c(c<1)=1;
c = log10(c);
c(c>3) = 3;

scatter3(handles.Axes3D,GVectors(:,1),GVectors(:,2),GVectors(:,3),1,c);

set(handles.Axes3D,...
    'XLim',[-.3, .3],...
    'YLim',[-.3, .3],...
    'ZLim',[0 .25],...
    'DataAspectRatio',[1 1 1],...
    'LineWidth', 1,...
    'XGrid', 'on',...
    'YGrid', 'on',...
    'ZGrid', 'on',...
    'XTick', linspace(-.3,.3,7),...
    'YTick', linspace(-.3,.3,7),...
    'ZTick', linspace(0,.25,6),...
    'XMinorTick','on',...
    'YMinorTick','on',...
    'ZMinorTick','on',...
    'GridLineStyle','--',...
    'FontName','times',...
    'FontSize',20);
xlabel('q_x (A^{-1})');
ylabel('q_y (A^{-1})');
zlabel('q_z (A^{-1})');
colorbar;
view([300,25]);

test = 1;

end

function hklPlotter(hObject, handles)

axes(handles.Axes3D);

[Planes,b,FileName] = DiffractionPts;

GVectors = Planes(:,1:3)*b';
GVectors = GVectors(and(GVectors(:,1)>-.3,GVectors(:,1)<.3),:);
GVectors = GVectors(and(GVectors(:,2)>-.3,GVectors(:,2)<.3),:);
GVectors = GVectors(and(GVectors(:,3)>=0,GVectors(:,3)<.25),:);
x = GVectors(:,1);
y = GVectors(:,2);
z = GVectors(:,3);

hold on;
scatter3(handles.Axes3D,x,y,z,250,'filled','MarkerEdgeColor','k');
hold off;

set(handles.Axes3D,...
    'XLim',[-.3, .3],...
    'YLim',[-.3, .3],...
    'ZLim',[0 .25],...
    'DataAspectRatio',[1 1 1],...
    'LineWidth', 1,...
    'XGrid', 'on',...
    'YGrid', 'on',...
    'ZGrid', 'on',...
    'XTick', linspace(-.3,.3,7),...
    'YTick', linspace(-.3,.3,7),...
    'ZTick', linspace(0,.25,6),...
    'XMinorTick','on',...
    'YMinorTick','on',...
    'ZMinorTick','on',...
    'GridLineStyle','--',...
    'FontName','times',...
    'FontSize',20);
xlabel('q_x (A^{-1})');
ylabel('q_y (A^{-1})');
zlabel('q_z (A^{-1})');
colorbar;
view([300,25]);

test = 1;

end

function Plotter2D(hObject, handles, AllAngles)

axes(handles.Axes2D);

Phi = AllAngles(:,4);
Chi = AllAngles(:,3);
Intensity = AllAngles(:,5);
Intensity(Intensity<1) = 1;
LogIntensity = log10(Intensity);
LogIntensity(LogIntensity>3) = 3;

F = TriScatteredInterp(Phi,Chi,LogIntensity);
[X,Y] = meshgrid(linspace(min(Phi),max(Phi),401),linspace(min(Chi),max(Chi),201));
qLogIntensity = F(X,Y);

surf(handles.Axes2D,X,Y,qLogIntensity,'EdgeAlpha',0);

axes(handles.Axes2D);
view(2);
axis tight;
shading interp;
material dull;
lightangle(-45,30);
% set(gcf,'Renderer','zbuffer')
set(findobj(gca,'type','surface'),...
    'FaceLighting','phong',...
    'AmbientStrength',.7,'DiffuseStrength',.8,...
    'SpecularStrength',.8,'SpecularExponent',25,...
    'BackFaceLighting','unlit');

test = 1;

end

