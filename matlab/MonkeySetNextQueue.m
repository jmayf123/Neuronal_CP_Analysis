function NumInQ = MonkeySetNextQueue(handles,string)
global playlist

if strcmp(get(handles.Q1,'Visible'),'off')
    set(handles.Q1,'String',string)
    set(handles.Q1, 'Visible', 'On')
    NumInQ=1;
    
elseif strcmp(get(handles.Q2,'Visible'),'off')
    set(handles.Q2,'String',string)
    set(handles.Q2, 'Visible', 'On')
    NumInQ=2;
    
elseif strcmp(get(handles.Q3,'Visible'),'off')
    set(handles.Q3,'String',string)
    set(handles.Q3, 'Visible', 'On')
    NumInQ=3;
    
elseif strcmp(get(handles.Q4,'Visible'),'off')
    set(handles.Q4,'String',string)
    set(handles.Q4, 'Visible', 'On')
    NumInQ=4;
    
elseif strcmp(get(handles.Q5,'Visible'),'off')
    set(handles.Q5,'String',string)
    set(handles.Q5, 'Visible', 'On')
    NumInQ=5;
    
elseif strcmp(get(handles.Q6,'Visible'),'off')
    set(handles.Q6,'String',string)
    set(handles.Q6, 'Visible', 'On')
    NumInQ=6;
    
elseif strcmp(get(handles.Q7,'Visible'),'off')
    set(handles.Q7,'String',string)
    set(handles.Q7, 'Visible', 'On')
    NumInQ=7;
    
elseif strcmp(get(handles.Q8,'Visible'),'off')
    set(handles.Q8,'String',string)
    set(handles.Q8, 'Visible', 'On')
    NumInQ=8;
    
elseif strcmp(get(handles.Q9,'Visible'),'off')
    set(handles.Q9,'String',string)
    set(handles.Q9, 'Visible', 'On')
    NumInQ=9;
    
else
    f = warndlg('Sorry, queue is full', 'Please try again later');
    waitfor(f);
    NumInQ=9;
    playlist.flag=1;
end