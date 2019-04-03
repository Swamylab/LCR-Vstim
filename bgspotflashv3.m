function  bgspotflashv3(w,srect,size,msinterval,reps,onval,offval,cx,cy,gray,graymultiple)
% bgspotflashv2 (w,srect,size,msinterval,reps,onval,offval,cx,cy,backg,gray,graymultiple)
%*********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', screenid)
% [w, srect] = Screen('OpenWindow', screenid,[0 0 0],[0 0 500 500]); % 500x500 screen testing
% % [w, srect] = Screen('OpenWindow', screenid,[0 0 0]); % full screen testing
% [gray] = temporalgrey1(2,srect,w,0);
%*********


screenresx = srect(3);%resol(2,3)-resol(1,3);
screenresy = srect(4);%resol(2,4);
liney = screenresy-30;
linex = 30;

% Screen('DrawTexture', window, whichScreen, 51[], [], [], [0], [0], [0, 255, 255], 0);
intframe = msinterval/100*6;
ovalsize = [(cx - size), (cy-(size)), (cx+size), (cy+(size))];
onvalue = [onval onval onval];
offvalue = [offval offval offval];
%onval = [0 0 0];
for i = 1:reps
    for kk = 1:((intframe*2)+((intframe*graymultiple)*1))
        if(mod(kk,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        if(mod(kk,6) == 1)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end %gray initial
    for k = 1:intframe
        
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);   
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);   
        end
        Screen('FillOval',w,offvalue, ovalsize);
        
        if(mod(k,6) == 1)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
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
        Screen('FillOval',w,onvalue, ovalsize);
        
        if(mod(j,6) == 1)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
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
        Screen('FillOval',w,offvalue, ovalsize);
        
        if(mod(k,6) == 1)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
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
        
        if(mod(k,6) == 1)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end % gray
end
Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
Screen(w,'Flip');
% % KbWait;
% Screen('CloseAll');
end
