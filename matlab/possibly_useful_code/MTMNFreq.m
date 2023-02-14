clear all; 
%% Get Data

Monkey = 'Charlie'; 
leter = 'c';
Location = 'CN'; 

Date = '181026';
Block = '19';

myTank = ['Z:\' Monkey 'data\Neurobehavior\' Location '\ex' Date '\tank' Date leter];
myBlock = ['OurData-' Block];

NOISEFREQ = 20; 

data = TDT2mat(myTank, myBlock, 'TYPE',[2 3]);

TLevel = data.epocs.Levl.data; 
Tstart = data.epocs.Levl.onset; 
Tend = data.epocs.Levl.onset + 0.2; 
CorrWrong = data.epocs.Corr.data; 
TotalSpikes = data.snips.eNeu.ts; 
%% Sort spikes by trial
stimspc = [];
for i = 1:140
    n = 1; 
    for j = 1:size(TotalSpikes,1)   
        if Tstart(i,1) <= TotalSpikes(j,1) 
            if TotalSpikes(j,1) < Tend(i,1)
                stimspc(n, i) = TotalSpikes(j,1); 
                n = n+1;
            end
        end
    end 
end 


%% Spike Count by Trial
count = zeros(140,1); 

for i = 1:size(stimspc,1)
    for n = 1:140
        if stimspc(i,n) > 0
            count(n, 1) = count(n,1) + 1; 
        end 
    end
end

binned = zeros(10, 140); 


for n = 1:140
    for p = 1:32
            bins = Tstart(n, 1):0.00625:Tend(n,1);
            w = 0;
        for i = 1:size(stimspc,1)  
            if bins(1, p) <= stimspc(i,n)
                if stimspc(i,n) < bins(1, p+1)
                    binned(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                

 sortall = sort(TLevel); 
 levels = sortall(30:10:140); 
 %% average spikes per level
 p = ones(12,1);
 totperlevel = [];
 
 for i = 1:12
    for n = 1:140
        if TLevel(n,1) == levels(i, 1)
            totperlevel(i,p(i,1)) = count(n,1); 
            p(i,1) = p(i,1) + 1;
        end
    end
 end
 %%

for i = 1:12
    if i > 1
        avspclevel(i, 1) = mean(totperlevel(i, 1:10));
        avspclevelstd(i, 1) = std(totperlevel(i,1:10)); 
    else
        avspclevel(i,1) = mean(totperlevel(i, 1:30)); 
        avspclevelstd(i,1) = std(totperlevel(i,1:30)); 
    end 
end

%levels into dB
levelsdB = dBtoSPL(levels, 12);

figure; 
plot(levelsdB(2:12),avspclevel(2:12), '*', levels(1,1), avspclevel(1,1), 'r*');
title('Spike Count by Tone Level');
figure;
errorbar(avspclevel, avspclevelstd, '*')



%% Vector Strength to the TONE (10 Hz)
for Z = 1:140
    if count(Z,1) > 0
        radpersec(1, Z) = (2*pi)*10;
        nZ=count(Z,1);
        reps=stimspc(1:nZ,Z);
        phaseangleZ=radpersec(1, Z) .* reps;
        xZ=cos(phaseangleZ);
        yZ=sin(phaseangleZ);
        r(Z,1)=sqrt((sum(xZ))^2+(sum(yZ))^2)/nZ;
    else
        r(Z,1) = 0; 
    end
end


 p = ones(12,1);
 for n = 1:140
    for i = 1:12
        if TLevel(n,1) == levels(i, 1)
            vsperlevel(i,p(i,1)) = r(n,1); 
            p(i,1) = p(i,1) + 1; 
            
        end
    end
 end
 
avvslevel = sum(vsperlevel, 2)./ 10; 
avvslevel(1,1) = avvslevel(1,1) * 10 / 30; 
figure
plot(levelsdB, avvslevel, '*')
title('Vector Strength'); 

%% Vector Strength to the NOISE (10,20,40,80 Hz)
for Z = 1:140
    if count(Z, 1) > 0
        radpersec(1, Z) = (2*pi)*NOISEFREQ;
        nZ=count(Z,1);
        reps=stimspc(1:nZ,Z);
        phaseangleZ=radpersec(1, Z) .* reps;
        xZ=cos(phaseangleZ);
        yZ=sin(phaseangleZ);
        r(Z,1)=sqrt((sum(xZ))^2+(sum(yZ))^2)/nZ;
    else
        r(Z,1) = 0;
    end
end


 p = ones(12,1);
 for n = 1:140
    for i = 1:12
        if TLevel(n,1) == levels(i, 1)
            vsperlevel(i,p(i,1)) = r(n,1); 
            p(i,1) = p(i,1) + 1; 
            
        end
    end
 end
 
Navvslevel = sum(vsperlevel, 2)./ 10; 
Navvslevel(1,1) = Navvslevel(1,1) * 10 / 30; 
figure
plot(levelsdB, avvslevel, 'b*', levelsdB, Navvslevel, 'sr')
title('Blue = VS to 10 Hz Tone, Red = VS to Noise')

    

% %% histograms
% 
% for i = 2:12
%     figure;
%     counter = 1;
%     for n = 1:140
%         if TLevel(n, 1) == levels(i,1) 
%             subplot(3, 4, counter);
%             histogram(stimspc(:,n), 'BinWidth', 0.02, 'BinLimits', [Tstart(n,1),Tend(n,1)]); 
%             counter = counter + 1; 
%         end
%     end
% end

%%
Lbinned = zeros(size(binned,1), size(levels,1));
for i = 1:length(levels)
    for n = 1:140
        if TLevel(n, 1) == levels(i,1) 
            Lbinned(:,i) = Lbinned(:,i) + binned(:, n);
        end
    end
end

for i = 1:12
    figure; 
    plot(1:32, Lbinned(:,i))
end

%%
for i = 1:12
    figure;
    Fs = 160;                  % Sampling frequency (5*number of bins) 
    T = 1/Fs;                  % Sample time
    L = 32;                    % Length of signal (number of bins)
    t = (0:L-1)*T;             % Time vector

    x = Lbinned(:,i);     % Sinusoids plus noise
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    Y = fft(x,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);

        % Plot single-sided amplitude spectrum.
    plot(f,2*abs(Y(1:NFFT/2+1))) 
    title('Amplitude Spectrum')
    xlabel('Frequency (Hz)')
    ylabel('Amplitude')

end  