function bgtetflashv3(w,srect,rectsize,msinterval,reps,onval,offval,scale,tetris,XC,YC,gray,graymultiple)
% bgtetflashv2 (w, srect, rectsize,msinterval,reps,onval,offval,scale,tetris,XC,YC,gray,graymultiple)
%*********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [w, srect] = Screen('OpenWindow', screenid,[0 0 0],[0 0 500 500]); % 500x500 screen testing
% % [w, srect] = Screen('OpenWindow', screenid,[0 0 0]);
% [gray] = temporalgrey1(2,srect,w,0);
%*********

xc = XC;
yc = YC;

box1 = NoiseToTetris(tetris,scale,rectsize,xc,yc);

screenresx = srect(3);%resol(2,3)-resol(1,3);
screenresy = srect(4);%resol(2,4);
liney = screenresy-30;
linex = 30;
[tetrisrects] = NoiseToTetris(tetris,scale,rectsize,xc,yc);
intframe = msinterval/100*6;

for i = 1:reps
    for k = 1:((intframe*3)+((intframe*graymultiple)))
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        if (mod(k,6) == 0)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end % gray initial
    for k = 1:intframe
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end
        Screen('FillRect',w, [0 0 0],tetrisrects);
        if (mod(k,6) == 0)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end % off
    for j = 1:intframe
        if(mod(j,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end
        Screen('FillRect',w, [onval onval onval],tetrisrects);
        if (mod(j,6) == 0)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end % on
    for k = 1:intframe
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end
        Screen('FillRect',w, [offval offval offval],tetrisrects);
        if (mod(k,6) == 0)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end % off
    for k = 1:intframe*graymultiple
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end  
        if (mod(k,6) == 0)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end % gray
end
Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
Screen(w,'Flip');

% KbWait;
% Screen('CloseAll');
end
