function [Count,Tank,BlockNumber,flag]= Monkey2RMrunGo(b,RorP)      %***********  
%b is orderd Data={[2], CF,ToneLevel,Octave,NoiseV,[],[]};

MasterSlave=1;
Recording=RorP;
ModNoiseTF=0;
Noise=b{5};
ToneMod=0;
NumOctave=b{4};
BF=b{2};
ToneLevel=b{3};


switch ToneLevel
    case 1
        ToneLevel=.000079;
    case 2
        ToneLevel=.00025;
    case 3
        ToneLevel=.00079;
    case 4
        ToneLevel= .0025;     
    case 5
        ToneLevel=.0079;
    case 6
        ToneLevel=.025;
    case 7
        ToneLevel=.079;
    case 8
        ToneLevel=.25;
    case 9
        ToneLevel=.79;        
    otherwise
end
        
Count=MonkeyRespMapfilemaker(Noise,ToneMod,NumOctave,BF,ToneLevel);


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
if Recording==1
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag,Tank]=MonkeyControlsWorld(0,0,...
        SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,1);
        %SaveData.Comments=inputdlg('Comments about current block or monkey behavior');
        SaveData.Comments={''};
        BlockNumber=BlockNumber;
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
        [MonkeyName,BlockNumber,DataType,flag, Tank]=MonkeyControlsWorld(0,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,0);
    end
    %msgbox('Behavior BFRL file creation a success!', 'Success!');
end

