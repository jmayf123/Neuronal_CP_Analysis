%% Lesson 10: ROC analysis of neuronal responses
%
% The general purpose of ROC analysis is to provide a measure of the
% difference between two distributions. For example, Britten et al. (1992)
% originally used an ROC analysis to determine how well a neuron can
% 'discriminate' between two stimuli. In this lesson we'll apply an ROC
% analysis to example spike data measure a neuron's 'neurometric function'.


%% The Neurophysiological Data
%
% Britten et al. (J. Neurosci, 1992) measured the spike rates from
% direction selective neurons in Macaque area MT with the goal of comparing
% these neuronal responses to the monkey's behavioral data on the same
% motion coherence task that we developed in the previous lessons.
%
% Their goal was to compare this behavioral data to the MT responses to see
% how well the results from an individual neuron can predict the behavioral
% data.
%
% The data set consists of the number of spikes measured in each of 60
% trials across five coherence values (.8,1.6,3.2,6.4 and 12.8%) with
% motion either in the preferred direction or in the direction opposite to
% the preferred direction of the neuron.
%
% I've generated a fake data set with numbers that are similar to the
% example neuron they show in their figure 5.  We'll load it in now:

%Example Data a = Correct , b = Incorrect 
% a = [0,0.000111590001324657,0.000264622998656705,0.000470572995254770,0.000627518980763853,0.000836809980683029,0.00111589999869466,0.00148808001540601,0.00198438996449113,0.00264622992835939,0.00470572989434004,0.0111589999869466;NaN,NaN,NaN,51,63,47,59,57,59,76,84,67;NaN,NaN,NaN,39,40,53,49,66,78,68,84,78;NaN,NaN,NaN,NaN,57,49,50,61,62,55,74,78;NaN,NaN,NaN,NaN,44,57,45,51,59,75,81,75;NaN,NaN,NaN,NaN,34,54,71,47,62,63,84,85;NaN,NaN,NaN,NaN,46,45,45,62,56,54,71,90;NaN,NaN,NaN,NaN,43,43,71,58,59,59,67,76;NaN,NaN,NaN,NaN,51,38,47,61,73,60,83,77;NaN,NaN,NaN,NaN,49,37,41,53,53,72,67,77;NaN,NaN,NaN,NaN,NaN,73,45,59,56,65,77,79;NaN,NaN,NaN,NaN,NaN,56,64,50,60,46,65,71;NaN,NaN,NaN,NaN,NaN,NaN,NaN,41,54,81,63,86;NaN,NaN,NaN,NaN,NaN,NaN,NaN,51,58,68,70,85;NaN,NaN,NaN,NaN,NaN,NaN,NaN,59,70,65,76,71;NaN,NaN,NaN,NaN,NaN,NaN,NaN,76,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
% b = [0,0.000111590001324657,0.000264622998656705,0.000470572995254770,0.000627518980763853,0.000836809980683029,0.00111589999869466,0.00148808001540601,0.00198438996449113,0.00264622992835939,0.00470572989434004,0.0111589999869466;27,25,39,43,54,46,49,NaN,66,NaN,69,75;30,31,37,33,26,38,38,NaN,NaN,NaN,NaN,NaN;35,31,28,37,36,37,31,NaN,NaN,NaN,NaN,NaN;27,29,30,26,34,NaN,60,NaN,NaN,NaN,NaN,NaN;30,26,39,29,30,NaN,NaN,NaN,NaN,NaN,NaN,NaN;34,21,23,31,32,NaN,NaN,NaN,NaN,NaN,NaN,NaN;29,41,34,39,36,NaN,NaN,NaN,NaN,NaN,NaN,NaN;32,29,20,35,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;31,37,36,33,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;25,28,31,32,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;20,33,30,29,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;25,17,32,24,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;28,NaN,33,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;32,NaN,28,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;33,NaN,28,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;27,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;40,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;29,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;34,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;19,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;25,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;23,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;32,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;33,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;22,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;28,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;22,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;29,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;22,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;0,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN;NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN,NaN];
function [ChoiceProbabilities , Grand_ChoiceProbability, p] = CP(a,b,tlvls)
 %hold off
[new_tlvlsC,new_tlvlsI] = Reshaped(a,b); %Finds data where there are >= 3 trials for each of Correct and Incorrect and reshapes data for use in ROC/CP

cList = new_tlvlsC(1,:); %List of tone levels where there are >= 3 trials for each of Correct and Incorrect

Correct = new_tlvlsC(2:end,:); %Takes away the first row which is the corresponding tone level, and leaves the spike data for Correct and Incorrect Trials
Incorrect = new_tlvlsI(2:end,:);



respPref = Correct'; 
respNonPref = Incorrect';

%%
% The file 'NeuroData' contains three parameters:
%
%  cList: the list of five coherence values
%
%  respPref: of size 5x60 where each row corresponds to a coherence value
%  and each column corresponds to a trial.  The values are the total
%  number of spikes for that trial for a stimulus in the preferred
%  direction.
%
%  respNonPref: same thing but for motion in the non-preferred direction.

%%
% First, let's look at histograms of the data, plotted like Britten et
% al.'s figure 5:

% figure(1)
% clf
% for i=1:length(cList)
%     subplot(length(cList),1,length(cList)-i+1)
%     %hist([respPref(i,:);respNonPref(i,:)]',linspace(0,150,40));
%      hist1 = histogram(respPref(i,:));
%     hold on
%      hist2 = histogram(respNonPref(i,:));
%     %set(gca,'XLim',[0,150]);
%     hist1.BinWidth = 5; 
%     hist2.BinWidth = 5; 
%     
%     title(sprintf('Tone Level %i ',cList(i)),'FontSize',12)
%     if i==1
%         xlabel('Response (spikes/trial)','FontSize',12);
%     end
%     set(gca,'FontSize',12);
% end

%set(gcf,'Position',[220    50   601   680]);

%%
% Blue bars in the histograms correspond to responses in the preferred
% direction and red bars are for the non-preferred direction.  Notice how
% the histograms spread apart as the coherence increases.  The neurons are
% responding more with increased coherence in the preferred direction and
% are becoming suppressed with increased coherence in the non-preferred
% direction.  This means that, loosely speaking, the neuron more and more
% able to 'discriminate' between the two stimuli with increasing coherence.
%
% Like humans, the monkey's behavioral performance increased with motion
% coherence.  So at least qualitatively, the neuronal responses are
% consistent with the behavioral results.  But how do we quantify the
% performance of the neuron?  Specifically, for a given motion coherence,
% how well could you do in the task if all you knew about the stimulus were
% the responses shown in the histogram above?
%
% The answer can be found with an ROC analysis. We can think of the
% analysis as an ideal observer performing a 'yes/no' task on samples from
% the data.  Suppose this observer receives a spike count from a stimulus
% that had, say, 1.6% coherence.  The observer must choose a criterion and
% decide that the stimulus was in the preferred direction if the response
% exceeds this criterion, otherwise it must have been a non-preferred
% stimulus.  We can calculate how well this observer will do on the task
% based on the data:
%
% To be specific, let's choose a criterion of 50 spikes/sec:

%  criterion =50;

%%


% cNum = 1;  %index into the 0.8% coherence row

% Find the Max number of trials for Both Correct and Incorrect Responses 
counterC = zeros(1,length(new_tlvlsC(1,:)));
for j = 1:length(new_tlvlsC(1,:))
    for i = 2:length(new_tlvlsC(:,j))
        if isnan(new_tlvlsC(i,j)) == 0
            counterC(j) = counterC(j) + 1;
        end    
    end
end
counterI = zeros(1,length(new_tlvlsI(1,:)));
for j = 1:length(new_tlvlsI(1,:))
    for i = 2:length(new_tlvlsI(:,j))
        if isnan(new_tlvlsI(i,j)) == 0
            counterI(j) = counterI(j) + 1;
        end    
    end
end


    
% The proportion of 'hits' will be the proportion of times that a preferred
% stimulus produces a response greater than the criterion:

% pHit = sum(respPref(cNum,:)>criterion)/nTrials
% 
% % The proportion of false alarms will be the proportion of spike counts
% % from the non-preferred data that exceeds the criterion:
% 
% pFA = sum(respNonPref(cNum,:)>criterion)/nTrials

%%
% This is the expected performance for this one value of the criterion.  To
% estimate the overall performance, we make this calculation for the whole
% range of criterion values which will generate an ROC curve.  We'll do
% this for each of the coherence values in a nested loop:

critList = 0:max(respPref(:));   %list of criterion values

pHit = zeros(length(critList),length(cList));
pFA =  zeros(length(critList),length(cList));
for cNum = 1:length(cList)
    for critNum = 1:length(critList)
        nTrialsC = counterC(cNum);
        nTrialsI = counterI(cNum);
        criterion = critList(critNum);
        pHit(critNum,cNum) = sum(respPref(cNum,:)>criterion)/nTrialsC;
        pFA(critNum,cNum) = sum(respNonPref(cNum,:)>criterion)/nTrialsI;
    end
end

%Let's plot the ROC curve for all coherences(tone levels):

% figure(2)
% 
% plot(pFA,pHit,'.-');
% legend(num2str(cList'*100),'Location','SouthEast');
% set(gca,'XLim',[0,1]);
% set(gca,'YLim',[0,1]);
% xlabel('p(null>crit)');
% ylabel('p(pref>crit)');
% set(gca,'XTick',0:.2:1);
% set(gca,'YTick',0:.2:1);
% hold on
% plot([0,1],[0,1],'k-');
% axis square

%%
% Notice how the ROC curve bows out more and more for higher coherence
% values.  Remember, the area under the curve reflects the difference
% between the preferred and non-preferred distributions.  Let's calculate
% these values using the 'trapz' function:

% This is the CP list for each tone level 
ChoiceProbabilities = zeros(2,length(cList)); 
ChoiceProbabilities(1,:) = cList;
for i=1:length(cList)
    ChoiceProbabilities(2,i) = -trapz(pFA(:,i),pHit(:,i));
end

%% Now lets do the grand CP calculation for all tone lvls instead of individual CPs 
% Z score the data for each of the tone lvls for both Correct (respPref) and Incorrect (respNonpref),
%after z scoring columnwise for each tone levl, we can put these z scores into a total Correct and total Incorrect  


% z_Correct = reshape(z_spikes_tlvls_C,[],1);
% z_Incorrect = reshape(z_spikes_tlvls_I,[],1);
% 
% z_Correct = rmmissing(z_Correct);
% z_Incorrect = rmmissing(z_Incorrect);  

%mean Value for the Zero Voltage tone level (Quiet Tone)
zero_voltage_spikes = rmmissing(tlvls(2:end,1));
norm_zero_voltage_spikes = normalize(zero_voltage_spikes);
mean_quiet = mean(zero_voltage_spikes);
std_quiet = std(zero_voltage_spikes); 


%take the z score for each tone level, so we need columnwise
%z scores for these instead of entire
%array z score, 
%this also provides each of the mu and sigma for each tone level for both 
%correct and incorrect distrubutions 

% old way of zscoring to the no tone/quiet response
% for k = 1:length(cList) 
% 
%         if any(isnan(Correct(:,k)))
%             C_mu(k)=nanmean(Correct(:,k));
%             C_sigma(k)=nanstd(Correct(:,k));
%             z_spikes_tlvls_C(:,k)=(Correct(:,k)-repmat(mean_quiet,length(Correct(:,k)),1))./repmat(C_sigma(k),length(Correct(:,k)),1);
%         else
%             [z_spikes_tlvls_C(:,k),C_mu(k),C_sigma(k)]=zscore(Correct(:,k));
%         end
%         
%         if any(isnan(Incorrect(:,k)))
%             I_mu(k)=nanmean(Incorrect(:,k));
%             I_sigma(k)=nanstd(Incorrect(:,k));
%             z_spikes_tlvls_I(:,k)=(Incorrect(:,k)-repmat(mean_quiet,length(Incorrect(:,k)),1))./repmat(I_sigma(k),length(Incorrect(:,k)),1);
%         else
%             [z_spikes_tlvls_I(:,k),I_mu(k),I_sigma(k)]=zscore(Incorrect(:,k));
%         end
% end

% new way, trying to z score to responses on incorrect trials
for k = 1:length(cList) 

        if any(isnan(Incorrect(:,k)))
            I_mu(k)=nanmean(Incorrect(:,k));
            I_sigma(k)=nanstd(Incorrect(:,k));
            z_spikes_tlvls_I(:,k)=(Incorrect(:,k)-mean_quiet)./std_quiet;
        end

        if any(isnan(Correct(:,k)))
            C_mu(k)=nanmean(Correct(:,k));
            C_sigma(k)=nanstd(Correct(:,k));
            z_spikes_tlvls_C(:,k)=(Correct(:,k)-nanmean(Incorrect(:,k)))./I_sigma(k);
        end
      
end

% Now that z score is taken columnwise we add to total arrays for correct and
% incorrect

zC_tot = rmmissing(reshape(z_spikes_tlvls_C,[],1));
zI_tot = rmmissing(reshape(z_spikes_tlvls_I,[],1)); 

% Zscored Histogram
% figure(2)
% clf
% subplot(1,2,1);
% histogram(zC_tot,40)
% hold on 
% histogram(zI_tot,40) 


%ROC curve calculation

all_z =  cat(1,zC_tot,zI_tot);  % Add all of the zscores into one array , C and I 

z_critList = min(all_z):.0001:max(all_z);   %list of criterion values *** THIS NEEDS TO BE FIXED TO ACCOUNT FOR NEGATIVE VALUES

z_pHit = zeros(length(z_critList),1);
z_pFA =  zeros(length(z_critList),1);

    for critNum = 1:length(z_critList)
        nTrialsC = length(zC_tot);
        nTrialsI = length(zI_tot);
        criterion = z_critList(critNum);
        z_pHit(critNum) = sum((zC_tot(:))>criterion)/nTrialsC;
        z_pFA(critNum) = sum((zI_tot(:))>criterion)/nTrialsI;
    end

% figure(3)
% subplot(1,2,2);
% plot(z_pFA,z_pHit,'.-');
% legend('Z Scores ROC','Location','SouthEast');
% set(gca,'XLim',[0,1]);
% set(gca,'YLim',[0,1]);
% xlabel('p(null>crit)');
% ylabel('p(pref>crit)');
% set(gca,'XTick',0:.2:1);
% set(gca,'YTick',0:.2:1);
% hold on
% plot([0,1],[0,1],'k-');
% axis square

Grand_ChoiceProbability = -trapz(z_pFA,z_pHit);


%% bootstrapping/ perm test for significance

bC = bootstrp(1000,@mean,zC_tot);
bI = bootstrp(1000,@mean,zI_tot);
    


% close all;
% histogram(bC)
% hold on 
% histogram(bI)
% figure(2)
% histogram(zC_tot)
% hold on 
% histogram(zI_tot)

[p, observeddifference, effectsize] = permutationTest(bC,bI,1000);

% pd = fitdist(zC_tot, 'Normal');
% ci = paramci(pd);
% if 
% p = ci()

%% calculate confidence intervals of the mean, using percentile method
% 
% per=80;
% CIFcn = @(x,p)prctile(x,abs([0,100]-(100-per)/2));
% 
% % CIcorr = CIFcn(bC,per)';
% % CIinc = CIFcn(bI,per)';
% pd_c = fitdist(bC,'Normal');
% pd_i = fitdist(bI,'Normal');
% CIcorr = paramci(pd_c,'Alpha',0.1) ;
% CIinc = paramci(pd_i,'Alpha',0.1) ; 
% 
% % calculate overlap
% if Grand_ChoiceProbability>=0.5
%     if CIcorr(1,1)<CIinc(2,1)
%         sig=0;
%     else 
%         sig = 1;
%     end
% elseif Grand_ChoiceProbability<0.5
%     if CIcorr(2,1)>CIinc(1,1)
%         sig=0;
%     else 
%         sig = 1;
%     end
% end
%     if sig==1
%         p='Cool';
%     else 
%         p=0.6;
%     end
%% DI analysis for significance (Not working)

% DI = MonkeyBootstrapDI(zC_tot,zI_tot);
% 
% % now calculate overlap of DI and CP
% if Grand_ChoiceProbability>0.5
%     overlap = trapz(DI(Grand_ChoiceProbability:end));
% else
%     overlap = trapz(DI(min:Grand_ChoiceProbability));
% end
% 
%  % significance 
%  p = overlap;

end