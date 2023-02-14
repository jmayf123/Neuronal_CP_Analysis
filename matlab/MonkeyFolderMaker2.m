function [out, f1, tankname] = MonkeyFolderMaker2(Monkey,Location,DataType)


letter=lower(Monkey(1));
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

if exist([filename,date])~=0
    f1=[filename,date];
    out=1;
end

f1=fullfile(filename,date);

if (exist(f1) == 0) %#ok<EXIST>
   out= mkdir (f1);
end

