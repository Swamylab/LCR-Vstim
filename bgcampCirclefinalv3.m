function bgcampCirclefinalv3(win,srect,r, msinterval, n,intensity, centerx,centery,creps,gray,graymultiple)
% to run from outside the arguments look like this: (win,srect,r, msinterval, n,intensity, centerx,centery,creps,gray,graymultiple)
% %*********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% 
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [win, srect] = Screen('OpenWindow', 0,[0 0 0],[0 0 500 500]); % for a 500x500 testing window
% % [win, srect] = Screen('OpenWindow', 1,[0 0 0]); % for a full screen testing window
% [gray] = temporalgrey1(2,srect,win,0);
% %*********comment in or out to control from here

screenresx = srect(3);  %srect(2,3)-srect(1,3);
screenresy = srect(4); %srect(2,4);
liney = screenresy-30;
linex = 30;
tstartcircle = 0;
tstartcircle = GetSecs;
interval = msinterval/100*6;

for circlereps = 1:creps
    for kk = 1:(interval)
        if(mod(kk,2) == 0)
            Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if (kk ==1)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
        if (mod(kk,6) ==0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
        Screen(win,'Flip');
    end %gray screen
    for i = 1:n
        a = centerx-r*i;
        b = centerx+r*i;
        c = centery-(r)*i;
        d = centery+(r)*i;
        for kk = 1:((interval*2)+((interval*graymultiple)*2))
            if(mod(kk,2) == 0)
                Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
            else
                Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
            if (mod(kk,6) ==0)
                Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
            end
            Screen(win,'Flip');
        end %gray screen
        for k = 1:interval
            if(mod(k,2) == 0)
                Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
            else
                Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
            Screen('FillOval',win, [0 0 0], [a c b d]);
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
            if (mod(k,6) ==0)
                Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
            end
            Screen(win,'Flip');
        end %black spot
        for j = 1:interval
            if(mod(j,2) == 0)
                Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
            else
                Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
            Screen('FillOval',win, [intensity intensity intensity], [a c b d]);
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
            if (mod(j,6) ==0)
                Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
            end
            Screen(win,'Flip');
        end %white spot
        for k = 1:interval
            if(mod(k,2) == 0)
                Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
            else
                Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
            Screen('FillOval',win, [0 0 0], [a c b d]);
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
            if (mod(k,6) ==0)
                Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
            end
            Screen(win,'Flip');
        end %black spot
        for j = 1:(interval*graymultiple)
            if(mod(j,2) == 0)
                Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
            else
                Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
            if (mod(j,6) ==0)
                Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
            end
            Screen(win,'Flip');
        end %gray spacer
    end % spot loop
end
Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
Screen(win,'Flip');


% KbWait;
% Screen('CloseAll');
end