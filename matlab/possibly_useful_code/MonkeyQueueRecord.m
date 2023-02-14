function [Count,Tank,Block,flag]=MonkeyQueueRecord(RorP)

global playlist
a=playlist.list;
b=a{1};
% try
    switch b{1}
        case 1
            dis('ERROR')
        case 2
            [Count,Tank,Block,flag]=Monkey2RMrunGo(b,RorP);
        case 3
            [Count,Tank,Block,flag]=Monkey2BFRLrunGo(b,RorP);
        case 4
            [Count,Tank,Block,flag]=MonkeyKlattahRunGo(b,RorP);
        case 5
            disp('haven''t gotten this far... go to MonkeyQueueRecord')
            %NRLData
        case 6
            disp('haven''t gotten this far... go to MonkeyQueueRecord')
            %PSTHData
        case 7
            [Count,Tank,BlockNumber,flag]= Monkey2FSRunGo(b,RorP);
            disp('If this does not work, go to MonkeyQueueRecord')
            %FrequencySearchData
        otherwise
            disp('MonkeyQueueRecord error... find me!')
    end
% catch
%     warndlg('Playlist is empty... Please add task to playlist','Getting ahead of ourselves?')
%     Count=[];
%     Tank=[];
%     Block=[];
%     b{1}=1;
%     flag=1;
%     
% end