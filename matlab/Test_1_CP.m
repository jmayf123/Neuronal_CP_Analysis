
%% file paths
clear;
paths = {
'Z:\Alpha data\Neurobehavior\IC\ex110323\tank110323a\OurData-6'
'Z:\Alpha data\Neurobehavior\IC\ex110322\tank110322a\OurData-8'
'Z:\Alpha data\Neurobehavior\IC\ex110324\tank110324a\OurData-4'
'Z:\Alpha data\Neurobehavior\IC\ex110325\tank110325a\OurData-6'
'Z:\Alpha data\Neurobehavior\IC\ex110328\tank110328a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex110329\tank110329a\OurData-8'
'Z:\Alpha data\Neurobehavior\IC\ex110330\tank110330a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex110331\tank110331a\OurData-6'
'Z:\Alpha data\Neurobehavior\IC\ex110401\tank110401a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex110407\tank110407a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex110408\tank110408a\OurData-7'
%'Z:\Alpha data\Neurobehavior\IC\ex110411\tank110411a\OurData-6'
'Z:\Alpha data\Neurobehavior\IC\ex110412\tank110412a\OurData-9'
%'Z:\Alpha data\Neurobehavior\IC\ex110413\tank110413a\OurData-7'
'Z:\Alpha data\Neurobehavior\IC\ex110518\tank110518a\OurData-6'
'Z:\Alpha data\Neurobehavior\IC\ex110601\tank110601a\OurData-6'
'Z:\Alpha data\Neurobehavior\IC\ex110606\tank110606a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex100809\tank100809a\OurData-3'
'Z:\Alpha data\Neurobehavior\IC\ex100917\tank100917a\OurData-2'
'Z:\Alpha data\Neurobehavior\IC\ex101021\tank101021a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex101022\tank101022a\OurData-6'
'Z:\Alpha data\Neurobehavior\IC\ex101025\tank101025a\OurData-7'
'Z:\Alpha data\Neurobehavior\IC\ex101026\tank101026a\OurData-4'
'Z:\Alpha data\Neurobehavior\IC\ex101027\tank101027a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex101028\tank101028a\OurData-7'
'Z:\Alpha data\Neurobehavior\IC\ex101029\tank101029a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex101102\tank101102a\OurData-4'
'Z:\Alpha data\Neurobehavior\IC\ex101103\tank101103a\OurData-9'
'Z:\Alpha data\Neurobehavior\IC\ex101105\tank101105a\OurData-7'
'Z:\Alpha data\Neurobehavior\IC\ex101117\tank101117a\OurData-10'
'Z:\Alpha data\Neurobehavior\IC\ex110120\tank110120a\OurData-10'
'Z:\Alpha data\Neurobehavior\IC\ex110121\tank110121a\OurData-10'
'Z:\Alpha data\Neurobehavior\IC\ex110125\tank110125a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex110126\tank110126a\OurData-5'
'Z:\Alpha data\Neurobehavior\IC\ex110127\tank110127a\OurData-4'
'Z:\Alpha data\Neurobehavior\IC\ex110128\tank110128a\OurData-4'
'Z:\Alpha data\Neurobehavior\IC\ex110209\tank110209a\OurData-4'
%'Z:\Alpha data\Neurobehavior\CN\ex110808\tank110808a\OurData-6'
'Z:\Alpha data\Neurobehavior\CN\ex110811\tank110811a\OurData-4'
%'Z:\Alpha data\Neurobehavior\CN\ex110815\tank110815a\OurData-5'
'Z:\Alpha data\Neurobehavior\CN\ex110826\tank110826a\OurData-8'
'Z:\Alpha data\Neurobehavior\CN\ex110902\tank110902a\OurData-5'
'Z:\Alpha data\Neurobehavior\CN\ex110907\tank110907a\OurData-5'
'Z:\Alpha data\Neurobehavior\CN\ex110909\tank110909a\OurData-6'
'Z:\Alpha data\Neurobehavior\CN\ex110919\tank110919a\OurData-5'
'Z:\Alpha data\Neurobehavior\CN\ex110922\tank110922a\OurData-8'
'Z:\Alpha data\Neurobehavior\CN\ex110923\tank110923a\OurData-10'
'Z:\Alpha data\Neurobehavior\CN\ex111019\tank111019a\OurData-8'
'Z:\Alpha data\Neurobehavior\CN\ex111021\tank111021a\OurData-10'
'Z:\Alpha data\Neurobehavior\CN\ex111024\tank111024a\OurData-7'
        };
%% import all of the above data into single cell variable 

Num_monkeys = 3; %Figure out how to make a 3-d cell array, third dimension is Number of monkeys (3)
% Each row is new tank/block combo  
neuron_data = cell(length(paths),1);

parfor imp = 1:length(paths)
    neuron_data{imp,1} = TDTbin2mat(paths{imp,1});
end

%% Loop trough each of the duration values and Calc Grand_CP for all durations 


dur = 12.5:12.5:200;

CP = cell(length(neuron_data),length(dur));
Grand_CP = cell(length(neuron_data),length(dur)); 
p_values = cell(length(neuron_data),length(dur));

for n_ct = 1:length(neuron_data)
    for dur_ct = 1:length(dur)
           [CP{n_ct,dur_ct},Grand_CP{n_ct,dur_ct},p_values{n_ct,dur_ct}] = CP_Calc(neuron_data{n_ct,1},dur(dur_ct));
    end
end

    assignin('base','CP',CP) 
    assignin('base','Grand_CP',Grand_CP)
    assignin('base','p_values',p_values)
    
    
    
    
    
    