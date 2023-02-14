
%% Plotting Grand CP values for durations values 
clear, close all;

% A = load("Alpha_CP_Analysis\Dur = 12.5 - 200, 12.5 Step\Alpha_Grand_CPs.mat");%35 IC
% B = load("Bravo_CP_Analysis\Dur = 12.5 - 200, 12.5 Step\Bravo_Grand_CPs.mat");%35 IC
% C = load("Charlie_CP_Analysis\Dur = 12.5 - 200, 12.5 Step\Charlie_Grand_CPs.mat");%18 IC
% D = load("Delta_CP_Anlaysis\Dur = 12.5 - 200, 12.5 Step\Delta_Grand_CPs.mat");%20 IC



% Need to pull out all IC vs CN tanks
% alpha_CP_IC = Alpha.Grand_CP(1:35,:);
% alpha_CP_CN = Alpha.Grand_CP(36:end,:);
% bravo_CP_IC = A.Grand_CP(1:35,:);
% bravo_CP_CN = A.Grand_CP(36:end,:);
% charlie_CP_IC = A.Grand_CP(1:18,:);
% charlie_CP_CN = A.Grand_CP(19:end,:);
% delta_CP_IC = A.Grand_CP(1:20,:);
% delta_CP_CN = A.Grand_CP(21:end,:);

%% 200  ms cps
Alpha = cell2mat(Alpha);

Bravo = cell2mat(Bravo);

Charlie = cell2mat(Charlie);

Delta = cell2mat(Delta);

% alpha_CP_IC = Alpha(1:35,16);
% alpha_CP_CN = Alpha(36:end,16);
% bravo_CP_IC = Bravo(1:35,16);
% bravo_CP_CN = Bravo(36:end,:);
% charlie_CP_IC = Charlie(1:18,16);
% charlie_CP_CN = Charlie(19:end,16);
% delta_CP_IC = Delta(1:20,16);
% delta_CP_CN = Delta(21:end,16);

%% all durations
alpha_CP_IC = Alpha(1:35,:);
alpha_CP_CN = Alpha(36:end,:);
bravo_CP_IC = Bravo(1:35,:);
bravo_CP_CN = Bravo(36:end,:);
charlie_CP_IC = Charlie(1:18,:);
charlie_CP_CN = Charlie(19:end,:);
delta_CP_IC = Delta(1:20,:);
delta_CP_CN = Delta(21:end,:);

%% combine across monkeys
allIC=vertcat(alpha_CP_IC,bravo_CP_IC,charlie_CP_IC,delta_CP_IC)
moreICidx=find(allIC(:,16)>0.5) %indices of positive cps
lessICidx=find(allIC(:,16)<0.5) % indices of negative cps

allCN=vertcat(alpha_CP_CN,bravo_CP_CN,charlie_CP_CN,delta_CP_CN);
moreCNidx=find(allCN(:,16)>0.5); %indices of positive cps
lessCNidx=find(allCN(:,16)<0.5); % indices of negative cps

%% average across neurons whose cps go up vs. go down
moreICmean=mean(allIC(moreICidx,:));
moreICmean(2,:)=std(allIC(moreICidx,:))/sqrt(length(moreICidx));
moreICmean(3,:)=std(allIC(moreICidx,:));

lessICmean=mean(allIC(lessICidx,:));
lessICmean(2,:)=std(allIC(lessICidx,:))/sqrt(length(lessICidx));
lessICmean(3,:)=std(allIC(lessICidx,:));

moreCNmean=mean(allCN(moreCNidx,:));
moreCNmean(2,:)=std(allIC(moreCNidx,:))/sqrt(length(moreCNidx));

lessCNmean=mean(allCN(lessCNidx,:));
lessCNmean(2,:)=std(allCN(lessCNidx,:))/sqrt(length(lessCNidx));

