trs_cdf(1,:)=trs_cdf(1,:)+start; %changing start of trial so we can look at baseline


% get snip times with baseline incorporated 
for snip_ct = 1:y %y is the trial count
    tdt_extract(snip_ct) = TT.ReadEventsV(100000,'eNeu',channel,0,trs_cdf(1,snip_ct),trs_cdf(2,snip_ct),'FILTERED');
    
    cdfSnipTimes(snip_ct,1:tdt_extract(snip_ct)) = TT.ParseEvInfoV (0,tdt_extract(snip_ct),6);
    
    min_cdf=2;
    sniplength_cdf = tdt_extract(snip_ct);
    while min_cdf <= sniplength_cdf % deletes spikes not neurologically possible
        datan_cdf = cdfSnipTimes(snip_ct,min_cdf)-cdfSnipTimes(snip_ct,min_cdf-1);
        if datan_cdf<maxtime
            cdfSnipTimes(snip_ct,1:tdt_extract(snip_ct))=[cdfSnipTimes(snip_ct,1:min_cdf-1) cdfSnipTimes(snip_ct,min_cdf+1:tdt_extract(snip_ct)) 0];
            DeleteCount(snip_ct) = DeleteCount(snip_ct) + 1;
        else
            min_cdf = min_cdf+1;
        end
        sniplength_cdf = nonzerolength(cdfSnipTimes(snip_ct,:));
    end
end

for cdfcount=1:length(trs4cdf_idx)
    [h,stats]=cdfplot(SnipTimes(trs4cdf_idx(cdfcount)));
     yvals(cdfcount,1)=get(h,'YData');
     xvals(cdfcount,1)=get(h,'XData');
end





% StartTime1=.0050;
% StepSize1=.005;
% StopTime1=StartTime1+StepSize1*4;
% X1val=(StartTime1+StopTime1)/2;
% SpikesByTime(4,:)=X1val+SpikesByTime(2,:);
k=0;
Summation=zeros(1,length(cdfSnipTimes(1,:)));

%%% calculates the baseline portion of the cumm. spike fxn?
for j=StartTime1+StepSize1:StepSize1:StopTime1;   
    TT.SetEpocTimeFilterV('Freq',0,j);
    cummtrs = TT.GetValidTimeRangesV;
    Chan1Snip = TT.ReadWavesOnTimeRangeV('Snip',1);
    for i=1:length(Chan1Snip(1,:))
        Summation(i)=Summation(i)+length(find(Chan1Snip(:,i)));
    end
    k=k+1;
end
Summation=Summation/(k+1);
cdfSnipTimes(5,:)=cdfSnipTimes(5,:)+Summation;  %This finds the mean Y value at


StartTime2=.01; % this is set at 10 ms because thegate time was 10 ms??
StepSize2=.005;
StopTime2=StartTime2+StepSize2*4;
X2val=(StartTime2+StopTime2)/2;
cdfSnipTimes(6,:)=X2val+cdfSnipTimes(2,:);
k=0;
Summation=zeros(1,length(cdfSnipTimes(1,:)));

% calculates the cum. spike fxn starting at full amp of the tone (10ms)
for j=(StartTime2+StepSize2):StepSize2:StopTime2   
    TT.SetEpocTimeFilterV('Freq',0,j);
    cummtrs = TT.GetValidTimeRangesV;
    Chan1Snip = TT.ReadWavesOnTimeRangeV('Snip',1);
    for i=1:length(Chan1Snip(1,:))
        Summation(i)=Summation(i)+length(find(Chan1Snip(:,i)));
    end
    k=k+1;
end
Summation=Summation/(k+1);
cdfSnipTimes(7,:)=cdfSnipTimes(7,:)+Summation;
close(figurea)