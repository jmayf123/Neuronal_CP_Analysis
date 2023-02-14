
%% CN and IC in Quiet and Noise Data
close all

x = [200;100;50;25;12.5;6.50;3.25]; %Duration Values 

normthresh_IC_q = NormalizeThresh(Thresh_Q(ICthreshidx,1));
normthresh_CN_q = NormalizeThresh(Thresh_Q(CNthreshidx,1));
normthresh_IC_N = NormalizeThresh(Thresh_N(ICthreshidx,1));
normthresh_CN_N = NormalizeThresh(Thresh_N(CNthreshidx,1));

a = normthresh_CN_q(:,1); %Takes norm threshold values from data
q = normthresh_CN_N(:,1);
p = normthresh_IC_q(:,1);
r = normthresh_IC_N(:,1);

% Removes Extrneous zeros from data sets
while a(end)==0 || q(end)==0 || p(end)==0 || r(end)==0
    if a(end) == 0
        a = a(1:end-1);
    elseif q(end) == 0
        q = q(1:end-1);
    elseif p(end) == 0
        p = p(1:end-1);
    elseif r(end) == 0
        r = r(1:end-1);
    else    
        break
    end   
end
    

columns_1 = length(a)./7;   %Reshapes Column vector into matrix for Mean Calcs
columns_2 = length(q)./7;
columns_3 = length(p)./7;
columns_4 = length(r)./7;

b_r = reshape(a,[],columns_1);
c_r = reshape(q,[],columns_2); 
d_r = reshape(p,[],columns_3);
e_r = reshape(r,[],columns_4);

CNthold_Q_med = median(b_r,2,'omitnan'); %Median Threshold values of each duration time 
CNthold_N_med = median(c_r,2,'omitnan'); 
ICthold_Q_med = median(d_r,2,'omitnan');
ICthold_N_med = median(e_r,2,'omitnan');

CNthold_Q_mean = mean(b_r,2,'omitnan'); %Mean Threshold values of each duration time 
CNthold_N_mean = mean(c_r,2,'omitnan'); 
ICthold_Q_mean = mean(d_r,2,'omitnan');
ICthold_N_mean = mean(e_r,2,'omitnan');


CNsem_Q = std(b_r,0,2,'omitnan')./sqrt(columns_1); %Standard Error of the Mean calc.
CNsem_N = std(c_r,0,2,'omitnan')./sqrt(columns_2); 
ICsem_Q = std(d_r,0,2,'omitnan')./sqrt(columns_3);
ICsem_N = std(e_r,0,2,'omitnan')./sqrt(columns_4);

CNsemed_Q = 1.2533.*CNsem_Q; %Standard Error of the median of threshold data at each duration
CNsemed_N = 1.2533.*CNsem_N; 
ICsemed_Q = 1.2533.*ICsem_Q;
ICsemed_N = 1.2533.*ICsem_N;

CNthold_Q_iqr = iqr(b_r,2); %Interquartile Range
CNthold_N_iqr = iqr(c_r,2); 
ICthold_Q_iqr = iqr(d_r,2);
ICthold_N_iqr = iqr(e_r,2);

% CNts_Q = tinv([0.025  0.975],length(columns_1)-1); %t score
% CNts_N = tinv([0.025  0.975],length(columns_2)-1); 
% ICts_Q = tinv([0.025  0.975],length(columns_3)-1);
% ICts_N = tinv([0.025  0.975],length(columns_4)-1);

% CNerr_Q = mean(CNthold_Q_med).*std(b_r,0,2,'omitnan')./sqrt(columns_1);
% CNerr_N = mean(CNthold_N_med).*std(c_r,0,2,'omitnan')./sqrt(columns_2); 
% ICerr_Q = mean(ICthold_Q_med).*std(d_r,0,2,'omitnan')./sqrt(columns_3);
% ICerr_N = mean(ICthold_N_med).*std(e_r,0,2,'omitnan')./sqrt(columns_4);

%Input for Which Graph to Plot

prompt = 'Which Method for Error Calculations?\n1 - Mean and SEM\n2 - Median and SEMed\n3 - Mean and IQR\n4 - Median and IQR\n(Enter Number 1-4)' ; 
inp = input(prompt)
if inp == 1
    CN_method_Q = CNthold_Q_mean; 
    CN_error_Q = CNsem_Q;
    CN_method_N = CNthold_N_mean;
    CN_error_N = CNsem_N;
    IC_method_Q = ICthold_Q_mean;
    IC_error_Q = ICsem_Q;
    IC_method_N = ICthold_N_mean;
    IC_error_N = ICsem_N; 
elseif inp == 2
    CN_method_Q = CNthold_Q_med; 
    CN_error_Q = CNsemed_Q;
    CN_method_N = CNthold_N_med;
    CN_error_N = CNsemed_N;
    IC_method_Q = ICthold_Q_med;
    IC_error_Q = ICsemed_Q;
    IC_method_N = ICthold_N_med;
    IC_error_N = ICsemed_N; 
elseif inp == 3 
    CN_method_Q = CNthold_Q_mean; 
    CN_error_Q = CNthold_Q_iqr;
    CN_method_N = CNthold_N_mean;
    CN_error_N = CNthold_N_iqr;
    IC_method_Q = ICthold_Q_mean;
    IC_error_Q = ICthold_Q_iqr;
    IC_method_N = ICthold_N_mean;
    IC_error_N = ICthold_N_iqr; 
elseif inp == 4
    CN_method_Q = CNthold_Q_med; 
    CN_error_Q = CNthold_Q_iqr;
    CN_method_N = CNthold_N_med;
    CN_error_N = CNthold_N_iqr;
    IC_method_Q = ICthold_Q_med;
    IC_error_Q = ICthold_Q_iqr;
    IC_method_N = ICthold_N_med;
    IC_error_N = ICthold_N_iqr; 
end

figure
%CN
subplot(2,1,1)
errorbar(x,CN_method_Q,CN_error_Q,'-o','MarkerSize',5,'MarkerEdgeColor','blue','MarkerFaceColor','blue')
hold on
errorbar(x,CN_method_N,CN_error_N,'-s','MarkerSize',5,'MarkerEdgeColor','red','MarkerFaceColor','red')

legend('CN in Quiet','CN in Noise')
xlabel('Duration (ms)')
ylabel('Thresholds')
title('CN in Quiet and Noise')

%IC
subplot(2,1,2)
errorbar(x,IC_method_Q,IC_error_Q,'-g*','MarkerSize',5,'MarkerEdgeColor','g','MarkerFaceColor','g')
hold on
errorbar(x,IC_method_N,IC_error_N,'-ms','MarkerSize',5,'MarkerEdgeColor','m','MarkerFaceColor','m')

legend('IC in Quiet','IC in Noise')
xlabel('Duration (ms)')
ylabel('Thresholds')
title('IC in Quiet and Noise')






