% Written by Andy Hrnicek under guidance of P.I. Ram Ramachandran, PhD.
% Fall 2010
% 
% when the monkey guesses there is a recorded response but no recorded time
% range in 'freq', 'levl', or 'nlvl'. this causes the array of responses to
% not align with the array of tone levels played which is problematic. this
% code goes through and finds the guesses and deletes those from the
% responses variable by looking at the time of the response compared to the
% time of the stimulus. if the response is more than 2.5 seconds after the
% end of the last stimulus it's deleted as well.
%
%%% INPUTS
% levl - tone level by trial
% Responses - response by trial (1 or 2)
%%% OUTPUTS
% TimeOfResponse - Time stamp of response by trial
% Responses - response by trial (1 or 2)
% guesscount - number times monkey released unrelated to a trial stimulus

function [TimeOfResponse TOR Responses guess] = ElimDuplTrials(Responses, levl)


levllength = length(levl(2,:));
guess = 0;

% if the monkey guesses before a stimulus is played, this deletes that
% guess.
if Responses(1,1)-levl(2,1) > 1
    Responses(:,1) = [];
    guess = 1;
end

TimeOfResponse = Responses(2,:);
TOR = length(TimeOfResponse);

% deletes guesses that occured after the last stimulus, if the block was
% allowed to go longer than it was supposed to and he guesses, this deletes
% that guess, or those guesses
countdown = TOR:-1:1; 
for i = 1:length(countdown)
    if TimeOfResponse(countdown(i)) > levl(2,end) + 2.5
        TimeOfResponse(countdown(i)) = [];
        Responses(:,countdown(i)) = [];
    end
end


while length(TimeOfResponse) > levllength %%#ok<ISMT>
    for i = 1:length(TimeOfResponse)
        % deletes responses that are more than .6 seconds after the end of
        % the stimulus which is ~ how long the monkey has after to respond
        if (levl(2,i)) > (TimeOfResponse(i) + .6) 
            TimeOfResponse(i) = [];
            Responses(:,i) = [];
            guess = guess+1; % keeps track of deleted ones for counting guesses
            break
        end
        if i == levllength
            TimeOfResponse(end) = [];
            Responses(:,end) = [];
            break
        end
    end
end

end