tic
%% file paths
clear;
addpath('..\possibly_useful_code\')
paths = readcell('..\..\data\tin_paths_list.csv')';
for i = 1:numel(paths)
    new_paths{i,1} = strrep(paths{i}, '/', '\');
end
%% import all of the above data into single cell variable 

%Num_monkeys = 3; %Figure out how to make a 3-d cell array, third dimension is Number of monkeys (3)
% Each row is new tank/block combo  
neuron_data = cell(length(new_paths),1);
h = waitbar(0, 'Processing...');

for imp = 1:50 %Limit to 50 becuase matlab runs out of memory
    neuron_data{imp,1} = TDTbin2mat(new_paths{imp,1});

        % Update the progress bar
    waitbar(imp/length(new_paths), h);
end

%% Loop trough each of the duration values and Calc Grand_CP for all durations
neuron_data = neuron_data(1:50,:);
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