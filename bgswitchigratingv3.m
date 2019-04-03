function bgswitchigratingv3(w,srect,numreps,duration,pixelsPerPeriod,tiltInDegrees,xcen,ycen,centersize,mask,mtype,tetris,scale,rcenter,rectsize,selector,cort,topval,gray)
%  bgswitchigratingv2(w,srect,numreps,duration,pixelsPerPeriod,tiltInDegrees,xcen,ycen,ba,centersize,mask,mtype,tetris,scale,rcenter,rectsize,selector,cort,topval,gray)
%*********comment in or out to control from here
KbName('UnifyKeyNames');
screenid = max(Screen('Screens'));
% stops psychtoolbox init screen from appearing
oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
Screen('Preference', 'SkipSyncTests', 1)
[w, srect] = Screen('OpenWindow', 0,[0 0 0],[0 0 500 500]); % 500x500 full screen testing
%[w, srect] = Screen('OpenWindow', 1,[0 0 0]); % full screen testing
[gray] = temporalgrey1(2,srect,w,0);
%*********
% w=window

% *** To rotate the grating, set tiltInDegrees to a new value.
% tiltInDegrees = 0; % The tilt of the grating in degrees.
tiltInRadians = tiltInDegrees * pi / 180; % The tilt of the grating in radians.

% *** To lengthen the period of the grating, increase pixelsPerPeriod.
%pixelsPerPeriod = 800; % How many pixels will each period/cycle occupy?
spatialFrequency = 1 / pixelsPerPeriod; % How many periods/cycles are there in a pixel?
radiansPerPixel = spatialFrequency * (2 * pi); % = (periods per pixel) * (2 pi radians per period)
screenresx = srect(3);
screenresy = srect(4);
liney = screenresy-30;
linex = 30;
dur = duration/1000*60;
crad = centersize/2;

% *** If the grating is clipped on the sides, increase widthOfGrid.

halfWidthOfGrid = srect(3)/2;
widthArray = (-halfWidthOfGrid) : halfWidthOfGrid;  % widthArray is used in creating the meshgrid.


% ---------- Color Setup ----------
% Gets color values.

% Retrieves color codes for black and white and gray.
% 	black = BlackIndex(window);  % Retrieves the CLUT color code for black.
% 	white = WhiteIndex(window);  % Retrieves the CLUT color code for white.
% 	gray = (black + white) / 2;  % Computes the CLUT color code for gray.

%     if round(gray)==white
% 		gray=black;
%     end
%
% Taking the absolute value of the difference between white and gray will
% help keep the grating consistent regardless of whether the CLUT color
% code for white is less or greater than the CLUT color code for black.



% ---------- Image Setup ----------
% Stores the image in a two dimensional matrix.

% Creates a two-dimensional square grid.  For each element i = i(x0, y0) of
% the grid, x = x(x0, y0) corresponds to the x-coordinate of element "i"
% and y = y(x0, y0) corresponds to the y-coordinate of element "i"
[x y] = meshgrid(widthArray, widthArray);

% Replaced original method of changing the orientation of the grating
% (gradient = y - tan(tiltInRadians) .* x) with sine and cosine (adapted from DriftDemo).
% Use of tangent was breakable because it is undefined for theta near pi/2 and the period
% of the grating changed with change in theta.

a=cos(tiltInRadians)*radiansPerPixel;
b=sin(tiltInRadians)*radiansPerPixel;
xphase = xcen-512;
yphase = xcen-384;
% Converts meshgrid into a sinusoidal grating, where elements
% along a line with angle theta have the same value and where the
% period of the sinusoid is equal to "pixelsPerPeriod" pixels.
% Note that each entry of gratingMatrix varies between minus one and
% one; -1 <= gratingMatrix(x0, y0)  <= 1
gratingMatrix = square((a*x+b*y)-(a*xphase) - (b*yphase));
gratingMatrix2 = square((a*x+b*y)-(a*xphase)-(b*yphase))*-1;


% Since each entry of gratingMatrix varies between minus one and one and each entry of
% circularGaussianMaskMatrix vary between zero and one, each entry of
% imageMatrix varies between minus one and one.
% -1 <= imageMatrix(x0, y0) <= 1
imageMatrix = gratingMatrix;
imageMatrix2 = gratingMatrix2;
% Since each entry of imageMatrix is a fraction between minus one and
% one, multiplying imageMatrix by absoluteDifferenceBetweenWhiteAndGray
% and adding the gray CLUT color code baseline
% converts each entry of imageMatrix into a shade of gray:
% if an entry of "m" is minus one, then the corresponding pixel is black;
% if an entry of "m" is zero, then the corresponding pixel is gray;
% if an entry of "m" is one, then the corresponding pixel is white.
grayscaleImageMatrix = topval + topval * imageMatrix;
grayscaleImageMatrix2 = topval + topval * imageMatrix2;

%   for the masking
crect = [(xcen-crad), (ycen-crad), (xcen+crad), (ycen+crad)];
lprect = [0, 0, (xcen-crad),srect(4)];
tprect = [0, 0, srect(3), (ycen-crad)];
rprect = [(xcen+crad),0,srect(3),srect(4)];
bprect = [0,(ycen+crad),srect(3),srect(4)];
l = transpose(lprect);
t = transpose(tprect);
r = transpose(rprect);
b = transpose(bprect);
prects = horzcat(l,t,r,b);
%   for the masking
wnrect = check2shape(tetris,scale,rcenter,rectsize,selector,xcen,ycen);

grating1=Screen('MakeTexture', w, grayscaleImageMatrix);
grating2 =Screen('MakeTexture', w, grayscaleImageMatrix2);

for i = 1:numreps
    for k = 1:(dur*2)
        if(mod(k,2) == 0)
            Screen('DrawTexture', w, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        if(k == 1)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
        end
        if(mod(k,6) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
        end
        Screen(w,'Flip');
    end % gray screen
    for j = 1:dur

        if mask == 0
            Screen('DrawTexture', w, grating1, [], srect, [], [], [], [0, 255, 255], 0);
        else
            if mtype ==0
                
                if cort == 1
                    Screen('DrawTexture', w, grating1,[], srect, [], [], [], [255, 255, 255], 0); 
                    Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
                    Screen('FillRect',w,[0 0 0 255], wnrect);
                    Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
                    if(mod(j,2) == 0)
                        for r = 1:size(wnrect,2)
                            Screen('DrawTexture',w,gray(1), wnrect(:,r), wnrect(:,r), [], [], [], [255, 255, 255], 0);       
                        end
                    else
                        for r = 1:size(wnrect,2)
                            Screen('DrawTexture',w,gray(2), wnrect(:,r), wnrect(:,r), [], [], [], [255, 255, 255], 0);       
                        end
                    end
                    Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                else
                    Screen('DrawTexture', w, grating1, [], srect, [], [], [], [255, 255, 255], 0);
                    if(mod(j,2) == 0)
                        Screen('DrawTexture',w,gray(1), crect, crect, [], [], [], [255, 255, 255], 0);
                    else
                        Screen('DrawTexture',w,gray(2), crect, crect, [], [], [], [255, 255, 255], 0);
                    end  

                end
                
            elseif mtype ==1
                if cort == 1
                    if(mod(j,2) == 0)
                        Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                    else
                        Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                    end
                    Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); 
                    Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);                    
                    Screen('FillRect', w, [0 0 0 255], wnrect);
                    Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
                    for r = 1:size(wnrect,2)
                        Screen('DrawTexture', w, grating1,wnrect(:,r), wnrect(:,r), [], [], [], [255, 255, 255], 0);
                    end
                    Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                    
                else
                    Screen('DrawTexture', w, grating1, [], srect, [], [], [], [255, 255, 255], 0);

                    if(mod(j,2) == 0)
                        Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                    else
                        Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                    end 
                    Screen('DrawTexture', w, grating1, crect, crect, [], [], [], [255, 255, 255], 0);
%                     Screen('FillRect', w, backg,prects);
                end
            end
        end
        Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(j,6) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
        end
        % Updates the screen to reflect our changes to the window.
        Screen('Flip', w);
    end   % 1st grating 
    for j = 1:dur
        if mask == 0
            Screen('DrawTexture', w, grating2, [], srect, [], [], [], [255, 255, 255], 0);
        else
            if mtype ==0
                
                if cort == 1
                    Screen('DrawTexture', w, grating2,[], srect, [], [], [], [255, 255, 255], 0); 
                    Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);
                    Screen('FillRect',w,[0 0 0 255], wnrect);
                    Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
                    if(mod(j,2) == 0)
                        for r = 1:size(wnrect,2)
                            Screen('DrawTexture',w,gray(1), wnrect(:,r), wnrect(:,r), [], [], [], [255, 255, 255], 0);       
                        end
                    else
                        for r = 1:size(wnrect,2)
                            Screen('DrawTexture',w,gray(2), wnrect(:,r), wnrect(:,r), [], [], [], [255, 255, 255], 0);       
                        end
                    end
                    Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                else
                    Screen('DrawTexture', w, grating2, [], srect, [], [], [], [255, 255, 255], 0);
                    if(mod(j,2) == 0)
                        Screen('DrawTexture',w,gray(1), crect, crect, [], [], [], [255, 255, 255], 0);
                    else
                        Screen('DrawTexture',w,gray(2), crect, crect, [], [], [], [255, 255, 255], 0);
                    end 
                end
                
            elseif mtype ==1
                if cort == 1
                    if(mod(j,2) == 0)
                        Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                    else
                        Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                    end
                    Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); 
                    Screen('Blendfunction', w, GL_ONE, GL_ZERO, [0 0 0 1]);                    
                    Screen('FillRect', w, [0 0 0 255], wnrect);
                    Screen('Blendfunction', w, GL_DST_ALPHA, GL_ONE_MINUS_DST_ALPHA, [1 1 1 1]);
                    for r = 1:size(wnrect,2)
                        Screen('DrawTexture', w, grating2,wnrect(:,r), wnrect(:,r), [], [], [], [255, 255, 255], 0);
                    end
                    Screen('Blendfunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
                    
                else
                    if(mod(j,2) == 0)
                        Screen('DrawTexture',w,gray(1), [], srect, [], [], [], [255, 255, 255], 0);
                    else
                        Screen('DrawTexture',w,gray(2), [], srect, [], [], [], [255, 255, 255], 0);
                    end 
                    Screen('DrawTexture', w, grating2, crect, crect, [], [], [], [255, 255, 255], 0);
                end
            end
        end
        Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(j,6) == 0)
            Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
        end
        % Updates the screen to reflect our changes to the window.
        Screen('Flip', w);
    end   % 2nd grating
end
Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy]);
Screen('FillRect',w, [255 255 255], [0, liney, linex, screenresy]);
Screen('Flip', w);
Screen('CloseAll');
end
