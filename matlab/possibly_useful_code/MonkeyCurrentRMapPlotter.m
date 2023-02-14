

function [] = MonkeyCurrentRMapPlotter(Tank,Block)


MyTank=Tank;
MyBlock = ['~OurData-' Block];

figurea = figure;
TT = actxcontrol('TTank.X');
invoke(TT,'ConnectServer','Local','Me');
invoke(TT,'OpenTank',MyTank,'R');
invoke(TT,'SelectBlock',MyBlock);
invoke(TT,'ResetFilters');

% Specify channel
% code = invoke(TT, 'GetEventCodes', 0);
% start = invoke(TT,'CurBlockStartTime')
% formstart = invoke(TT,'FancyTime',start ,'D/O/Y H:M:S.U W')
% notes = invoke(TT,'CurBlockNotes')
channel = 1;
invoke(TT,'SetGlobalV','Channel',channel);
freq = invoke(TT, 'GetEpocsV', 'Freq', 0, 0, 10000);
levl = invoke(TT, 'GetEpocsV', 'Levl', 0, 0, 10000);


x = 'Freq>0';
filt0 = TT.SetFilterWithDescEx(x);
trs = TT.GetValidTimeRangesV;

%% pulls out all snip counts to all trials and stores in 'N'
TT.SetFilterTolerance(0.0001); %%If this code breaks, look at the returns for these functions to see if they are 1/0
TT.SetEpocTimeFilterV('Levl',0,.2);
% sortname = [Date '-' Num ' sorted']; 
% TT.SetUseSortName(sortname);
TT.SetFilterWithDescEx(x);
[x,y] = size(levl);
if y > 110
    y = 110;
end
N = zeros(1,y);
for l = 1:y
    N(l) = TT.ReadEventsV(100000,'Snip',channel,0,trs(1,l),trs(2,l),'FILTERED');
end
catches = [];
Data = [freq(1,1:y); N]; Data2 = Data; % aggregates important data
for i = y:-1:1 % deletes catch trials in response map
    if levl(1,i) == 0
        catches = [catches Data2(2,i)]; % stores catch trial spike counts to establishing baseline rate
        Data2(:,i) = [];
    end
end
OutData1=Data2(1,:); 
OutData2=Data2(2,:);
a=length(OutData1);    
if length(OutData1)<101
    for j=a:101
        OutData1(j)=NaN;
        OutData2(j)=NaN;
    end
end
baseline = mean(catches); % calculates baseline spontaneous firing rate

TT.SetGlobalV('RespectOffsetEpoc',0);
TT.SetEpocTimeFilterV('Freq',-.4,.4);
trs = TT.GetValidTimeRangesV;
[x,y] = size(levl);
N2 = zeros(1,y);
if y > 110
    y = 110;
end
N2 = zeros(1,y);
for l = 1:y
    N2(l) = TT.ReadEventsV(100000,'Snip',channel,0,trs(1,l),trs(2,l),'FILTERED');
end

baseline=mean(N2);
TT.SetGlobalV('RespectOffsetEpoc',1);


TT.CloseTank
TT.ReleaseServer
close(figurea);
figure
plot(Data2(1,:),Data2(2,:),'k*')
hold on
set(gca,'xscale','log');
set(gca,'xlim',[min(freq(1,:)) max(freq(1,:))])
end
