function [Count,Tank,Block,flag]=MonkeyQueueRecord2(RorP)

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
            [Count,Tank,Block,flag]=MonkeyKlattahRunGo2(b,RorP);
        case 5
            disp('haven''t gotten this far... go to MonkeyQueRecord')
            %NRLData
        case 6
            disp('haven''t gotten this far... go to MonkeyQueRecord')
            %PSTHData
        case 7
            disp('haven''t gotten this far... go to MonkeyQueRecord')
            %FrequencySearchData
        otherwise
            disp('MOnkeyQueueRecord error... find me!')
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