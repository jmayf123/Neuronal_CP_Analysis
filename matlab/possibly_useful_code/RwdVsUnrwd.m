function []=RwdVsUnrwd(AllArray,threshold)
%Condition one: All trials
%Condition two: W/Out Catch Trials
%Condition three: RxnTimes>Threshold
%Condition four: RxnTimes>Threshold-4

AllArray(6,:)=AllArray(1,:)*0;
UniqueLevels=unique(AllArray(2,:));
NumberUnique_dB=length(UniqueLevels);

for i=1:length(UniqueLevels)    
    Indeces=find(AllArray(2,:)==UniqueLevels(i));
    RespIndeces=find(AllArray(4,Indeces)==1);
    RespIndeces=Indeces(RespIndeces);     
    %Computation to NORMALIZE Reaction Times!!!!!
    AllArray(6,RespIndeces)=(AllArray(5,RespIndeces)-min(AllArray(5,RespIndeces)))/...
       (max(AllArray(5,RespIndeces))-min(AllArray(5,RespIndeces)));
end

%*************************************************************************************************************
%*************************************************************************************************************  


[PrevRewd, PrevUnrewd]=RwdVsUnrwdSort(AllArray);
NormPRwd=PrevRewd(6,:); %making an array of NORMALIZED rxn times for rwd and unrwd!!!!!
NormPUrwd=PrevUnrewd(6,:);
[BootstrappedDataOut1]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);


%*************************************************************************************************************  
%*************************************************************************************************************  
AbvThrshArray=AllArray(:,find(AllArray(2,:)~=-inf)); %#ok<*FNDSB>
[PrevRewd1, PrevUnrewd1]=RwdVsUnrwdSort(AbvThrshArray);
NormPRwd=PrevRewd1(6,:); %making an array of NORMALIZED rxn times for rwd and unrwd
NormPUrwd=PrevUnrewd1(6,:);
[BootstrappedDataOut2]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);

%*************************************************************************************************************  
%*************************************************************************************************************  
AbvThrshWoutCTArray=AbvThrshArray(:,find(AbvThrshArray(2,:)>threshold));
[PrevRewd2, PrevUnrewd2]=RwdVsUnrwdSort(AbvThrshWoutCTArray);
NormPRwd=PrevRewd2(6,:); %making an array of NORMALIZED rxn times for rwd and unrwd
NormPUrwd=PrevUnrewd2(6,:);
[BootstrappedDataOut3]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);
%*************************************************************************************************************  
%*************************************************************************************************************  
AbvThrshWoutCTArray=AbvThrshArray(:,find(AbvThrshArray(2,:)>(threshold-4)));
[PrevRewd3, PrevUnrewd3]=RwdVsUnrwdSort(AbvThrshWoutCTArray);
NormPRwd=PrevRewd3(6,:); %making an array of NORMALIZED rxn times for rwd and unrwd
NormPUrwd=PrevUnrewd3(6,:);

[BootstrappedDataOut4]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);
%*************************************************************************************************************    
%*************************************************************************************************************  
figure

subplot(2,2,1)
hold on
PrevRewd=PrevRewd(:,find(PrevRewd(2,:)>-1000));
p=polyfit(PrevRewd(2,:),PrevRewd(5,:),1);
r = p(1) .* PrevRewd(2,:) + p(2);
plot(PrevRewd(2,:),r,'r-')
PrevUnrewd=PrevUnrewd(:,find(PrevUnrewd(2,:)>-1000));
p=polyfit(PrevUnrewd(2,:),PrevUnrewd(5,:),1);
r = p(1) .* PrevUnrewd(2,:) + p(2);
plot(PrevUnrewd(2,:),r,'b:')
plot(PrevRewd(2,:),PrevRewd(5,:),'r.',PrevUnrewd(2,:),PrevUnrewd(5,:),'bp')

hold off

subplot(2,2,2)
hold on
p=polyfit(PrevRewd1(2,:),PrevRewd1(5,:),1);
r = p(1) .* PrevRewd1(2,:) + p(2);
plot(PrevRewd1(2,:),r,'r-')
p=polyfit(PrevUnrewd1(2,:),PrevUnrewd1(5,:),1);
r = p(1) .* PrevUnrewd1(2,:) + p(2);
plot(PrevUnrewd1(2,:),r,'b:')
plot(PrevRewd1(2,:),PrevRewd1(5,:),'r.',PrevUnrewd1(2,:),PrevUnrewd1(5,:),'bp')
hold off

subplot(2,2,3)
hold on
p=polyfit(PrevRewd2(2,:),PrevRewd2(5,:),1);
r = p(1) .* PrevRewd2(2,:) + p(2);
plot(PrevRewd2(2,:),r,'r-')
p=polyfit(PrevUnrewd2(2,:),PrevUnrewd2(5,:),1);
r = p(1) .* PrevUnrewd2(2,:) + p(2);
plot(PrevUnrewd2(2,:),r,'b:')
plot(PrevRewd2(2,:),PrevRewd2(5,:),'r.',PrevUnrewd2(2,:),PrevUnrewd2(5,:),'bp')
hold off

subplot(2,2,4)
hold on
p=polyfit(PrevRewd3(2,:),PrevRewd3(5,:),1);
r = p(1) .* PrevRewd3(2,:) + p(2);
plot(PrevRewd3(2,:),r,'r-')
p=polyfit(PrevUnrewd3(2,:),PrevUnrewd3(5,:),1);
r = p(1) .* PrevUnrewd3(2,:) + p(2);
plot(PrevUnrewd3(2,:),r,'b:')
plot(PrevRewd3(2,:),PrevRewd3(5,:),'r.',PrevUnrewd3(2,:),PrevUnrewd3(5,:),'bp')
hold off


%*************************************************************************************************************    
%*************************************************************************************************************  
%%%%%%%%% CODE HERE: instead of looking at previously unrewarded vs
%%%%%%%%% rewarded, now we want to look at what happens with the next
%%%%%%%%% trial? Is there any trend? So we are looking at rxn time based on
%%%%%%%%% Next trial being rewarded or not. Ignore variable lables as code
%%%%%%%%% was copied and pasted. 

[PrevRewd, PrevUnrewd]=FRwdVsUnrwdSort(AllArray);
NormPRwd=PrevRewd(6,:); %making an array of NORMALIZED rxn times for rwd and unrwd
NormPUrwd=PrevUnrewd(6,:);
[BootstrappedDataOut5]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);  
%*************************************************************************************************************    
%*************************************************************************************************************  
AbvThrshArray=AllArray(:,find(AllArray(2,:)~=-inf));
[PrevRewd1, PrevUnrewd1]=FRwdVsUnrwdSort(AbvThrshArray);
NormPRwd=PrevRewd1(6,:);  %making an array of NORMALIZED rxn times for rwd and unrwd
NormPUrwd=PrevUnrewd1(6,:);
[BootstrappedDataOut6]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);
%*************************************************************************************************************    
AbvThrshWoutCTArray=AbvThrshArray(:,find(AbvThrshArray(2,:)>threshold));
[PrevRewd2, PrevUnrewd2]=FRwdVsUnrwdSort(AbvThrshWoutCTArray);
NormPRwd=PrevRewd2(6,:); %making an array of NORMALIZED rxn times for rwd and unrwd
NormPUrwd=PrevUnrewd2(6,:);
[BootstrappedDataOut7]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);
%*************************************************************************************************************    
AbvThrshWoutCTArray=AbvThrshArray(:,find(AbvThrshArray(2,:)>(threshold-4)));
[PrevRewd3, PrevUnrewd3]=FRwdVsUnrwdSort(AbvThrshWoutCTArray);
NormPRwd=PrevRewd3(6,:); %making an array of NORMALIZED rxn times for rwd and unrwd
NormPUrwd=PrevUnrewd3(6,:);
[BootstrappedDataOut8]=RwdVsUnrwdBootstrap(NormPRwd,NormPUrwd);

%*************************************************************************************************************    
%*************************************************************************************************************  
%Ploting data
figure
subplot(2,2,1)
hold on
PrevRewd=PrevRewd(:,find(PrevRewd(2,:)>-1000));
p=polyfit(PrevRewd(2,:),PrevRewd(5,:),1);
r = p(1) .* PrevRewd(2,:) + p(2);
plot(PrevRewd(2,:),r,'r-')
PrevUnrewd=PrevUnrewd(:,find(PrevUnrewd(2,:)>-1000));
p=polyfit(PrevUnrewd(2,:),PrevUnrewd(5,:),1);
r = p(1) .* PrevUnrewd(2,:) + p(2);
plot(PrevUnrewd(2,:),r,'b:')
plot(PrevRewd(2,:),PrevRewd(5,:),'r.',PrevUnrewd(2,:),PrevUnrewd(5,:),'bp')
hold off

subplot(2,2,2)
hold on
p=polyfit(PrevRewd1(2,:),PrevRewd1(5,:),1);
r = p(1) .* PrevRewd1(2,:) + p(2);
plot(PrevRewd1(2,:),r,'r-')
p=polyfit(PrevUnrewd1(2,:),PrevUnrewd1(5,:),1);
r = p(1) .* PrevUnrewd1(2,:) + p(2);
plot(PrevUnrewd1(2,:),r,'b:')
plot(PrevRewd1(2,:),PrevRewd1(5,:),'r.',PrevUnrewd1(2,:),PrevUnrewd1(5,:),'bp')
hold off

subplot(2,2,3)
hold on
p=polyfit(PrevRewd2(2,:),PrevRewd2(5,:),1);
r = p(1) .* PrevRewd2(2,:) + p(2);
plot(PrevRewd2(2,:),r,'r-')
p=polyfit(PrevUnrewd2(2,:),PrevUnrewd2(5,:),1);
r = p(1) .* PrevUnrewd2(2,:) + p(2);
plot(PrevUnrewd2(2,:),r,'b:')
plot(PrevRewd2(2,:),PrevRewd2(5,:),'r.',PrevUnrewd2(2,:),PrevUnrewd2(5,:),'bp')
hold off

subplot(2,2,4)
hold on
p=polyfit(PrevRewd3(2,:),PrevRewd3(5,:),1);
r = p(1) .* PrevRewd3(2,:) + p(2);
plot(PrevRewd3(2,:),r,'r-')
p=polyfit(PrevUnrewd3(2,:),PrevUnrewd3(5,:),1);
r = p(1) .* PrevUnrewd3(2,:) + p(2);
plot(PrevUnrewd3(2,:),r,'b:')
plot(PrevRewd3(2,:),PrevRewd3(5,:),'r.',PrevUnrewd3(2,:),PrevUnrewd3(5,:),'bp')
hold off

%[TimeSinceRew,TimeSinceURew]=TimeSinceLastRwd(AllArray);
%*************************************************************************************************************  
BootstrappedDataOut=vertcat(BootstrappedDataOut1,BootstrappedDataOut2,BootstrappedDataOut3,BootstrappedDataOut4,BootstrappedDataOut5,BootstrappedDataOut6,BootstrappedDataOut7,BootstrappedDataOut8)


