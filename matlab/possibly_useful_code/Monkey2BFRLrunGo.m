function [Count,Tank,BlockNumber,flag] = Monkey2BFRLrunGo(b,RorP)    %*********** 
%{[3],BF,BFToneLevel,NoiseModF,ToneModF,NoiseV,[]};


BFRLRecording=RorP;
MasterSlave=1;
BF=(b{2});
Tone=b{3};
if b{4}>0
    ModNoiseTF=1;
else
    ModNoiseTF=0;
end
ToneMod=(b{5});
Noise=b{6};




[Count LowestToneLevel]= MonkeyBehaviorBFRLfilemaker(BF,Tone,Noise,ToneMod,ModNoiseTF);


if ModNoiseTF==1
    SaveData.ModNoiseFreq=(b{4});
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
if BFRLRecording==1      
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag,Tank]=MonkeyControlsWorld(0,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,1);
        SaveData.Comments={''};   %   inputdlg('Comments about current block or monkey behavior'); 
        BlockNumber=BlockNumber;
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
        [MonkeyName,BlockNumber,DataType,flag, Tank]=MonkeyControlsWorld(0,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,0);
    end
    
    %msgbox('Behavior BFRL file creation a success!', 'Success!');
end