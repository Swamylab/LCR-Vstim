%Create Dots sparse noise implemented by Smith and Häusser in 2011 for RF
%mapping
% function bgDotsSparseNoise(w,winRect,recsize,mult,frames,frate,XC,YC,gray, minnum,maxnum)
function bgDotsSparseNoise % w ,winRect, rectangle size in which dots will appear, multiplier to resize dots, number of frames, frame rate, x topleft corner position, y topleft corner position, gray, minimum number of dot in one frame, maximum number of dots in one frames

%% open Psychtoolbox
KbName('UnifyKeyNames');
screenid = max(Screen('Screens'));

% stops psychtoolbox init screen from appearing
oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
Screen('Preference', 'SkipSyncTests', 1)
[w, winRect] = Screen('OpenWindow', 1,[0 0 0]);
[gray] = temporalgrey1(2,winRect,w,0);
minnum = 2; 
maxnum =8;
mult =7;
recsize = 900;
frate = 3; 
frames = 30;
XC = 900;
YC = 600;

% +20 – +124° in azimuth (in one experiment, the span was +20 – +73°) and ?10 – +42° in elevation. 
%Between 4000 and 6000 stimulus frames were used in each experiment (3hz).
%White and black dots on a gray background
%Adjacent frames had no overlap in dot locations
%Dots ranged in size from 1.3° to 8.0° in diameter (I think 2 to 11 pixels)
% 1° = ~31-34um (Geng et al.,2012)


realrate = 60/frate;
counter = 1;
smallestsize = 2*mult; %smallest size that the dots can have (diameter)
biggestsize = 11*mult; %biggest size that the dots can have (diameter)


%numpos = (biggestsize)^2;
grid = floor(recsize/biggestsize); %divide the recspace in a grid depending of the size of the biggest dot
numpos = grid^2; %number of cells in the grid
empty = 1:numpos; %indicate the cells that are free to choose to draw dots
Dots = cell(1,frames); % array containing (x:y:diameter:color, dot, frames)
rng('default'); % reset the RNG based seed.
for i = 1:frames
    %how many dots white/black
    numdots = ceil(randsample(minnum:maxnum, 1)/2);
    % dots will be half white and half black
    col= [repelem(255,numdots) repelem(0,numdots)];
    %numdots = ceil((biggestnum-smallestnum).*rand(1,1) + smallestnum);
    % size of the dots
    sizedots = repelem(randsample(smallestsize:biggestsize,numdots, true),2);
    %sizedots = repelem((biggestsize-smallestsize).*rand(numdots,1) + smallestsize,2);
    %choose a cell positions for each dot (one dot per cell)
    full = randsample(empty,numdots *2); %positions of all the dots
    empty = 1:numpos; 
    empty (full)= []; %exclude for the next frame the cells we are using now
    Dots{i} = zeros(4,numdots*2); %initialiate array
    for p = 1:numdots *2
        pos = floor((full(p)-1)/grid); %find the cell position in x and y
        x = round(((full(p)-(pos*grid)-1)*biggestsize) + randsample(sizedots(p)/2:biggestsize-(sizedots(p)/2),1)); %give a random position in x withing the cell
        y = round((pos*biggestsize) + randsample(sizedots(p)/2:biggestsize-(sizedots(p)/2),1)); %give a random position in y withing the cell
        Dots{i}(:,p) = [x,y,sizedots(p), col(p)];%(x, y, diameter,color)
    end
end
        
   
Screen(w, 'FillRect', [125 125 125], winRect);
Screen('flip', w);

while counter < frames+1
    for i = 1:realrate
%     Screen(w, 'FillRect', [125 125 125], winRect);
        if(mod(counter,2) == 0)
            Screen('DrawTexture', w, gray(1), [], winRect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', w, gray(2), [], winRect, [], [], [], [255, 255, 255], 0);
        end 
    Screen('DrawDots', w, Dots{counter}(1:2,:) ,Dots{counter}(3,:), repmat(Dots{counter}(4,:),3,1),[(XC-(recsize/2)) (YC-(recsize/2))], 1);
    %o=3; viscircles(Dots{o}(1:2,:)',Dots{o}(3,:)/2, 'Color', 'y')
    %Screen('DrawDots', w, [100 500; 800 1000] ,[20 20], [255 255 255], [0,0], 1 );
    Screen('Flip', w);
    end
    counter= counter+1;
end

% WaitSecs(4);

%% set screen to grey
Screen(w, 'FillRect', [125 125 125], winRect);
Screen('flip', w);
Screen('CloseAll');
end


