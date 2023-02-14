function MonkeyRemoveFromQueue(handles)

global playlist
NewPlaylist=cell(9,1);
Strings={get(handles.Q1,'String'),get(handles.Q2,'String'),get(handles.Q3,'String'),...
    get(handles.Q4,'String'), get(handles.Q5,'String'),get(handles.Q6,'String'),...
    get(handles.Q7,'String'),get(handles.Q8,'String'),get(handles.Q9,'String')};


Keepers=[get(handles.Q1,'Value'),get(handles.Q2,'Value'),get(handles.Q3,'Value'),...
    get(handles.Q4,'Value'), get(handles.Q5,'Value'), get(handles.Q6,'Value'),...
    get(handles.Q7,'Value'),get(handles.Q8,'Value'),get(handles.Q9,'Value')];

for i=1:length(Keepers)
    if strcmp(Strings(i),'E')
        Keepers(i)=1;
    end
end


StringArray=Strings;
count=1;
for i=1:length(Keepers)        
    if ~strcmp(Strings(i),'E') && Keepers(i)==0  %If not empty, and it is somethign we want to keep, 
        StringArray(count)=Strings(i);
        NewPlaylist(count)=playlist.list(i);
        count=count+1;
        
    end        
end

playlist.list=NewPlaylist;

    



switch sum(Keepers)
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
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'Visible','Off','String','E','Value',0)
        set(handles.Q3,'Visible','Off','String','E','Value',0)
        set(handles.Q4,'Visible','Off','String','E','Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)
        
        
    case 7
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'String',StringArray{2},'Value',0)
        set(handles.Q3,'Visible','Off','String','E','Value',0)
        set(handles.Q4,'Visible','Off','String','E','Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 6
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'String',StringArray{2},'Value',0)
        set(handles.Q3,'String',StringArray{3},'Value',0)
        set(handles.Q4,'Visible','Off','String','E','Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 5
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'String',StringArray{2},'Value',0)
        set(handles.Q3,'String',StringArray{3},'Value',0)
        set(handles.Q4,'String',StringArray{4},'Value',0)
        set(handles.Q5,'Visible','Off','String','E','Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 4
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'String',StringArray{2},'Value',0)
        set(handles.Q3,'String',StringArray{3},'Value',0)
        set(handles.Q4,'String',StringArray{4},'Value',0)
        set(handles.Q5,'String',StringArray{5},'Value',0)
        set(handles.Q6,'Visible','Off','String','E','Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 3
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'String',StringArray{2},'Value',0)
        set(handles.Q3,'String',StringArray{3},'Value',0)
        set(handles.Q4,'String',StringArray{4},'Value',0)
        set(handles.Q5,'String',StringArray{5},'Value',0)
        set(handles.Q6,'String',StringArray{6},'Value',0)
        set(handles.Q7,'Visible','Off','String','E','Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 2
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'String',StringArray{2},'Value',0)
        set(handles.Q3,'String',StringArray{3},'Value',0)
        set(handles.Q4,'String',StringArray{4},'Value',0)
        set(handles.Q5,'String',StringArray{5},'Value',0)
        set(handles.Q6,'String',StringArray{6},'Value',0)
        set(handles.Q7,'String',StringArray{7},'Value',0)
        set(handles.Q8,'Visible','Off','String','E','Value',0)
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 1
        set(handles.Q1,'String',StringArray{1},'Value',0)
        set(handles.Q2,'String',StringArray{2},'Value',0)
        set(handles.Q3,'String',StringArray{3},'Value',0)
        set(handles.Q4,'String',StringArray{4},'Value',0)
        set(handles.Q5,'String',StringArray{5},'Value',0)
        set(handles.Q6,'String',StringArray{6},'Value',0)
        set(handles.Q7,'String',StringArray{7},'Value',0)
        set(handles.Q8,'String',StringArray{8},'Value',0)        
        set(handles.Q9,'Visible','Off','String','E','Value',0)

    case 0
end