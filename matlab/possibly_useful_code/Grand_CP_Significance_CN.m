% clear, close
%THIS SCRIPT IS FOR THE CN, 
%Provides insight into significant CP values for multiple nuerons in 4 monkeys

dur = 12.5:12.5:200;

% CHANGE THIS BACK A_g = load("D:\Jackson\Chase Stuff\Alpha_CP_Analysis\Grand_CPs.mat");%35 IC
B_g = load("D:\Jackson\Chase Stuff\Bravo_CP_Analysis\Dur = 12.5 -200, 12.5 Step, 0.0 window\Bravo_Grand_CPs.mat");%35 IC
C_g = load("D:\Jackson\Chase Stuff\Charlie_CP_Analysis\Dur = 12.5 -200, 12.5 Step, 0.0 window\Charlie_Grand_CPs.mat");%18 IC
D_g = load("D:\Jackson\Chase Stuff\Delta_CP_Anlaysis\Dur = 12.5 -200, 12.5 Step, 0.0 window\Delta_Grand_CPs.mat");%20 IC

% CHANGE THIS BACK A_p = load("D:\Jackson\Chase Stuff\Alpha_CP_Analysis\P_Values.mat");%35 IC
B_p = load("D:\Jackson\Chase Stuff\Bravo_CP_Analysis\Dur = 12.5 -200, 12.5 Step, 0.0 window\Bravo_P_Values.mat");%35 IC
C_p = load("D:\Jackson\Chase Stuff\Charlie_CP_Analysis\Dur = 12.5 -200, 12.5 Step, 0.0 window\Charlie_P_Values.mat");%18 IC
D_p = load("D:\Jackson\Chase Stuff\Delta_CP_Anlaysis\Dur = 12.5 -200, 12.5 Step, 0.0 window\Delta_P_Values.mat");%20 IC

ga = cell2mat(A_g.Grand_CP);
gb = cell2mat(B_g.Grand_CP);
gc = cell2mat(C_g.Grand_CP);
gd = cell2mat(D_g.Grand_CP);

pa = cell2mat(A_p.p_values);
pb = cell2mat(B_p.p_values);
pc = cell2mat(C_p.p_values);
pd = cell2mat(D_p.p_values);

%%Trim them down to only CN 
ga = ga(35:end,:);
gb = gb(35:end,:); 
gc = gc(18:end,:);
gd = gd(20:end,:);

pa = pa(35:end,:);
pb = pb(35:end,:); 
pc = pc(18:end,:);
pd = pd(20:end,:);

%Boolean to find all indeces with significance
sig_a = pa <= 0.05;
sig_b = pb <= 0.05;
sig_c = pc <= 0.05;
sig_d = pd <= 0.05;

sig_tot = cat(1,sig_a,sig_b,sig_c,sig_d); %All indeces in for significant CP's in the CN

acceptable_a = ga.*(sig_a);
acceptable_b = gb.*(sig_b);
acceptable_c = gc.*(sig_c);
acceptable_d = gd.*(sig_d);

acceptable_a(acceptable_a == 0) = NaN;
acceptable_b(acceptable_b == 0) = NaN;
acceptable_c(acceptable_c == 0) = NaN;
acceptable_d(acceptable_d == 0) = NaN;


%average across all monkeys 
all_monk = cat(1,acceptable_a,acceptable_b,acceptable_c,acceptable_d); 
mean = mean(all_monk,'omitnan');
plot(dur,mean)
xlabel('Duration')
ylabel('CP')
title('Average CP across Neurons with p <= 0.05 in the IC')

%percentage of significant nerons in the IC at each duration 
per = zeros(2,16);
per(1,:) = dur;
per(2,:) = sum(sig_tot)./108;