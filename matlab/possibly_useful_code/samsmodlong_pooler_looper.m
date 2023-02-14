% loop through the samsmodlong pooling fxn to get a count of how many times
% threshold is met by the populations of neurons




%% file paths

paths = {
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150604/tank150604d/OurData-6';	% high mf units
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150604/tank150604d/OurData-15';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150605/tank150605d/OurData-4';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150611/tank150611d/OurData-4';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150611/tank150611d/OurData-5';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150611/tank150611d/OurData-9';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150615/tank150615d/OurData-5';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150616/tank150616d/OurData-8';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150618/tank150618d/OurData-8';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150713/tank150713d/OurData-6';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150727/tank150727d/OurData-7';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150727/tank150727d/OurData-14';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150807/tank150807d/OurData-6';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150727/tank150727d/OurData-37';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150910/tank150910d/OurData-10';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150903/tank150903d/OurData-7';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150831/tank150831d/OurData-11';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150807/tank150807d/OurData-6';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150917/tank150917d/OurData-4';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex150917/tank150917d/OurData-14';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex151012/tank151012d/OurData-19';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex151125/tank151125d/OurData-7';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex151210/tank151210d/OurData-10';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex160113/tank160113d/OurData-25';
        '/Volumes/ramlab/Delta data/Neurobehavior/IC/ex151120/tank151120d/OurData-7';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180227/tank180227c/OurData-17';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180301/tank180301c/OurData-25';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180306/tank180306c/OurData-15';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180306/tank180306c/OurData-21';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180307/tank180307c/OurData-17';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180308/tank180308c/OurData-12';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180309/tank180309c/OurData-16';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180309/tank180309c/OurData-23';
        '/Volumes/ramlab/Charlie data/Neurobehavior/IC/ex180510/tank180510c/OurData-16';
        };
    
% import
for imp = 1:1:size(paths)
    data{imp,1} = TDTbin2mat(paths{imp,1});
end

%% permutation loop

ct=0;
i=1;

parfor i = 1:1:1000
    [pc] = samsmodlong_pooler_fxn(paths,data);
    
    if max(pc(:,1)) > 0.759
        ct = ct+1;
        thresh(i,1)=ThreshCalc(pc');
        thresh(i,1)=thresh(i,1)-pc(1,2);
    
    end
end

% proportion of neurons with a threshold
propthresh=ct/i

% find the ones with thresholds
nonzeroidx=find(thresh(:,1)>0);
meanthresh=mean(thresh(nonzeroidx,1))

%calculate confidence intervals of the mean, using percentile method
x=thresh(nonzeroidx,1);
p=95;
CIFcn = @(x,p)prctile(x,abs([0,100]-(100-p)/2));
CI = CIFcn(x,95)
beep on; beep;