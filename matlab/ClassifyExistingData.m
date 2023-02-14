function [] = ClassifyExistingData(Direct)

[AllVowelData]=BuildVowelWaveforms();
[MonkeyName,fl]=FindMonkeyName(Direct);

h = waitbar(0,'Please wait...');
startyear=09;
endyear=13;
i=0;
for a=startyear:endyear                  %start with year of folder
    i=i+1;
    if a<10
        ap1='0';
    else
        ap1='';
    end
    for b=1:12              %next go through months
        if b<10
            ap2='0';
        else
            ap2='';
        end
        for c=1:31          %next days
            if c<10
                ap3='0';
            else
                ap3='';
            end
            for d=1:30
                date=[ap1,num2str(a),ap2,num2str(b),ap3,num2str(c)];
                Dir=[Direct,'\ex',date,'\tank',date,fl,'\OurData-',num2str(d)];               
                if exist(Dir,'dir')
                    
                    MyTank=[Direct,'\ex',date,'\tank',date, fl];
                    MyBlock=['~OurData-' num2str(d)];
                    [msg1 LengthTrial DataType LowestNoise LowestTone BF Mod flag]=...
                        CollectData(MyTank, MyBlock,AllVowelData);          
                    if flag==0
                        SaveData.LengthTrial=num2str(LengthTrial);
                        SaveData.NoiseType='Unknown';
                        SaveData.MonkeyName=MonkeyName;
                        SaveData.Date=date;
                        SaveData.BlockNumber=num2str(d);
                        SaveData.TestType=FindRecordType(Direct);
                        SaveData.DataType=DataType;
                        SaveData.CF=BF;
                        SaveData.ToneLevel=LowestTone;
                        SaveData.ToneMod='Unknown';
                        SaveData.NoiseLevel=LowestNoise;
                        SaveData.NoiseMod=Mod;
                        SaveData.Comments=msg1;
                        MonkeySaveOldData(SaveData)
                    end
                    %things to save- if flag not set Date, Tank,
                    %MonkeyName, RecordType, DataType
                end                
            end
        end
    waitbar(i*b/((endyear-startyear+1)*12))
    end
    
end

close(h)   


function [RecordType] = FindRecordType(Tank)
DataType=[];
if isempty(findstr(Tank,'Neuro'))==0
    RecordType='NeuroBehavior';
elseif isempty(findstr(Tank,'Behavior'))==0
    RecordType='Behavior';
else
    RecordType='Unknown';
end

function [MonkeyName,FirstLetter] = FindMonkeyName(Tank)
if isempty(findstr(Tank,'Alpha'))==0
    MonkeyName='Alpha';
    FirstLetter='a';
elseif isempty(findstr(Tank,'Bravo'))==0
    MonkeyName='Bravo';  
    FirstLetter='b';
elseif isempty(findstr(Tank,'Charlie'))==0
    MonkeyName='Charlie';
    FirstLetter='c';
elseif isempty(findstr(Tank,'Delta'))==0
    MonkeyName='Delta';
    FirstLetter='d';
else MonkeyName='Unknown';
end


function [msg1 LengthTrial DataType LowestNoise LowestTone BF Mod flag]=CollectData(MyTank,MyBlock,VowelData)

ActXFig= figure('Position',[0 100000 1 1]);
TT = actxcontrol('TTank.X');
invoke(TT,'ConnectServer','Local','Me');
invoke(TT,'OpenTank',MyTank,'R');
invoke(TT,'SelectBlock',MyBlock);
invoke(TT,'ResetFilters');
Responses = invoke(TT, 'GetEpocsV', 'Corr', 0, 0, 10000); %puts the 'Corr' variable into an x,1 matrix with lots of zeros
channel = 1;
invoke(TT,'SetGlobalV','Channel',channel);
freq = invoke(TT, 'GetEpocsV', 'Freq', 0, 0, 10000);
levl = invoke(TT, 'GetEpocsV', 'Levl', 0, 0, 10000);
nlvl = invoke(TT, 'GetEpocsV', 'nlvl', 0, 0, 10000);
nLvls= invoke(TT, 'GetEpocsV', 'NseL',0, 0, 30000); 

[Mod]=FindModNoise(freq);

a=length(freq(1,:));
flag=0;
msg1='';
LengthTrial='';
DataType= '';
LowestNoise ='';
LowestTone ='';
BF='';
VowelType='';

if a<20
    close(ActXFig);
    flag=1;
    return
end

if a<80
    msg1=['Only ', num2str(a),' trials recorded, most likely incomplete data'];
else
    msg1='';%%%
end

LengthTrial=num2str(a); %%%
b1=length(unique(freq(1,:)));
b2=min(freq(1,:));
lnlvls=length(unique(nlvl(1,:)));
if isempty(unique(Responses(1,:)))==1 && lnlvls>3 
    DataType='NRL';
elseif length(unique(Responses(1,:)))==1;
    DataType='PSTH';
else
    if b1>4 && b2>0
        DataType='Response Map';
    elseif b1>4 && b2<0
        DataType='Vowel BFRL';
        [VowelType]=FindVowelType(freq(1,:),VowelData);
    elseif b1<3
        DataType='BFRL';
    else
        DataType='Couldn''t determine Data Type'; %%%%
    end
end

c=length(unique(nlvl(1,:)));
d=length(unique(levl(1,:)));
if length(unique(nlvl(1,:)))==1 
    unnlvl=unique(nlvl(1,:));
    LowestNoise=num2str(unnlvl); %%%%%
else
    nlvls=unique(nlvl);
    LowestNoise=num2str(nlvls(2));
end

BF=(median(freq(1,:))); %%%%% 
unBF=unique(freq(1,:));
if BF==0
    DataType='Vowel BFRL';
    BF=VowelType;
else
    BF=num2str(BF);
end


tlvl=unique(levl);

if length(tlvl)>1
    LowestTone=num2str(tlvl(2));  %%%%
else 
    LowestTone=tlvl(1);
end

close(ActXFig);


function [modnoise voweltype] = CheckForHiddenData(freq)
modnoise=NaN;
voweltype=NaN;

function [AllData]=BuildVowelWaveforms()
Dir1='C:\My Documents\GUIde\Ah waveform.txt';
fid=fopen(Dir1,'r');
AllData(1)=textscan(fid, '%f');
Dir2='C:\My Documents\GUIde\Eh waveform.txt';
fid=fopen(Dir2,'r');
AllData(2)=textscan(fid, '%f');
Dir3='C:\My Documents\GUIde\Ih waveform.txt';
fid=fopen(Dir3,'r');
AllData(3)=textscan(fid, '%f');
Dir4='C:\My Documents\GUIde\Oh waveform.txt';
fid=fopen(Dir4,'r');
AllData(4)=textscan(fid, '%f');
Dir5='C:\My Documents\GUIde\Ooh waveform.txt';
fid=fopen(Dir5,'r');
AllData(5)=textscan(fid, '%f');
fclose all;

function [Mod]=FindModNoise(freq)

CheckIfIsMod=find(freq(1,:)==12321);
if isempty(CheckIfIsMod)==0
    Mod='10';
else
    Mod='Unknown';
end

function [VowelType]= FindVowelType(freq,AllWaveForms)
LengthAll=length(AllWaveForms{1});
VowelType='';
UniqueFreq=unique(rot90(freq));
global freqout
Freq=rot90(freq);
freqout=Freq;
Ah=AllWaveForms{1};
UniqueAh=unique(Ah);
Combined=vertcat(UniqueAh,Freq);
UniqueComb=unique(Combined);

if length(UniqueComb)==(length(UniqueAh))
    VowelType='Ah'
    return
end
length(UniqueComb)
length(UniqueAh)
Eh=AllWaveForms{2};
UniqueEh=unique(Eh);
Combined=vertcat(UniqueEh,Freq);
UniqueComb=unique(Combined);
if length(UniqueComb)==(length(UniqueEh))
    VowelType='Eh'
    return
end
length(UniqueComb)
length(UniqueEh)
Ih=AllWaveForms{3};
UniqueIh=unique(Ih);
Combined=vertcat(UniqueIh,Freq);
UniqueComb=unique(Combined);
if length(UniqueComb)==length(UniqueIh)
    VowelType='Ih'
    return
end
length(UniqueComb)
length(UniqueIh)
Oh=AllWaveForms{4};
UniqueOh=unique(Oh);
Combined=vertcat(UniqueOh,Freq);
UniqueComb=unique(Combined);
length(UniqueComb)
length(UniqueOh)
if length(UniqueComb)==length(UniqueOh)
    VowelType='Oh'   
    return
end

Ooh=AllWaveForms{5};
UniqueOoh=unique(Ooh);
Combined=vertcat(UniqueOoh,Freq);
UniqueComb=unique(Combined);
if length(UniqueComb)==(length(UniqueOoh))
    VowelType='Ooh'
    return    
end
disp('5')

checkAh=find(freq(1,:)==12421);
if isempty(checkAh)==0
    VowelType='Ah';
end
checkEh=find(freq(1,:)==12521);
if isempty(checkAh)==0
    VowelType='Eh';
end
checkIh=find(freq(1,:)==12621);
if isempty(checkAh)==0
    VowelType='Ih';
end
checkOh=find(freq(1,:)==12721);
if isempty(checkAh)==0
    VowelType='Oh';
end
checkOoh=find(freq(1,:)==12821);
if isempty(checkAh)==0
    VowelType='Ooh';
end

VowelType='Unknown';



