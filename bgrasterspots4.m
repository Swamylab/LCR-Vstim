function bgrasterspots4(w,srect,r,msinterval,xspots,yspots,flashes, xcenter,ycenter,intensity,gray,graymultiple)
% bgrasterspots3 (w,srect,r,msinterval,xspots,yspots,flashes, xcenter,ycenter,backg,intensity,gray,graymultiple)
%***********************************************************************
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% 
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [w, srect] = Screen('OpenWindow', 0,[0 0 0],[0 0 500 500]); % for a 500x500 testing window
% % [w, srect] = Screen('OpenWindow', 1,[0 0 0]);
% [gray] = temporalgrey1(2,srect,w,0);
%*************************************************************************
screenresx = srect(3);
screenresy = srect(4);
liney = screenresy-30;
linex = 30;
x = xcenter;
y = ycenter;

framenum = msinterval/100*6;

d = 2*r;

if mod(xspots,2) == 0
    xstart = x+r;
else
    xstart = x;
end

if mod(yspots,2) == 0
    ystart = y+r;
else
    ystart = y;
end

stepx = floor(xspots/2);
xstart = xstart - stepx*d;
stepy = floor(yspots/2);
ystart = ystart - stepy*d;

for k = 1:flashes
    lx = xstart-r;
    ty = ystart-r;
    rx = xstart+r;
    by = ystart+r;
%     Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
%     Screen('FillRect',w, [255 0 0], [0, liney, screenresx, screenresy]);
%     Screen('Flip', w);
    
    for i = 1:yspots
        for j = 1:xspots
            for k = 1:((framenum*3)+((framenum*graymultiple)))
                if(mod(k,2) == 0)
                    Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(k,6) == 0)
                    Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen(w,'Flip');
            end % gray sequence
            for n = 1:framenum
                if(mod(n,2) == 0)
                    Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect', w,[0 0 0],[lx,ty,rx,by]);
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(n,6) == 0)
                    Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen('Flip', w);
            end %black
            for m = 1:framenum
                if(mod(m,2) == 0)
                    Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect', w,[intensity intensity intensity],[lx,ty,rx,by]);
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(m,6) == 0)
                    Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen('Flip', w);
            end %white
            for n = 1:framenum
                if(mod(n,2) == 0)
                    Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect', w,[0 0 0],[lx,ty,rx,by]);
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(n,6) == 0)
                    Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen('Flip', w);
            end %black
            for n = 1:framenum*graymultiple
                if(mod(n,2) == 0)
                    Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                else
                    Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                end
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(n,6) == 0)
                    Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen('Flip', w);
            end %gray
            
            lx = lx + d;
            rx = rx + d;
        end
        by = by + d;
        ty = ty + d;
        lx = xstart-r;
        rx = xstart+r;
    end % stim sequence
end%
Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
Screen('Flip', w);
% Screen('Closeall');
end
