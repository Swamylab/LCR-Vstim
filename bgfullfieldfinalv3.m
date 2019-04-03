function bgfullfieldfinalv3 (win,srect,msinterval,reps,gray,graymultiple)
%  bgfullfieldfinalv3 (win,srect,msinterval,reps,gray,graymultiple)
%*********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
%  [win, srect] = Screen('OpenWindow', 0,[0 0 0],[0 0 500 500]); % for a 500x500 testing window
% % [win, srect] = Screen('OpenWindow', 1,[0 0 0]); % full screen testing
% [gray] = temporalgrey1(2,srect,win,0);
%*********comment in or out to control from here


% whichScreen = screenid;
window = win;
% resol = get(0,'Monitorpositions');
screenresx = srect(3);%resol(2,3)-resol(1,3);
screenresy = srect(4);%resol(2,4);
liney = screenresy-30;
linex = 30;
intframe = msinterval/100*6;

% stimtrack(1) = .5;
for i = 1:reps
    for k = 1:((intframe*3)+((intframe*graymultiple)))
        if(mod(k,2) == 0)
            Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if(k == 1)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy])
        end
        if(mod(k,6) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
%         stimtrack(end+1) = .5;
        Screen(win,'Flip');
    end % initial gray
    for k = 1:intframe 
        Screen(window, 'FillRect', [0 0 0]);
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(k,6) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
%         stimtrack(end+1) = 0;
        Screen(window,'Flip');
    end % off
    for j = 1:intframe
        Screen(window, 'FillRect', [255 255 255]);
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(j,6) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
%         stimtrack(end+1) = 1;
        Screen(window,'Flip');
    end % on
    for k = 1:intframe
        Screen(window, 'FillRect', [0 0 0]);
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(k,6) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
%         stimtrack(end+1) = 0;
        Screen(window,'Flip');
    end % off
    for k = 1:intframe*graymultiple
        if(mod(k,2) == 0)
            Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(k,6) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
%         stimtrack(end+1) = .5;
        Screen(window,'Flip');
    end %grey
end
Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
Screen(window,'Flip');
% KbWait;
% Screen('CloseAll');
end
