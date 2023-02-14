function [StimType Data string] = MonkeyGetStimInfo(handles)

Selection = get(handles.TaskSelect1,'Value');
switch Selection
    case 1
        warndlg('You have not selected anything to add','Doh!!!')
        Data={1,[],[],[],[],[],'blank'};
        string=['Man you really messed up now...'];
       
        StimType='';
    case 2
        [Data string]=ResponseMapData(handles);
        StimType='Response Map';
    case 3
        [Data string]=BFRLData(handles);
        StimType='BFRL';
    case 4
        [Data string]=VowelData(handles);
        StimType='Vowel';
    case 5 
        [Data string]=NRLData(handles);
        StimType='NRL';
    case 6
        [Data string]=PSTHData(handles);
        StimType='PSTH';
    case 7
        [Data string]=FrequencySearchData(handles);
        StimType='Freq Search';
        
    case 8
        [Data string]=TestData(handles);
        StimType='StimStats';
        
    otherwise
end

function [Data string]= ResponseMapData(handles)
CF=str2num(get(handles.Data1,'String'));
CFStr=['CF@',num2str(CF), ' Hz'];

switch   get(handles.Data2,'Value')
    case 1
        ToneLevel=.000079;
        TonedB='-6 dB';
    case 2
        ToneLevel=.00025;
        TonedB='4 dB';
    case 3
        ToneLevel=.00079;
        TonedB='14 dB';
    case 4
        ToneLevel= .0025; 
        TonedB='24 dB';
    case 5
        ToneLevel=.0079;
        TonedB='34 dB';
    case 6
        ToneLevel=.025;
        TonedB='44 dB';
    case 7
        ToneLevel=.079;
        TonedB='54 dB';
    case 8
        ToneLevel=.25;
        TonedB='64 dB';
    case 9
        ToneLevel=.79;
        TonedB='74 dB';
end

Octave=str2num(get(handles.Data3,'String'));
OctaveStr=[num2str(CF), ' Octave Steps'];

switch get(handles.Data4, 'Value')
    case 1
        NoiseV=0;
        NoisedB='+0 dB noise';
    case 2
        NoiseV=.0079;
        NoisedB='+10 dB noise';
    case 3 
        NoiseV=.025;
        NoisedB='+20 dB noise';
end

 
string=['Resp. Map,',TonedB, NoisedB];
Data={[2], CF,ToneLevel,Octave,NoiseV,[],[]};


function [Data string] = BFRLData(handles)
BF=str2num(get(handles.Data1,'String'));
BFStr=['@',num2str(BF), ' Hz'];
Data1= {BF, BFStr};
BFToneLevel=get(handles.Data2, 'Value')+1;
switch BFToneLevel
    case 2
        ToneC=2;
        TonedB=', -16dB';
    case 3
        ToneC=3;
        TonedB=', -13dB';
    case 4
        ToneC=4;
        TonedB=', -10dB';
    case 5
        ToneC=5;
        TonedB=', -6dB';
    case 6
        ToneC=6;
        TonedB=', -3dB';
    case 7
        ToneC=7;
        TonedB=', 0dB';
    case 8
        ToneC=8;
        TonedB=', 4dB';
    case 9
        ToneC=9;
        TonedB=', 7dB';    
    case 10
        ToneC=10;
        TonedB=', 10dB';       
    case 11
        ToneC=11;
        TonedB=', 14dB';
    case 12
        ToneC=12;
        TonedB='17db';
    case 13
        ToneC=13;
        TonedB='20dB';
    case 14
        ToneC=14;
        TonedB='24dB';
    case 15
        ToneC=42;
        TonedB='Big 1';
    case 16
        ToneC=52;
        TonedB='Catch 1';
    case 17
        ToneC=53;
        TonedB='Catch 2';
    case 18
        ToneC=54;
        TonedB='Catch 3';
    case 19
        ToneC=55;
        TonedB='Catch 4';
    case 20
        ToneC=56;
        TonedB='Catch 5';
    case 21
        ToneC=57;
        TonedB='Catch 6';
    case 22
        ToneC=58;
        TonedB='Catch 7';
    case 23
        ToneC=59;
        TonedB='Catch 8';
    case 24
        ToneC=60;
        TonedB='Catch 9';
    case 25
        ToneC=61;
        TonedB='Catch 10';
end


switch get(handles.Data3, 'Value')
    case 1
        ToneModF=0;
        ToneModS='';
    case 2
        ToneModF=10;
        ToneModS=', 10 Hz Mod. Tone';
    case 3 
        ToneModF=20;
        ToneModS=', 20 Hz Mod. Tone';

end

switch get(handles.Data4, 'Value')
    case 1
        NoiseV=0;
        NoisedB=', +0 dB noise';
    case 2
        
        
        NoiseV=.0079;
        
        NoisedB=', +10 dB noise';
    case 3 
        
        
        
        NoiseV=.025;
        NoisedB=', +20 dB noise';
end


switch get(handles.Data5, 'Value')
    case 1
        NoiseModF=0;      
        NoiseModS='';
    case 2
        NoiseModF=10;      
        NoiseModS=', 10 Hz Mod. Noise';
    case 3 
        NoiseModF=20;        
        NoiseModS=', 20 Hz Mod. Noise';
    case 4
        NoiseModF=25;
        NoiseModS=', 25 Hz Mod. Noise';
    case 5
        NoiseModF=50;
        NoiseModS=', 50 Hz Mod. Noise';
    case 6
        NoiseModF=100;
        NoiseModS=', 100 Hz Mod. Noise';
        
end


Data={[3],BF,ToneC,NoiseModF,ToneModF,NoiseV,'blank'};
string=['BFRL ',BFStr,'',TonedB,'',ToneModS,'', NoisedB,'',NoiseModS];


function [Data string]=VowelData(handles)
switch get(handles.Data1, 'Value')
    case 1
        VowelNum=1;
        Vowel='Ah';
    case 2
        VowelNum=2;
        Vowel='Eh';
    case 3
        VowelNum=4;
        Vowel='Ih';
    case 4
        VowelNum=5;
        Vowel='Oh';
    case 5
        VowelNum=3;
        Vowel='Ooh';
end  

switch get(handles.Data2, 'Value')
    
    case 1
        TonedB=', -16dB,';
        ToneV=1;
    case 2
        TonedB=', -13dB,';
        ToneV=2;
    case 3
        TonedB=', -10dB,';
        ToneV=3;
    case 4
        TonedB=', -6dB,';
        ToneV=4;
    case 5
        TonedB=', -3dB,';
        ToneV=5;
    case 6
        TonedB=', 0dB,';
        ToneV=6;
    case 7
        TonedB=', 4dB,';
        ToneV=7;
    case 8
        TonedB=', 7dB,';
        ToneV=8;
    case 9
        TonedB=', 10dB,';
        ToneV=9;
    case 10
        TonedB=', 14dB,';
        ToneV=10;
    case 11
        TonedB=', 17dB,';
        ToneV=11;
    case 12
        TonedB=', 20dB,';
        ToneV=12;
    case 13
        TonedB=', 24dB,';
        ToneV=13;
    case 14
        TonedB=', 27dB,';
        ToneV=14;
    case 15
        TonedB=', 30dB,';
        ToneV=15;
    case 16
        TonedB=', 34dB,';
        ToneV=16;
    case 17
        TonedB=', 37dB,';
        ToneV=17;
    case 18
        TonedB=', 40dB,';
        ToneV=18;
    case 19
        TonedB=', 44dB,';
        ToneV=19;
        
    
    end


switch get(handles.Data3, 'Value')
    case 1
        NoiseV=0;
        NoisedB=' +0V ';
    case 2
        NoiseV=.004446;
        NoisedB=' +.004446V ';
    case 3
        NoiseV=.0079;
        NoisedB=' +.0079V ';        
    case 4
        NoiseV=.01405;
        NoisedB=' +.01405V ';
    case 5 
        NoiseV=.025;
        NoisedB=' +.025V ';
    case 6
        NoiseV=.04446;
        NoisedB=' +.04446V ';
    case 7
        NoiseV=.079;
        NoisedB=' +.079V ';
end

switch get(handles.Data4,'Value')
    case 1
        NoiseType=1;
        NType='Vowel Noise';        
    case 2
        NoiseType=0;
        NType='Steady State Noise';
end


switch get(handles.Data5, 'Value')
    case 1
        NoiseModF=0;
        NoiseModS='';
    case 2
        NoiseModF=10;
        NoiseModS=', 10 Hz Mod. Noise';
    case 3 
        NoiseModF=20;
        NoiseModS=', 20 Hz Mod. Noise';
    case 4
        NoiseModF=40;
        NoiseModS=', 40 Hz Mod. Noise';
    case 5
        NoiseModF=50;
        NoiseModS=', 50 Hz Mod. Noise';
    case 6
        NoiseModF=70.7;
        NoiseModS=', 70.7 Hz Mod. Noise';
    case 7
        NoiseModF=80;
        NoiseModS=', 80 Hz Mod. Noise';
    case 8
        NoiseModF=84.1;
        NoiseModS=', 84.1 Hz Mod. Noise';
    case 9
        NoiseModF=100;
        NoiseModS=', 100 Hz Mod. Noise';
    case 10 
        NoiseModF=141.4;
        NoiseModS=', 141.4 Hz Mod. Noise';    
    case 11
        NoiseModF=200;
        NoiseModS=', 200 Hz Mod. Noise';    
end

switch get(handles.popupmenu8, 'Value')
    case 1
        f0 = 60;
        f0s = 'f0 = 60 Hz';
    case 2
        f0 = 80;
        f0s = 'f0 = 80 Hz';
    case 3
        f0 = 100;
        f0s = 'f0 = 100 Hz';
end


Data={4,ToneV,VowelNum, NoiseV,NoiseType,NoiseModF,f0,[]};
string=['"',Vowel,'" BFRL' f0s, TonedB, ' in', NoisedB,NType,NoiseModS];

function [Data1 Data2 Data3 Data4 Data5 string]=NRLData(handles)

switch get(handles.Data1, 'Value')
    case 1
        LowestNoise=' -16dB noise';
        Voltage=.000025;
    case 2
        LowestNoise=' -6dB noise';
        Voltage=.000079;
    case 3
        LowestNoise=' 4dB noise';
        Voltage=.00025;
    case 4
        LowestNoise=' 9dB noise';
        Voltage=.0004446;
    case 5
        LowestNoise=' 14dB noise';
        Voltage=.00079;
end
Data1={Voltage,LowestNoise};

switch get(handles.Data2, 'Value')
    case 1
        NoiseModF=0;
        NoiseModS='';
    case 2
        NoiseModF=10;
        NoiseModS=', 10 Hz Mod. Noise';
    case 3 
        NoiseModF=20;
        NoiseModS=', 20 Hz Mod. Noise';
end
Data2={NoiseModF,NoiseModS};
Data3=[];
Data4=[];
Data5=[];
string=['NRL, Lowest Noise @',LowestNoise,NoiseModS];

function [Data1 Data2 Data3 Data4 Data5 string]=PSTHData(handles)
BF=str2num(get(handles.Data1,'String'));

switch get(handles.Data2, 'Value')
    case 1
        TonedB=', -16dB';
        ToneV=.000025;
    case 2
        TonedB=', -6dB';
        ToneV=.000079;
    case 3
        TonedB=', 4dB';
        ToneV=.00025;
    case 4
        TonedB=', 9dB';
        ToneV=.0004446;
    case 5
        TonedB=', 14dB';
        ToneV=.00079;
end

reps=str2num(get(handles.Data3,'String'));

 

switch get(handles.Data4, 'Value')
    case 1
        ToneModF=0;
        ToneModS='';
    case 2
        ToneModF=10;
        ToneModS=', 10 Hz Mod. Tone';
    case 3 
        ToneModF=20;
        ToneModS=', 20 Hz Mod. Tone';
end



switch get(handles.Data5, 'Value')
    case 1
        NoiseV=0;
        NoisedB=', +0 dB Noise';
    case 2
        NoiseV=.0079;
        NoisedB=', +10 dB Noise';
    case 3 
        NoiseV=.025;
        NoisedB=', +20 dB Noise';
end

string=['PSTH @', num2str(BF),' Hz', TonedB, ToneModS, NoisedB];
Data1=[];
Data2=[];
Data3=[];
Data4=[];
Data5=[];


function [Data string]=FrequencySearchData(handles)

LowerFreq=str2num(get(handles.Data1,'String'));
UpperFreq=str2num(get(handles.Data2,'String'));
NumPulses=str2num(get(handles.Data3,'String'));
StepSize=str2num(get(handles.Data4,'String'));

switch get(handles.Data5,'Value')
    case 1 
        Order='Ascending';
        OrderV=0;
    case 2
        Order='Descending';
        OrderV=1;
end
string=['Frequency Search from ',num2str(LowerFreq),' Hz to ', num2str(UpperFreq),' Hz in ', num2str(StepSize), ' octave steps'];

Data={7,LowerFreq,UpperFreq,NumPulses,StepSize,OrderV,[]};

% NRL  NRLfilemaker(BF,BFtone,ToneMod,NoiseLevel);
% Vowel_BFRL MonkeyVowelBFRLfilemakerr(LowestTone, Noise,vowel)   MonkeyKlattah2(vowel); %
% ResponseMap MonkeyRespMapfilemaker(Noise,ToneMod,NumOctave,BF,ToneLevel);
% BFRL filemaker(BF,Tone,Noise,ToneMod,ModNoiseTF)
% PSTH MonkeyPSTHfilemaker(BF,ToneLevel,ToneMod,Noise,NumReps);
% Search MonkeySearchFilemaker(LowFreq,HighFreq,StepSize,Order,NumPulses);
