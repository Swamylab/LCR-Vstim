function bgWNTetrisv1(w,winRect,rectsize,scale, frames,tetris,frate,XC,YC,gray)
% bgWNTetris(w,winRect,rectsize,scale, frames,tetris,frate,XC,YC,gray)
%% open Psychtoolbox
%*********comment in or out to control from here
% KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
% stops psychtoolbox init screen from appearing
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% Screen('Preference', 'SkipSyncTests', screenid)
% [w, winRect] = Screen('OpenWindow', screenid,[0 0 0],[0 0 500 500]); % 500x500 screen testing
% %[w, srect] = Screen('OpenWindow', screenid,[0 0 0]); % full screen testing
% [gray] = temporalgrey1(2,winRect,w,0);
%*********
%% assign default values for all unspecified input parameters:
liney = winRect(4)-30;
linex = 30;
xres = winRect(3);
yres = winRect(4);
if nargin < 1 || isempty(rectsize)
    rectsize = 15; % default patch size is 128 by 128 noisels.
end

if nargin < 2 || isempty(scale)
    scale = 3; % don't up- or downscale patch by default.
end

synctovbl = 1; % synchronize to vertical retrace by default.

if synctovbl > 0
    asyncflag = 0;
else
    asyncflag = 2;
end

if nargin < 3 || isempty(frames)
    frames = 1000; % default framaes to be rpesented.
end


dontclear = 0; % clear backbuffer to background color by default after each bufferswap.

if dontclear > 0
    % a value of 2 will prevent any change to the backbuffer after a
    % bufferswap. in that case it is your responsibility to take care of
    % that, but you'll might save up to 1 millisecond.
    dontclear = 2;
end
%% reset random number generator seed
rng('default');

%     RNG('default') puts the settings of the random number generator used by
%     RAND, RANDI, and RANDN to their default values so that they produce the
%     same random numbers as if you restarted MATLAB. In this release, the
%     default settings are the Mersenne Twister with seed 0.

%% Center Stimulus to center and resize if necessary
%AK: square centers.
% compute destination rectangle locations for the random noise patches:

% arrangerects creates 'numrects' copies of 'objrect', all nicely
% arranged / distributed in our window of size 'winRect':

% now we rescale all rects: they are scaled in size by a factor 'scale':
% compute center position [xc,yc] of the i'th rectangle:
xc = XC;
yc = YC;

% create a new rectange, centered at the same position, but 'scale'
% times the size of our pixel noise matrix 'objrect':

% dstrect(1,:)=CenterRectOnPoint(objrect * scale, xc, yc);

% init framecounter to zero and take initial timestamp:
count = 0;
[tetrisrects] = NoiseToTetris(tetris,scale,rectsize,xc,yc)
noiseimg=zeros(rectsize, rectsize,3);

% run noise image drawing loop for 1000 frames:

Screen('DrawTexture', w, gray(1), [], winRect, [], [], [], [255, 255, 255], 0);
Screen('flip', w);
WaitSecs(5);

%% Stimulus loop sync with red frames
realrate = 60/frate;
while count < frames
    fillval=255*rand;
        if(mod(count,2) == 0)
            Screen('DrawTexture', w, gray(1), [], winRect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], winRect, [], [], [], [255, 255, 255], 0);
        end
        Screen('FillRect',w,[fillval,fillval,fillval],tetrisrects);
    
    for i = 1:realrate
        if mod(count,5) == 0 && i == 1
            Screen(w, 'FillRect', [255 0 0], [0 liney linex yres]);
        else
            Screen(w, 'FillRect', [0 0 0], [0 liney linex yres]);
        end
    Screen('flip', w, 0, 1, asyncflag);
    end
    count = count + 1;
end

%     WaitSecs(4);

%% set screen to grey
%     Screen(w, 'FillRect', backg, winRect);
%     Screen('flip', w);
%     Screen('CloseAll');
end