

function [SpikesByTime,TimeArray] = MonkeyRespByTime (Monkey, Date, Num, Loc)

% Monkey='Bravo';
 %Date='111007b';
 %Num='8';
 %Loc='CN';
 Num=num2str(Num);



Date1=Date(1:6);
MyTank = ['G:\' Monkey ' data\NeuroBehavior\' Loc '\ex' Date1 '\tank' Date];
MyBlock = ['~OurData-' Num];


figure('Position',[0 100000 1 1])

TT = actxcontrol('TTank.X');

invoke(TT,'ConnectServer','Local','Me');
invoke(TT,'OpenTank',MyTank,'R');
invoke(TT,'SelectBlock',MyBlock);
invoke(TT,'ResetFilters');
TT.SetGlobalV('RespectOffsetEpoc',1);
Responses = invoke(TT, 'GetEpocsV', 'Corr', 0, 0, 10000); %puts the 'Corr' variable into an x,1 matrix with lots of zeros
channel = 1;
invoke(TT,'SetGlobalV','Channel',channel);
TT.SetEpocTimeFilterV('Freq',0,.2);
trs =  TT.GetValidTimeRangesV;
freq = invoke(TT, 'GetEpocsV', 'Freq', 0, 0, 10000);
levl = invoke(TT, 'GetEpocsV', 'Levl', 0, 0, 10000);
nlvl = invoke(TT, 'GetEpocsV', 'nlvl', 0, 0, 10000);

TT.SetGlobalV('RespectOffsetEpoc',0);



StartTime=-.05;     %-20  ms
PulseDuration=.2;   %0.2  ms
OverTime=.05;       %+20  ms after signal terminates
StepSize=.005;      %will be finding snip count every 5ms window
Height= (abs(StartTime)+PulseDuration+OverTime)/StepSize;
Length= (length(trs(1,:)));
TimeArray=(StartTime+StepSize:StepSize:(PulseDuration+OverTime));
SpikesByTime=zeros(Height,Length); %Build an array of zeros to store data in for each trial
k=1;

h = waitbar(0,'Please wait...');
for j=StartTime:StepSize:(PulseDuration+OverTime-StepSize)
    %disp(k)
    TT.SetEpocTimeFilterV('Freq',j,StepSize);
    trs = TT.GetValidTimeRangesV;
    Chan1Snip = TT.ReadWavesOnTimeRangeV('Snip',1);
    for i=1:length(Chan1Snip(1,:))
        if k>1
            SpikesByTime(k,i)=SpikesByTime(k-1,i)+length(find(Chan1Snip(:,i)));
        else
            SpikesByTime(k,i)=length(find(Chan1Snip(:,i)));
        end
    end

    k=k+1;
    waitbar(k /60)
end

      

close(h)   
    
    
[OnsetDelay] = MonkeyRespCummulative (Monkey, Date, Num, Loc)
close(figure);
figure
plot(TimeArray,SpikesByTime)
hold on
plot(OnsetDelay(2,:),OnsetDelay(3,:),'k*')
hold off