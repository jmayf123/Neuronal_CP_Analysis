%This program generates 3 files to create noise rate level function;
% One contains Tone frequencies, one contains tone levels,
% the third contains noise levels, which are set to zero.
function [LowestLevel] = MonkeyNRLfilemaker(BF,BFtone,Mod,NoiseLevel)

bf = 20500;
bftonelevels = 0;
modfreq=0;
switch NoiseLevel  
    case 2
        noiselevels=[0 .000025 .0000353 .0000498 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];%.25 .025 .25 .025 .025 .25 0 .025 .25];
        LowestLevel=.000025;
    case 3
        noiselevels=[0 .0000353 .0000498 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.0000353;
    case 4
        noiselevels=[0 .0000498 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.0000498;
    case 5
        noiselevels=[0 .000079 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.000079;
    case 6
        noiselevels=[0 .000112 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.000112;
    case 7
        noiselevels=[0 .000158 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.000158;
    case 8
        noiselevels=[0 .00025 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.00025;
    case 8
        noiselevels=[0 .000353 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.000353;
    case 9
        noiselevels=[0 .000498 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.000498;
    case 10
        noiselevels=[0 .00079 .00112 .00158 .0025 .00353 .00498 .0079 .0112 .0158 .025 .079058 .25 .79];
        LowestLevel=.00079;
    otherwise
end
fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\FreqList.txt','wt');
fid2=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\LevlList.txt','wt');
fid3=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\NlvlList.txt','wt');
fid4=fopen('C:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\UserFiles\ModfList.txt','wt');
for numreps=1:10, 
    for nslevels=1:length(noiselevels),
        freq((numreps-1)*length(noiselevels)+nslevels)= bf;
        tlvl((numreps-1)*length(noiselevels)+nslevels)= bftonelevels;
        nlvl((numreps-1)*length(noiselevels)+nslevels)=noiselevels(nslevels);
        modf((numreps-1)*length(noiselevels)+nslevels)=modfreq;
    end
end

fprintf(fid1,'%g\n',freq);
fprintf(fid2,'%g\n',tlvl);
fprintf(fid3,'%g\n',nlvl);
fprintf(fid4,'%g\n',modf);
fclose all;

