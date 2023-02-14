clear all; 
%% Get Data
% 
Monkey = 'Delta'; 
leter = 'd';
Location = 'IC'; 

Date = '130716';
Block = '11';
NOISEFREQ = 100;

myTank = ['Z:\' Monkey ' data\Neurobehavior\' Location '\ex' Date '\tank' Date leter];%
myBlock = ['OurData-' Block];

% myTank = 'Z:\SAM\ex150807\tank150807c';
% myBlock = 'OurData-10';
 
 

data = TDT2mat(myTank, myBlock, 'TYPE',[2 3]);

TLevel = data.epocs.Levl.data; 
Tstart = data.epocs.Levl.onset; 
Tend = data.epocs.Levl.onset + 0.2; 
CorrWrong = data.epocs.Corr.data; 
TotalSpikes = data.snips.eNeu.ts; 
NumOfTrials = length(data.epocs.Levl.data);

%% Sort spikes by trial
stimspc = [];
for i = 1:NumOfTrials
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
count = zeros(NumOfTrials,1); 

for i = 1:size(stimspc,1)
    for n = 1:NumOfTrials
        if stimspc(i,n) > 0
            count(n, 1) = count(n,1) + 1; 
        end 
    end
end
%% sorting levels
 sortall = sort(TLevel); 
 levels = sortall(29:15:NumOfTrials); 

  %% spikes summed per level
 p = ones(length(levels),1);
 totperlevel = [];
 
 for i = 1:length(levels)
    for n = 1:NumOfTrials
        if TLevel(n,1) == levels(i, 1)
            totperlevel(i,p(i,1)) = count(n,1); 
            p(i,1) = p(i,1) + 1;
            
        end
    end
 end
 
for i = 1:length(levels)
    if i > 1
      sumlevel(i, 1) = sum(totperlevel(i, 1:15)); 
    else
       sumlevelcatch(i,1) = sum(totperlevel(i, 1:29)); 
    end 
end

%% levels into dB

levelsdB = dBtoSPL(levels, length(levels));

% figure; 
% plot(levelsdB(2:length(levels)),avspclevel(2:length(levels)), '*', levels(1,1), avspclevel(1,1), 'r*');
% title('Spike Count by Tone Level');
% figure;
% errorbar(avspclevel, avspclevelstd, '*')

%% first level of bins -20 bins
binned = zeros(2560, NumOfTrials); 

for n = 1:NumOfTrials
    for p = 1:2560
            bins = Tstart(n, 1):.200/2560:Tend(n,1);
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

%% average bin over level
Lbinned = zeros(size(binned,1), size(levels,1));
for i = 1:length(levels)
    for n = 1:NumOfTrials
        if TLevel(n, 1) == levels(i,1) 
            Lbinned(:,i) = Lbinned(:,i) + binned(:, n);
        end
    end
end

%% suming into 128 bins


firstbinned = zeros(128, size(levels,1));


   for i = 1:size(levels,1);
       for j = 1:128
             firstbinned(j, i)= (Lbinned(j,i)+Lbinned(127+j,i)+ Lbinned(255+j,i)+Lbinned(383+j,i)+Lbinned(511+j,i)+ Lbinned(639+j,i)+Lbinned(767+j,i)+Lbinned(895+j,i)+Lbinned(1023+j,i)+Lbinned(1151+j,i)+Lbinned(1279+j,i)+Lbinned(1407+j,i)+Lbinned(1535+j,i)+Lbinned(1663+j,i)+Lbinned(1791+j,i)+Lbinned(1919+j,i)+Lbinned(2047+j,i)+Lbinned(2175+j,i)+Lbinned(2303+j,i)+Lbinned(2431+j,i));
       end
   end

     %% summing into 20 bins (10ms each)- wrong don't need
%  
% 
% secondbinned = zeros(20, size(levels,1));
% 
%     for i = 1:size(levels,1);
%        for j = 1:20;
%            for k = 0:20:2559;
%              secondbinned(j, i)= secondbinned(j,i) + Lbinned(k+j,i);
%        end
%        end
%     end
%     
    
 
 %% plot
% for i = 1:length(levels)
%     figure; 
%     plot(1:length(firstbinned), firstbinned(:,i))
% end

% %% correct period histograms
% for i = 1:length(levels)
%     figure;
%     newfirstbinned = ((firstbinned/.078)*200/300);
%     plot (1:length(newfirstbinned), newfirstbinned(:,i));
%     axis ([0,128,0,200])
% end

% %% subtracting out mean firing rate
% for i = 1:length(levels)
%     fire(1,i) = sum(avgbinned(:,i));
%     meanfire = fire/128; 
%     for j = 1:128
%         corrbinned(j, i) = avgbinned(j,i) - meanfire(1, i); 
%     end
%    
% end
%    
%% FFT

for i = 1:length(levels)
    %figure;
    Fs = 12800;                  % Sampling frequency (5*number of bins) 
    T = 1/Fs;                  % Sample time
    L = 128;                    % Length of signal (number of bins)
    t = (0:L-1)*T;             % Time vector

    x = firstbinned(:,i);     % Sinusoids plus noise
    NFFT = 2^nextpow2(L+1); % Next power of 2 from length of y
    Y = fft(x,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
     ftranspose = f';

    %plot(f,2*abs(Y(1:NFFT/2+1)))
    %title('Amplitude Spectrum')
    %xlabel('Frequency (Hz)')
    %ylabel('Amplitude')
    yes(:,i) = 2*abs(Y(1:NFFT/2+1));
    yesminusfirst = yes([2:end],:);
end
   
   %%
%  
% for i = 1:length(levels)
%     figure;
%     Fs = 12800;                  % Sampling frequency (5*number of bins) 
%     T = 1/Fs;                  % Sample time
%     L = 128;                    % Length of signal (number of bins)
%     t = (0:L-1)*T;             % Time vector
% 
%     x = firstbinned(:,i);     % Sinusoids plus noise
%     NFFT = 256; % Next power of 2 from length of y
%     Y = fft(x,NFFT)/L;
%     f = Fs/2*linspace(0,1,NFFT/2+1);
% 
%         % Plot single-sided amplitude spectrum.
%     plot(f,2*abs(Y(1:NFFT/2+1)))
%     yesorig (:,i) = 2*abs(Y(1:NFFT/2+1));
%     yesminusfirstandcatch = yesorig([2:end],[2:end]);
%     ftranspose = f';
%     title('Amplitude Spectrum')
%     xlabel('Frequency (Hz)')
%     ylabel('Amplitude')
% end
% 
% % %% After Curvefitter
% % % x = txt(:,1); y = txt(:,2);
% % % x1 = (floor(xval(1)):ceil(xval(end)))';
% % % x1 = (floor(fitx(1)):ceil(fitx(end)))';
% % x1 = 0:0.001:max(AxisX)+15; 
% % k = coeffvalues(fittedmodel);
% % y1 = k(3)-k(4)*exp(-(x1./k(1)).^k(2));
% % % y1 = (-k(1)./(1+(k(2).*k(3).^(-x1))))+k(4);
% % figure
% % plot(x1,y1);
% % 
% % ythresh =((max(y1)+min(y1))*0.5)
% %  
% % NeuroTimingThresh = 0; 
% % for i = 1:length(x1)
% %     if y1(1, i) >= ythresh 
% %         NeuroTimingThresh(1,1) = x1(1,i) + levelsdB(1,2);
% %     end 
% % end
% 

%% play tone to know when done
fs = 8000;
T = 1; % 2 seconds duration
t = 0:(1/fs):T;
f = 400;
a = 0.5;
y = a*sin(2*pi*f*t);
sound(y, fs)