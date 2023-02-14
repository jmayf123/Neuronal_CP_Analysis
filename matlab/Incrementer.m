function varargout = Incrementer(varargin)
% INCREMENTER M-file for Incrementer.fig
%      INCREMENTER, by itself, creates a new INCREMENTER or raises the existing
%      singleton*.
%
%      H = INCREMENTER returns the handle to a new INCREMENTER or the handle to
%      the existing singleton*.
%
%      INCREMENTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INCREMENTER.M with the given input arguments.
%
%      INCREMENTER('Property','Value',...) creates a new INCREMENTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Incrementer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Incrementer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Incrementer

% Last Modified by GUIDE v2.5 09-Nov-2011 18:06:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Incrementer_OpeningFcn, ...
                   'gui_OutputFcn',  @Incrementer_OutputFcn, ...
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


% --- Executes just before Incrementer is made visible.
function Incrementer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Incrementer (see VARARGIN)

% Choose default command line output for Incrementer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Incrementer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Incrementer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Add.
function Add_Callback(hObject, eventdata, handles)
Value=str2num(get(handles.Number, 'String'));
Value=Value+1;
Value=num2str(Value);
f=warndlg('text','header');
waitfor(f);
 %http://www.mathworks.com/help/techdoc/ref/warndlg.html <- built in gui's

 
 % a=uigetfile;
% b=uigetdir;
% set(handles.Display, 'String', Value);
% disp(a);
% disp(b);
% hObject    handle to Add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




