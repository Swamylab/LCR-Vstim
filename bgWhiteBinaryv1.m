% function bgWhiteBinaryv1(w,winRect,rectsize,scale,frames,frate,XC,YC,highval,gray)
bgWhiteBinary(rectsize,scale, frames,backg,frate,XC,YC,highval)
%% open Psychtoolbox
KbName('UnifyKeyNames');
screenid = max(Screen('Screens'));

% stops psychtoolbox init screen from appearing
oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
Screen('Preference', 'SkipSyncTests', 1)
[w, winRect] = Screen('OpenWindow', 1,[0 0 0]);
[gray] = temporalgrey1(2,winRect,w);

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

% compute destination rectangle locations for the random noise patches:

objrect = SetRect(0,0, rectsize, rectsize);

% arrangerects creates 'numrects' copies of 'objrect', all nicely
% arranged / distributed in our window of size 'winRect':

dstrect = ArrangeRects(1, objrect, winRect);

% now we rescale all rects: they are scaled in size by a factor 'scale':
% compute center position [xc,yc] of the i'th rectangle:

% [xc, yc] = RectCenter(dstrect(1,:));
xc = XC;
yc = YC;
% create a new rectange, centered at the same position, but 'scale'
% times the size of our pixel noise matrix 'objrect':

dstrect(1,:)=CenterRectOnPoint(objrect * scale, xc, yc);

% init framecounter to zero and take initial timestamp:
count = 0;
noiseimg=zeros(rectsize, rectsize,3);

% run noise image drawing loop for 1000 frames:

Screen('DrawTexture', w, gray(2), [], winRect, [], [], [], [255, 255, 255], 0);
Screen('flip', w);
WaitSecs(5);

%% Stimulus loop sync with red frames
realrate = 60/frate;
while count < frames
 
    noiseimg(:,:,2)=highval*randi(0:1,[rectsize, rectsize]);
    noiseimg(:,:,3)=noiseimg(:,:,2);
    noiseimg(:,:,1)=noiseimg(:,:,2);
       
        if(mod(count,2) == 0)
            Screen('DrawTexture', w, gray(1), [], winRect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], winRect, [], [], [], [255, 255, 255], 0);
        end 
    
    % convert it to a texture 'tex':
    tex=Screen('maketexture', w, noiseimg);
    Screen('drawtexture', w, tex, [], dstrect(1,:), [], 0);
    % after drawing, we can discard the noise texture.
    Screen('close', tex);
    
    for i = 1:realrate
    
        if mod(count,5) == 0 && i == 1
            Screen(w, 'FillRect', [255 255 255], [0 liney linex yres]);
        else
            Screen(w, 'FillRect', [0 0 0], [0 liney linex yres]);
        end
    Screen('flip', w, 0, 1, asyncflag);
    end
%     Screen('flip', w, 0, 1, asyncflag);% second flip to reduce the frame rate to 30 Hz
    % increase our frame counter:
    count = count + 1;
end

% WaitSecs(4);

%% set screen to grey
Screen(w, 'FillRect', [0 150 150], [1 1 800 600]);
Screen('flip', w);
Screen('CloseAll');
end