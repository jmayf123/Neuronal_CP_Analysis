function MonkeyGUIBuild2(Task, handles)


switch Task
    case 0
        StartUpSelect(handles)

    case 2
        ResponseMapSelect(handles)
    case 3
        BFRLSelect(handles)
    case 4
        VowelSelect(handles)
    case 5 
        NRLSelect(handles)
    case 6
        PSTHSelect(handles)
    case 7
        FrequencySearchSelect(handles)
    case 8
        GreyOutButtons(handles)
    case 9
        RecordingOver(handles)
    otherwise
end

function RecordingOver(handles)

set(handles.PauseResume,'Visible','On')
set(handles.PlotCurrent,'Visible','Off')
set(handles.StopMonitor,'Visible','Off')

set(handles.Cancel,'Visible','Off')
set(handles.TaskSelect1, 'Enable','On')
set(handles.Q1,'Enable','On')
set(handles.Q1,'BackgroundColor',[165/256,171/256,139/256])
set(handles.Remove,'Visible','On')
set(handles.PreviewQ,'Visible','On')
set(handles.QueueRecord,'Visible','On')
set(handles.IdleSingle,'Enable','On')
set(handles.AddTo,'Enable','On')
set(handles.MonitorCurrent,'Enable','On')

function GreyOutButtons(handles)
set(handles.Q1,'Value',0)
set(handles.StopMonitor,'Visible','On')
set(handles.PauseResume,'Visible','On')
set(handles.PlotCurrent,'Visible','On')
set(handles.Cancel,'Visible','On')
set(handles.Q1,'Enable','Off')
set(handles.Q1,'BackgroundColor',[219/256, 107/256 , 72/256])
set(handles.Remove,'Visible','On')
set(handles.PreviewQ,'Visible','Off')
set(handles.QueueRecord,'Visible','Off')
set(handles.IdleSingle,'Enable','On')

set(handles.MonitorCurrent,'Enable','Off')
%set(handles.AddTo,'Enable','Off')

function StartUpSelect(handles)
set(handles.StopMonitor,'Visible','Off')
set(handles.PlotCurrent,'Visible','Off')
set(handles.Cancel,'Visible','Off')
set(handles.PauseResume,'Visible','On')
set(handles.Label1,'Visible','Off')
set(handles.Data1, 'Visible','Off')
set(handles.Label2,'Visible','Off')
set(handles.Data2, 'Visible','Off')
set(handles.Label3,'Visible','Off')
set(handles.Data3, 'Visible','Off')
set(handles.Label4,'Visible','Off')
set(handles.Data4, 'Visible','Off')
set(handles.Label5,'Visible','Off')
set(handles.Data5, 'Visible','Off')
set(handles.text10,'Visible','Off')
set(handles.popupmenu8,'Visible','Off')
set(handles.Q1,'Visible','Off')
set(handles.Q2,'Visible','Off')
set(handles.Q3,'Visible','Off')
set(handles.Q4,'Visible','Off')
set(handles.Q5,'Visible','Off')
set(handles.Q6,'Visible','Off')
set(handles.Q7,'Visible','Off')
set(handles.Q8,'Visible','Off')
set(handles.Q9,'Visible','Off')

function ResponseMapSelect(handles)
ToneList={'-6 dB';'4 dB';'14 dB';'24 dB';'34 dB';'44 dB';'54 dB';'64 dB';'74 dB'};
NoiseList={'+0dB';'+10dB (.0079V)';'+20dB (.025V)'};

set(handles.Label1,'Visible','On')
set(handles.Data1,'Visible','On')
set(handles.Label1,'String','CF')
set(handles.Data1,'Style','edit')
set(handles.Data1,'String','0')

set(handles.Label2,'Visible','On')
set(handles.Data2, 'Visible','On')
set(handles.Label2,'String','Tone Level')
set(handles.Data2, 'Style','popupmenu')
set(handles.Data2, 'String', ToneList)
set(handles.Data2,'Value',1)

set(handles.Label3,'Visible','On')
set(handles.Data3, 'Visible','On')
set(handles.Label3,'String','# Octaves')
set(handles.Data3, 'Style','edit')
set(handles.Data3,'String','2')

set(handles.Label4,'Visible','On')
set(handles.Data4, 'Visible','On')
set(handles.Label4,'String','Noise')
set(handles.Data4, 'Style','popupmenu')
set(handles.Data4, 'String', NoiseList)
set(handles.Data4,'Value',1)

set(handles.Label5,'Visible','Off')
set(handles.Data5, 'Visible','Off')

set(handles.text10,'Visible','Off')
set(handles.popupmenu8,'Visible','Off')

function BFRLSelect(handles)
ToneList={'-16 dB';'-13 dB';'-10 dB';'-6 dB';'-3 dB';'0 dB';'4 dB';'7 dB';'10 dB';'14 dB';'17 dB';'20 db';'24 db'};
NoiseList={'+0dB';'+10dB (.0079V)';'+20dB (.025V)'};
NoiseModFreq={'0 Hz'; '10 Hz'; '20 Hz';'25 Hz'; '50 Hz';'100 Hz'};
ModFreq={'0 Hz'; '10 Hz'; '20 Hz';};

set(handles.Label1,'Visible','On')
set(handles.Data1,'Visible','On')
set(handles.Label1,'String','BF')
set(handles.Data1,'Style','edit')
set(handles.Data1,'String','0')

set(handles.Label2,'Visible','On')
set(handles.Data2, 'Visible','On')
set(handles.Label2,'String','Lowest Tone')
set(handles.Data2, 'Style','popupmenu')
set(handles.Data2, 'String', ToneList)
set(handles.Data2,'Value',1)

set(handles.Label3,'Visible','On')
set(handles.Data3, 'Visible','On')
set(handles.Label3,'String','Tone Mod Freq')
set(handles.Data3, 'Style','popupmenu')
set(handles.Data3,'String', ModFreq)
set(handles.Data3,'Value',1)

set(handles.Label4,'Visible','On')
set(handles.Data4, 'Visible','On')
set(handles.Label4,'String','Noise')
set(handles.Data4, 'Style','popupmenu')
set(handles.Data4, 'String', NoiseList)
set(handles.Data4,'Value',1)
          
set(handles.Label5,'Visible','On')
set(handles.Data5, 'Visible','On')
set(handles.Label5,'String','Noise Mod Freq')
set(handles.Data5, 'Style','popupmenu')
set(handles.Data5,'String',NoiseModFreq)
set(handles.Data5,'Value',1)

set(handles.text10,'Visible','Off')
set(handles.popupmenu8,'Visible','Off')

function   VowelSelect(handles)
VowelList={'Ah';'Eh';'Ih';'Oh';'Ooh'};
ToneList={'-16db';'-13db';'-10db';'-6db';'-3db';'0db';'4db';'7db';'10db';'14db';'17db';'20db';'24db';'27db';'30db';'34db';'37db';'40db';'44db'};
NoiseList={'+0V';'+.004446V';'+.0079V';'+.01405V';'+.025V';'+.04446V';'+.079V'};
NoiseType={'V-Noise';'SS-Noise'};
ModFreq={'0 Hz'; '10 Hz'; '20 Hz';'40 Hz';'80 Hz';'100 Hz'};
F0Freq={'60 Hz';'80 Hz';'100 Hz'};

set(handles.Label1,'Visible','On')
set(handles.Data1,'Visible','On')
set(handles.Label1,'String','Vowel Select')
set(handles.Data1,'Style','popupmenu')
set(handles.Data1,'String',VowelList)

set(handles.Label2,'Visible','On')
set(handles.Data2, 'Visible','On')
set(handles.Label2,'String','Lowest Tone')
set(handles.Data2, 'Style','popupmenu')
set(handles.Data2, 'String', ToneList)
set(handles.Data2, 'Value',1)

set(handles.Label3,'Visible','On')
set(handles.Data3, 'Visible','On')
set(handles.Label3,'String','Noise')
set(handles.Data3, 'Style','popupmenu')
set(handles.Data3,'String', NoiseList)
set(handles.Data3,'Value',1)

set(handles.Label4,'Visible','On')
set(handles.Data4, 'Visible','On')
set(handles.Label4,'String','Noise Type')
set(handles.Data4, 'Style','popupmenu')
set(handles.Data4, 'String', NoiseType)
set(handles.Data4,'Value',1)

set(handles.Label5,'Visible','On')
set(handles.Data5, 'Visible','On')
set(handles.Label5,'String','Noise Mod Freq')
set(handles.Data5, 'Style','popupmenu')
set(handles.Data5,'String',ModFreq)
set(handles.Data5,'Value',1)

set(handles.text10,'Visible','On')
set(handles.text10,'String','f0')
set(handles.popupmenu8,'Visible','On')
set(handles.popupmenu8,'Style','popupmenu')
set(handles.popupmenu8,'String',F0Freq)
set(handles.popupmenu8,'Value',3)


function   NRLSelect(handles)
LowestNoise={'-16 dB';'-6 dB';'4 dB';'14 dB'};
ModFreq={'0 Hz'; '10 Hz'; '20 Hz'};

set(handles.Label1,'Visible','On')
set(handles.Data1,'Visible','On')
set(handles.Label1,'String','Lowest Noise')
set(handles.Data1,'Style','popupmenu')
set(handles.Data1,'String',LowestNoise)

set(handles.Label2,'Visible','On')
set(handles.Data2, 'Visible','On')
set(handles.Label2,'String','Mod Freq')
set(handles.Data2, 'Style','popupmenu')
set(handles.Data2, 'String', ModFreq)

set(handles.Label3,'Visible','Off')
set(handles.Data3, 'Visible','Off')

set(handles.Label4,'Visible','Off')
set(handles.Data4, 'Visible','Off')
          
set(handles.Label5,'Visible','Off')
set(handles.Data5, 'Visible','Off')

set(handles.text10,'Visible','Off')
set(handles.popupmenu8,'Visible','Off')




function   PSTHSelect(handles)
ToneList={'-16 dB';'-6 dB';'4 dB';'9 dB';'14 dB'};
ModFreq={'0 Hz'; '10 Hz'; '20 Hz'};

set(handles.Label1,'Visible','On')
set(handles.Data1,'Visible','On')
set(handles.Label1,'String','BF')
set(handles.Data1,'Style','edit')
set(handles.Data1,'String','0')

set(handles.Label2,'Visible','On')
set(handles.Data2, 'Visible','On')
set(handles.Label2,'String','Lowest Tone')
set(handles.Data2, 'Style','popupmenu')
set(handles.Data2, 'String', ToneList)

set(handles.Label3,'Visible','On')
set(handles.Data3, 'Visible','On')
set(handles.Label3,'String','Reps')
set(handles.Data3, 'Style','edit')
set(handles.Data3,'String','100')

set(handles.Label4,'Visible','On')
set(handles.Data4, 'Visible','On')
set(handles.Label4,'String','Tone Mod Freq')
set(handles.Data4, 'Style','popupmenu')
set(handles.Data4, 'String', ModFreq)
          
set(handles.Label5,'Visible','On')
set(handles.Data5, 'Visible','On')
set(handles.Label5,'String','Noise Level')
set(handles.Data5, 'Style','popupmenu')
set(handles.Data5,'String',ModFreq)

set(handles.text10,'Visible','Off')
set(handles.popupmenu8,'Visible','Off')

function  FrequencySearchSelect(handles)
FreqOrder={'Ascending';'Descending'};
set(handles.Label1,'Visible','On')
set(handles.Data1,'Visible','On')
set(handles.Label1,'String','Lower Freq')
set(handles.Data1,'Style','edit')
set(handles.Data1,'String','100')

set(handles.Label2,'Visible','On')
set(handles.Data2, 'Visible','On')
set(handles.Label2,'String','Upper Freq')
set(handles.Data2, 'Style','edit')
set(handles.Data2, 'String', '40000')

set(handles.Label3,'Visible','On')
set(handles.Data3, 'Visible','On')
set(handles.Label3,'String','# Pulses')
set(handles.Data3, 'Style','edit')
set(handles.Data3,'String', '2')

set(handles.Label4,'Visible','On')
set(handles.Data4, 'Visible','On')
set(handles.Label4,'String','Step Size (Octaves)')
set(handles.Data4, 'Style','edit')
set(handles.Data4, 'String', '.2')
          
set(handles.Label5,'Visible','On')
set(handles.Data5, 'Visible','On')
set(handles.Label5,'String','Order')
set(handles.Data5, 'Style','popupmenu')
set(handles.Data5,'String',FreqOrder)

set(handles.text10,'Visible','Off')
set(handles.popupmenu8,'Visible','Off')