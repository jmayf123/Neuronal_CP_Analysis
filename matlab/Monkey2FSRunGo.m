function [Count,Tank,BlockNumber,flag]= Monkey2FSRunGo(b,RorP)      %***********  
%b is orderd Data={[2], CF,ToneLevel,Octave,NoiseV,[],[]};
MatlabAudio=1;
ModNoiseTF=0;
LowerFreq=b{2};
UpperFreq=b{3};
NumPulses=b{4};
StepSize=b{5};
Order=b{6};
NeuralOnly=1; 
FSType=1;

        
Count=Monkey2SearchFilemaker(LowerFreq,UpperFreq,StepSize,Order,NumPulses);



flag=0;


% [MonkeyName,BlockNumber,DataType,flag, Tank]=MonkeyControlsWorld(0,0,...
%     0,0,0,0,...
%     0,NeuralOnly,MatlabAudio,FSType);

[MonkeyName,BlockNumber,DataType,flag, Tank]=MonkeyControlsWorld(0,0,...
    0,0,0,0,...
    0);


