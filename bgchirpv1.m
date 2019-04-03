function bgchirpv1(win,srect,msinterval,epochreps,gray)
%*********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [win, srect] = Screen('OpenWindow', 1,[0 0 0]);
% [gray] = temporalgrey1(2,srect,win,0);
%*********comment in or out to control from here


% whichScreen = screenid;
window = win;
% b = backg
% resol = get(0,'Monitorpositions');
screenresx = srect(3);%resol(2,3)-resol(1,3);
screenresy = srect(4);%resol(2,4);
liney = screenresy-30;
linex = 30;
tstartfull = GetSecs;
intframe = msinterval/100*6;
intervals = [0:4:intframe];
% intervals2 =[2 4 16 64 128 256 512];
reps = length(intervals);
for jj = 1:epochreps
for k = 1:(sum(intervals)*2)
        if(mod(k,2) == 0)
            Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        if(mod(k,6) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(win,'Flip');
end % standing gray
for i = 1:reps-1
    for j = 1:intervals((reps+1)-i)
        Screen(window, 'FillRect', [255 255 255]);
        if (mod(j,6) ==0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(window,'Flip');
    end % on
    for k = 1:intervals((reps+1)-i)
        
        Screen(window, 'FillRect', [0 0 0]);
        if (mod(k,6) ==0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(window,'Flip');
    end % off
end % linear chirp
end
Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
Screen(window,'Flip');
% Screen('CloseAll');
end
% KbWait;
