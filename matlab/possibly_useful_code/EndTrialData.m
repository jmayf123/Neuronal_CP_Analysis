% Written by Andy Hrnicek under P.I. Ram Ramachandran, PhD.
% Fall 2010
% 
% sometimes we as researchers get distracted from focusing on the monkey at
% the task we are providing. this means that when we may intend to do 255
% stimuli we actually allow it to go to 266. this function deletes the
% extra trials by comparing the frequency of the first cell to the
% frequency of the end. usually it changes after 255 in the example so we
% can delete the different ones. this will not work for vowels. we should
% switch it to use nlvl instead for vowels.
% 
%%% INPUTS
% freq - frequency by trial, data from Freq in TDT epoch storage, look at
% their documentation for more info.
% levl - tone level by trial
% nlvl - noise level by trial
% Responses - response by trial (1 or 2)
% TimeOfResponse - Time stamp of response by trial
%%% OUTPUTS
% see inputs

function [freq, levl, nlvl,  Responses, TimeOfResponse] = EndTrialData(freq, levl, nlvl, Responses, TimeOfResponse)
initialnoise = nlvl(1,1);

[row4,col4]=size(nlvl);
TrialOver = [];
for i = 1:col4 % finds trials to delete
    if nlvl(1,i) ~= initialnoise
        TrialOver = [i TrialOver];
    end
end

for i = 1:length(TrialOver) % deletes these trials in all relevant variables
    freq(:,TrialOver(i)) = [];
    levl(:,TrialOver(i)) = [];
    nlvl(:,TrialOver(i)) = [];
    Responses(:,TrialOver(i))=[];
    TimeOfResponse(TrialOver(i)) = [];
end

end