tic
%% file paths
clear;
paths = {
% 'Z:\Alpha data\Neurobehavior\IC\ex110323\tank110323a\OurData-6'
% 'Z:\Alpha data\Neurobehavior\IC\ex110322\tank110322a\OurData-8'
'Z:\Alpha data\Neurobehavior\IC\ex110324\tank110324a\OurData-4'


        };
%% import all of the above data into single cell variable 

%Num_monkeys = 3; %Figure out how to make a 3-d cell array, third dimension is Number of monkeys (3)
% Each row is new tank/block combo  
neuron_data = cell(length(paths),1);

parfor imp = 1:length(paths)
    neuron_data{imp,1} = TDTbin2mat(paths{imp,1});
end

%% Loop trough each of the duration values and Calc Grand_CP for all durations
dur = 0.0125:0.0125:0.2;

CP = cell(length(neuron_data),length(dur));
Grand_CP = cell(length(neuron_data),length(dur)); 
p_values = cell(length(neuron_data),length(dur));
grandcpboot = cell(length(neuron_data),length(dur));

for n_ct = 1:length(neuron_data)
    for dur_ct = 1:length(dur)
           [CP{n_ct,dur_ct},Grand_CP{n_ct,dur_ct},p_values{n_ct,dur_ct},grandcpboot{n_ct,dur_ct}] = CP_Calc(neuron_data{n_ct,1},dur(dur_ct));
    end
end

toc