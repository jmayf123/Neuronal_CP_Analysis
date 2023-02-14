%This program generates 4 files to create bf rate level function;
% One contains Tone frequencies, one contains tone levels,
% the third contains noise levels, which are set to zero.
% the fourth contains modulation frequencies to study temporal sensitivity.
function [lowest] = MonkeyNeuroBFRLfilemaker(BF,Tone,Noise,Mod)
clear freq tlvl nlvl modf;

bf = BF;
switch Tone
    case 2
        bftonelevels = [0 0 0 .000025 .000025 .000079 .000079 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79]; % 0 0 0 .000025 .000025 .000079 .000079 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79
        lowest=.000025;
    case 3
        bftonelevels = [0 0 0 .000079 .000079 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79];
        lowest=.00079;
    case 4
        bftonelevels = [0 0 0 .00025 .00025 .00079 .00079 .0025 .0025 .0079 .0079 .025 .025 .079 .079 .079 .25 .25 .25 .79 .79 .79];
        lowest=.00025;
        %bftonelevels =  [.7906 .079 .25 0 .079 .25 .7906 .25 .7906 .25 .7906 .025 .025 .0079 .0025 .00079 .00025 .000079]
    otherwise
end

noiselevel=Noise;
modfreq=Mod; % modulation frequency of tone
fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\FreqList.txt','wt');
fid2=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\LevlList.txt','wt');
fid3=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\NlvlList.txt','wt');
fid4=fopen('C:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\UserFiles\ModfList.txt','wt');
for numreps=1:10, 
   randint=randperm(length(bftonelevels));
   bftonelevels2=bftonelevels(randint);
    for bftlevels=1:length(bftonelevels),
        freq((numreps-1)*length(bftonelevels)+bftlevels)= bf;
        tlvl((numreps-1)*length(bftonelevels)+bftlevels)= bftonelevels2(bftlevels);
        nlvl((numreps-1)*length(bftonelevels)+bftlevels)=noiselevel;
        modf((numreps-1)*length(bftonelevels)+bftlevels)=modfreq;
    end
end

fprintf(fid1,'%g\n',freq);
fprintf(fid2,'%g\n',tlvl);
fprintf(fid3,'%g\n',nlvl);
fprintf(fid4,'%g\n',modf);
fclose all;
