function [out] = MonkeyFolderMaker(Monkey,Location,DataType)

%G:\Bravo data\Neurobehavior\CN
%G:\Bravo data\Behavior
out=0;

switch Monkey
    case 1;  Monkey='Alpha';    letter='a';
    case 2;  Monkey='Bravo';    letter='b';
    case 3;  Monkey='Charlie';  letter='c';
    case 4;  Monkey='Delta';    letter='d';
end
switch Location
    case 1; Location='CN';
    case 2; Location='IC';
end
switch DataType
    case 1; DataType='Neurobehavior';
    case 2; DataType='Behavior';
end

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
date=strcat('\ex', year,month,day);
tankname=strcat('tank',year,month,day,letter);                    
if strcmp(DataType,'Neurobehavior')==1 
    filename=['G:\' Monkey ' data\' DataType '\' Location];
elseif strcmp(DataType,'Behavior')==1
    filename=['G:\' Monkey ' data\' DataType ];
end

f1=fullfile(filename,date);
disp('Use the following for tank creation directory')
disp(f1)
disp('Tank name')
disp(tankname)
if (exist(f1) == 0) %#ok<EXIST>
   out= mkdir (f1);
end

