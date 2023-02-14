
function []=CopyState()
source='C:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2_Test\UserFiles\Sorter.csf';
destination='C:\TDT\OpenEx\Examples\AutoTuner4_Test\UserFiles';
[~]=copyfile(source,destination);