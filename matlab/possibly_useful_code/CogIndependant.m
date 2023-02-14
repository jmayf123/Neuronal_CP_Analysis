clc;
clear all;
close all;
%
path = 'G:\Bilbo data\Behavior\ex190802\tank190802b\OurData-2';

Data = TDTbin2mat(path);

% Check if responses are equal to presentations. (Caught blocks with one less response)

LF =  length(Data.epocs.Freq.data(:,1));
LC = length(Data.epocs.Corr.data(:,1));
if isequal(LF,LC)
    % ALL in one matrix
    All(1,:) = Data.epocs.Freq.data';
    All(2,:) = Data.epocs.nlvl.data';
    All(3,:) = Data.epocs.Levl.data';
    All(4,:) = Data.epocs.Corr.data';
    
else
    
    %Delete last trial to compensate one less response
    Data.epocs.Freq.data(LF,:) = [];
    Data.epocs.nlvl.data(LF,:) = [];
    Data.epocs.Levl.data(LF,:) = [];
    
    
    % ALL in one matrix
    All(1,:) = Data.epocs.Freq.data';
    All(2,:) = Data.epocs.nlvl.data';
    All(3,:) = Data.epocs.Levl.data';
    All(4,:) = Data.epocs.Corr.data';

end

%%convert vtodb rm40
v0=.79/(10^(74/20));
%%Search for different freqs
% load('echo4.mat');
Frequencies = unique(All(1,:))
no_of_freq = length(Frequencies);

NoiseLevels = unique(All(2,:))
no_of_noises = length(NoiseLevels);

%BinFreqNoise(All,Frequencies,NoiseLevels,no_of_freq,no_of_noises);

for i = 1:no_of_freq
    FreqBinPlaces{1,i} = find(All(1,:) == Frequencies(1,i));
    for x = 1:length(FreqBinPlaces{1,i})
        FreqBin{1,i}(:,x) = All(:,(FreqBinPlaces{1,i}(1,x)));
    end
    for j = 1:no_of_noises
        NoisePlaces{1,i}{1,j} = find(FreqBin{1,i}(2,:)== NoiseLevels(1,j));
        
        for k = 1:length(NoisePlaces{1,i}{1,j})
            NoiseBin{1,i}{1,j}(:,k)= FreqBin{1,i}(:,(NoisePlaces{1,i}{1,j}(1,k)));
        end
        Tones{1,i}{1,j} = unique(NoiseBin{1,i}{1,j}(3,:));
        for l = 1:length(Tones{1,i}{1,j})
            TonePlaces{1,i}{1,j}{1,l} = find(NoiseBin{1,i}{1,j}(3,:)==Tones{1,i}{1,j}(1,l));
            ToneBin{1,i}{1,j}(1,l) = length(TonePlaces{1,i}{1,j}{1,l});
            ToneBin{1,i}{1,j}(2,l) = Tones{1,i}{1,j}(1,l);
            for m = 1:length(TonePlaces{1,i}{1,j}{1,l})
                Responses{1,i}{1,j}{1,l}(1,m) = NoiseBin{1,i}{1,j}(4,TonePlaces{1,i}{1,j}{1,l}(1,m));
            end
            ToneBin{1,i}{1,j}(3,l) = length(find(Responses{1,i}{1,j}{1,l}== 1));
            % %
            ToneBin{1,i}{1,j}(4,l) = ToneBin{1,i}{1,j}(3,l)/ToneBin{1,i}{1,j}(1,l);
            ToneBin{1,i}{1,j}(4,:) = changem(ToneBin{1,i}{1,j}(4,:),0.01,0);
            ToneBin{1,i}{1,j}(4,:) = changem(ToneBin{1,i}{1,j}(4,:),0.99,1);
            dprime{1,i}{1,j} = norminv(ToneBin{1,i}{1,j}(4,:))-norminv(ToneBin{1,i}{1,j}(4,1));
            ToneBin{1,i}{1,j}(5,:) = normcdf(dprime{1,i}{1,j}./2);
            ToneBin{1,i}{1,j}(6,:) = 20.*log10(ToneBin{1,i}{1,j}(2,:)./v0);
            ToneBin{1,i}{1,j}(5,1) = NaN;
            ToneBin{1,i}{1,j}(6,1) = NaN;
            
            %
        end
        pc(1,:) = ToneBin{1,i}{1,j}(5,:);
            pc(2,:) = ToneBin{1,i}{1,j}(6,:);
            LineThreshold{1,i}(1,j) = ThreshCalc(pc);
            pc = pc;
            FA{1,i}(1,j) = ToneBin{1,i}{1,j}(4,1);
            Threshold(i,j) = LineThreshold{1,i}(1,j);
            Threshold(i,j) = round(Threshold(i,j)*1000)/1000;
            pc=[];
    end
end
    figure;
for count1 = 1:i
    for count = 1:j
    plot(ToneBin{1,count1}{1,count}(6,:),ToneBin{1,count1}{1,count}(5,:));
    hold on;
    end
   
    if count1==no_of_freq
        hold off;
    else
        hold off;
       figure;
    end

end
Threshold
FalseA = mean(FA{1,1})
ylim([0 1])
for count1 = 1:i
    for count = 1:j
   [fitresult, gof] = createCoGFitWB(ToneBin{1,count1}{1,count}(6,:),ToneBin{1,count1}{1,count}(5,:),Threshold(count1,count));
   Name = num2str(count);
   title(Name);
    end
end
%%Tone bin cell array has one cell for each frequency under which has one
%%cell for each noise level
%%Row1 = Trial reps
%%Row2 = tone levels volts
%%Row3 = Lever Release
%%Row4 = hitrate
%%Row5  = probability correct
%%Row6 = tone levels dB
