function MonkeyPlotCurrent()

actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
Running=num2str(DA.GetSysMode);
Tank=DA.GetTankName;
[Block] = num2str(FindBlockNumber(Tank));
DA.CloseConnection;
close(actxfigure);
BlockNum=num2str(Block);

figurea = figure('Position',[0 100000 1 1]);
TT = actxcontrol('TTank.X');
MyBlock = ['~OurData-' BlockNum];
invoke(TT,'ConnectServer','Local','Me');
invoke(TT,'OpenTank',Tank,'R');
invoke(TT,'SelectBlock',MyBlock);
invoke(TT,'ResetFilters');
channel = 1;
invoke(TT,'SetGlobalV','Channel',channel);
freq = invoke(TT, 'GetEpocsV', 'Freq', 0, 0, 10000);
close(figurea)
freq;
a=length(unique(freq(1,:)));
if length(freq)<100 &&  a<15
    Warning=['There are only ', num2str(length(freq)),' trials recorded'];
    warndlg(Warning,'More trials needed')
elseif length(freq)>=100 || a>=15
    if isempty(strfind(Tank,'Behavior'))
        %find if it is a RM or ROC analysis
      
        if a>15
            MonkeyCurrentRMapPlotter(Tank,Block)
            
        else
            
             MonkeyCurrentROC(Tank,Block)
            %go to monkey n and level if this is the case...
        end
    elseif isempty(strfind(Tank,'Neuro'))
        MonkeyCurrentTankPlotter(Tank,Block)
        
    end

end







function [BlockNumber] = FindBlockNumber(Tank)
BlockNumber=[];
for i=1:100              %checking for dirrectory... very unlikely it will ever have 100 blocks. 
    dirrectory=[Tank,'\OurData-',num2str(i)];
    if exist(dirrectory,'dir')
        BlockNumber=i;
    end
    if isempty(BlockNumber)==1
        BlockNumber=1;
    end
end
