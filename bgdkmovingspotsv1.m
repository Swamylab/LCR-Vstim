function bgdkmovingspotsv1(window,srect,realxv,length, totalwidth, periodtime, repeats,bardiv,xc,yc,backg,foreg,gray)
% function dkmovingspots(realxv,length, totalwidth, periodtime, repeats,bardiv,xc,yc,backg,foreg)
% 
% KbName('UnifyKeyNames');
% screenid = 2;
% 
% % stops psychtoolbox init screen from appearing
% Screen('Preference', 'VisualDebugLevel', 3);
% Screen('Preference', 'SuppressAllWarnings', 1);
% 
% [window, srect] = Screen('OpenWindow', screenid,[0 backg backg]);


% frate = Screen('FrameRate', window);
w = srect(3);
h = srect(4);
%   ifi = Screen('GetFlipInterval', window);
%   vbl=Screen('Flip', window);
liney = h - 30;
linex = 30;
% DIM: will use liney to make red flashing bar for frame counter

% For example, if period time is 2, and stime time is 2, then it will do 4
% half periods or 2 full periods
%distancexy = realxv * periodtime*frate; %dist from vel,time,and current frame rate
duration = periodtime*60; %how many periods do you want the bar to travel
offset = totalwidth/2-totalwidth/bardiv/2;
width = totalwidth/bardiv;
 
% white = 255; % pixel value for white
% black = 0; % pixel value for black
% gray = (white+black)/2;
% inc = white-gray;
% Screen(window, 'FillRect', [0 backg backg]);
% Screen(window,'Flip');

[x,y] = meshgrid(-width/2:+width/2, -length/2:+length/2);
m = ones(size(x,1),size(x,2));

% Use these if gray is actually halfway between white and black
% w1 = Screen('MakeTexture', window, gray+inc*m);
% w2 = Screen('MakeTexture', window, gray+inc*n);
w1 = Screen('MakeTexture', window, foreg*m);

dstRect=[0 0 width length];


for i = 1:repeats
    %% 0. gray screen
for k = 1:(duration*8)-60-30
    if(mod(k,2) == 0)
        Screen('DrawTexture', window, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
    else
        Screen('DrawTexture', window, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
    end 
        Screen('FillRect',window, [0 0 0], [0, liney, linex, h]);
        if(mod(k,2) == 0)
            Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
        else
            Screen('FillRect',window, [0 0 0], [0, liney, linex, h]);
        end
    Screen(window,'Flip');
end % 
%% 0.5 quickflash
for j = 1:60        
    Screen(window, 'FillRect', [255 255 255]);
    Screen('FillRect',window, [0 0 0], [0, liney, linex, h]);
    if(mod(j,2) == 0)
        Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
    else
        Screen('FillRect',window, [0 0 0], [0, liney, linex, h]);
    end
    Screen(window,'Flip');
end
for m = 1:30
    Screen(window, 'FillRect', [0 0 0]); 
    Screen('FillRect',window, [0 0 0], [0, liney, linex, h]);
    if(mod(m,2) == 0)
        Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
    else
        Screen('FillRect',window, [0 0 0], [0, liney, linex, h]);
    end
    Screen(window,'Flip');
end
%% 1.east to west
    xstart = xc+duration/2*realxv;
    ystart = yc-offset;
    for k = 1:bardiv        
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 90, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart-realxv*j,ystart);
        end
        ystart = ystart+width;
    end
%% 2.nw to se
    xstart = xc-duration/2*realxv/sqrt(2)+offset/sqrt(2);
    ystart = yc-duration/2*realxv/sqrt(2)-offset/sqrt(2);
    for k = 1:bardiv
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 135, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart+realxv*j/sqrt(2),ystart+realxv*j/sqrt(2));
        end
        xstart = xstart-width/sqrt(2);
        ystart = ystart+width/sqrt(2);
    end
    
%% 3.s to n
    xstart = xc-offset;
    ystart = yc+duration/2*realxv;
    for k = 1:bardiv
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 0, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart,ystart-realxv*j);
        end
        xstart = xstart+width;
    end
    
%% 4.ne to sw
    xstart = xc+duration/2*realxv/sqrt(2)-offset/sqrt(2);
    ystart = yc-duration/2*realxv/sqrt(2)-offset/sqrt(2);
    for k = 1:bardiv
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 45, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart-realxv*j/sqrt(2),ystart+realxv*j/sqrt(2));
        end
        xstart = xstart+width/sqrt(2);
        ystart = ystart+width/sqrt(2);
    end
    
%% 5.w to e
    xstart = xc-duration/2*realxv;
    ystart = yc-offset;
    for k = 1:bardiv
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 90, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart+realxv*j,ystart);
        end
        ystart = ystart+width;
    end
    
%% 6.se to nw
    xstart = xc+duration/2*realxv/sqrt(2)+offset/sqrt(2);
    ystart = yc+duration/2*realxv/sqrt(2)-offset/sqrt(2);
    for k = 1:bardiv
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 135, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart-realxv*j/sqrt(2),ystart-realxv*j/sqrt(2));
        end
        xstart = xstart-width/sqrt(2);
        ystart = ystart+width/sqrt(2);
    end
        
%% 7.n to s
    xstart = xc-offset;
    ystart = yc-duration/2*realxv; 
    for k = 1:bardiv        
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 0, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart,ystart+realxv*j);
        end
        xstart = xstart+width;
    end
    
%% 8.sw to ne
    xstart = xc-duration/2*realxv/sqrt(2)-offset/sqrt(2);
    ystart = yc+duration/2*realxv/sqrt(2)-offset/sqrt(2);
    for k = 1:bardiv
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
        for j = 1:duration        
            Screen('DrawTexture', window, w1, [], dstRect, 45, [0], [0], [255, 255, 255], 0);         
            if mod(j,6) ==1
                Screen('FillRect',window, [255 255 255], [0, liney, linex, h]);
            end
            Screen(window,'Flip');
            dstRect=CenterRectOnPoint(dstRect,xstart+realxv*j/sqrt(2),ystart-realxv*j/sqrt(2));
        end
        xstart = xstart+width/sqrt(2);
        ystart = ystart+width/sqrt(2);
    end
end
%% end on a red frame 
Screen('DrawTexture', window, gray(1), [], srect, [], [], [], [255, 255, 255], 0);   
Screen('FillRect',window, [0 0 0], [0, liney, linex, h]);
Screen('FillRect',window, [255 22 255], [0, liney, linex, h]);
Screen(window,'Flip');
% Screen('CloseAll');

return