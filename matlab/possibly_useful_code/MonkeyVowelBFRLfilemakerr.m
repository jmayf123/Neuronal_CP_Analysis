
function [Trials, LowestTone] = MonkeyVowelBFRLfilemakerr(LowestTone, Noise, vowel)
LowestTone
switch LowestTone
    case 1; disp('Please select lowest tone');
    case 2; vowellevels = [0 0 .000025 .0000353 .0000498 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025]; % 0 .000025 .000079 .00025 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .079 .25 .25 .79 .79
            LowestTone=.000025;
    case 3; vowellevels = [0 0 .0000353 .0000498 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025]; % 0 .000025 .000079 .00025 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .079 .25 .25 .79 .79
            LowestTone=.0000353;
    case 4; vowellevels = [0 0 .0000498 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025]; % 0 .000025 .000079 .00025 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .079 .25 .25 .79 .79
            LowestTone=.0000498;
    case 5; vowellevels = [0 0 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025];
            LowestTone=.000079;
    case 6; vowellevels = [0 0 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025];
            LowestTone=.000112;
    case 7; vowellevels = [0 0 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025];
            LowestTone=.000158;
    case 8; vowellevels = [0 0 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079];
            LowestTone=.00025;
    case 9; vowellevels = [0 0 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079];
            LowestTone=.000353;
    case 10; vowellevels = [0 0 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.000498;
    case 11; vowellevels = [0 0 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.00079;
    case 12; vowellevels = [0 0 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.00112;
    case 13; vowellevels = [0 0 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.00158;
    case 14; vowellevels = [0 0 .0025 .00353 .00498 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.0025;
    case 15; vowellevels = [0 0 .00353 .00498 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.00353;
    case 16; vowellevels = [0 0 .00498 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.00498;
    case 17; vowellevels = [0 0 .0079 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.0079;
    case 18; vowellevels = [0 0 .0112 .0158 .025 .0353 .0498 .079];
            LowestTone=.0112
    case 19; vowellevels = [0 0 .0158 .025 .0353 .0498 .079];
            LowestTone=.0158
    case 20;vowellevels = [0 0 .025 .0353 .0498 .079];
            LowestTone=.025
    otherwise
end
% set numreps=1:15  on line 13 of code, max will be 270 trials

switch vowel
    case 2 %Vowel Ah
        Sound='Ah';
    case 3 %Vowel Eh
        Sound='Eh';
    case 4 %Vowel ooh
        Sound='Ooh';
    case 5 %Vowel ih
        Sound='Ih';
    case 6 %Vowel oh
        Sound='Oh';
    otherwise
end


%neuro
%vowellevels = [0 0 0 .000025 .000025 .000079 .000079 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79]; % 0 0 0 .000025 .000025 .000079 .000079 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79
% set numreps=1:10  on line 13 of code, max will be 260 trials



%bftonelevels =  [.7906 .079 .25 0 .079 .25 .7906 .25 .7906 .25 .7906 .025 .025 .0079 .0025 .00079 .00025 .000079]
noiselevel=Noise;
fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\VowelLevel.txt','wt');
fid2=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\VowelNoise.txt','wt');
fid3=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\NlvlList.txt','wt');
fid4=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\LevlList.txt','wt');
fid5=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\FreqList.txt','wt');

for numreps=1:15, 
   randint=randperm(length(vowellevels));
   bftonelevels2=vowellevels(randint);
    for bftlevels=1:length(vowellevels),
        tlvl((numreps-1)*length(vowellevels)+bftlevels)= bftonelevels2(bftlevels);
        nlvl((numreps-1)*length(vowellevels)+bftlevels)=noiselevel;
        freq((numreps-1)*length(vowellevels)+bftlevels)= 0;
        vnlvl((numreps-1)*length(vowellevels)+bftlevels)= 0;
    end
end


index=find(tlvl==0);
switch vowel
    case 2 %Vowel Ah
        Sound='Ah';
        freq(index(1))=12421;
    case 3 %Vowel Eh
        Sound='Eh';
        freq(index(1))=12521;
    case 4 %Vowel ooh
        Sound='Ooh';
        freq(index(1))=12821;
    case 5 %Vowel ih
        Sound='Ih';
        freq(index(1))=12621;
    case 6 %Vowel oh
        Sound='Oh';
        freq(index(1))=12721;
    otherwise
end



Trials=length(tlvl);
fprintf(fid1,'%g\n',tlvl);
fprintf(fid2,'%g\n',nlvl);
fprintf(fid3,'%g\n',nlvl);
fprintf(fid4,'%g\n',tlvl);
fprintf(fid5,'%g\n',freq);
fclose all;