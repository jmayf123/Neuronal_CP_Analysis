function [Count,Tank,BlockNumber,flag]=MonkeyKlattahRunGo2(b,RorP)  %***********
%%Data={4,ToneV(1-4),VowelNum(1-5), NoiseV(in V),NoiseType(1-Vnoise 0 SS),NoiseModF,[]};

Recording=RorP;
MasterSlave=1;

LowestTone=b{2}+1;
vowel=b{3}+1;
Noise= b{4};
NoiseType=b{5};
if b{6}>0
    ModNoiseTF=1;
else
    ModNoiseTF=0;
end






[Count, LowestToneLevel] = MonkeyVowelBFRLfilemakerr(LowestTone, Noise,vowel);
VowelSound=MonkeyKlattah_complex(vowel,b{7});

if ModNoiseTF==1 && NoiseType==0
    SaveData.ModNoiseFreq=b{6};
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
if Recording==1
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag,Tank]=MonkeyControlsWorld(1,0,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,1);
        SaveData.Comments={' '};
        BlockNumber=BlockNumber;
        if flag==1
            return
        end
       
    end
    SaveData.MonkeyName=MonkeyName;
    SaveData.BlockNumber=BlockNumber;
    SaveData.DataType=DataType;    
    MonkeySaveData(SaveData)
else
    %msgbox('Vowel file creation a success!', 'Success!');
    if MasterSlave==1
        [MonkeyName,BlockNumber,DataType,flag, Tank]=MonkeyControlsWorld(1,NoiseType,...
            SaveData.ModNoiseFreq,SaveData.ToneMod,SaveData.NoiseLevel,SaveData.NoiseLevel,0);
    end
end