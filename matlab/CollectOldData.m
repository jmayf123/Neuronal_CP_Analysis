function varargout = CollectOldData(varargin)
% COLLECTOLDDATA M-file for CollectOldData.fig
%      COLLECTOLDDATA, by itself, creates a new COLLECTOLDDATA or raises the existing
%      singleton*.
%
%      H = COLLECTOLDDATA returns the handle to a new COLLECTOLDDATA or the handle to
%      the existing singleton*.
%
%      COLLECTOLDDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLLECTOLDDATA.M with the given input arguments.
%
%      COLLECTOLDDATA('Property','Value',...) creates a new COLLECTOLDDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CollectOldData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CollectOldData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CollectOldData

% Last Modified by GUIDE v2.5 27-Oct-2011 15:53:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CollectOldData_OpeningFcn, ...
                   'gui_OutputFcn',  @CollectOldData_OutputFcn, ...
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


% --- Executes just before CollectOldData is made visible.
function CollectOldData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CollectOldData (see VARARGIN)

% Choose default command line output for CollectOldData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CollectOldData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CollectOldData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Dirrectory=uigetdir;
set(handles.Dirrectory, 'String', Dirrectory);



function Collect_Callback(hObject, eventdata, handles)
Dir=get(handles.Dirrectory,'String');
ClassifyExistingData(Dir)
% hObject    handle to Collect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


