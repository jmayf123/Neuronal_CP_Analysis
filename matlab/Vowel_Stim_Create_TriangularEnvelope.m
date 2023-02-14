%%Vowel Code for triangular envelope of synth vowels
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
        F =  [5.13, 17.00, 24.07, 30.63]*f0;
        BW = [ .82, 1.18,   1.31,  1.60]*f0; f=1;
    case 'Eh'
        F =  [6.00, 17.00, 24.07, 30.63] *f0;
        %F =  [3.0]*f0;
        %BW = [0.82]*f0; f=2;
        BW = [ .82, 1.18, 1.31,  1.60]*f0; f=2;
    case 'Ih'
        F =  [3.19, 21.82, 28.90, 36.43]*f0;
        BW = [ .97, 1.00, 1.57,  2.80]*f0; f=3;
    case 'Oh'
        F =  [5.02, 10.00, 26.67, 34.79]*f0;
        BW = [ .80, 1.22, 1.96, 1.00]*f0; f=4;
    case 'Ooh'
        fs=8192;
        t=(1:1:0.2*fs)/fs;
        j=2*pi*t;
        %n1=0
            %a1=0;a2=0;a3=0;a4=0;a5=0;
        %n1=300
             %a1=1;a2=0.4169;a3=0.5863;a4=0;a5=0.2654;
        n1=400
            a1=1;a2=0.5863;a3=0.7387;a4=0.2654;a5=0.5161;
        %n1=500
            %a1=1;a2=0.6791;a3=0.7387;a4=0.2654;a5=0.5161;
        %n1=600
            %a1=1;a2=0.7387;a3=0.7783;a4=0.4169;a5=0.5863;
        %n2=0
            %a6=0;a7=0;a8=0;a9=0;a10=0;
        %n2=1200
            %a6=1;a7=0.8745;a8=0.8845;a9=0.737;a10=0.7776;
        %n2=1500
            %a6=1;a7=0.9005;a8=0.9069;a9=0.7936;a10=0.8194;
        %n2=1700
            %a6=1;a7=0.9125;a8=0.926;a9=0.8194;a10=0.8395;
        %n2=1900
            %a6=1;a7=0.922;a8=0.926;a9=0.8395;a10=0.8556;
        n2=2100
            a6=1;a7=0.9296;a8=0.9329;a9=0.8556;a10=0.8688;
        formant1=a1*sin(j*n1)+a2*sin(j*(n1-100))+a3*sin(j*(n1+100))+a4*sin(j*(n1-200))+a5*sin(j*(n1+200));
        formant2=a6*sin(j*n2)+a7*sin(j*(n2-100))+a8*sin(j*(n2+100))+a9*sin(j*(n2-200))+a10*sin(j*(n2+200));
        vowel=formant1+formant2;
        vowel = vowel/max(vowel);

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
FreqList=vowel;
NoiseLevel=Noise.Level+FreqList*0;
fprintf(fid1,'%g\n',FreqList);
fclose(fid1);
fprintf(fid2,'%g\n',VoltageTrialList);
fclose(fid2);
fprintf(fid3,'%g\n',NoiseLevel);
fclose(fid3);

%fs = 8192;              % Sampling rate (Hz)
%nsecs = length(F);
%R = exp(-pi*BW/fs);     % Pole radii
%theta = 2*pi*F/fs;      % Pole angles
%poles = R .* exp(1i*theta); % Complex poles 
%B = 1;  A = real(poly([poles,conj(poles)]));
% freqz(B,A); % View frequency response:

% Convert to parallel complex one-poles (PFE):
%[r,p,~] = residuez(B,A);
%As = zeros(nsecs,3);
%Bs = zeros(nsecs,3);
% complex-conjugate pairs are adjacent in r and p:
%for i=1:2:2*nsecs
    %k = 1+(i-1)/2;
    %Bs(k,:) = [r(i)+r(i+1),  -(r(i)*p(i+1)+r(i+1)*p(i)), 0];
    %As(k,:) = [1, -(p(i)+p(i+1)), p(i)*p(i+1)];
%end
%sos = [Bs,As]; % standard second-order-section form
% iperr = norm(imag(sos))/norm(sos); % make sure sos is ~real
% disp(sprintf('||imag(sos)||/||sos|| = %g',iperr)); % 1.6e-16
%sos = real(sos); % and make it exactly real
%Bs = sos(:,1:3); 
%As = sos(:,4:6); 
%Bh = Bs(1,:);  
%Ah = As(1,:);
%for i=2:nsecs
  %Bh = conv(Bh,As(i,:)) + conv(Ah,Bs(i,:));
  %Ah = conv(Ah,As(i,:));
%end
% Reconstruct original numerator and denominator as a check:
% [Bh,Ah] = Monkeypsos2tf(sos); % parallel sos to transfer function
% psos2tf appears in the matlab-utilities appendix
% disp(sprintf('||A-Ah|| = %g',norm(A-Ah))); % 5.77423e-15
% Bh has trailing epsilons, so we'll zero-pad B:
% disp(sprintf('||B-Bh|| = %g',...
%             norm([B,zeros(1,length(Bh)-length(B))] - Bh)));
% 1.25116e-15

% Plot overlay and sum of all three 
% resonator amplitude responses:
%nfft=512;
%H = zeros(nsecs+1,nfft);
%for i=1:nsecs
  %[Hiw,~] = freqz(Bs(i,:),As(i,:));
  %H(1+i,:) = Hiw(:).';
%end
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
% figure(1); clf;
% myplot(wp,20*log10(abs(Hp)),sym,ttl,xlab,ylab,1,lgnd);
% disp('PAUSING'); pause;
% saveplot('../eps/lpcexovl.eps');
% Now synthesize the vowel [a]:
%nsamps = 1*fs;
% f0 = 100; % Pitch in Hz
%w0T = 2*pi*f0/fs; % radians per sample

%nharm = floor((fs/2)/f0); % number of harmonics
%sig = zeros(1,nsamps);
%n = 0:(nsamps-1);
% Synthesize bandlimited impulse train
%for i=1:nharm,
    %sig = sig + cos(i*w0T*n);
%end;
%sig = sig/max(sig);
% x=(1:1:length(sig));
% figure
% plot(x,sig)
%speech = filter(1,A,sig);
%soundsc(speech); % hear buzz, then 'ah'
%%%
speech=vowel;
sample_rate = fs;
new_sample_rate = 4*24414.0625;
% put sample rate of RPx here
%[data, sample_rate, bps] = wavread(wav_filename) ;
[p, q] = rat(sample_rate/new_sample_rate, 0.0001); 
new_data = resample(speech, q, p);
length(new_data);
fid = fopen('C:\TDT\test.f32','wb');
fwrite(fid, new_data, 'float');
fclose(fid);
InTrial=getappdata(PlayListHandle,'InTrial');
InTrial.TrialLength=length(FreqList);
setappdata(PlayListHandle,'InTrial',InTrial);


Vowel_Go();
end

