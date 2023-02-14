function MonkeyQueueRecordGo2(handles,RorP)

global playlist

MonkeyGUIBuild(8, handles)
figurea = figure('Position',[0 100000 1 1]);
TT = actxcontrol('TTank.X');

flag1=0;
while flag1==0
    flag2=0;
    [NumberTrials,Tank,Block flag]=MonkeyQueueRecord2(RorP);
    Block=Block+1
    if flag==1
        break
    end
    SkipRemove=0;
    while flag2==0
        
        PauseTF=get(handles.PauseResume,'Value');
        CancelTF=get(handles.Cancel,'Value');
        
        
        if  playlist.flag3==1
            playlist.flag3=0;
            flag1=1;
            flag2=1;
            SkipRemove=1;
        end
        if CancelTF==1 
            Select = questdlg('What would you like to do?','Stop Recording in Progress?','Stop Progress','Let Current Finish','Cancel','Stop Progress');
            if strcmp(Select,'Stop Progress')
                flag1=1;
                flag2=1;
                set(handles.Cancel,'Value',0)
                MonkeyIdleStim
                SkipRemove=1;
            elseif  strcmp(Select,'Let Current Finish')
                flag1=1;
                flag2=1;
                set(handles.Cancel,'Value',0)
                SkipRemove=1;
            else
                set(handles.Cancel,'Value',0)
            end
        end
            
        if PauseTF==1
            set(handles.PauseResume,'String','Resume')
            MonkeyToggleRPVD(1);           
            flag3=1;
            while flag3==1
                CancelTF=get(handles.Cancel,'Value');
                flag3=get(handles.PauseResume,'Value'); 
                pause(.1);
                
                if  playlist.flag3==1
                    playlist.flag3=0;
                    flag1=1;
                    flag2=1;
                    flag3=0;
                    SkipRemove=1;
                end
                
                if CancelTF==1
                    Select = questdlg('What would you like to do?','Stop Recording in Progress?','Stop Progress','Let Current Finish','Cancel','Stop Progress');
                    if strcmp(Select,'Stop Progress')
                        flag1=1;
                        flag2=1;
                        flag3=0;  
                        set(handles.Cancel,'Value',0)
                        MonkeyIdleStim
                        SkipRemove=1;
                    elseif  strcmp(Select,'Let Current Finish') 
                        flag1=1;
                        flag2=1;
                        flag3=0;  
                        set(handles.Cancel,'Value',0)
                        SkipRemove=1;
                    else
                        set(handles.Cancel,'Value',0)
                    end
                end
            end
            MonkeyToggleRPVD(0);
            set(handles.PauseResume,'String','Pause','Value',0);
            
        end
        if RorP==1
            Record='3';
        else
            Record='2';
        end
        
        [OnTrialNumber] = MonkeyFindProgress(Tank,Block,TT,Record);
        if playlist.flag2==1
            playlist.flag2=0;
            flag1=1;
            SkipRemove=1;
            break
        end
        %%%%%
        % Might want to add number to OnTrialNumber... Might not... who
        % knows... 
        %OnTrialNumber=OnTrialNumber+250;
        %%%%%
       
        if OnTrialNumber >= NumberTrials
            flag2=1;
           
            
            MonkeyIdleStim
           
            pause(1)
            
            %Add code here to remove first from queue and move to 2nd
            %Also see if queue is empty or not...
        end
        
    end
    
    if SkipRemove==0 
        Done=MonkeyRemoveFirst(handles);
        if Done==1
            break
        end
    end
end

MonkeyGUIBuild(9, handles)
close(figurea)