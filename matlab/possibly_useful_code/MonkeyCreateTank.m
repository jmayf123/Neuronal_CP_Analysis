function varargout = MonkeyCreateTank(varargin)
% MONKEYCREATETANK MATLAB code for MonkeyCreateTank.fig
%      MONKEYCREATETANK, by itself, creates a new MONKEYCREATETANK or raises the existing
%      singleton*.
%
%      H = MONKEYCREATETANK returns the handle to a new MONKEYCREATETANK or the handle to
%      the existing singleton*.
%
%      MONKEYCREATETANK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONKEYCREATETANK.M with the given input arguments.
%
%      MONKEYCREATETANK('Property','Value',...) creates a new MONKEYCREATETANK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MonkeyCreateTank_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MonkeyCreateTank_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MonkeyCreateTank

% Last Modified by GUIDE v2.5 29-Apr-2012 11:47:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MonkeyCreateTank_OpeningFcn, ...
                   'gui_OutputFcn',  @MonkeyCreateTank_OutputFcn, ...
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


% --- Executes just before MonkeyCreateTank is made visible.
function MonkeyCreateTank_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MonkeyCreateTank (see VARARGIN)

% Choose default command line output for MonkeyCreateTank
handles.output = hObject;


MonkeyList={'Alpha';'Bravo';'Charlie';'Delta';'Echo';'Gatsby'};
TypeList={'Behavior';'IC';'CN'};
set(handles.MonkeySelect,'String',MonkeyList);
set(handles.RecordType,'String',TypeList);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MonkeyCreateTank wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MonkeyCreateTank_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in Run.
function Run_Callback(~, ~, handles)
MonkeyList=get(handles.MonkeySelect,'String');
MonkeyNumber=get(handles.MonkeySelect,'Value');
Monkey=MonkeyList{MonkeyNumber};

switch get(handles.RecordType,'Value')
    case 1
        Location='IC';
        Behavior='Behavior';
    case 2
        Location='IC';
        Behavior='Neurobehavior';
    case 3
        Location='CN';
        Behavior='Neurobehavior';
end
        
[~, filepath,tankname] =MonkeyFolderMaker2(Monkey,Location,Behavior);
msgbox('Data Tank Folder has been created', 'Success!');
set(handles.String1,'String',filepath,'Enable','On');
set(handles.String2,'String',tankname,'Enable','On');



% --- Executes on button press in Done.
function Done_Callback(~, ~, handles)

a=get(handles.String1,'String');
b=get(handles.String2,'String');
FinalString=[a,'\',b];
if length(FinalString)>5    
    actxfigure2=figure('Position',[0 100000 1 1]);
    DA = actxcontrol('TDevAcc.X');
    DA.ConnectServer('Local');
    a=DA.SetTankName(FinalString);
    DA.CloseConnection;
    close(actxfigure2);
else
    a=2;
end


if a==1
    close MonkeyCreateTank
elseif a==0 
    msgbox('Path NOT created, make sure Workbench is open', 'FAIL!');
elseif a==2
    msgbox('No path has been selected','Sorry');
end
    
% hObject    handle to Done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
