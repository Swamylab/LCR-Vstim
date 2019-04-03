function [xcenter, ycenter] = bgprobefinalv1(w,srect,intensity,size, blink,gray)

%***********************************************************************
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% 
% % stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', 1)
% [w, srect] = Screen('OpenWindow', 1,[0 0 0]);
% [gray] = temporalgrey1(2,srect,w);
%*************************************************************************


xcenter = 0;
ycenter = 0;
% d = 0
% SpriteDemo
%
% Animates a sprite across the screen.  The image
% follows the mouse, like a huge cursor.
% 
% There are many ways to create animations.  The simplest is to show a
% movie, computing all the frames in advance, as in MovieDemo.  Sprites may
% be a better approach when you want to show a relatively small object
% moving unpredictably.  Here we generate one offscreen window holding the
% sprite image and copy it to the screen for each frame of the animation,
% specifying the screen location by using the destination rect argument of
% Screen 'CopyWindow'.
% 
% See also MovieDemo.
% 
% Thanks to tj <thomasjerde@hotmail.com> for asking how. 
% web http://groups.yahoo.com/group/psychtoolbox/message/1101 ;
%
% 6/20/02 awi  Wrote it as TargetDemo.  
% 6/20/02 dgp  Cosmetic.  Renamed SpriteDemo.
% 8/25/06 rhh  Added noise to the sprite.  Expanded comments.
% 10/14/06 dhb Save and restore altered prefs, more extensive comments for them
% 09/20/09 mk  Improve screenNumber selection as per suggestion of Peter April.

% ------ Parameters ------
spriteSize = 200; % The height and width of the sprite in pixels (the sprite is square)
numberOfSpriteFrames = 30; % The number of animation frames for our sprite
HideCursor;
    % ------ Bookkeeping Variables ------
    
    %spriteRect = [0 0 spriteSize spriteSize]; % The bounding box for our animated sprite
    spriteFrameIndex = 1; % Which frame of the animation should we show?
    buttons = 0; % When the user clicks the mouse, 'buttons' becomes nonzero.
    mX =0; % The x-coordinate of the mouse cursor
    mY =0; % The y-coordinate of the mouse cursor
    
   m = 0;
    % Exit the demo as soon as the user presses a mouse button.
    while ~any(buttons(1))
        [a] = KbCheck ;
        if(mod(m,2) == 0)
            Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end
        %capture and print screenposition
         xpos = num2str(mX);
         ypos = num2str(mY);
         X = 'x=';
         Y = 'y=';
         dX = strcat(X,xpos);
         dY = strcat(Y,ypos);
         Screen('DrawText', w, dX, 0, 0, [0 0 0]);
         Screen('DrawText', w, dY, 0, 25, [0 0 0]);
         
        
        
        % Get the location and click state of the mouse.
        previousX = mX;
        previousY = mY;
        [mX, mY, buttons] = GetMouse(w, 0);
        xcenter = mX;
        ycenter = mY;             
        
        if(blink == 1)
            if (mod(m,60) == 0)
                intensity = -intensity
            end
        end
        % Draw the sprite at the new location.
%         xyvector1 = [mX mY];
%         xyvector2 = [mX+1 mY+2];
%         xyv = vercat(xyvector1,xyvector2);
        Screen('gluDisk', w, [intensity intensity intensity], mX, mY, size);
        
%         Screen('DrawLines', window, xyv);
        
        
        % Call Screen('Flip') to update the screen.  Note that calling
        % 'Flip' after we have both erased and redrawn the sprite prevents
        % the sprite from flickering.
        Screen('Flip', w);
        
        % Animate the sprite only when the mouse is moving.
        if (previousX ~= mX) || (previousY ~= mY)
            spriteFrameIndex = spriteFrameIndex + 1;
            if spriteFrameIndex > numberOfSpriteFrames
                spriteFrameIndex = 1;
            end
        end
       m = m+1;
    end

    % Revive the mouse cursor.
    ShowCursor; 
end
