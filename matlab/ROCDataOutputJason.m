function []= ROCDataOutputJason(ArrayIn,MyTank,MyBlock,tlvls,Sorted, NeuroThresh)
v0 = .79/(10^(74/20));

MyTank=MyTank(end-6:end);
ArrayIn=rot90(ArrayIn);
[NumberRows,NumberColumns]=size(ArrayIn);
Array2=flipud(ArrayIn);

for i=1:NumberColumns-1
    Dirrectory= ['C:\Users\Chris Rice\Desktop\VowelData\Charlie\IC\',...
        ' Block', num2str(MyTank) , num2str(MyBlock),' ', ' Tlvl ' num2str(tlvls(1,i)),'.txt'];
    
    OutArray(1,:)=flipud(ArrayIn(:,1));
    OutArray(2,:)=flipud(ArrayIn(:,i+1));
    
    fid=fopen(Dirrectory, 'w+');
    
    for j=1:NumberRows
        
        fprintf(fid, '%d\t', OutArray(1,j));
        fprintf(fid, '%d\r\n', OutArray(2,j));
        
        
    end
    fclose(fid);
end
    

Dirrectory=['C:\Users\Chris Rice\Documents\GUIde\Firing Rate Comp\',...
        ' Block', num2str(MyTank) , num2str(MyBlock),' FiringRates.txt'];

[NumberTrials, NumberTones]=size(tlvls);
SpikeMean=zeros(1,length(NumberTones));
SpikeStd=SpikeMean;
for i=1:NumberTones
    SpikeMean(i)=nanmean(tlvls(2:end,i));
    SpikeStd(i)=nanstd(tlvls(2:end,i))  ;  
end

SpikeData=([tlvls(1,:);SpikeMean;SpikeStd]);
for i=1:length(SpikeData)
    SpikeData(1,i) = 20*log10((SpikeData(1,i))/v0);
end
SpikeData=rot90(SpikeData);

fid=fopen(Dirrectory, 'w+');
for i=1:NumberTones    
    fprintf(fid, '%d\t', SpikeData(i,1));
    fprintf(fid, '%d\t', SpikeData(i,2));
    fprintf(fid, '%d\r\n', SpikeData(i,3));
end
fclose(fid);

abc=Sorted;
SortedPlotter=Sorted;
for i=1:length(Sorted)
    if Sorted(3,i)==2
        SortedPlotter(:,i)=NaN;
    end
    if Sorted(5,i)>.5
        SortedPlotter(:,i)=NaN;
    end
    if Sorted(5,i)<.2
        SortedPlotter(:,i)=NaN;
    end
end



for i=1:length(SortedPlotter)
    SortedPlotter(1,i) = 20*log10((SortedPlotter(1,i))/v0);
end

SortedPlotter=RemoveNans(SortedPlotter);
SortedPlotter=SortAscending(SortedPlotter);

Sorted=rot90(SortedPlotter);



%print out reaction times in order of decible level 
Dirrectory=['C:\Users\Chris Rice\Documents\GUIde\Firing Rate Comp\',...
        ' Block', num2str(MyTank) , num2str(MyBlock),' Reaction Times.txt'];
fid=fopen(Dirrectory, 'w+');
for i=1:length(SortedPlotter)    
    fprintf(fid, '%d\t', Sorted(i,1));
    fprintf(fid, '%d\t', Sorted(i,4));
    fprintf(fid, '%d\r\n', Sorted(i,5));
end
fclose(fid);


p=polyfit(SortedPlotter(1,:),SortedPlotter(5,:),1);
r = p(1) .* SortedPlotter(1,:) + p(2);
p2=polyfit(SortedPlotter(4,:),SortedPlotter(5,:),1);
r2 = p2(1) .* SortedPlotter(4,:) + p2(2);

% figure
% scatter(SortedPlotter(1,:),SortedPlotter(5,:))


%print out reaction time fit
Dirrectory=['C:\Users\Chris Rice\Documents\GUIde\Firing Rate Comp\',...
    ' Block', num2str(MyTank) , num2str(MyBlock),' Reaction Time Fit.txt'];
fid=fopen(Dirrectory, 'w+');
for i=1:length(SortedPlotter)
    fprintf(fid, '%d\t', SortedPlotter(4,i));
    fprintf(fid, '%d\r\n', r2(i));
end
fclose(fid);



DesiredData=WhatTheFuck(SortedPlotter);
a=length(DesiredData);
DesiredData=(rot90(DesiredData));

Dirrectory=['C:\Users\Chris Rice\Documents\GUIde\Firing Rate Comp\',...
    ' Block', num2str(MyTank) , num2str(MyBlock),' Reaction Time Means.txt'];
fid=fopen(Dirrectory, 'w+');
for i=1:a
    fprintf(fid, '%d\t', DesiredData(i,1));
    fprintf(fid, '%d\t', DesiredData(i,2));
    fprintf(fid, '%d\r\n', DesiredData(i,3));
end
fclose(fid);


abc(1,:)=20.*log10((abc(1,:))/v0);
abc=SortAscending(abc);
a=length(abc);
Dirrectory=['C:\Users\Chris Rice\Documents\GUIde\Firing Rate Comp\',...
    ' Block', num2str(MyTank) , num2str(MyBlock),' Responses and Spikes'];
fid=fopen(Dirrectory, 'w+');
for i=1:a
    fprintf(fid, '%d\t', abc(1,i));
    fprintf(fid, '%d\t', abc(3,i));
    fprintf(fid, '%d\r\n', abc(4,i));
end
fclose(fid);




function x=RemoveNans(x) %and inf's from columns
x=rot90(x);
x(any(isnan(x),2),:) = [];
x(any(isinf(x),2),:) = [];
x=rot90(x,3);


function output=SortAscending(x)
[d1,d2]=sort(round(x(1,:)));
output=x(:,d2);

function Output = WhatTheFuck(Input)    %Send Array in horizontally with Tone Levels on TOP 
tones=unique(Input(1,:));               %This rediculous code finds the mean rxn time with std 
Mean=zeros(length(tones));              %for each individual tone level. TADAAAA. 
Std=Mean;
for i=1:length(tones) 
    try
        Locations=find(round(Input(1,:)),round(tones(i)));
    catch
        Locations=find(round(Input(1,:)),(-1*round(tones(i))));
    end
        Temporary=zeros(length(Locations));
   for j=1:length(Locations)
       Temporary(1,j)=Input(5,Locations(j));
   end   
   Mean(1,i)=mean(Temporary(1,:));
   Std(1,i)=std(Temporary(1,:));
end
Output=[tones(1,:);Mean(1,:);Std(1,:)];




