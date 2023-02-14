function MonkeyMonitorCurrent(handles)

global playlist
MonkeyGUIBuild(8, handles)
actxfigure=figure('Position',[0 100000 1 1]);
DA = actxcontrol('TDevAcc.X');
DA.ConnectServer('Local');
Running=num2str(DA.GetSysMode);
Tank=DA.GetTankName;
[Block] = num2str(FindBlockNumber(Tank));
DA.CloseConnection;
close(actxfigure);
NumberTrials = FindNumberTrials;
flag=1;
figurea = figure('Position',[0 100000 1 1]);
TT = actxcontrol('TTank.X');

if ~(strcmp(Running,'0'))
    
    
    while flag==1;
        [OnTrialNumber] = MonkeyFindProgress(Tank,Block,TT,Running);
        CancelTF=get(handles.Cancel,'Value');
        PauseTF=get(handles.PauseResume,'Value');

        if  playlist.flag3==1
            
            playlist.flag3=0;
            break
        end
        if CancelTF==1;
            set(handles.Cancel,'Value',0)
            break
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
                    flag=0;
                    flag3=1;
                    break
                end
                if CancelTF==1
                    set(handles.Cancel,'Value',0)
                    flag=0;
                    flag3=1;
                    break
                end
            end
            MonkeyToggleRPVD(0);
            set(handles.PauseResume,'String','Pause');
        end

        if OnTrialNumber >= NumberTrials
            
            MonkeyIdleStim
            break
            
        end
        
    end
else
    warndlg('This function doesn''t work if the workbench is already idled...', 'Better luck next time')
end

close(figurea)
MonkeyGUIBuild(9, handles)



function [BlockNumber] = FindBlockNumber(Tank)
BlockNumber=[];
pause(10)
for i=1:100              %checking for dirrectory... very unlikely it will ever have 100 blocks.
    dirrectory=[Tank,'\OurData-',num2str(i)];
    if exist(dirrectory,'dir')
        BlockNumber=i;
    end
    if isempty(BlockNumber)==1
        BlockNumber=1;
    end
    
end


function NumberTrials = FindNumberTrials()

fid=fopen('c:\TDT\OpenEx\Examples\AutoTuner\AutoTuner2\Userfiles\FreqList.txt','r');



C = textscan(fid, '%d');
NumberTrials = length(C{1});
fclose all;

