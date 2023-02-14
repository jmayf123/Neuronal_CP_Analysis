function [OnTrialNumber] = MonkeyFindProgress(MyTank,BlockNum,TT,Record)
BlockNum=num2str(BlockNum);

Record=str2num(Record);
MyTank;
if Record==3
    MyBlock = ['~OurData-' BlockNum];
else
    MyBlock=  '~TempBlk';
end

invoke(TT,'ConnectServer','Local','Me');
invoke(TT,'OpenTank',MyTank,'R');
invoke(TT,'SelectBlock',MyBlock);
invoke(TT,'ResetFilters');
channel = 1;
invoke(TT,'SetGlobalV','Channel',channel);
freq = invoke(TT, 'GetEpocsV', 'Freq', 0, 0, 10000);
OnTrialNumber=length(freq);
pause(.2)
