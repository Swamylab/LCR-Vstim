function bgdkmovingbarv1(w,srect,realxv,length, width, periodtime, repeats,xc,yc,foreg,gray)
% bgdkmovingbar(w,srect,realxv,length, width, periodtime, repeats,xc,yc,foreg,gray)
%*********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [w, srect] = Screen('OpenWindow', 0,[0 0 0],[0 0 500 500]); % for a 500x500 testing window
% % [w, srect] = Screen('OpenWindow', 1,[0 0 0]); % for a fullscreen testing window
% [gray] = temporalgrey1(2,srect,w,0);
%*********

% frate = Screen('FrameRate', window);
wid = srect(3);
height = srect(4);
%   ifi = Screen('GetFlipInterval', window);
%   vbl=Screen('Flip', window);
liney = height - 30;
linex = 30;
% DIM: will use liney to make red flashing bar for frame counter

 % For example, if period time is 2, and stime time is 2, then it will do 4
 % half periods or 2 full periods
 %distancexy = realxv * periodtime*frate; %dist from vel,time,and current frame rate
 duration = periodtime*60; %how many periods do you want the bar to travel
 
% white = 255; % pixel value for white
% black = 0; % pixel value for black
% gray = (white+black)/2;
% inc = white-gray;
% Screen(w, 'FillRect', [backg backg backg]);
% Screen(w,'Flip');

[x,y] = meshgrid(-width/2:+width/2, -length/2:+length/2);
front = ones(size(x/2,1),size(x/2,2));
back = zeros(size(x/2,1),size(x/2,2));
m = front;

% Use these if gray is actually halfway between white and black
% w1 = Screen('MakeTexture', window, gray+inc*m);
% w2 = Screen('MakeTexture', window, gray+inc*n);
w1 = Screen('MakeTexture', w, foreg*m);

dstRect=[0 0 width length];

% for i = 1:2
%     for a = 1:30
%         Screen(window, 'FillRect', [0 backg backg]);
%         Screen(window,'Flip');
%     end
%     for j = 1:60        
%         Screen(window, 'FillRect', [0 foreg foreg]);        
%         Screen(window,'Flip');
%     end
%     for m = 1:30
%         Screen(window, 'FillRect', [0 backg backg]);        
%         Screen(window,'Flip');
%     end
% end
 

for i = 1:repeats
%% 0. gray screen
for k = 1:(duration*8)-60-30
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(k,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
end % 
%% 0.5 quickflash
    for j = 1:60        
        Screen(w, 'FillRect', [255 255 255]);
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
    end
    for m = 1:30
        Screen(w, 'FillRect', [0 0 0]); 
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(m,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
    end

%% 1.east to west
    xstart = xc+duration/2*realxv;
    ystart = yc;    
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration   
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end
        Screen('DrawTexture', w, w1, [], dstRect, 90, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart-realxv*j,ystart);
    end    
    
%% 2.nw to se
    xstart = xc-duration/2*realxv/sqrt(2);
    ystart = yc-duration/2*realxv/sqrt(2);
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration        
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end
        
        Screen('DrawTexture', w, w1, [], dstRect, 135, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart+realxv*j/sqrt(2),ystart+realxv*j/sqrt(2));
    end    
    
%% 3.s to n
    xstart = xc;
    ystart = yc+duration/2*realxv;    
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration        
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end
        Screen('DrawTexture', w, w1, [], dstRect, 0, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart-realxv*j);
    end
    
%% 4.ne to sw
    xstart = xc+duration/2*realxv/sqrt(2);
    ystart = yc-duration/2*realxv/sqrt(2);
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration        
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end
        Screen('DrawTexture', w, w1, [], dstRect, 45, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart-realxv*j/sqrt(2),ystart+realxv*j/sqrt(2));
    end
    
%% 5.w to e
    xstart = xc-duration/2*realxv;
    ystart = yc;    
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration        
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end        
        Screen('DrawTexture', w, w1, [], dstRect, 90, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart+realxv*j,ystart);
    end
   
%% 6.se to nw
    xstart = xc+duration/2*realxv/sqrt(2);
    ystart = yc+duration/2*realxv/sqrt(2);
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration        
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end
        Screen('DrawTexture', w, w1, [], dstRect, 135, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart-realxv*j/sqrt(2),ystart-realxv*j/sqrt(2));
    end
    
%% 7.n to s
    xstart = xc;
    ystart = yc-duration/2*realxv;    
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration        
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end        
        Screen('DrawTexture', w, w1, [], dstRect, 0, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart,ystart+realxv*j);
    end
    
%% 8.sw to ne
    xstart = xc-duration/2*realxv/sqrt(2);
    ystart = yc+duration/2*realxv/sqrt(2);
    dstRect=CenterRectOnPoint(dstRect,xstart,ystart);
    for j = 1:duration        
%         if(mod(j,2) == 0)
%             Screen('DrawTexture', w, gray2(1), [], srect, [], [], [], [0, 255, 255], 0);   
%         else
%             Screen('DrawTexture', w, gray2(2), [], srect, [], [], [], [0, 255, 255], 0);   
%         end        
        Screen('DrawTexture', w, w1, [], dstRect, 45, [0], [0], [255, 255, 255], 0);         
        Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        if(mod(j,2) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, height]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
        end
        Screen(w,'Flip');
        dstRect=CenterRectOnPoint(dstRect,xstart+realxv*j/sqrt(2),ystart-realxv*j/sqrt(2));
    end
    
  
end
%% end on a red frame 
Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);   
Screen('FillRect',w, [0 0 0], [0, liney, linex, height]);
Screen('FillRect',w, [255 22 255], [0, liney, linex, height]);
Screen(w,'Flip');
% Screen('CloseAll');

return