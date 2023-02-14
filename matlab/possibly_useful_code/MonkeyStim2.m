function varargout = MonkeyStim2(varargin)
% MONKEYSTIM2 MATLAB code for MonkeyStim2.fig
%      MONKEYSTIM2, by itself, creates a new MONKEYSTIM2 or raises the existing
%      singleton*.
%
%      H = MONKEYSTIM2 returns the handle to a new MONKEYSTIM2 or the handle to
%      the existing singleton*.
%
%      MONKEYSTIM2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MONKEYSTIM2.M with the given input arguments.
%
%      MONKEYSTIM2('Property','Value',...) creates a new MONKEYSTIM2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MonkeyStim2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MonkeyStim2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MonkeyStim2

% Last Modified by GUIDE v2.5 30-Apr-2013 14:16:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MonkeyStim2_OpeningFcn, ...
                   'gui_OutputFcn',  @MonkeyStim2_OutputFcn, ...
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


% --- Executes just before MonkeyStim2 is made visible.
function MonkeyStim2_OpeningFcn(hObject, eventdata, handles, varargin)
global playlist NoiseFilter

playlist.list=cell(9,1);
playlist.flag2=0;
playlist.flag3=0;
NoiseFilter.HP=5;
NoiseFilter.LP=40000;
handles.output = hObject;
guidata(hObject, handles);
MonkeyGUIBuild(0, handles)





% --- Outputs from this function are returned to the command line.
function varargout = MonkeyStim2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on selection change in TaskSelect.
function TaskSelect1_Callback(hObject, eventdata, handles)
% hObject    handle to TaskSelect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

Task=(get(handles.TaskSelect1, 'Value'));
MonkeyGUIBuild(Task,handles)

        

        


function AddTo_Callback(hObject, eventdata, handles)
global playlist
playlist.flag=0;
playlist.flag3=0;
[StimType Data string]= MonkeyGetStimInfo(handles);
NumInQ = MonkeySetNextQueue(handles,string);

if playlist.flag==0;
    playlist.list{NumInQ}=Data;
    
end





function IdleSingle_Callback(~, ~, handles)
global playlist
playlist.flag2=1;
playlist.flag3=0;
MonkeyIdleStim

MonkeyGUIBuild(9,handles)


function Remove_Callback(~, ~, handles)
MonkeyRemoveFromQueue(handles)


% --- Executes on button press in QueueRecord.
function QueueRecord_Callback(~, ~, handles)

global playlist
playlist.flag2=0;
playlist.flag3=0;
RorP=1; %one means record
MonkeyQueueRecordGo(handles, RorP)


% --- Executes on button press in PreviewQ.
function PreviewQ_Callback(~, ~, handles)
global playlist
playlist.flag2=0;
playlist.flag3=0;
RorP=0;
MonkeyQueueRecordGo(handles, RorP)


% --- Executes on button press in MonitorCurrent.
function MonitorCurrent_Callback(hObject, eventdata, handles)
%first check to see if it is even running.... 
%(make toggle(while toggled, monitor, else switch off)
%Didn't take into consideration if it was a preview or record... 
global playlist
playlist.flag2=0;
playlist.flag3=0;
set(handles.MonitorCurrent,'Value',0,'Enable','Off')
MonkeyMonitorCurrent(handles)
set(handles.MonitorCurrent,'Enable','On')



function PauseResume_Callback(hObject, eventdata, handles)
global playlist
playlist.flag2=0;
playlist.flag3=0;
YN=get(handles.PauseResume,'Value');

if YN==1
    set(handles.PauseResume,'String','Resume')
    MonkeyToggleRPVD(1);
else
    set(handles.PauseResume,'String','Pause')
    MonkeyToggleRPVD(0);
end


% --- Executes on button press in PlotCurrent.
function PlotCurrent_Callback(hObject, eventdata, handles)
 MonkeyPlotCurrent()

% hObject    handle to PlotCurrent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in StopMonitor.
function StopMonitor_Callback(hObject, eventdata, handles)
global playlist
playlist.flag3=1;
% hObject    handle to StopMonitor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in NoiseFilterOptions.
function NoiseFilterOptions_Callback(hObject, eventdata, handles)
global NoiseFilter
dlg={'HP Frequency in Hz','LP Frequency in Hz'};
[Response]=inputdlg(dlg);
try
    if ~isempty(Response{1}) && ~isempty(Response{2})
        a=questdlg(['Set HP at ',Response{1}, ' and LP at ', Response{2},'?'],'Are you sure...?', 'Yes','No','Yes');
        if strcmp(a,'Yes')
            NoiseFilter.LP=str2num(Response{2});
            NoiseFilter.HP=str2num(Response{1});
            
            actxfigure=figure('Position',[0 100000 1 1]);
            DA = actxcontrol('TDevAcc.X');
            DA.ConnectServer('Local');
            
           
            %DA.SetTargetVal('Stim1.NoiseLevel',0);
            %pause(1)
            DA.SetTargetVal('Stim1.HPMatlab',5);
            pause(.1)
            DA.SetTargetVal('Stim1.LPMatlab',40000);
            pause(.1)
            
            DA.SetTargetVal('Stim1.LPMatlab',NoiseFilter.LP);
            pause(.1)
            DA.SetTargetVal('Stim1.HPMatlab',NoiseFilter.HP);
            pause(.1)
            %NoiseFilter.Noise
            %DA.SetTargetVal('Stim1.NoiseLevel',NoiseFilter.Noise);
            pause(.05)
            
            
            close(actxfigure);
        end
    end
catch
end
% hObject    handle to NoiseFilterOptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NoiseFilterOptions


% --- Executes on button press in NewProject.
function NewProject_Callback(hObject, eventdata, handles)

MonkeyCreateTank


% --- Executes on button press in MonkeyAnal.
function MonkeyAnal_Callback(hObject, eventdata, handles)

MonkeyAnalysis
% hObject    handle to MonkeyAnal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Honk.
function Honk_Callback(hObject, eventdata, handles)
% hObject    handle to Honk (see GCBO)

actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
DA.SetTargetVal('Stim1.Honk',1);
pause(.1)
DA.SetTargetVal('Stim1.Honk',0);
close(actxfigure);


% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
