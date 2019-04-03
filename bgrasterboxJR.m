function bgrasterboxJR(w,srect,r,msinterval,displacement,xnum,ynum,flashes, xcenter,ycenter,intensity,gray,graymultiple)
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

stepx = floor(xnum/2); % how many steps to the left
xstart = x - stepx*displacement; % how far to the left
d = 2*r;

if mod(ynum,2) == 0
    ystart = y+r;
else
    ystart = y;
end

stepy = floor(ynum/2);
ystart = ystart - stepy*d;

for f = 1:flashes % repetitions
    lx = xstart - r;
    rx = xstart + r;
    ty = ystart - r;
    by = ystart + r;
%     Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
%     Screen('FillRect',w, [255 0 0], [0, liney, screenresx, screenresy]);
%     Screen('Flip', w);
    
    for k = 1:(framenum*xnum)
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

    for i = 1:ynum
        for j = 1:xnum
                for m = 1:(framenum*2)
                    Screen(w, 'FillRect', [0 0 0]); 
                    Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                    if(mod(m,2) == 0)
                        Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                    else
                        Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                    end
                    Screen(w,'Flip');
                end % black
            for n = 1:framenum
                Screen('FillRect', w,[intensity intensity intensity],[lx,ty,rx,by]);
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                if(mod(n,6) == 0)
                    Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                end
                Screen('Flip', w);
            end % flash
                for m = 1:(framenum*2)
                    Screen(w, 'FillRect', [0 0 0]); 
                    Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                    if(mod(m,2) == 0)
                        Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
                    else
                        Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
                    end
                    Screen(w,'Flip');
                end % black
            lx = lx + displacement;
            rx = rx + displacement;
        end
            ty = ty + d;
            by = by + d;
            lx = xstart - r;
            rx = xstart + r;
     end % stim sequence

end%
Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
Screen('Flip', w);
% Screen('Closeall');
end
