function [BootstrappedDataOut]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd)

GreaterThanCount=0;
EqualToCount=0;
for i=1:length(NormPRwd)
    for j=1:length(NormPUrwd)
        if NormPRwd(i)>NormPUrwd(j)
            GreaterThanCount=GreaterThanCount+1;        
        elseif NormPRwd(i)==NormPUrwd(j)
            EqualToCount=EqualToCount+1;
            
        end        
    end    
end
DI=(GreaterThanCount+.5*EqualToCount)/(length(NormPRwd)*length(NormPUrwd)); 



NumberOfTimesBootstrapped=1000;
NumberRwd=length(NormPRwd);
NumberUnrwd=length(NormPUrwd);
AllRxnTimes=[NormPRwd,NormPUrwd];
ResampledDI=zeros(1,NumberOfTimesBootstrapped);
for a=1:NumberOfTimesBootstrapped
    NewRwd=NormPRwd*0;
    NewURwd=NormPUrwd*0;
    for i=1:length(NumberRwd)
        NewRwd(i)=AllRxnTimes(round(rand(1)*(length(AllRxnTimes)-1)+1));
    end
    
    for i=1:length(NumberUnrwd)
        NewURwd(i)=AllRxnTimes(round(rand(1)*(length(AllRxnTimes)-1)+1));
    end
    
    %Have two new arrays of equal lengths, now calculate DI
    
    %making an array of just rxn times for rwd and unrwd
    
    %PRwd=NewRwd; 
    %PUrwd=NewURwd;
    
    NormPRwd=NewRwd;
    NormPUrwd=NewURwd;
    GreaterThanCount=0;
    EqualToCount=0;
    for i=1:length(NormPRwd)
        for j=1:length(NormPUrwd)
            if NormPRwd(i)>NormPUrwd(j)
                GreaterThanCount=GreaterThanCount+1;
            elseif NormPRwd(i)==NormPUrwd(j)
                EqualToCount=EqualToCount+1;
            end
        end
    end

    ResampledDI(a)=(GreaterThanCount+.5*EqualToCount)/(length(NormPRwd)*length(NormPUrwd));
end
ResampledDI;

p=length(find(ResampledDI>DI))/NumberOfTimesBootstrapped;




BootstrappedDataOut=[DI,p];
