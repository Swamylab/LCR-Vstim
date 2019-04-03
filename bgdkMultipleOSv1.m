function bgdkMultipleOSv1(numRec,width, msinterval,intensity, xc,yc,repeats,graymultiple)
% to run from outside the arguments look like this: (win,srect,numRec,Rotation,width, msinterval,intensity, xc,yc,repeats,gray,graymultiple)
% % % *********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% 
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [win, srect] = Screen('OpenWindow', 0,[0 0 0],[0 0 500 500]); % for a 500x500 testing window
% %[win, srect] = Screen('OpenWindow', 1,[0 0 0]); % for a full screen testing window
% [gray] = temporalgrey1(2,srect,win,0);
% 
% % [wid, hei]=Screen('DisplaySize',screenid)
% % % *********comment in or out to control from here
[wid, hei]=Screen('DisplaySize',screenid)

length = 2*sqrt(wid^2+hei^2);
Rotation = 4;
screenresx = srect(3);  %srect(2,3)-srect(1,3);
screenresy = srect(4); %srect(2,4);
liney = screenresy-30;
linex = 30;
dstRect=[0 0 width length];
interval = msinterval/100*6;

% make texture
[x,y] = meshgrid(-width/2:+width/2, -length/2:+length/2);
front = ones(size(x/2,1),size(x/2,2));
w1 = Screen('MakeTexture', win, 255*front);

startpos = floor(width/2)*(numRec-1);%set start position

for reps = 1:repeats
    for k = 1:(interval)
        if(mod(k,2) == 0)
            Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if (k ==1)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
        if (mod(k,6) ==0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        end
        Screen(win,'Flip');
    end %gray screen
    %% Bar Flash
    for i = 1:Rotation% set 4 cardinal planes.
        switch i
            case 1 % vertical
                xmod = -1;
                ymod = 0;
            case 2 %45 degrees slope up
                xmod = -sqrt(2)/2;
                ymod = -sqrt(2)/2;
            case 3 %horizontal
                xmod = 0;
                ymod = -1;
            case 4 %45 degrees slope down
                xmod = sqrt(2)/2;
                ymod = -sqrt(2)/2;
        end
        
        for j=1:numRec
            angle = i*(180/Rotation)-(180/Rotation);%will always start at 0 degrees and go up
            dstRect=CenterRectOnPoint(dstRect,xc-xmod*(startpos+(j-1)*width),yc-ymod*(startpos+(j-1)*width));% jump and shift between each loop
            for k = 1:((interval*2)+((interval*graymultiple)*2))
                if(mod(k,2) == 0)
                    Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
                if (mod(k,6) ==0)
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
                Screen('DrawTexture', win, w1, [], dstRect, angle, [0], [0], [0, 0, 0], 0);
                Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
                if (mod(k,6) ==0)
                    Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen(win,'Flip');
            end %black bar
            for k = 1:interval
                if(mod(k,2) == 0)
                    Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('DrawTexture', win, w1, [], dstRect, angle, [0], [0], [intensity, intensity, intensity], 0);
                Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
                if (mod(k,6) ==0)
                    Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen(win,'Flip');
            end %white bar
            for k = 1:interval
                if(mod(k,2) == 0)
                    Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('DrawTexture', win, w1, [], dstRect, angle, [0], [0], [0, 0, 0], 0);
                Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
                if (mod(k,6) ==0)
                    Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen(win,'Flip');
            end %black bar
            for k = 1:(interval*graymultiple)
                if(mod(k,2) == 0)
                    Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
                if (mod(k,6) ==0)
                    Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen(win,'Flip');
            end %gray spacer
        end
    end % spot loop
end
%% end on a red frame 
Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
Screen(win,'Flip');
Screen('CloseAll');

return