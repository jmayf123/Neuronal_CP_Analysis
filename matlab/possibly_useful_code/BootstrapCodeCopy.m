clear all
%% Bootstrap Analysis

%% Get Data
% 
Monkey = 'Delta'; 
leter = 'd';
Location = 'IC'; 

Date = '121116';
Block = '8';
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
 levels = sortall(30:15:NumOfTrials); 
 
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
       sumlevelcatch(i,1) = sum(totperlevel(i, 1:30)); 
    end 
end
%% Random Distribution

% numspikes=16; %just an example, you get this actual value from the code
% y=sort(0+0.2*rand(1,numspikes));
% Now the above was to just one repeat of 1 trial. To get 100 repeats,
% y(1:100,1:numspikes) = sort(0+0.2*rand(100,numspikes),2);
% Now you just have to repeat it for 15 trials

%level1,15trials
rep = 100
for i=3
    onetimerandom = sort( 0 + (.2-0)*rand(totperlevel(i,1),1));
    manytimesrandomrep1 = sort( 0 + (.2-0)*rand(totperlevel(i,1),rep));
    manytimesrandomrep2 = sort( 0 + (.2-0)*rand(totperlevel(i,2),rep));
    manytimesrandomrep3 = sort( 0 + (.2-0)*rand(totperlevel(i,3),rep));
    manytimesrandomrep4 = sort( 0 + (.2-0)*rand(totperlevel(i,4),rep));
    manytimesrandomrep5 = sort( 0 + (.2-0)*rand(totperlevel(i,5),rep));
    manytimesrandomrep6 = sort( 0 + (.2-0)*rand(totperlevel(i,6),rep));
    manytimesrandomrep7 = sort( 0 + (.2-0)*rand(totperlevel(i,7),rep));
    manytimesrandomrep8 = sort( 0 + (.2-0)*rand(totperlevel(i,8),rep));
    manytimesrandomrep9 = sort( 0 + (.2-0)*rand(totperlevel(i,9),rep));
    manytimesrandomrep10 = sort( 0 + (.2-0)*rand(totperlevel(i,10),rep));
    manytimesrandomrep11 = sort( 0 + (.2-0)*rand(totperlevel(i,11),rep));
    manytimesrandomrep12 = sort( 0 + (.2-0)*rand(totperlevel(i,12),rep));
    manytimesrandomrep13 = sort( 0 + (.2-0)*rand(totperlevel(i,13),rep));
    manytimesrandomrep14 = sort( 0 + (.2-0)*rand(totperlevel(i,14),rep));
    manytimesrandomrep15 = sort( 0 + (.2-0)*rand(totperlevel(i,15),rep));
end


%% first level of bins -20 bins
repetitions = (100);
binnedbootrep1 = zeros(2560, repetitions); 

for n = 1:repetitions
    for p = 1:2560
            binsbootrep1 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep1,1)  
            if binsbootrep1(1, p) <= manytimesrandomrep1(i,n)
                if manytimesrandomrep1(i,n) < binsbootrep1(1, p+1)
                    binnedbootrep1(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep1
                    clear manytimesrandomrep1

 %% 
binnedbootrep2 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep2 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep2,1)  
            if binsbootrep2(1, p) <= manytimesrandomrep2(i,n)
                if manytimesrandomrep2(i,n) < binsbootrep2(1, p+1)
                    binnedbootrep2(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end

                    clear binsbootrep2
                    clear manytimesrandomrep2
%%

binnedbootrep3 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep3 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep3,1)  
            if binsbootrep3(1, p) <= manytimesrandomrep3(i,n)
                if manytimesrandomrep3(i,n) < binsbootrep3(1, p+1)
                    binnedbootrep3(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end

                    clear binsbootrep3
                    clear manytimesrandomrep3
%%

binnedbootrep4 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep4 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep4,1)  
            if binsbootrep4(1, p) <= manytimesrandomrep4(i,n)
                if manytimesrandomrep4(i,n) < binsbootrep4(1, p+1)
                    binnedbootrep4(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end

                    clear binsbootrep4
                    clear manytimesrandomrep4
  %%
  
                    
binnedbootrep5 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep5 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep5,1)  
            if binsbootrep5(1, p) <= manytimesrandomrep5(i,n)
                if manytimesrandomrep5(i,n) < binsbootrep5(1, p+1)
                    binnedbootrep5(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep5
                    clear manytimesrandomrep5
  %%
  
binnedbootrep6 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep6 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep6,1)  
            if binsbootrep6(1, p) <= manytimesrandomrep6(i,n)
                if manytimesrandomrep6(i,n) < binsbootrep6(1, p+1)
                    binnedbootrep6(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep6
                    clear manytimesrandomrep6
%%

binnedbootrep7 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep7 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep7,1)  
            if binsbootrep7(1, p) <= manytimesrandomrep7(i,n)
                if manytimesrandomrep7(i,n) < binsbootrep7(1, p+1)
                    binnedbootrep7(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep7
                    clear manytimesrandomrep7
                    %%
                  
binnedbootrep8 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep8 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep8,1)  
            if binsbootrep8(1, p) <= manytimesrandomrep8(i,n)
                if manytimesrandomrep8(i,n) < binsbootrep8(1, p+1)
                    binnedbootrep8(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep8
                    clear manytimesrandomrep8
                    %%
binnedbootrep9 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep9 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep9,1)  
            if binsbootrep9(1, p) <= manytimesrandomrep9(i,n)
                if manytimesrandomrep9(i,n) < binsbootrep9(1, p+1)
                    binnedbootrep9(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep9
                    clear manytimesrandomrep9
                    
                    %%
binnedbootrep10 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep10 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep10,1)  
            if binsbootrep10(1, p) <= manytimesrandomrep10(i,n)
                if manytimesrandomrep10(i,n) < binsbootrep10(1, p+1)
                    binnedbootrep10(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep10
                    clear manytimesrandomrep10
                    
                    %%

binnedbootrep11 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep11 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep11,1)  
            if binsbootrep11(1, p) <= manytimesrandomrep11(i,n)
                if manytimesrandomrep11(i,n) < binsbootrep11(1, p+1)
                    binnedbootrep11(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep11
                    clear manytimesrandomrep11
                    
                    %%
binnedbootrep12 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep12 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep12,1)  
            if binsbootrep12(1, p) <= manytimesrandomrep12(i,n)
                if manytimesrandomrep12(i,n) < binsbootrep12(1, p+1)
                    binnedbootrep12(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep12
                    clear manytimesrandomrep12
                    
                    %%
binnedbootrep13 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep13 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep13,1)  
            if binsbootrep13(1, p) <= manytimesrandomrep13(i,n)
                if manytimesrandomrep13(i,n) < binsbootrep13(1, p+1)
                    binnedbootrep13(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep13
                    clear manytimesrandomrep13
                    
                    %%
binnedbootrep14 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep14 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep14,1)  
            if binsbootrep14(1, p) <= manytimesrandomrep14(i,n)
                if manytimesrandomrep14(i,n) < binsbootrep14(1, p+1)
                    binnedbootrep14(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep14
                    clear manytimesrandomrep14
                    
                    %%
binnedbootrep15 = zeros(2560, repetitions); 
for n = 1:repetitions
    for p = 1:2560
            binsbootrep15 = 0:.200/2560:.2;
            w = 0;
    for i = 1:size(manytimesrandomrep15,1)  
            if binsbootrep15(1, p) <= manytimesrandomrep15(i,n)
                if manytimesrandomrep15(i,n) < binsbootrep15(1, p+1)
                    binnedbootrep15(p, n) = w + 1; 
                    w = w + 1; 
                end
            end
        end
    end
end
                    clear binsbootrep15
                    clear manytimesrandomrep15

 %% if 10 repitions
% binnedbootrep11 = zeros(2560, rep);
% binnedbootrep12 = zeros(2560, rep);
% binnedbootrep13 = zeros(2560, rep);
% binnedbootrep14 = zeros(2560, rep);
% binnedbootrep15 = zeros(2560, rep);

%% giant array
binnedbootbig = zeros(2560, rep*15);
binnedbootbig = cat(2,binnedbootrep1,binnedbootrep2,binnedbootrep3,binnedbootrep4, binnedbootrep5, binnedbootrep6, binnedbootrep7, binnedbootrep8, binnedbootrep9, binnedbootrep10, binnedbootrep11, binnedbootrep12, binnedbootrep13, binnedbootrep14, binnedbootrep15);
binnedbootbigflip = transpose(binnedbootbig);
 %% suming before collapsing
 
 togetherbinnedboot = zeros(2560, rep);
 togetherbinnedbootflip = zeros(rep, 2560);
    for i = 1:2560
       for j = 1:rep
             togetherbinnedbootflip(j, i)= (binnedbootbigflip(j,i)+ binnedbootbigflip(rep*1+j,i)+ binnedbootbigflip(rep*2+j,i)+ binnedbootbigflip(rep*3+j,i)+ binnedbootbigflip(rep*4+j,i)+ binnedbootbigflip(rep*5+j,i)+binnedbootbigflip(rep*6+j,i)+binnedbootbigflip(rep*7+j,i)+binnedbootbigflip(rep*8+j,i)+binnedbootbigflip(rep*9+j,i)+binnedbootbigflip(rep*10+j,i)+binnedbootbigflip(rep*11+j,i)+binnedbootbigflip(rep*12+j,i)+binnedbootbigflip(rep*13+j,i)+binnedbootbigflip(rep*14+j,i));
       end
   end
togetherbinnedboot = transpose (togetherbinnedbootflip);

%% suming into 128 bins

firstbinnedboot = zeros(128, rep);

 for i = 1:rep;
       for j = 1:128
         firstbinnedboot(j, i)= (togetherbinnedboot(j,i)+togetherbinnedboot(127+j,i)+ togetherbinnedboot(255+j,i)+togetherbinnedboot(383+j,i)+togetherbinnedboot(511+j,i)+ togetherbinnedboot(639+j,i)+togetherbinnedboot(767+j,i)+togetherbinnedboot(895+j,i)+togetherbinnedboot(1023+j,i)+togetherbinnedboot(1151+j,i)+togetherbinnedboot(1279+j,i)+togetherbinnedboot(1407+j,i)+togetherbinnedboot(1535+j,i)+togetherbinnedboot(1663+j,i)+togetherbinnedboot(1791+j,i)+togetherbinnedboot(1919+j,i)+togetherbinnedboot(2047+j,i)+togetherbinnedboot(2175+j,i)+togetherbinnedboot(2303+j,i)+togetherbinnedboot(2431+j,i));
    end
   end
%  %% correction
%  
%    newfirstbinnedboot = ((firstbinnedboot/.078)*200/300);

%% plot
% 
% for i = 1:100
%     figure; 
%     plot(1:length(firstbinnedboot), firstbinnedboot(:,i))
% end


for i = 1:rep
%     figure;
    Fs = 12800;                  % Sampling frequency (5*number of bins) 
    T = 1/Fs;                  % Sample time
    L = 128;                    % Length of signal (number of bins)
    t = (0:L-1)*T;             % Time vector

    x = firstbinnedboot(:,i);     % Sinusoids plus noise
    NFFT = 2^nextpow2(L+1); % Next power of 2 from length of y
    Y = fft(x,NFFT)/L;
    f = Fs/2*linspace(0,1,NFFT/2+1);
    
    yesboot(:,i) = 2*abs(Y(1:NFFT/2+1));
     yesminusfirstboot = yesboot([2:end],:);
     means = mean(yesminusfirstboot,2);
     stds = std(yesminusfirstboot,0,2);
     stdyes = stds*3 + means;
     ftranspose = f';


 % Plot single-sided amplitude spectrum.
%    
%     plot(f,2*abs(Y(1:NFFT/2+1)))
%     title('Amplitude Spectrum')
%     xlabel('Frequency (Hz)')
%     ylabel('Amplitude')
%     axis ([0,4500,0,1.4])
%     

end

%% play tone to know when done
fs = 8000;
T = 1; % 2 seconds duration
t = 0:(1/fs):T;
f = 400;
a = 0.5;
y = a*sin(2*pi*f*t);
sound(y, fs)