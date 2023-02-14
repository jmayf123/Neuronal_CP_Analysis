%% Modulation Transfer function analysis
% MTF analysis/plotting written by Sam Hauser (~2015), pooling and ROC analysis written by
% Chase Mackey (2021)
%
% 
% this is the version that loops through multiple blocks. trying to make a
% CN--IC pooling model - CM
% now i'm adding onto the loop version so it adds responses from each
% neuron instead of just pooling binned spikes - CM
%

%% set variables
function [pc] = samsmodlong_pooler_fxn(paths,data)

%respNonPref = onefreq(1,19); % setting the comparison stimulus
stdidx=8; % comparison stim for rate
bmf=28; %bmf for rate
stdvs=24; %comparison stim for VS 
bmfvs=27; %bmf for vs

flipr=0; %flip the sign if you're using downward sloping part of MTF
flipvs=0; %flip sign for vector strength

% duration
int = 2; %interval for stepping through binned spikes (2 for 500 ms, 4, for 250 ms, etc.)
dur = 1/int; %bin width in seconds (0.5, 0.25, 0.1, 0.05)

% make this 1 if you want to do ROC analysis
discanalysis=1;

% reps for permutation loop
perms = 20;

% size of population
subpop = 1; % make this 1 if you want to randomly select < all neurons
popsize = 32; % how many neurons?



%% this lets you randomly select neurons from the population
if subpop == 1
    % select neurons here
    allsize = size(paths(:,1));
    randunits = randi([1 allsize(1,1)],popsize,1);
    data_sub = {};
    
    %loop to make the subpopulation = random selection of the real population
    for randsel = 1:1:length(randunits)
        data_sub(randsel,1) = data(randunits(randsel,1),1); %not indexing this correctly yet
    end
    
    data=data_sub;
    
end
%


%% looping through all paths
% loop through every neuron and sum responses
check = 1; 
for perm = 1:1:perms                            % permutation loop
    for unit = 1:1:size(data)                  % neuron loop

        % bin the spikes 
        [binnedspc,stimspc,sortedspikes] = mfSort(data{unit,1},0.5,2);

        % loop through the MTF function to get responses at each mf
        [levelspikes,levelspikesVS,onefreq] = MTF(binnedspc,0.5,2,stimspc,sortedspikes);

        if check == 1
            for mf = 1:1:length(levelspikes)
            r = randi([1 4],1,1); % select a random trial, we had 4 reps
            popspike(mf,unit) = levelspikes(mf,r);
            end
            check = check+1;
        else 
            for mf = 1:1:length(levelspikes)
            r = randi([1 4],1,1); 
            popspike(mf,unit) = levelspikes(mf,r); %concatenate with existing array
            end
        end
            
        % add resps from each single unit's MTF 
        % resps are chosen randomly from each trial and from each neuron, resulting in
        % a distribution of 20 summed resps.

        % ROC on population MTF at a few MFs. 
    end
    popspike_all(:,perm) = sum(popspike,2); %pass the summed resps to the final array
end


%% Neuronal discrimination analysis
if discanalysis ==1
    %% ROC analysis on spike count

    [pc,FA,HR]=mfROC_pop(popspike_all,stdidx,bmf,0); % pass data to ROC function
    pc(:,2) = onefreq(1,stdidx:bmf)'; % get the mod freqs

end
end
