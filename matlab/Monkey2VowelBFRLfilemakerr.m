
function [Trials, LowestTone] = MonkeyVowelBFRLfilemakerr(LowestTone, vowel)
switch LowestTone
    
    case 1; vowellevels = [0 .00025 .0004446 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .25 .25 .79 .79]; % 0 .000025 .000079 .00025 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .079 .25 .25 .79 .79
            LowestTone=.00025;
    case 2; vowellevels = [0 .0004446 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .25 .25 .79 .79]; % 0 .000025 .000079 .00025 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .079 .25 .25 .79 .79
            LowestTone=.0004446;
    case 3; vowellevels = [0 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .25 .25 .79 .79]; % 0 .000025 .000079 .00025 .00079 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .079 .25 .25 .79 .79
            LowestTone=.00079;
    case 4; vowellevels = [0 .001405 .0025 0 .004446 .0079 .01405 .025 .079 .25 .25 .79 .79];
            LowestTone=.001405;
    otherwise
end
% set numreps=1:15  on line 13 of code, max will be 270 trials

switch vowel
    case 1 %Vowel Ah
        Sound='Ah';
    case 2 %Vowel Eh
        Sound='Eh';
    case 3 %Vowel ooh
        Sound='Ih';
    case 4 %Vowel ih
        Sound='Oh';
    case 5 %Vowel oh
        Sound='Ooh';
    otherwise
end


%neuro
%vowellevels = [0 0 0 .000025 .000025 .000079 .000079 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79]; % 0 0 0 .000025 .000025 .000079 .000079 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79
% set numreps=1:10  on line 13 of code, max will be 260 trials



%bftonelevels =  [.7906 .079 .25 0 .079 .25 .7906 .25 .7906 .25 .7906 .025 .025 .0079 .0025 .00079 .00025 .000079]

fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner4\Userfiles\VowelLevel.txt','wt');
fid4=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner4\Userfiles\LevlList.txt','wt');
fid5=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner4\Userfiles\FreqList.txt','wt');

for numreps=1:15, 
   randint=randperm(length(vowellevels));
   bftonelevels2=vowellevels(randint);
    for bftlevels=1:length(vowellevels),
        tlvl((numreps-1)*length(vowellevels)+bftlevels)= bftonelevels2(bftlevels);
 
        freq((numreps-1)*length(vowellevels)+bftlevels)= 0;
 
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