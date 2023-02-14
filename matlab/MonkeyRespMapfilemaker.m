
function [a] = MonkeyRespMapfilemaker(Noise,Mod,NumOctave,BF,ToneLevel)
%This program generates 4 files to produce a response map centered around bf.

bf = BF;
tonelevel = ToneLevel;
noiselevel = Noise;
modfreq = Mod;
fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\FreqList.txt','wt');
fid2=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\LevlList.txt','wt');
fid3=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\NlvlList.txt','wt');
fid4=fopen('C:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\UserFiles\ModfList.txt','wt');
numoctaves =NumOctave; %# of octaves above and below the central frequency.
bflog=log2(bf);
toprange=bflog+numoctaves;
bottomrange=bflog-numoctaves;
range=2*numoctaves;
increment=range/100;
for trials=1:101
    freqmap(trials)=bottomrange+(increment*(trials-1));
    levels(trials)=tonelevel;
end
for trials=1:9
    freqmap(trials+101)=bflog;
    levels(trials+101)=0;
end

%Sort into random order
freqmap=pow2(freqmap);
randint=randperm(110);
for trials=1:110
    freqmap2(trials)=freqmap(randint(trials));
    tonelevel2(trials)=levels(randint(trials));
end

for bftlevels=1:length(freqmap2)
        freq(bftlevels)= freqmap2(bftlevels);
        tlvl(bftlevels)= tonelevel2(bftlevels);
        nlvl(bftlevels)= noiselevel;
        modf(bftlevels)= modfreq;
end
a= length(freq);
fprintf(fid1,'%g\n',freq);
fprintf(fid2,'%g\n',tlvl);
fprintf(fid3,'%g\n',nlvl);
fprintf(fid4,'%g\n',modf);
fclose all;

