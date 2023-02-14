function MonkeySaveOldData(SaveData)


FinalString=[SaveData.MonkeyName,'		',SaveData.Date,'		',SaveData.BlockNumber,'		',SaveData.TestType,...
    '		',SaveData.LengthTrial,'		',SaveData.ToneLevel,'		',SaveData.CF,'		',SaveData.ToneMod,...
    '		',SaveData.NoiseType,'		',SaveData.NoiseLevel,'		',SaveData.DataType,'		',SaveData.NoiseMod,...
    '		',SaveData.Comments];

Dirrectory= 'C:\Users\Kimaya\Desktop\Recording Info\OldRecordingInfo.txt';
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