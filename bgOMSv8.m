function bgOMSv8(w,srect,shift, sf, oangle,osize,reps,bgangle,Cx,Cy,backg,numperiods,Diffdelay,csize,scale,rcenter,rectsize,selector,tetris,cort,topval,gray)
% bgOMSv7(w,srect,shift, sf, oangle,osize,reps,bgangle,Cx,Cy,backg,numperiods,Diffdelay,csize,scale,rcenter,rectsize,selector,tetris,cort,topval,gray)
%**** COMMENT OUT TO CONTROL FROM OUTSIDE
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% 
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [w, srect] = Screen('OpenWindow', 1,[0 0 0]);
% [gray] = temporalgrey1(2,srect,w);
%**** COMMENT OUT TO CONTROL FROM OUTSIDE

% w = window; % CHANGE TO CONTROL FROM OUTSIDE TO win
% srect = winRect; %srect; % MAKE IT EQUAL TO srect TO CONTROL FROM OUTSIDE; make it equal to the screen for inside ie:[0 0 1280 1024] screenresx =srect(3); % MAKE EQUAL TO srect(3)TO CONTROL FROM OUTSIDE;
screenresx =srect(3); % MAKE EQUAL TO srect(3)TO CONTROL FROM OUTSIDE;
screenresy = srect(4); %MAKE EQUAL TO srect(4)TO CONTROL FROM OUTSIDE;
liney = screenresy-30;
linex = 30;
AssertOpenGL; % CHECK IN STIMCONTROL

crect = check2shape(tetris,scale,rcenter,rectsize,selector,Cx,Cy);

texsize=srect(3)/2; % Half-Size of the grating image.
% white=255;
% black=0;
f= 1/sf;  %/100;
% gray= 125;
p=ceil(1/f);
% frameshift = stimtime/1000*60; OLD
frameshift = p*numperiods/shift;
ddelay = Diffdelay/1000*60;
fr=f*2*pi;
visiblesize=2.5*texsize;
if cort == 1
    lx = min(crect(1,:));
    rx = max(crect(3,:));
    ty = min(crect(2,:));
    by = max(crect(4,:));
    xdim = rx-lx;
    ydim = by-ty;
    if xdim > ydim
        osize1 = xdim;
    else
        osize1 = ydim;
    end
    visible2size = 1.6*osize1;
else
    visible2size=osize;
end

%DIM: add line below and remove line 2 below to make stimulus run for
%certain number of spatial periods instead of for defined amount of time
[x,y]=meshgrid(-texsize:texsize + p*numperiods, 1);
%[x,y]=meshgrid(-texsize:texsize + frameshift*shift, 1);
[x2,y2]=meshgrid(-texsize:texsize,-texsize:texsize);

grating= topval + topval*square(fr*x);
% mask = gray * (x2.^2 + y2.^2 <= (texsize)^2);
gratingblank = backg(2) + (0 * x2);
gratingtex=Screen('MakeTexture', w, grating);
masktex=Screen('MakeTexture', w, gratingblank);

dstRect=[0 0 visiblesize visiblesize];
% dstRect=CenterRect(dstRect, screenRect);
% dstRect=CenterRectOnPoint(dstRect,CscreenX,CscreenY);
dst2Rect=[0 0 visible2size visible2size];
graysize = sqrt((visible2size)^2 + (visible2size)^2);
grayrect = [0 0 (graysize+csize) (graysize+csize)];
dst2Rect=CenterRectOnPoint(dst2Rect,Cx,Cy);
gray2rect = CenterRectOnPoint(grayrect,Cx,Cy);
% dst2Rect=CenterRect(dst2Rect, dstRect);

% DIM: remove frameshift definition above (line ~ 28), change stimtime
% in command line to number of periods, and add line below to make stimulus
% run for defined number of periods instead of for a set number of frames
% frameshift = p*numperiods/shift;

xstep = zeros(frameshift);

for r = 1:frameshift
    xstep(r) = r*shift;
end
xstep(1) = 0;
for g = 1:reps
    %% GRAY screen
    for k = 1:((frameshift+ddelay)*6)
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        if(mod(k,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end
    %% Differential Motion
    
    %% background shift to left with delay
    %background shift to the left
    for q = 1:frameshift
        srcRect=[xstep(q) 0 xstep(q) + visiblesize visiblesize];
        Screen('DrawTexture', w, gratingtex, srcRect, dstRect, bgangle, [], [], [255, 255, 255], 0);
        if (q == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        Screen('FillOval', w, backg, gray2rect);
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        if(mod(q,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, bgangle, [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, bgangle, [], [], [255, 255, 255], 0);
        end
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        if cort == 1
            Screen('FillRect', w, [0 0 0 255], crect);
        else
            Screen('FillOval', w, [0 0 0 255], dst2Rect);
        end
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        Screen('DrawTexture', w, gratingtex, srcRect, dstRect, bgangle, [], [], [255, 255, 255], 0);
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        if(mod(q,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
        pauserect = srcRect;
    end
    % I WANT TO PUT A DELAY IN HERE TO INCREASE THE DELAY TIME BETWEEN
    % GLOBAL AND LOCAL SHIFTS
    for cc = 1:ddelay
        Screen('DrawTexture', w, gratingtex, pauserect, dstRect, bgangle, [], [], [255, 255, 255]);
        if(mod(cc,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
    end %DELAY LOOP
    %% object shift to the right with delay
    
    %object shift to the right
    for k = 1:frameshift
        %run the object grating back a full period here we are creating a count-down indext to go backwards through the array xstep. u = p-t+1;
        %the coordinates of a rectangle within gratingtex to copy the grating from
        srcRect=[xstep(1), 0, xstep(1) + visiblesize, visiblesize];
        %the coordinates of a rectangle within grantingtex to copy the object grating from. ideally this should be the same starting area
        % as the one used in the destination grating
        src2Rect = dst2Rect + [xstep(frameshift-k+1), 0, xstep(frameshift-k+1), 0];
        %Draw grating texture, rotated by "angle":
        Screen('DrawTexture', w, gratingtex, srcRect, dstRect, bgangle, [], [], [255, 255, 255], 0);
        
        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        Screen('FillOval', w, backg, gray2rect);
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, bgangle, [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, bgangle, [], [], [255, 255, 255], 0);
        end
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        if cort == 1
            Screen('FillRect', w, [0 0 0 255], crect);
        else
            Screen('FillOval', w, [0 0 0 255], dst2Rect);
        end
        
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        Screen('DrawTexture', w, gratingtex, src2Rect, dst2Rect, oangle,[], [], [255, 255, 255], 0);% replaced dst2Rect with srcRect
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        if(mod(k,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
    end    
    %another delay loop here for symmetry
    for hh = 1:ddelay
        Screen('DrawTexture', w, gratingtex, pauserect, dstRect, bgangle, [], [], [255, 255, 255]);
        if(mod(hh,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
    end %DELAY LOOP
    %% background shift to left with delay
    %background shift to the left
    for q = 1:frameshift
        srcRect=[xstep(q) 0 xstep(q) + visiblesize visiblesize];
        Screen('DrawTexture', w, gratingtex, srcRect, dstRect, bgangle, [], [], [255, 255, 255], 0);
        if (q == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        Screen('FillOval', w, backg, gray2rect);
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        if(mod(q,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, bgangle, [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, bgangle, [], [], [255, 255, 255], 0);
        end
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        if cort == 1
            Screen('FillRect', w, [0 0 0 255], crect);
        else
            Screen('FillOval', w, [0 0 0 255], dst2Rect);
        end
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        Screen('DrawTexture', w, gratingtex, srcRect, dstRect, bgangle, [], [], [255, 255, 255], 0);
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        if(mod(q,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
        pauserect = srcRect;
    end
    % I WANT TO PUT A DELAY IN HERE TO INCREASE THE DELAY TIME BETWEEN
    % GLOBAL AND LOCAL SHIFTS
    for cc = 1:ddelay
        Screen('DrawTexture', w, gratingtex, pauserect, dstRect, bgangle, [], [], [255, 255, 255]);
        if(mod(cc,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
    end %DELAY LOOP
    %% object shift to the right with delay
    
    %object shift to the right
    for k = 1:frameshift
        %run the object grating back a full period here we are creating a count-down indext to go backwards through the array xstep. u = p-t+1;
        %the coordinates of a rectangle within gratingtex to copy the grating from
        srcRect=[xstep(1), 0, xstep(1) + visiblesize, visiblesize];
        %the coordinates of a rectangle within grantingtex to copy the object grating from. ideally this should be the same starting area
        % as the one used in the destination grating
        src2Rect = dst2Rect + [xstep(frameshift-k+1), 0, xstep(frameshift-k+1), 0];
        %Draw grating texture, rotated by "angle":
        Screen('DrawTexture', w, gratingtex, srcRect, dstRect, bgangle, [], [], [255, 255, 255], 0);

        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        Screen('FillOval', w, backg, gray2rect);
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, bgangle, [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, bgangle, [], [], [255, 255, 255], 0);
        end
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        
        Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
        Screen('FillRect', w, [0 0 0 0], dstRect);
        if cort == 1
            Screen('FillRect', w, [0 0 0 255], crect);
        else
            Screen('FillOval', w, [0 0 0 255], dst2Rect);
        end
        
        Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
        Screen('DrawTexture', w, gratingtex, src2Rect, dst2Rect, oangle,[], [], [255, 255, 255], 0);% replaced dst2Rect with srcRect
        Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
        if(mod(k,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
    end    
    %another delay loop here for symmetry
    for hh = 1:ddelay
        Screen('DrawTexture', w, gratingtex, pauserect, dstRect, bgangle, [], [], [255, 255, 255]);
        if(mod(hh,6) == 1)
            Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen('Flip', w);
    end %DELAY LOOP
    %% Local Motion
    
    %% local motion to the left with delay
    
    %local motion
    % is the same as "object shift to the left" but this time with a
    % background texture that is solid
    for dk = 1:1
        for t = 1:frameshift
            %run the object grating back a full period here we are creating a count-down indext to go backwards through the array xstep. u = p-t+1;
            %the coordinates of a rectangle within gratingtex to copy the grating from
            srcRect=[xstep(p), 0, xstep(p) + visiblesize, visiblesize];
            %the coordinates of a rectangle within grantingtex to copy the object grating from. ideally this should be the same starting area
            % as the one used in the destination grating
            src2Rect = dst2Rect + [xstep(t), 0, xstep(t), 0];
            %Draw grating texture, rotated by "angle":
            if(mod(t,2) == 0)
               Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
               
            else
               Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
%             Screen('DrawTexture', w, masktex, srcRect, dstRect, bgangle, [], [], [0, 255, 255], 0);
            %Disable alpha-blending, restrict following drawing to alpha channel:
            Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
            %Clear 'dstRect' region of framebuffers alpha channel to zero:
            Screen('FillRect', w, [0 0 0 0], dstRect);
            %Fill circular 'dstRect' region with an alpha value of 255:
            if cort == 1
                Screen('FillRect', w, [0 0 0 255], crect);
            else
                Screen('FillOval', w, [0 0 0 255], dst2Rect);
            end
            %Enable DeSTination alpha blending and reenalbe drawing to all color
            %channels. Following drawing commands will only draw there the alpha value
            %in the framebuffer is greater than zero, ie., in our case, inside the
            %circular 'dst2Rect' aperture where alpha has been set to 255 by our 'FillOval' command:
            Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
            %Draw 2nd grating texture, but only inside alpha == 255 circular aperture, and at an angle of 90 degrees:
            Screen('DrawTexture', w, gratingtex, src2Rect, dst2Rect, oangle,[], [], [255, 255, 255], 0);% replaced dst2Rect with srcRect
            %Restore alpha blending mode for next draw iteration:
            Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
            if(mod(t,6) == 1)
                Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
            else
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
            end
            Screen('Flip', w);
            pauserect = src2Rect;
        end
        % ADD A THE SAME DELAY THATS GOING TO APPEAR IN THE DIFFERENTIAL PART
        % AS A DELAY HERE TO MAKE THE TIMES SPENT IN MOTION EQUAL TO DMOTION
        for ee = 1:ddelay
            %run the object grating back a full period here we are creating a count-down indext to go backwards through the array xstep. u = p-t+1;
            %the coordinates of a rectangle within gratingtex to copy the grating from
            srcRect=[xstep(p), 0, xstep(p) + visiblesize, visiblesize];
            %the coordinates of a rectangle within grantingtex to copy the object grating from. ideally this should be the same starting area
            % as the one used in the destination grating
            src2Rect = dst2Rect + [xstep(t), 0, xstep(t), 0];
            %Draw grating texture, rotated by "angle":
            if(mod(ee,2) == 0)
               Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
               
            else
               Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
%             Screen('DrawTexture', w, masktex, srcRect, dstRect, bgangle, [], [], [0, 255, 255], 0);
            %Disable alpha-blending, restrict following drawing to alpha channel:
            Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
            %Clear 'dstRect' region of framebuffers alpha channel to zero:
            Screen('FillRect', w, [0 0 0 0], dstRect);
            %Fill circular 'dstRect' region with an alpha value of 255:
            if cort == 1
                Screen('FillRect', w, [0 0 0 255], crect);
            else
                Screen('FillOval', w, [0 0 0 255], dst2Rect);
            end
            %Enable DeSTination alpha blending and reenalbe drawing to all color
            %channels. Following drawing commands will only draw there the alpha value
            %in the framebuffer is greater than zero, ie., in our case, inside the
            %circular 'dst2Rect' aperture where alpha has been set to 255 by our 'FillOval' command:
            Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
            %Draw 2nd grating texture, but only inside alpha == 255 circular aperture, and at an angle of 90 degrees:
            Screen('DrawTexture', w, gratingtex, pauserect, dst2Rect, oangle,[], [], [255, 255, 255], 0);% replaced dst2Rect with srcRect
            %Restore alpha blending mode for next draw iteration:
            Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
            if(mod(ee,6) == 1)
                Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
            else
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
            end
            Screen('Flip', w);
        end % DELAY LOOP
    end
    %% local motion to the right with delay
    
    % is the same as "object shift to the right" but this time with a
    % background texture that is solid
    for dk = 1:1
        for k = 1:frameshift
            %run the object grating back a full period here we are creating a count-down indext to go backwards through the array xstep. u = p-t+1;
            %the coordinates of a rectangle within gratingtex to copy the grating from
            srcRect=[xstep(1), 0, xstep(1) + visiblesize, visiblesize];
            %the coordinates of a rectangle within grantingtex to copy the object grating from. ideally this should be the same starting area
            % as the one used in the destination grating
            src2Rect = dst2Rect + [xstep(frameshift-k+1), 0, xstep(frameshift-k+1), 0];
            %Draw grating texture, rotated by "angle":
            if(mod(k,2) == 0)
               Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
               
            else
               Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
%             Screen('DrawTexture', w, masktex, srcRect, dstRect, bgangle, [], [], [0, 255, 255], 0);
            %Disable alpha-blending, restrict following drawing to alpha channel:
            Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
            %Clear 'dstRect' region of framebuffers alpha channel to zero:
            Screen('FillRect', w, [0 0 0 0], dstRect);
            %Fill circular 'dstRect' region with an alpha value of 255:
            if cort == 1
                Screen('FillRect', w, [0 0 0 255], crect);
            else
                Screen('FillOval', w, [0 0 0 255], dst2Rect);
            end
            %Enable DeSTination alpha blending and reenalbe drawing to all color
            %channels. Following drawing commands will only draw there the alpha value
            %in the framebuffer is greater than zero, ie., in our case, inside the
            %circular 'dst2Rect' aperture where alpha has been set to 255 by our 'FillOval' command:
            Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
            %Draw 2nd grating texture, but only inside alpha == 255 circular aperture, and at an angle of 90 degrees:
            Screen('DrawTexture', w, gratingtex, src2Rect, dst2Rect, oangle,[], [], [255, 255, 255], 0);% replaced dst2Rect with srcRect
            %Restore alpha blending mode for next draw iteration:
            Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
            if(mod(k,6) == 1)
                Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
            else
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
            end
            Screen('Flip', w);
            pauserect = src2Rect;
        end
        % ADD A THE SAME DELAY THATS GOING TO APPEAR IN THE DIFFERENTIAL PART
        % AS A DELAY HERE TO MAKE THE TIMES SPENT IN GMOTION EQUAL TO DMOTION
        for ff = 1:ddelay
            %run the object grating back a full period here we are creating a count-down indext to go backwards through the array xstep. u = p-t+1;
            %the coordinates of a rectangle within gratingtex to copy the grating from
            srcRect=[xstep(p), 0, xstep(p) + visiblesize, visiblesize];
            %the coordinates of a rectangle within grantingtex to copy the object grating from. ideally this should be the same starting area
            % as the one used in the destination grating
            src2Rect = dst2Rect + [xstep(t), 0, xstep(t), 0];
            %Draw grating texture, rotated by "angle":
            if(mod(ff,2) == 0)
               Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
               
            else
               Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
            end
            Screen('DrawTexture', w, masktex, srcRect, dstRect, bgangle, [], [], [255, 255, 255], 0);
            %Disable alpha-blending, restrict following drawing to alpha channel:
            Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
            %Clear 'dstRect' region of framebuffers alpha channel to zero:
            Screen('FillRect', w, [0 0 0 0], dstRect);
            %Fill circular 'dstRect' region with an alpha value of 255:
            if cort == 1
                Screen('FillRect', w, [0 0 0 255], crect);
            else
                Screen('FillOval', w, [0 0 0 255], dst2Rect);
            end
            %Enable DeSTination alpha blending and reenalbe drawing to all color
            %channels. Following drawing commands will only draw there the alpha value
            %in the framebuffer is greater than zero, ie., in our case, inside the
            %circular 'dst2Rect' aperture where alpha has been set to 255 by our 'FillOval' command:
            Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
            %Draw 2nd grating texture, but only inside alpha == 255 circular aperture, and at an angle of 90 degrees:
            Screen('DrawTexture', w, gratingtex, pauserect, dst2Rect, oangle,[], [], [255, 255, 255], 0);% replaced dst2Rect with srcRect
            %Restore alpha blending mode for next draw iteration:
            Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
            if(mod(ff,6) == 1)
                Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
            else
                Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
            end
            Screen('Flip', w);
        end % DELAY LOOP
    end
    
end
%% final flip for the last frame
Screen('FillRect',w, [255 0 0], [0, liney, linex, screenresy]);
Screen('Flip', w);
% Screen('CloseAll');
end