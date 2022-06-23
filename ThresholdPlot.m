function varargout = ThresholdPlot(varargin)
% THRESHOLDPLOT M-file for ThresholdPlot.fig
%      THRESHOLDPLOT, by itself, creates a new THRESHOLDPLOT or raises the existing
%      singleton*.
%
%      H = THRESHOLDPLOT returns the handle to a new THRESHOLDPLOT or the handle to
%      the existing singleton*.
%
%      THRESHOLDPLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THRESHOLDPLOT.M with the given input arguments.
%
%      THRESHOLDPLOT('Property','Value',...) creates a new THRESHOLDPLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ThresholdPlot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ThresholdPlot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ThresholdPlot

% Last Modified by GUIDE v2.5 27-Sep-2011 16:11:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ThresholdPlot_OpeningFcn, ...
                   'gui_OutputFcn',  @ThresholdPlot_OutputFcn, ...
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


% --- Executes just before ThresholdPlot is made visible.
function ThresholdPlot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ThresholdPlot (see VARARGIN)

% Choose default command line output for ThresholdPlot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ThresholdPlot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ThresholdPlot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SavePlotButton.
function SavePlotButton_Callback(hObject, eventdata, handles)
 
saveas(gcf,'corelation','pdf') 

% hObject    handle to SavePlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


