

%% extract data
% 
% run the MonkeyAnalysis gui, input block 130114-6 in Charlie's IC tank, hit "ROC Analysis"
% this will run PlotTogetherPlot, which loops MonkeyNandLevel, which contains other
% stuff. Stopping at different points in MonkeyNandLevel will let you know
% what everything does.

%% sort spike count by tone level

% already done around line 270 of MonkeyNandLevel.

%% sort num spikes by correct/incorrect response
% done around line 315 in MonkeyNandLevel

%% make histograms of spikes on incorrect and correct trials for all tone lvls where there is >=3 trials of each (correct/incorrect)
%
%

%% create ROC curve (hit rate vs false alarm rate) based on correct/incorrect histograms
% Fig 5 of Britten et al.
% MonkeyBootstrapDI.m may do this. hard to tell for me.
% 

%% area under ROC curve = choice probability

%% Grand CP calculation
% z score area under the ROC curve for each tone level, combine into one Correct distribution, and another Incorrect distribution
% see papers for reference

%% calculate area under new Grand CP distributions

%% determine significance by permutation test
% probably something like this: https://github.com/lrkrol/permutationTest

%% loop through all of this with different time windows to replicate Liu et al. Fig 3

% loop through durations in these steps 12.5 : 12.5 :200