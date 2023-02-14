%This program generates 4 files to create bf rate level function;
% One contains Tone frequencies, one contains tone levels,
% the third contains noise levels, which are set to zero.
% the fourth contains modulation frequencies to study temporal sensitivity.
function [Steps] = MonkeySearchFilemaker(StartFreqIn,EndFreqIn,OctaveStepIn,Order,Pulses)
nlvl=0;
modf=0;

 % modulation frequency of tone
StartFreq=StartFreqIn;
EndFreq=EndFreqIn;
Freq(1)=StartFreq;
Pulses=Pulses;
%Start with freq array increasing by octave steps 

OctaveStep=OctaveStepIn;
CompFreq=StartFreq;
i=1;
while CompFreq<EndFreq    
    Freq(i+1)=StartFreq*2^((i)*OctaveStep);
    CompFreq=StartFreq*2^((i)*OctaveStep);
    i=i+1;
end
Freq(i)=EndFreq;
Steps=length(Freq);
count=Steps*Pulses;
n=0;
count3=1;
while n<Steps  
    n=n+1;
    count2=0;
    while count2<Pulses
        FreqArray(count3)=Freq(n);
        count2=count2+1;
        count3=count3+1;
    end
end
FinalFreq=FreqArray;
for iteration=1:15,
    FinalFreq =horzcat(FinalFreq,FreqArray);
end
if Order==2
    FinalFreq=rot90(FinalFreq, 2);
end
fid1=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\Freq2List.txt','wt');
fid2=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\Levl2List.txt','wt');
fid3=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\Nlvl2List.txt','wt');
fid4=fopen('C:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\UserFiles\Modf2List.txt','wt');

for numreps=1:length(FinalFreq), 
        freq(numreps)= FinalFreq(numreps);
        tlvl(numreps)= 0;
        nlvl(numreps)= 0;
        modf(numreps)= 0;
end

fprintf(fid1,'%g\n',freq);
fprintf(fid2,'%g\n',tlvl);
fprintf(fid3,'%g\n',nlvl);
fprintf(fid4,'%g\n',modf);
fclose all;
