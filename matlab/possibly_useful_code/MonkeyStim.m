

function varargout = MonkeyStim(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MonkeyStim_OpeningFcn, ...
                   'gui_OutputFcn',  @MonkeyStim_OutputFcn, ...
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


% --- Executes just before MonkeyStim is made visible.
function MonkeyStim_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
global SaveData
SaveData.Flag=0;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%After NRL run is pushed go here
function NRLrun_Callback(hObject, eventdata, handles)      %***********
MasterSlave=get(handles.TakeControl,'Value');
global SaveData
a=0;
if SaveData.Flag==1        
    warndlg('Please Complete last save data', 'Can not continue!');
    SaveRecording
    return
end

ModNoiseTF=get(handles.ModNoiseTF,'Value');
BF=str2num(get(handles.NRLBF, 'String'));
ToneMod=str2num(get(handles.NRLModFreq, 'String'));
BFtone=str2num(get(handles.NRLBFLevel, 'String'));
switch get(handles.NRLLowestNoise, 'Value')
    case 1
        warndlg('Lowest Noise Not Selected', 'Warning!');
        return
    case 2
        NoiseLevel=2;
    case 3
        NoiseLevel=3;
    case 4
        NoiseLevel=4;
end

LowestNoise=MonkeyNRLfilemaker(BF,BFtone,ToneMod,NoiseLevel);


if get(handles.NRLRecording,'Value')==1   
    if ModNoiseTF==1
        SaveData.ModNoiseFreq=10;
    else
        SaveData.ModNoiseFreq=0;
    end
    SaveData.CF=BF;
    SaveData.ToneLevel=BFtone;
    SaveData.ToneMod=ToneMod;
    SaveData.TestType='NRL';
    SaveData.NoiseLevel=LowestNoise;
    SaveData.NoiseType='Steady State';
    SaveData.Flag=1;
    SaveRecording
else
    msgbox('NRL file creation a success!', 'Success!');
end
end

%After Klattah run is pushed go here
function Klattahrun_Callback(hObject, eventdata, handles)  %***********

MasterSlave=get(handles.TakeControl,'Value');
ModNoiseTF=get(handles.ModNoiseTF,'Value');
NoiseType=get(handles.NoiseType,'Value');
vowel=get(handles.KlattahVowellSelect, 'Value');
switch vowel
    case 1
        warndlg('Vowel Not Selected', 'Warning!');        
        return
    otherwise
end
LowestTone=get(handles.KlattahLowestTone,'Value');
if (LowestTone==1)
    warndlg('Lowest Noise Not Selected', 'Warning!');
    return
end
Noise= str2num(get(handles.KlattahNoiseLevel, 'String'));
[Count, LowestToneLevel] = MonkeyVowelBFRLfilemakerr(LowestTone, Noise,vowel);
VowelSound=MonkeyKlattah2(vowel);
set(handles.TrialNumber, 'String', Count);
if ModNoiseTF==1 && NoiseType==0
    SaveData.ModNoiseFreq=10;
    SaveData.NoiseType='Modulated Noise';
elseif ModNoiseTF==0 && NoiseType==1
    SaveData.ModNoiseFreq=0;
    SaveData.NoiseType='Vowel Noise';
elseif ModNoiseTF==0 && NoiseType==0
    SaveData.ModNoiseFreq=0;
    SaveData.NoiseType='SteadyState';
end
flag=0;
SaveData.CF='n/a';
SaveData.ToneLevel=LowestToneLevel;
SaveData.ToneMod=0;
SaveData.TestType=VowelSound;
SaveData.NoiseLevel=Noise;
if get(handles.KRecording,'Value')==1
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag]=MonkeyControlsWorld(1,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,1);
        SaveData.Comments=inputdlg('Comments about current block or monkey behavior');
        if flag==1
            return
        end
    elseif MasterSlave==0
        dlg={'Monkey Name','Block Number','NeuroBehavior or Behavior','Comments'};
        [Response]=inputdlg(dlg);
        MonkeyName=Response(1); 
        BlockNumber=Response(2);
        DataType=Response(3);
        SaveData.Comments=Response(4);   
    end
    SaveData.MonkeyName=MonkeyName;
    SaveData.BlockNumber=BlockNumber;
    SaveData.DataType=DataType;    
    MonkeySaveData(SaveData)
else
    msgbox('Vowel file creation a success!', 'Success!');
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType]=MonkeyControlsWorld(1,NoiseType,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,0);
    end
end
end


%After Response Map Run is pushed go here
function RMrun_Callback(hObject, eventdata, handles)      %***********  
MasterSlave=get(handles.TakeControl,'Value');
ModNoiseTF=get(handles.ModNoiseTF,'Value');
Noise=str2num(get(handles.RMNoiseLevel, 'String'));
ToneMod=0;
%Mod=str2num(get(handles.RMModFreq, 'String'));
NumOctave=str2num(get(handles.NumOctaves, 'String'));
BF=str2num(get(handles.RMBF, 'String'));
ToneLevel=str2num(get(handles.RMToneLevel, 'String'));
Count=MonkeyRespMapfilemaker(Noise,ToneMod,NumOctave,BF,ToneLevel);
set(handles.TrialNumber, 'String', Count);

if ModNoiseTF==1
    SaveData.ModNoiseFreq=10;
    SaveData.NoiseType='Modulated Noise';
else
    SaveData.ModNoiseFreq=0;
    SaveData.NoiseType='SteadyState';
end

flag=0;
SaveData.CF=BF;
SaveData.ToneLevel=ToneLevel;
SaveData.ToneMod=ToneMod;
SaveData.TestType='Response Map';
SaveData.NoiseLevel=Noise;
if get(handles.RMRecording,'Value')==1
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag]=MonkeyControlsWorld(0,0,...
        SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,1);
        SaveData.Comments=inputdlg('Comments about current block or monkey behavior');
    elseif MasterSlave==0
        dlg={'Monkey Name','Block Number','NeuroBehavior or Behavior','Comments'};
        [Response]=inputdlg(dlg);
        MonkeyName=Response(1);
        BlockNumber=Response(2);
        DataType=Response(3);
        SaveData.Comments=Response(4);
    end
    if flag==1
        return
    end
    SaveData.MonkeyName=MonkeyName;
    SaveData.BlockNumber=BlockNumber;
    SaveData.DataType=DataType;
    MonkeySaveData(SaveData);

else
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag]=MonkeyControlsWorld(0,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,0);
    end
    msgbox('Behavior BFRL file creation a success!', 'Success!');
end
end

%After BFRL run is pushed go here
function BFRLrun_Callback(hObject, eventdata, handles)    %*********** 
MasterSlave=get(handles.TakeControl,'Value');
Noise=str2num(get(handles.BFRLNoiseLevel, 'String'));
ModNoiseTF=get(handles.ModNoiseTF,'Value');
ToneMod=str2num(get(handles.BFRLModFreq, 'String'));
BF=str2num(get(handles.BFRLBF, 'String'));
d=get(handles.BFRLLowestTone,'Value');
switch d
    case 1
        warndlg('Lowest Tone Not Selected', 'Warning!');
        return;
    otherwise
end
Tone=d;
[Count LowestToneLevel]= MonkeyBehaviorBFRLfilemaker(BF,Tone,Noise,ToneMod,ModNoiseTF);
set(handles.TrialNumber, 'String', Count);

if ModNoiseTF==1
    SaveData.ModNoiseFreq=10;
    SaveData.NoiseType='Modulated Noise';
else
    SaveData.ModNoiseFreq=0;
    SaveData.NoiseType='SteadyState';
end

SaveData.CF=BF;
SaveData.ToneLevel=LowestToneLevel;
SaveData.ToneMod=ToneMod;
SaveData.TestType='BFRL';
SaveData.NoiseLevel=Noise;
flag=0;
if get(handles.BBFRLRecording,'Value')==1      
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag]=MonkeyControlsWorld(0,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,1);
        SaveData.Comments=inputdlg('Comments about current block or monkey behavior'); 
    elseif MasterSlave==0
        dlg={'Monkey Name','Block Number','NeuroBehavior or Behavior','Comments'};
        [Response]=inputdlg(dlg);
        MonkeyName=Response(1); 
        BlockNumber=Response(2);
        DataType=Response(3);
        SaveData.Comments=Response(4);
    end
    if flag==1
        return
    end
    SaveData.MonkeyName=MonkeyName;
    SaveData.BlockNumber=BlockNumber;
    SaveData.DataType=DataType;  
    MonkeySaveData(SaveData)
    
else
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag]=MonkeyControlsWorld(0,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,0);
    end
    msgbox('Behavior BFRL file creation a success!', 'Success!');
end
end


function PSTHRun_Callback(hObject, eventdata, handles) %***********
global SaveData
if SaveData.Flag==1    
    warndlg('Please Complete last save data', 'Can not continue!');
    SaveRecording
    return
end
Noise=str2num(get(handles.PSTHNoiseLevel, 'String'));
ModNoiseTF=get(handles.ModNoiseTF,'Value');
ToneMod=str2num(get(handles.PSTHModFreq, 'String'));
BF=str2num(get(handles.PSTHBF, 'String'));
ToneLevel=str2num(get(handles.PSTHToneLevel, 'String'));
NumReps= str2num(get(handles.PSTHnumreps, 'String'));
reps=MonkeyPSTHfilemaker(BF,ToneLevel,ToneMod,Noise,NumReps);
set(handles.TrialNumber, 'String', reps);


if get(handles.PSTHRecording,'Value')==1
    if ModNoiseTF==1
        SaveData.ModNoiseFreq=10;
        SaveData.NoiseType='Modulated Noise';
    else
        SaveData.ModNoiseFreq=0;
        SaveData.NoiseType='SteadyState';
    end
    SaveData.CF=BF;
    SaveData.ToneLevel=ToneLevel;
    SaveData.ToneMod=ToneMod;
    SaveData.TestType='PSTH';
    SaveData.NoiseLevel=Noise;
    SaveData.Flag=1;
    SaveRecording
else
    msgbox('PSTH file creation a success!', 'Success!');
end
end


function CloseMonkeyStim_Callback(hObject, eventdata, handles)
close all
end


% --- Executes on button press in FreqSearchGo.
function FreqSearchGo_Callback(hObject, eventdata, handles) 

HighFreq=str2num(get(handles.HighFreq, 'String'));
if HighFreq==0
    warndlg('Please input High Frequency', 'Sorry!');
    return
elseif  HighFreq>36000
    warndlg('Please input a Frequency lower than 36000', 'Sorry');
    return
end
LowFreq=str2num(get(handles.LowFreq, 'String'));
if LowFreq<=180
    warndlg('Please input frequency higher than 200 for Low Freq', 'Sorry!');
    return
end
StepSize=str2num(get(handles.OctaveSteps, 'String'));
if StepSize==0
    warndlg('Please Input Step size larger than 0', 'Sorry!');
    return
end
NumPulses=str2num(get(handles.NumPulses, 'String'));
if NumPulses==0
    warndlg('Please enter an integer greater than 0', 'Sorry!');
    return
end
if HighFreq<=LowFreq
    warndlg('High Frequency must be larger than Low Frequency','Sorry!');
    return
end
Order=(get(handles.FSOrder,'Value'));

[Steps] = MonkeySearchFilemaker(LowFreq,HighFreq,StepSize,Order,NumPulses);
msgbox('Search parameter creation a success!', 'Success!');
set(handles.TrialNumber, 'String', Steps);
end

function FolderCreateRun_Callback(hObject, eventdata, handles)

Behavior=(get(handles.BehaviorSelect,'Value'));
Location=(get(handles.LocationSelect,'Value'));
Monkey=(get(handles.MonkeySelect,'Value'));
success=MonkeyFolderMaker(Monkey,Location,Behavior);

msgbox('Data Tank Folder has been created', 'Success!');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function varargout = MonkeyStim_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
end


%on idle push button go
function Idle_Callback(hObject, eventdata, handles)
actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
if  DA.GetSysMode ~=0
    DA.SetSysMode(0);
    DA.CloseConnection;
    close(actxfigure);
elseif DA.GetSysMode == 0
    warndlg('OpenEx already idled', 'Did you know....')    
    DA.CloseConnection;
    close(actxfigure);
    return
end
end

% --- Executes on button press in RandFact.
function RandFact_Callback(hObject, eventdata, handles)
fact=MonkeyRandomFact;
msgbox(fact);
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

a= get(hObject, 'Value');
set(handles.text57,'String',['Noise Level = ',num2str(a/100)])
actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
    b=DA.SetTargetVal('Stim.NsLvlIn1',a/100);
    pause(.05)
%     b=DA.SetTargetVal('Stim1.NsLvlIn1',NoiseFilter.BW);
%     pause(.005)
%    
DA.CloseConnection;
    close(actxfigure);
end

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a= get(hObject, 'Value');
set(handles.text58,'String',['Stim Level = ',num2str(a)])
actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
    b=DA.SetTargetVal('Stim.LevelIn1',a/100);
    pause(.05)
%     b=DA.SetTargetVal('Stim1.NsLvlIn1',NoiseFilter.BW);
%     pause(.005)
%    
DA.CloseConnection;
    close(actxfigure);

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
end
