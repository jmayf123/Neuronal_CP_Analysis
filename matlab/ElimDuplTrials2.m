function [TimeOfResponse TOR Responses guess] = ElimDuplTrials2(Responses, levl)


levllength = length(levl(2,:));

% if length(Responses(1,:)) ~= levllength
%     Responses(:,1) = [];
% end

TimeOfResponse = Responses(2,:);
TOR = length(TimeOfResponse);

countdown = TOR:-1:length(levllength);
for i = 1:length(countdown)
    if TimeOfResponse(countdown(i)) > levl(2,end) + 2.5
        TimeOfResponse(countdown(i)) = [];
        Responses(:,countdown(i)) = [];
    end
end

guess = 0;
while length(TimeOfResponse) > levllength %%#ok<ISMT>
    for i = 1:length(TimeOfResponse)
        if (levl(2,i)) > (TimeOfResponse(i) + .5)
            TimeOfResponse(i) = [];
            Responses(:,i) = [];
            guess = guess+1;
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