function bgFBPbars(length2scan,width,msinterval,reps,xc,yc,intensity)
%(win,srect,length2scan,width,msinterval,reps,xc,yc,intensity,gray) for
%outside control
%will plot the bars randomly to map receptive fields
KbName('UnifyKeyNames');
screenid = max(Screen('Screens'));

% stops psychtoolbox init screen from appearing
oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
Screen('Preference', 'SkipSyncTests', 1)
[win, srect] = Screen('OpenWindow', 0,[0 0 0],[0 0 500 500]); % for a 500x500 testing window
%[win, srect] = Screen('OpenWindow', 1,[0 0 0]); % for a full screen testing window
[gray] = temporalgrey1(2,srect,win,0);

[wid, hei]=Screen('DisplaySize',screenid)

ength = 3*sqrt(wid^2+hei^2);

screenresx = srect(3);  %srect(2,3)-srect(1,3);
screenresy = srect(4); %srect(2,4);
liney = screenresy-30;
linex = 30;
dstRect=[0 0 width ength];
interval = msinterval/100*6;

% make texture
[x,y] = meshgrid(-width/2:+width/2, -ength/2:+ength/2);
front = ones(size(x/2,1),size(x/2,2));
w1 = Screen('MakeTexture', win, 255*front);



while mod(length2scan,width)~=0
    length2scan = length2scan+1;
end

bins = (-(length2scan-width)/2:width:(length2scan-width)/2);%establish predefined positions.
binsTrial = bins;

% binsTrial =(1:20);

% 
% rng('default');% reset the RNG based seed.
% % determine the indeces such that no bar are adjacent and all get picked
% % once.
% indexarray = zeros(5,length(bins));
% for i = 1:5
%     for j =1:length(bins)
%         index = randi(length(binsTrial));
%         
%         if mod(j,2) == 0
%             while(index < ceil(length(binsTrial)/2) && binsTrial(index) == 0)
%                 index = randi(length(binsTrial));
%             end
%         else
%             while(index > ceil(length(binsTrial)/2) && binsTrial(index) ==0)
%                 index = randi(length(binsTrial));
%             end
%         end
%         
%         indexarray(i,j) = index;
%         
%         
%         binsTrial(index) = 0;
%     end
%     binsTrial =(1:20);
% end



rng('default');% reset the RNG based seed.

for k = 1:(interval*8)
        if(mod(k,2) == 0)
            Screen('DrawTexture', win, gray(1), [], srect, [], [], [], [255, 255, 255], 0);
        else
            Screen('DrawTexture', win, gray(2), [], srect, [], [], [], [255, 255, 255], 0);
        end 
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(k,2) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(win,'Flip');
end % gray screen - dn if  this is needed yet
%% Black Screen
    for j = 1:interval*8
        Screen(win, 'FillRect', [0 0 0]); 
        Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        if(mod(j,2) == 0)
            Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
        else
            Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
        end
        Screen(win,'Flip');
    end

for i = 1:5 %5 angles of rotation 
   angle = i*(180/5)-(180/5);
   binsTrial = bins;
   for j = 1:reps % number of reps over the field
       
       for jj = 1:length(bins)% go over all possible positions
           
           index = randi(length(binsTrial)); % pick one position at random will need to prevent overlap
%            index = indexarray(i,jj);
           dstRect=CenterRectOnPoint(dstRect,xc-cos((i-1)*pi/5)*(binsTrial(index)),yc-sin((i-1)*pi/5)*(binsTrial(index)));
           for k = 1:interval
               
               Screen('DrawTexture', win, w1, [], dstRect, angle, [0], [0], [intensity, intensity, intensity], 0);
               Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
               
               if(mod(k,2) == 0)
                   Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
               else
                   Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
               end
               Screen(win,'Flip');
           end %white bar
           for k = 1:interval
               
               Screen('DrawTexture', win, w1, [], dstRect, angle, [0], [0], [0, 0, 0], 0);
               Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
               if(mod(k,2) == 0)
                   Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
               else
                   Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
               end
               Screen(win,'Flip');
           end %black bar
           binsTrial(index) = [];
       end
   end
   
end
%% end on a red frame 
Screen('FillRect',win, [0 0 0], [0, liney, linex, screenresy]);
Screen('FillRect',win, [255 255 255], [0, liney, linex, screenresy]);
Screen(win,'Flip');
Screen('CloseAll');

return