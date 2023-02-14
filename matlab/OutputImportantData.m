function [] =OutputImportantData(HitRateData,PCData,Monkey,...
    Date,BlockNumber,Responses,levl,freq,threshold)


%  prompt = {'Tone Duration Length in ms'};
% dlg_title = 'Input';
% num_lines = 1;
% def = {'200'};
% phase = inputdlg(prompt,dlg_title,num_lines,def)
% if isempty(phase)
%      phase='200';
% end

HitRateData(1,:)=PCData(2,:);
HitRateVsLevel=rot90(HitRateData([1,5],2:end));
PCData(:,1)=[];
PCData=rot90(flipud(PCData));
num2str(mode(freq(1,:)));


% Dirrectory1=['C:\Documents and Settings\user1\My Documents\GUIde\DurationData\',Monkey,' ',...
%     num2str(mode(freq(1,:))),'hz ',num2str(Date(1:6)) ,'-',num2str(BlockNumber),' ',phase{1},'ms HitRate vs Level.txt'];
% 
% fid=fopen(Dirrectory1, 'w+');
% 
% for i=1:length(HitRateVsLevel(:,1))    
%     fprintf(fid, '%f\t', HitRateVsLevel(i,1));
%     fprintf(fid, '%f\r\n', HitRateVsLevel(i,2));
% end
% fclose(fid);



% Dirrectory1=['C:\Documents and Settings\user1\My Documents\GUIde\DurationData\',Monkey,' ',...
%     num2str(mode(freq(1,:))),'hz ',num2str(Date(1:6)) ,'-',num2str(BlockNumber),' ',phase{1},'ms ProbCorr vs Level.txt'];
% 
% fid=fopen(Dirrectory1, 'w+');
% 
% for i=1:length(PCData(:,1))    
%     fprintf(fid, '%f\t', PCData(i,1));
%     fprintf(fid, '%f\r\n', PCData(i,2));
% end
% fclose(fid);


for i=1:length(levl(1,:))   
    TrueCases=find(Responses(2,:)>levl(2,i));
    if ~isempty(TrueCases)
        levl(3,i)=Responses(1,TrueCases(1));
        levl(4,i)=Responses(2,TrueCases(1))-levl(2,i);    
    end
end



levl(1,:)=round(dBtoSPL(levl(1,:),length(levl(1,:))));

[levl(1,:),Indeces]=sort(levl(1,:));
levl(2:end,:)=levl(2:end,Indeces);
a=find(levl(3,:)==1);
CorrectResponses=levl([1,4],a);
ReactionMode=mode(levl(4,:));

DeleteThese=find(CorrectResponses(2,:)>ReactionMode);
CorrectResponses(:,DeleteThese)=[];

deletethis=find(CorrectResponses(1,:)<(threshold-4));
CorrectResponses(:,deletethis)=[];

figure


scatter(CorrectResponses(1,:),CorrectResponses(2,:))


 RT10=[];
% % MEAN OR MEDIAN RT AT ONE LEVEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this loop allocates RTs at a given range of levels 
for i_medRT=1:length(CorrectResponses)
    if CorrectResponses(1,i_medRT)>54&&CorrectResponses(1,i_medRT)<58
        RT10(1,i_medRT)=CorrectResponses(2,i_medRT);
    else
        continue
    end
end
RT10(:,~any(RT10,1))=[]; %% deletes zeros
% meanRT=mean(RT10)
% stdRT=std(RT10)
medRT=median(RT10)

%displays warning if too few rep    
if length(RT10)<=9
    disp('less than 10 reps in this RT')
end



%Comment the following in or out if you want reaction time vs level

Dirrectory1=['C:\My Documents\GUIde\DurationData\',Monkey,' ',...
    num2str(mode(freq(1,:))),'hz ',num2str(Date(1:6)) ,'-',num2str(BlockNumber),' 200 ms Reaction Time Vs. Level.txt'];

% fid=fopen(Dirrectory1, 'w+');
% for i=1:length(CorrectResponses(1,:))    
%     fprintf(fid, '%f\t', CorrectResponses(1,i));
%     fprintf(fid, '%f\r\n', CorrectResponses(2,i));
% end
% fclose(fid);
levl;

%%%%%%%%%linear fit of RT vs lvl%%%%%%%%%%%%%%%%%%%%%%
p=polyfit(CorrectResponses(1,:),CorrectResponses(2,:),1);

r = p(1) .* CorrectResponses(1,:) + p(2);
slope=p(1);
RTint=p(2)
ReactionTimeSlope=slope
hold on
plot (CorrectResponses(1,:),r)
% Dirrectory1=['C:\Documents and Settings\user1\My Documents\GUIde\DurationData\',Monkey,' ',...
%     num2str(mode(freq(1,:))),'hz ',num2str(Date(1:6)) ,'-',num2str(BlockNumber),' Reaction Time Fit.txt'];
% fid=fopen(Dirrectory1, 'w+');
% 
% fprintf(fid,'%s\r\n',['Slope equals ',num2str(slope)]);
% 
% for i=1:length(CorrectResponses(1,:))
%     fprintf(fid, '%f\t', CorrectResponses(1,i));
%     fprintf(fid, '%f\r\n', r(i));
% end
% fclose(fid);
