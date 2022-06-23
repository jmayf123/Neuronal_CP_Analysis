function [levl,N,ChoiceProbs,Grand_CP] = Try_this(data,dur,data_ct)


% set the room the exp was done in and the duration of spike analysis and
% the latency of the neuron for duration analysis
WindowAnalysis=1; % 1 is yes (we're doing this analysis), 0 is no
room=40; %gives this to the sound level conversion fxn later
%dur=0.1; % duration of analysis window in secs
start=0.02; %starting spike counting at latency, calculated in Raster_PSTH_latency


% set tank and location and select block
MyTank = data{data_ct,1}.info.tankpath ; 
MyBlock = data{data_ct,1}.info.blockname;  

if exist(MyTank) ~= 7 %#ok<*EXIST>
    warndlg('The tank you are looking for does not exist, please check inputs', 'Warning!');
    levl=0;
    N=0;
    return
end
BlockDir=[MyTank,'\',MyBlock];
if exist(BlockDir)~=7
    warndlg('The Block you have selected does not exist within the tank you have selected','Failure!');
    levl=0;
    N=0;
    return
end


%Open tank/block for reading
figurea = figure('Position',[0 100000 1 1]);
TT = actxcontrol('TTank.X');
TT.ConnectServer('Local','Me');
TT.OpenTank(MyTank,'R');
TT.SelectBlock(MyBlock);
TT.ResetFilters;
Responses = invoke(TT, 'GetEpocsV', 'Corr', 0, 0, 10000); %puts the 'Corr' variable into an x,1 matrix with lots of zeros
channel = 1;
invoke(TT,'SetGlobalV','Channel',channel);
freq = invoke(TT, 'GetEpocsV', 'Freq', 0, 0, 10000);
global freqout
freqout=rot90(freq(1,:));
levl = invoke(TT, 'GetEpocsV', 'Levl', 0, 0, 10000);
nlvl = invoke(TT, 'GetEpocsV', 'nlvl', 0, 0, 10000);
nLvls= invoke(TT, 'GetEpocsV', 'NseL',0, 0, 30000);
%  nlvl = invoke(TT, 'GetEpocsV', 'Levl', 0, 0, 10000);
%  levl = invoke(TT, 'GetEpocsV', 'nlvl', 0, 0, 10000);

% length(Responses)
% length(freq)
% length(levl)
% length(nlvl)
% unique(Responses(1,:))
part1=length(freq(1,:));
part2=length(unique(freq(1,:)));
BFused=mode(freq(1,:));

part4=min(freq(1,:));
warn1str=num2str(part1);
warn1str=['Only ',warn1str, ' Trials Recorded, Terminating Analysis'];
if part1<70
    warndlg(warn1str, 'Warning!');
    close(figurea);
    levl=0;
    N=0;
    return
elseif part2>3 && part4>0
    warndlg('Block selected is most likely Response Map', 'Warning!');
    close(figurea);
    levl=0;
    N=0;
    return
end

%tlvls = TLevlFindNOrder(levl)
tlvls = unique(levl(1,:)); % contains tone levels used

CheckIfIsMod=find(freq(1,:)==12321);
if isempty(CheckIfIsMod)==0
    ModNoise=1;
    freq(1,CheckIfIsMod)=median(freq(1,:));
else
    ModNoise=0;
end

%CHANGE NOISE LEVEL BASED ON THE ROOM %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ROCFreq=median(freq(1,:));  %the frequency for the ROC analysis
ROCNoise=median(nlvl(1,:)); %ROC Noise Level
if ROCNoise>0
    if room==40
    v0 = .79/(10^(74/20)); % On Hylebos-PC in room 040
    else
    v0=.79/(10^(82/20)); % On Yakima in Room 034
    end
    ROCNoise=round(20*log10((ROCNoise)/v0));
elseif  ROCNoise==0
    ROCNoise=24;
end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% psychometric function calc.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ProbabilityCorrect=MonkeyTankPlotter2(freq,levl,nlvl,Responses,TT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% importing trial info
x = 'Freq>=0';
TT.SetFilterWithDescEx(x);
trs = TT.GetValidTimeRangesV; %gets start and end time of each epoch 
TT.SetFilterTolerance(0.0001); %%If this code breaks, look at the returns for these functions to see if they are 1/0
TT.SetEpocTimeFilterV('Levl',0,.2);
TT.SetFilterWithDescEx(x);


maxtime = 1/325;
[~,y] = size(levl);
[~,y1] = size(trs);
if y > 400 % deletes extraneous trials
    y = 400;
    freq = freq(:,1:400);
    levl = levl(:,1:400);
    nlvl = nlvl(:,1:400);
end

if y>y1 % deletes extraneous trials
    y = y1;
    freq = freq(:,1:y1);
    levl = levl(:,1:y1);
    nlvl = nlvl(:,1:y1);
end

r = rem(y,10);
if r>0 % deletes extraneous trialsclc
    y = y-r;
    freq = freq(:,1:y);
    levl = levl(:,1:y);
    nlvl = nlvl(:,1:y);
end

N = zeros(1,y);
M=N;
DeleteCount = zeros(1,y);
SnipTimes = zeros(y,20);
InstRates = zeros(y,20);

%%
%%%%%%%%%%%%%%%% CHANGE DURATION OF ANALYSIS WINDOW HERE %%%%%%%%%%%%%%

% 
if WindowAnalysis==1
    trs(1,:)=trs(1,:)+start; %changing start of trial 

    trs(2,:)=trs(2,:)-(0.2-(dur+start)); %changing end of trial
    windowsize=trs(2,1)-trs(1,1); %make sure the math is right
else
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%% extracting spikes and spike times

for l = 1:y %y is the trial count
    N(l) = TT.ReadEventsV(100000,'Snip',channel,0,trs(1,l),trs(2,l),'FILTERED'); 
    
    SnipTimes(l,1:N(l)) = TT.ParseEvInfoV (0,N(l),6);
    m=2;
    sniplength = N(l);
    while m <= sniplength % deletes spikes not neurologically possible
        datan = SnipTimes(l,m)-SnipTimes(l,m-1);
        if datan<maxtime
            SnipTimes(l,1:N(l))=[SnipTimes(l,1:m-1) SnipTimes(l,m+1:N(l)) 0];
            DeleteCount(l) = DeleteCount(l) + 1;
        else
            m = m+1;
        end
        sniplength = nonzerolength(SnipTimes(l,:));
    end
    InstRate = zeros(1,sniplength);
    InstRate(1) = 1/SnipTimes(l,1);
    for i = sniplength:-1:2
        InstRate(i) = 1/(SnipTimes(l,i)-SnipTimes(l,i-1));
    end
    InstRates(l,1:sniplength) = InstRate;
end


for l = 1:y %y is the trial count
    M(l) = TT.ReadEventsV(100000,'eNeu',channel,0,trs(1,l),trs(2,l),'FILTERED');
    
    SnipTimes(l,1:M(l)) = TT.ParseEvInfoV (0,M(l),6);
    
    m=2;
    sniplength = M(l);
    while m <= sniplength % deletes spikes not neurologically possible
        datan = SnipTimes(l,m)-SnipTimes(l,m-1);
        if datan<maxtime
            SnipTimes(l,1:M(l))=[SnipTimes(l,1:m-1) SnipTimes(l,m+1:M(l)) 0];
            DeleteCount(l) = DeleteCount(l) + 1;
        else
            m = m+1;
        end
        sniplength = nonzerolength(SnipTimes(l,:));
    end
    InstRate = zeros(1,sniplength);
    InstRate(1) = 1/SnipTimes(l,1);
    for i = sniplength:-1:2
        InstRate(i) = 1/(SnipTimes(l,i)-SnipTimes(l,i-1));
    end
    InstRates(l,1:sniplength) = InstRate;
end
  
    

eNeuSnips=length(unique(M));
SnipSnips=length(unique(N));
if(eNeuSnips>SnipSnips)
    N=M; % puts all the spike counts from each trial into N, why??
end


% Chan1Snip = TT.ReadWavesOnTimeRangeV('Snip',1);
% N2=zeros(1,length(freq));
%close(figurea);
% length(freq(1,:))
% for i=1:length(freq(1,:))
%     N2(i)=length(unique(Chan1Snip(:,i)));
% end
% N=N2


%% spikes and spike times have been extracted, now sorting spike data


Sorted = SortingByTime(levl, Responses);

m=length(Sorted(1,:));
for i=1:m-1
    Sorted(4,i)=N(i); % puts # spikes in each trial in the 4th row of "Sorted"
end


a=length(levl);
for i=1:a
    levl(2,i)=N(i);
end
b=length(tlvls);
ToneLevels=tlvls;
LengthTlvls=b;



%%%%%%%%%%%%%%%%%%
%                   Build an array with Tone levels as the first column,
%                   assuming that the tone is repeated 30 times max. If
%                   this number is greater, make length the number of
%                   repeats +1
%%%%%%%%%%%%%%%%%%
for i=2:35
    tlvls(i,:)=NaN;
end


        
%%%%%%%%%%%%%%%%%%
%                   The following for loop sorts spike counts by tone from
%                   the sorted array into two arrays, tlvlsCorrect which
%                   corresponds to a correct pull from the monkey, and
%                   tlvlsIncorrect which contains all spike data miss
%                   trials
%%%%%%%%%%%%%%%%%%


tlvlsCorrect=tlvls;
tlvlsIncorrect=tlvls;
for i=1:b
    count1=2;
    count2=2;
    for j=1:a
        if Sorted(1,j)==tlvls(1,i)
            if Sorted(3,j)==1
                tlvlsCorrect(count1,i)=Sorted(4,j);
                count1=count1+1;
            elseif Sorted(3,j)==2
                tlvlsIncorrect(count2,i)=Sorted(4,j);
                count2=count2+1;
            end
        end
    end
end


NANflag=0;
for i=1:length(tlvlsCorrect(1,:))
    Check1=tlvlsCorrect(2,i);
    Check2=tlvlsIncorrect(2,i);
    if isnan(Check1)==1 && isnan(Check2)==1
        NANflag=1;
        RowIndex=i;
    end
end
if NANflag==1
    tlvlsCorrect(:,RowIndex)=[];
    tlvlsIncorrect(:,RowIndex)=[];
end

% sortin spike counts by tone level (in volts)
for i=1:b
    c=2;
    for j=1:a
        if tlvls(1,i)==levl(1,j)
            tlvls(c,i)=levl(2,j);
            c=c+1;
        end
    end
end
if NANflag==1
    LengthTlvls=LengthTlvls-1;
    b=b-1;
    tlvls(:,RowIndex)=[];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%   Reshaping Tone level Data and Spitting Out Choice Probablity %%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%   Jackson Mayfield 08/30/21   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[ChoiceProbs,Grand_CP] = CP(tlvlsCorrect,tlvlsIncorrect,tlvls);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%