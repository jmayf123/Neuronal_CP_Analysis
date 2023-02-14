function varargout = SaveRecording(varargin)
% SAVERECORDING M-file for SaveRecording.fig
%      SAVERECORDING, by itself, creates a new SAVERECORDING or raises the existing
%      singleton*.
%
%      H = SAVERECORDING returns the handle to a new SAVERECORDING or the handle to
%      the existing singleton*.
%
%      SAVERECORDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVERECORDING.M with the given input arguments.
%
%      SAVERECORDING('Property','Value',...) creates a new SAVERECORDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SaveRecording_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SaveRecording_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SaveRecording

% Last Modified by GUIDE v2.5 11-Oct-2011 14:22:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SaveRecording_OpeningFcn, ...
                   'gui_OutputFcn',  @SaveRecording_OutputFcn, ...
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
end
% End initialization code - DO NOT EDIT


% --- Executes just before SaveRecording is made visible.
function SaveRecording_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
end
    

function varargout = SaveRecording_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;
end

% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
global SaveData
SaveData.Flag=0;
MonkeyStim
close(SaveRecording)
end

% --- Executes on button press in SaveData.
function SaveData_Callback(hObject, eventdata, handles)
global SaveData

MonkeySelect=get(handles.MonkeySelect, 'Value');

MonkeyName=GetMonkeyNames(MonkeySelect);
Date=GetDateString();
Block=(get(handles.BlockNumber,'String'));
Test=SaveData.TestType;
ToneLevel=num2str(SaveData.ToneLevel);
CF=num2str(SaveData.CF);
ToneModulation=num2str(SaveData.ToneMod);
NoiseType=SaveData.NoiseType;
NoiseLevel=num2str(SaveData.NoiseLevel);
NoiseMod=num2str(SaveData.ModNoiseFreq);
Type=get(handles.DataType,'Value');
if Type==1
    BehavOrNeuro='Psycometric Data';
else
    BehavOrNeuro='Neurometric Data';
end
Comments1=get(handles.Comments,'String');
FinalString=[MonkeyName,'	',Date,'	',Block,'	',Test,'	',ToneLevel,'	',CF,'	',ToneModulation,...
    '	',NoiseType,'	',NoiseLevel,'	',BehavOrNeuro,'	',NoiseMod,'	',Comments1];

Dirrectory= 'C:\Users\Kimaya\Desktop\Recording Info\RecordingInfo.txt';
fid=fopen(Dirrectory, 'a+');
fprintf(fid, '%s\r\n', FinalString);
fclose(fid);
SaveData.Flag=0;
close(SaveRecording);
end

function [MonkeyName]= GetMonkeyNames(MonkeySelect)
switch MonkeySelect
    case 1
        MonkeyName='Alpha';
    case 2
        MonkeyName='Bravo';
    case 3
        MonkeyName='Charlie';
    case 4
        MonkeyName='Delta';
    otherwise
end
end


function [out]= GetDateString()
DateArray=clock;
year=num2str(DateArray(1)-2000);
month=num2str(DateArray(2));
if length(month)==1
    month= strcat('0',month);
end
day=num2str(DateArray(3));
if length(day)==1
    day= strcat('0',day);
end
out=strcat(year,month,day);
end