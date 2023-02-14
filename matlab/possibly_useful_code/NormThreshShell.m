

%% loop through thresholds and get threshold re 200 ms thresh

normthresh_IC_q = NormalizeThresh(Thresholds(ICidx,1));
normthresh_CN_q = NormalizeThresh(Thresholds(CNidx,1));
normthresh_IC_N = NormalizeThresh(Thresholds(ICidxN,1));
normthresh_CN_N = NormalizeThresh(Thresholds(CNidxN,1));



%IC and CN plot or Quiet and Noise Plots 

% get indices of each duration
% durations=[3.25,6.5,12.5,25,50,100,200]';
% for durct = 1:1:length(durations)
%     duridx(:,durct)=find(durs(:,1)==durations(durct,1))
% end

