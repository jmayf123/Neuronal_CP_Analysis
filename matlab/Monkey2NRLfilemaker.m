%This program generates 3 files to create noise rate level function;
% One contains Tone frequencies, one contains tone levels,
% the third contains noise levels, which are set to zero.
function [LowestLevel] = MonkeyNRLfilemaker(BF,BFtone,Mod,NoiseLevel)

bf = 20500;
bftonelevels = 0;
modfreq=0;
switch NoiseLevel  
    case 2
        noiselevels=[0 .000025 .00079 .00025 .00079 .0025 .0079 .025 .079058 .25 .79];%.25 .025 .25 .025 .025 .25 0 .025 .25];
        LowestLevel=.000025;
    case 3
        noiselevels=[0 .000079 .00025 .00079 .0025 .0079 .025 .079058 .25 .79];
        LowestLevel=.000079;
    case 4
        noiselevels=[0 .00025 .00079 .0025 .0079 .025 .079058 .25 .79];
        LowestLevel=.00025;
    case 5
        noiselevels=[0 .00079 .0025 .0079 .025 .079058 .25 .79];
        LowestLevel=.00079;
    otherwise
end
fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner4\Userfiles\FreqList.txt','wt');
fid2=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner4\Userfiles\LevlList.txt','wt');

for numreps=1:10, 
    for nslevels=1:length(noiselevels),
        freq((numreps-1)*length(noiselevels)+nslevels)= bf;
        tlvl((numreps-1)*length(noiselevels)+nslevels)= bftonelevels;
    end
end

fprintf(fid1,'%g\n',freq);
fprintf(fid2,'%g\n',tlvl);

fclose all;

