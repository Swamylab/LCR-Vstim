function [gray] = temporalgrey1(numframes,srect,w,ChR)
% echo off
% oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
% oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
% 	
% % Find out how many screens and use largest screen number.
% whichScreen = 1; %max(Screen('Screens'));
% [window winRect] = Screen('OpenWindow', whichScreen);
% w=window;
% srect = winRect;

for i = 1:srect(3)
    if(mod(i,2) == 0)
        oneline(i) = 1;
    else
        oneline(i) = 0;
    end
end
nextline = circshift(oneline,[0 1]);

for i = 1:srect(4)
    if(mod(i,2) == 0)
        oneframe(:,i) = oneline;
    else
        oneframe(:,i) = nextline;
    end
end
nextframe = 1-oneframe;
nextframe = nextframe*255;
oneframe = oneframe*255;
if(ChR == 1)
    oneframe = oneframe*0;
    nextframe = nextframe*0;
end
for i = 1:numframes
    if(mod(i,2) == 0)
        gray(i) = Screen('MakeTexture', w, oneframe);
    else
        gray(i) = Screen('MakeTexture', w, nextframe);
    end
end
% 
% for i = 1:numframes
%     Screen('DrawTexture',w,gray(i), [], srect, [], [], [], [255, 255, 255], 0);
%     Screen('Flip',w);
%     pause(.5)
% end

% Screen('CloseAll');
end