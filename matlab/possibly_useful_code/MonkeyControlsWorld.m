
function [MonkeyName,BlockNumber,DataType,flag,Tank]=MonkeyControlsWorld(StimType,NoiseType,...
    NoiseModFreq,StimModFreq,NoiseLevel,VowelNoiseLevel,Recording)
global NoiseFilter
actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');



% if DA.CheckServerConnection==0
%     warndlg('Unable to connect to OpenEx. Make sure program is running or try again','Warning')
%     DA.CloseConnection
%     close(actxfigure);
%     return
% end
flag=0;
Tank=DA.GetTankName;
[BlockNumber] = FindBlockNumber(Tank);
[MonkeyName] = FindMonkeyName(Tank);
[DataType] = FindDataType(Tank);
[Date]= GetDateString;
if isempty(findstr(Tank,Date))==1 && Recording==1
    warndlg('Tank you are saving to does not match todays date. Create Tank for today.','Oooooops')
    %flag=1;
    %DA.CloseConnection
    %close(actxfigure);
    return
end

if Recording==1
    flag=Record(DA);
    pause(.2)
elseif Recording==0    
    flag=Preview(DA);
    pause(.2)
end

if NoiseType==1
    NoiseLevel=0;
elseif NoiseType==0
    VowelNoiseLevel=0;
end

NoiseFilter.Noise=NoiseLevel;

try  
    pause(.005)
    h=DA.SetTargetVal('Stim1.HPMatlab',5);
    pause(.05)
    g=DA.SetTargetVal('Stim1.LPMatlab',40000);
    pause(.005)
    
    
    h=DA.SetTargetVal('Stim1.LPMatlab',NoiseFilter.LP);
    pause(.05)
    g=DA.SetTargetVal('Stim1.HPMatlab',NoiseFilter.HP);
    pause(.005)
       
catch
    NoiseFilter.HP=5    ;
    NoiseFilter.LP=40000;
end



a=DA.SetTargetVal('Stim1.StimType',StimType);
pause(.05)
b=DA.SetTargetVal('Stim1.VowelNoiseLevel',VowelNoiseLevel);
pause(.05)
c=DA.SetTargetVal('Stim1.NoiseModFreq',NoiseModFreq);
pause(.05)
d=DA.SetTargetVal('Stim1.NoiseLevel',NoiseLevel);
pause(.05)
e=DA.SetTargetVal('Stim1.StimModFreq',StimModFreq);
pause(.05)
f=DA.SetTargetVal('Stim1.NoiseType',NoiseType);
pause(.05)



    
if (a+b+c+d+e)~=5 && flag==0
    warndlg('Unable to set values in RPvd''s, make sure correct RPvd is open', 'Better luck next time')
    flag=1;
end
DA.CloseConnection;
close(actxfigure);





function [BlockNumber] = FindBlockNumber(Tank)
BlockNumber=[];
for i=1:100              %checking for dirrectory... very unlikely it will ever have 100 blocks. 
    dirrectory=[Tank,'\OurData-',num2str(i)];
    if exist(dirrectory,'dir')
        BlockNumber=i;
    end
    if isempty(BlockNumber)==1
        BlockNumber=0;
    end
end

function [MonkeyName] = FindMonkeyName(Tank)
if isempty(findstr(Tank,'Alpha'))==0
    MonkeyName='Alpha';
elseif isempty(findstr(Tank,'Bravo'))==0
    MonkeyName='Bravo';    
elseif isempty(findstr(Tank,'Charlie'))==0
    MonkeyName='Charlie';
elseif isempty(findstr(Tank,'Delta'))==0
    MonkeyName='Delta';
elseif isempty(findstr(Tank,'Echo'))==0
    MonkeyName='Echo';
elseif isempty(findstr(Tank,'Gatsby'))==0
    MonkeyName='Gatsby';

end

function [DataType] = FindDataType(Tank)
DataType=[];
if isempty(findstr(Tank,'Neuro'))==0
    DataType='NeuroBehavior';
else
    DataType='Behavior';
end

function [Date]= GetDateString()
DateArray=clock;
year=num2str(DateArray(1)-2000);
month=num2str(DateArray(2));
if length(month)==1
    month= strcat('0',month);
end
day=num2str(DateArray(3));
if length(day)==1
    day= strcat('0',day);
end
Date=strcat(year,month,day);

function [flag]=Record(DA)
if  DA.GetSysMode ~= 3 && DA.GetSysMode~=2
    DA.SetSysMode(3);
    flag=0;
elseif DA.GetSysMode == 3
    warndlg('OpenEx already Recording, please manually idle','Warning')
    flag=1;
    DA.CloseConnection;
    try
        close(actxfigure);
        return
    catch       
        return
    end
    return
elseif DA.GetSysMode == 2
    warndlg('OpenEx already Previewing, please manually idle','Warning')
    flag=1;
    DA.CloseConnection;
    try
        close(actxfigure);
        return
    catch       
        return
    end
end

function [flag]=Preview(DA)
if  DA.GetSysMode ~= 3 && DA.GetSysMode~=2
    DA.SetSysMode(2);
    flag=0;
elseif DA.GetSysMode == 3
    warndlg('OpenEx already Recording, please manually idle','Warning')
    flag=1;
    DA.CloseConnection;
    try
        close(actxfigure);
        return
    catch       
        return
    end
    return
elseif DA.GetSysMode == 2
    warndlg('OpenEx already Previewing, please manually idle','Warning')
    DA.CloseConnection;
    flag=1;
    try    
        close(actxfigure);
        return
    catch
        return
    end
    
end

