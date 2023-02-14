%This program generates 3 files to create bf rate level function;
% One contains Tone frequencies, one contains tone levels,
% the third contains noise levels, which are set to zero.
function [out] = MonkeyPSTHfilemaker(BF,BFtone,Mod,NoiseLevel,NumReps)

bf = BF; 
bftonelevels = BFtone;
noiselevel=NoiseLevel;
modfreq=Mod;

fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\FreqList.txt','wt');
fid2=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\LevlList.txt','wt');
fid3=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\NlvlList.txt','wt');
fid4=fopen('C:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\UserFiles\ModfList.txt','wt');
for numreps=1:NumReps, 
        freq(numreps)= bf;
        tlvl(numreps)= bftonelevels;
        nlvl(numreps)=noiselevel;
        modf(numreps)=modfreq;
end
out=length(freq);
fprintf(fid1,'%g\n',freq);
fprintf(fid2,'%g\n',tlvl);
fprintf(fid3,'%g\n',nlvl);
fprintf(fid4,'%g\n',modf);
fclose all;
