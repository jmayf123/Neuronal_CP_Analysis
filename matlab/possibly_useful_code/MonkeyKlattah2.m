function [Sound] = MonkeyKlattah2(vowel)
switch vowel

    case 2 %Vowel Ah
        F =  [513, 1200, 2407, 3063]; % Formant frequencies (Hz) original 700 1220 2600
        BW = [ 82, 118,   131,  160];  % Formant bandwidths (Hz) original 130 70 160
        Sound='Ah';
    case 3 %Vowel Eh
        F =  [513, 1489, 2407, 3063]; % Formant frequencies (Hz) original 700 1220 2600
        BW = [ 82, 118, 131,  160];  % Formant bandwidths (Hz) original 130 70 160
        Sound='Eh';
    case 4 %Vowel ooh
        F =  [273, 753, 2296, 3185]; % Formant frequencies (Hz) original 700 1220 2600
        BW = [ 93, 105, 91, 106];  % Formant bandwidths (Hz) original 130 70 160
        Sound='Ooh';
    case 5 %Vowel ih
        F =  [319, 2182, 2890, 3643]; % Formant frequencies (Hz) original 700 1220 2600
        BW = [ 97, 100, 157,  280];  % Formant bandwidths (Hz) original 130 70 160
        Sound='Ih';
    case 6 %Vowel oh
        F =  [502, 1000, 2667, 3479]; % Formant frequencies (Hz) original 700 1220 2600  MODIFIED
        BW = [ 80, 122, 196, 100];  % Formant bandwidths (Hz) original 130 70 160
        Sound='Oh';
    otherwise
end


fs = 8192;              % Sampling rate (Hz)

nsecs = length(F);
R = exp(-pi*BW/fs);     % Pole radii
theta = 2*pi*F/fs;      % Pole angles
poles = R .* exp(j*theta); % Complex poles 
B = 1;  A = real(poly([poles,conj(poles)]));
% freqz(B,A); % View frequency response:

% Convert to parallel complex one-poles (PFE):
[r,p,f] = residuez(B,A);
As = zeros(nsecs,3);
Bs = zeros(nsecs,3);
% complex-conjugate pairs are adjacent in r and p:
for i=1:2:2*nsecs
    k = 1+(i-1)/2;
    Bs(k,:) = [r(i)+r(i+1),  -(r(i)*p(i+1)+r(i+1)*p(i)), 0];
    As(k,:) = [1, -(p(i)+p(i+1)), p(i)*p(i+1)];
end
sos = [Bs,As]; % standard second-order-section form
iperr = norm(imag(sos))/norm(sos); % make sure sos is ~real
%disp(sprintf('||imag(sos)||/||sos|| = %g',iperr)); % 1.6e-16
sos = real(sos); % and make it exactly real

% Reconstruct original numerator and denominator as a check:
[Bh,Ah] = Monkeypsos2tf(sos); % parallel sos to transfer function
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
  [Hiw,w] = freqz(Bs(i,:),As(i,:));
  H(1+i,:) = Hiw(:).';
end
H(1,:) = sum(H(2:nsecs+1,:));
ttl = 'Amplitude Response'; 
xlab = 'Frequency (Hz)';
ylab = 'Magnitude (dB)';
sym = ''; 
lgnd = {'sum','sec 1','sec 2', 'sec 3'};
np=nfft/2; % Only plot for positive frequencies
wp = w(1:np); Hp=H(:,1:np);
%figure(1); clf;
%myplot(wp,20*log10(abs(Hp)),sym,ttl,xlab,ylab,1,lgnd);
%disp('PAUSING'); pause;
%saveplot('../eps/lpcexovl.eps');

% Now synthesize the vowel [a]:
nsamps = 1*fs;
f0 = 100; % Pitch in Hz
w0T = 2*pi*f0/fs; % radians per sample

nharm = floor((fs/2)/f0); % number of harmonics
sig = zeros(1,nsamps);
n = 0:(nsamps-1);
% Synthesize bandlimited impulse train
for i=1:nharm,
    sig = sig + cos(i*w0T*n);
end;
sig = sig/max(sig);
speech = filter(1,A,sig);
soundsc([speech]); % hear buzz, then 'ah'

%%%
sample_rate = fs;
new_sample_rate = 4*24414.0625;
% put sample rate of RPx here
%[data, sample_rate, bps] = wavread(wav_filename) ;
[p, q] = rat(sample_rate/new_sample_rate, 0.0001) ;
new_data = resample(speech, q, p);


length(new_data);
fid = fopen('C:\TDT\test.f32','wb');
fwrite(fid, new_data, 'float');
figure
plot(new_data)
fclose(fid);

dir2=['C:\My Documents\GUIde\',Sound, ' waveform.txt'];
fid2=fopen(dir2,'w');
length(new_data);
fprintf(fid, '%d', new_data);


fclose(fid2);


