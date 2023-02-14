function [ Data ] = RTvCount( levl,Responses )


levels = unique(levl(1,:));
levels(:) = round(Amp_to_dB(levels(:)));

[A,B] = size(levl);
RIter = 1;
count = 0;
corr = 0;

Data = zeros(5,B);
Data(1,:) = round(Amp_to_dB(levl(1,:)));

[RR,CR] = size(Responses);

for ii = 1:B
    while Responses(2,RIter) < levl(2,ii) & RIter < CR
        RIter = RIter+1;
    end
    
    Data(2,ii) = Responses(2,RIter)-levl(2,ii);
    Data(4,ii) = abs(round(Responses(1,RIter)-2));
    if Responses(1,RIter) == 1
        if corr == 1
            Data(5,ii) = count;
            count = count+1;
        else
            Data(5,ii) = -count;
            count = 1;
            corr = 1;
        end
    else
        if corr == 1
            Data(5,ii) = count;
            corr = 0;
            count = 1;
        else
            Data(5,ii) = -count;
            count = count+1;
        end
    end
end

num_removed = 0;
for ii = 1:B
    if Data(4,ii-num_removed) == 0
        Data(:,ii-num_removed) = [];
        num_removed = num_removed +1;
    end
end

Data(4,:) = [];

[A,B] = size(Data);
[Q,R] = size(levels);

AveDev = zeros(4,R);
AveDev(1,:) = levels;

for ii = 1:B
    VolIter = 1;
    while Data(1,ii)~=levels(1,VolIter)
        VolIter = VolIter+1;
    end
    AveDev(2,VolIter) = AveDev(2,VolIter)+Data(2,ii);
    AveDev(4,VolIter) = AveDev(4,VolIter)+1;
end

AveDev(2,:) = AveDev(2,:)./AveDev(4,:);

for ii = 1:B
    VolIter = 1;
    while Data(1,ii)~=levels(1,VolIter)
        VolIter = VolIter+1;
    end
    AveDev(3,VolIter) = AveDev(3,VolIter) +(AveDev(2,VolIter)-Data(2,ii))^2;
end

AveDev(3,:) = sqrt(AveDev(3,:)./AveDev(4,:));

for ii = 1:B
    VolIter = 1;
    while Data(1,ii)~=levels(1,VolIter)
        VolIter = VolIter+1;
    end
    Data(3,ii) = (Data(2,ii)-AveDev(2,VolIter))/AveDev(3,VolIter);
end

end

