function Done= MonkeyRemoveFirst(handles)
global playlist




Strings={get(handles.Q1,'String'),get(handles.Q2,'String'),get(handles.Q3,'String'),...
    get(handles.Q4,'String'), get(handles.Q5,'String'),get(handles.Q6,'String'),...
    get(handles.Q7,'String'),get(handles.Q8,'String'),get(handles.Q9,'String')};
Strings=circshift(Strings,[1,-1]);
Strings(9)={'E'};


CaseNumber=0;
for i=1:length(Strings)
    if strcmp(Strings(i),'E')
        CaseNumber=CaseNumber+1;
    end
end

if CaseNumber==9
    Done=1;
else
    Done=0;
end


NewPlayList=circshift((playlist.list),[-1 1]);
NewPlayList(9)={'D'};
playlist.list=NewPlayList;


switch CaseNumber
    case 9
        set(handles.Q1,'Visible','Off','String','E','Value',0)
        set(handles.Q2,'Visible','Off','String','E','Value',0)
        set(handles.Q3,'Visible','Off','String','E','Value',0)
        set(handles.Q4,'Visible','Off','String','E','Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)
        

    case 8        
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'Visible','Off','String','E','Value',0)
        set(handles.Q3,'Visible','Off','String','E','Value',0)
        set(handles.Q4,'Visible','Off','String','E','Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)
        
        
    case 7
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'String',Strings{2},'Value',0)
        set(handles.Q3,'Visible','Off','String','E','Value',0)
        set(handles.Q4,'Visible','Off','String','E','Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 6
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'String',Strings{2},'Value',0)
        set(handles.Q3,'String',Strings{3},'Value',0)
        set(handles.Q4,'Visible','Off','String','E','Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 5
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'String',Strings{2},'Value',0)
        set(handles.Q3,'String',Strings{3},'Value',0)
        set(handles.Q4,'String',Strings{4},'Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 4
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'String',Strings{2},'Value',0)
        set(handles.Q3,'String',Strings{3},'Value',0)
        set(handles.Q4,'String',Strings{4},'Value',0)
        set(handles.Q5,'String',Strings{5},'Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 3
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'String',Strings{2},'Value',0)
        set(handles.Q3,'String',Strings{3},'Value',0)
        set(handles.Q4,'String',Strings{4},'Value',0)
        set(handles.Q5,'String',Strings{5},'Value',0)
        set(handles.Q6,'String',Strings{6},'Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 2
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'String',Strings{2},'Value',0)
        set(handles.Q3,'String',Strings{3},'Value',0)
        set(handles.Q4,'String',Strings{4},'Value',0)
        set(handles.Q5,'String',Strings{5},'Value',0)
        set(handles.Q6,'String',Strings{6},'Value',0)
        set(handles.Q7,'String',Strings{7},'Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 1
        set(handles.Q1,'String',Strings{1},'Value',0)
        set(handles.Q2,'String',Strings{2},'Value',0)
        set(handles.Q3,'String',Strings{3},'Value',0)
        set(handles.Q4,'String',Strings{4},'Value',0)
        set(handles.Q5,'String',Strings{5},'Value',0)
        set(handles.Q6,'String',Strings{6},'Value',0)
        set(handles.Q7,'String',Strings{7},'Value',0)
        set(handles.Q8,'String',Strings{8},'Value',0)        
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 0
end