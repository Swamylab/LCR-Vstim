function gScreenchopv1(w ,srect,chopx,chopy,msinterval,flashnum,gray,graymultiple)
% gScreenchopv1 (w ,srect, chopx, chopy, msinterval, flashnum,gray,graymultiple)
%***********************************************************************
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 0)
% [w, srect] = Screen('OpenWindow', screenid,[0 0 0],[0 0 500 500]); % 500x500 full screen testing
% % [w, srect] = Screen('OpenWindow', screenid,[0 0 0]); % for full screen testing
% [gray] = temporalgrey1(2,srect,w,0);
%*************************************************************************
screenresx = srect(3);
screenresy = srect(4);
liney = screenresy-30;
linex = 30;
intframe = msinterval/100*6;

xpix = screenresx/chopx;
ypix = screenresy/chopy;
for k = 1:flashnum   
a = 0;
b = 0;
c = xpix-1;
d = ypix-1;

for i = 1:chopy     
    for j = 1:chopx
        
            for kk = 1:((intframe*2)+((intframe*graymultiple)*2))
                if(mod(kk,2) == 0)
                    Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [0, 255, 255], 0);
                else
                    Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [0, 255, 255], 0);
                end
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(kk == 1)
                    Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
                end
                if(mod(kk,6) == 1)
                    Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
                end
                Screen(w,'Flip');
            end % gray sequence 
            for m = 1:intframe
                if(mod(m,2) == 0)
                    Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                
                Screen('FillRect',w, [0 0 0], [a b c d]);
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(m,6) == 1)
                    Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
                end
                Screen(w,'Flip');
            end % Off
            for l = 1:intframe
                if(mod(l,2) == 0)
                    Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect',w, [255 255 255], [a b c d]);       
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(m,6) == 1)
                    Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
                end            
                Screen(w,'Flip');
            end % On
            for m = 1:intframe
                if(mod(m,2) == 0)
                    Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                
                Screen('FillRect',w, [0 0 0], [a b c d]);
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(m,6) == 1)
                    Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
                end
                Screen(w,'Flip');
            end % Off
        a = a + xpix;
        c = c + xpix;
    end
    a = 0;
    b = b+ypix-1;
    c = xpix-1;
    d = d+ypix-1;
end
end%
Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
Screen(w,'Flip');

%KbWait;
% Screen('CloseAll');
end