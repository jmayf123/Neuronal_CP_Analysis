%%This is the original Vowel_Stim_Create as of July 2015; to return to
%%that, copy this file into what is now titled Vowel_Stim_Create

%%%%%%%%%%%%%%% Example of Tone and Noise Variable Inputs %%%%%%%%%%%%%%%%%
% Tone = 
% 
%            StimType: 'Vowel'
%               Vowel: 'Ah'
%     FundamentalFreq: 100
%            Duration: 200
%             ModFreq: 0
%            ModDepth: 1
%               Phase: 0
%         LowestLevel: -10
%             Spacing: 7
%           ToneCount: 2
% Noise = 
% 
%           Level: 0.0250
%            Type: 'SS Gated'
%         LLValue: 0
%        Duration: 200
%         ModFreq: 10
%        ModDepth: 1
%           Phase: 0
%     HighCutoff1: 40000
%      LowCutoff1: 5
%     HighCutoff2: 40000
%      LowCutoff2: 5
%     HighCutoff3: 40000
%      LowCutoff3: 5
%     HighCutoff4: 40000
%      LowCutoff4: 5
%     HighCutoff5: 40000
%      LowCutoff5: 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function []=Vowel_Stim_Create()


PlayListHandle=getappdata(0,'PlayListHandle');
SaveLocation=getappdata(PlayListHandle,'OpenProjectSaveLocation');
fid1=fopen([SaveLocation,'FreqList.txt'],'wt');
fid2=fopen([SaveLocation,'LevlList.txt'],'wt');
fid3=fopen([SaveLocation,'NlvlList.txt'],'wt');
Noise=getappdata(PlayListHandle,'Current_Noise');
Tone=getappdata(PlayListHandle,'Current_Tone');
Tone
Noise
f0=Tone.FundamentalFreq;
switch Tone.Vowel
    case 'Ah'
%        F =  [5]*f0;
%        BW = [0.00001]*f0; f=1;
         F =  [5.13, 12.00, 24.07, 30.63]*f0;
         BW = [ .82, 1.18, 1.31,  1.60]*f0; f=1;
    case 'Eh'
        F =  [5.13, 17.00, 24.07, 30.63]*f0;
        BW = [ .82, 1.18, 1.31,  1.60]*f0; f=2;
%          F =  [5.13, 14.89, 24.07, 30.63]*f0;
%         BW = [ .82, 1.18, 1.31,  1.60]*f0; f=2;
    case 'Ih'
        F =  [3.19, 21.82, 28.90, 36.43]*f0;
        BW = [ .97, 1.00, 1.57,  2.80]*f0; f=3;
    case 'Oh'
        F =  [5.02, 10.00, 26.67, 34.79]*f0;
        BW = [ .80, 1.22, 1.96, 1.00]*f0; f=4;
    case 'Ooh' 
        F =  [2.73, 7.53, 22.96, 31.85]*f0; 
        BW = [ .93, 1.05, .91, 1.06]*f0; f=5;
end


switch Tone.Spacing
    case 1
        ToneSpacing=[-30,-15,-7.5,-5,-2.5,0,2.5,5,7.5,15,30];
    case 2
        ToneSpacing=[-25,-20,-15,-10,-5,0,5,10,15,20,25];
    case 3
        ToneSpacing=[-35,-30,-25,-20,-15,-10,-5,0,5,10,15,20,25,30,35];
    case 4
        ToneSpacing=[-50/3,-40/3,-30/3,-20/3,-10/3,0,10/3,20/3,30/3,40/3,50/3];
    case 5
        ToneSpacing=[-60/3,-50/3,-40/3,-30/3,-20/3,-10/3,0,10/3,20/3,30/3,40/3,50/3,60/3];
    case 6
        ToneSpacing=[-12.5,-10,-7.5,-5,-2.5,0,2.5,5,7.5,10,12.5];
    case 7
        ToneSpacing=[-20,-17.5,-15,-12.5,-10,-7.5,-5,-2.5,0,2.5,5,7.5,10,12.5,15,17.5,20];
    otherwise
        ToneSpacing=[-30,-15,-7.5,-5,-2.5,0,2.5,5,7.5,15,30]; 
end

Levels=ToneSpacing+Tone.LowestLevel;
Defaults=GetDefaultValues;
Voltages=dB2V(Levels);
VoltageTrialList=[];
for i=1:Tone.ToneCount
    VoltageTrialList=[VoltageTrialList,Voltages]; %#ok<*AGROW>
end
VoltageTrialList=[VoltageTrialList,zeros(1,Defaults.NumberCatchTrials)];
Randomization=randperm(length(VoltageTrialList));
VoltageTrialList=VoltageTrialList(Randomization);
FreqList=VoltageTrialList*0+f;
NoiseLevel=Noise.Level+FreqList*0;
fprintf(fid1,'%g\n',FreqList);
fclose(fid1);
fprintf(fid2,'%g\n',VoltageTrialList);
fclose(fid2);
fprintf(fid3,'%g\n',NoiseLevel);
fclose(fid3);

fs = 8192;              % Sampling rate (Hz)
nsecs = length(F);
R = exp(-pi*BW/fs);     % Pole radii
theta = 2*pi*F/fs;      % Pole angles
poles = R .* exp(1i*theta); % Complex poles 
B = 1;  A = real(poly([poles,conj(poles)]));
% freqz(B,A); % View frequency response:

% Convert to parallel complex one-poles (PFE):
[r,p,~] = residuez(B,A);
As = zeros(nsecs,3);
Bs = zeros(nsecs,3);
% complex-conjugate pairs are adjacent in r and p:
for i=1:2:2*nsecs
    k = 1+(i-1)/2;
    Bs(k,:) = [r(i)+r(i+1),  -(r(i)*p(i+1)+r(i+1)*p(i)), 0];
    As(k,:) = [1, -(p(i)+p(i+1)), p(i)*p(i+1)];
end
sos = [Bs,As]; % standard second-order-section form
% iperr = norm(imag(sos))/norm(sos); % make sure sos is ~real
%disp(sprintf('||imag(sos)||/||sos|| = %g',iperr)); % 1.6e-16
sos = real(sos); % and make it exactly real
Bs = sos(:,1:3); 
As = sos(:,4:6); 
Bh = Bs(1,:);  
Ah = As(1,:);
for i=2:nsecs
  Bh = conv(Bh,As(i,:)) + conv(Ah,Bs(i,:));
  Ah = conv(Ah,As(i,:));
end
% Reconstruct original numerator and denominator as a check:
% [Bh,Ah] = Monkeypsos2tf(sos); % parallel sos to transfer function
% psos2tf appears in the matlab-utilities appendix
%disp(sprintf('||A-Ah|| = %g',norm(A-Ah))); % 5.77423e-15
% Bh has trailing epsilons, so we'll zero-pad B:
%disp(sprintf('||B-Bh|| = %g',...
%             norm([B,zeros(1,length(Bh)-length(B))] - Bh)));
% 1.25116e-15

% Plot overlay and sum of all three 
% resonator amplitude responses:
nfft=512;
H = zeros(nsecs+1,nfft);
for i=1:nsecs
  [Hiw,~] = freqz(Bs(i,:),As(i,:));
  H(1+i,:) = Hiw(:).';
end
% H(1,:) = sum(H(2:nsecs+1,:));
% ttl = 'Amplitude Response'; 
% xlab = 'Frequency (Hz)';
% ylab = 'Magnitude (dB)';
% sym = ''; 
% lgnd = {'sum','sec 1','sec 2', 'sec 3'};
% np=nfft/2; % Only plot for positive frequencies
% wp = w(1:np); Hp=H(:,1:np);
% figure
% plot(wp,20*log10(abs(Hp)))
%figure(1); clf;
%myplot(wp,20*log10(abs(Hp)),sym,ttl,xlab,ylab,1,lgnd);
%disp('PAUSING'); pause;
%saveplot('../eps/lpcexovl.eps');
% Now synthesize the vowel [a]:
nsamps = 1*fs;
% f0 = 100; % Pitch in Hz
w0T = 2*pi*f0/fs; % radians per sample

nharm = floor((fs/2)/f0); % number of harmonics
sig = zeros(1,nsamps);
n = 0:(nsamps-1);
% Synthesize bandlimited impulse train
for i=1:nharm,
    sig = sig + cos(i*w0T*n);
end;
sig = sig/max(sig);
% x=(1:1:length(sig));
% figure
% plot(x,sig)
speech = filter(1,A,sig);
soundsc(speech); % hear buzz, then 'ah'
%%%
sample_rate = fs;
new_sample_rate = 4*24414.0625;
% put sample rate of RPx here
%[data, sample_rate, bps] = wavread(wav_filename) ;
[p, q] = rat(sample_rate/new_sample_rate, 0.0001); 

new_data = resample(speech, q, p);
% %%
% JULIA
% Fs=97656;  
%  
% frequency = 4000; % Change this number between 2000 and 500 as needed!
% clear new_data
% t = [0:1:.3.*Fs]/Fs;
% Anow=sin(2*pi*frequency*t);
% new_data = Anow;
%%
length(new_data);
fid = fopen('C:\TDT\test.f32','wb');
fwrite(fid, new_data, 'float');
fclose(fid);
InTrial=getappdata(PlayListHandle,'InTrial');
InTrial.TrialLength=length(FreqList);
setappdata(PlayListHandle,'InTrial',InTrial);


Vowel_Go();















