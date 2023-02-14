function MonkeySaveData(SaveData)

Date=GetDateString();
MonkeyName=SaveData.MonkeyName;
SaveData.BlockNumber;
Block=num2str(SaveData.BlockNumber+1);
Test=SaveData.TestType;
ToneLevel=num2str(SaveData.ToneLevel);
CF=num2str(SaveData.CF);
ToneModulation=num2str(SaveData.ToneMod);
NoiseType=SaveData.NoiseType;
NoiseLevel=num2str(SaveData.NoiseLevel);
NoiseMod=num2str(SaveData.ModNoiseFreq);
Type=SaveData.DataType;
Comments1=SaveData.Comments;
FinalString=[MonkeyName,'	',Date,'	',Block,'	',Test,'	',ToneLevel,'	',CF,'	',ToneModulation,...
    '	',NoiseType,'	',NoiseLevel,'	',Type,'	',NoiseMod,'	',Comments1];
FinalString=cell2mat(FinalString);
Dirrectory= 'C:\Users\Kimaya\Desktop\Recording Info\RecordingInfo.txt';
fid=fopen(Dirrectory, 'a+');
fprintf(fid, '%s\r\n', FinalString);
fclose(fid);
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