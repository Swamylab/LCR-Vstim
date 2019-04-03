function stimcontrolbinary3colorPierre

%(stim)

KbName('UnifyKeyNames');
% screenid = max(Screen('Screens'));
screenid = max(Screen('Screens'));
% stops psychtlab
% xoolbox init screen from appearing
oldVisualDebugLevel = Screen('Preference', 'VisualDebugLevel', 3);
oldSupressAllWarnings = Screen('Preference', 'SuppressAllWarnings', 1);
Screen('Preference', 'SkipSyncTests', screenid)
% Screen('Preference', 'ScreenToHead', screenid, 0,0, 0);
[w, winRect] = Screen('OpenWindow', screenid,[0 0 0]);
% [w] = Screen('OpenWindow', screenid,[0 0 0]);

% Screen('glScale', win, 0.5,1,1);

[gray] = temporalgrey1(2,winRect,w,0);
background = [0 0 0];
xcenter = 0;
ycenter = 0;
pause(3);
HideCursor([w]);
[xcenter, ycenter] = bgprobefinalv1(w,winRect,255,20,1,gray);

vbl=Screen('Flip', w);
escapeKey = KbName('ESCAPE');
% for TCP/IP start and select info
% echotcpip('on', 1);
%t = tcpip('132.216.34.15', 6342);% EPHYS COMPUTER
t = tcpip('132.216.34.106', 6342); % 2P COMPUTER
% t = tcpip('169.254.94.20', 6342); %Cricket computer Test

fopen(t);
screenresx = winRect(3);%resol(2,3)-resol(1,3);
screenresy = winRect(4);%resol(2,4);
liney = screenresy-30;
linex = 30;

% data = fscanf(t);
%echotcpip('off');

% input = str2num (data);

count = 1;
while (vbl<(vbl+3600))
    data = fscanf(t);
    command = str2num (data);
    command;
    input = command(1);
    count = count+1;
    if (isempty(input))
        input = 10;
    end
    
    switch input
        case 1
            %             Screen('FillRect',win, background);
            %             Screen('Flip', win);
            if(mod(count,2) == 0)
                Screen('DrawTexture',w,gray(1), [], winRect, [], [], [], [255, 255, 255], 0);
            else
                Screen('DrawTexture',w,gray(2), [], winRect, [], [], [], [255, 255, 255], 0);
            end
            Screen('FillRect',w, [0 0 0], [0, liney, linex, screenresy])
            Screen('Flip',w);
        case 2
            gcampringfinalv2(w,winRect,command(2),command(3),command(4),command(5),command(6),background,xcenter,ycenter)
%                         ringfinalv2(win,srect,numrings,rtime,rwidth,rcolor,backg,xc,yc)
%                         Ringfinal(win,winRect,command(2),command(3),command(4),xcenter,ycenter);
%                         Ringfinal(win,winRect,4,.5,10,xcenter,ycenter)
        case 3
            bgcampCirclefinalv3(w,winRect,command(2),command(3),command(4),command(5),xcenter,ycenter,command(6),gray,command(7));
            
            %             Circlefinal(win,winRect,4,.5,10,10,xcenter,ycenter)
        case 4
            pause(.5)
            [xcenter,ycenter] = bgprobefinalv1(w,winRect,command(2),command(3),command(4),gray);
            %             [xcenter,ycenter] = probefinal(win,screenid,255)
        case 5
            bgdkmovingbarv1(w,winRect,command(2),command(3),command(4),command(5),command(6),xcenter,ycenter,command(7),gray)
            %           akmovingbar2(window,srect,realxv,le,wi,periodtime,repeats,x,y, backg)
        case 6
%             gOMSv4(w,winRect,command(2), command(3), command(4),command(5), command(6), command(7), xcenter, ycenter,background,command(8),command(9),command(10))
            %           oms(win,winRect,command(2),command(3),command(4),command(5),command(6),command(7),command(8), xcenter,ycenter,background,command(9));
            %           OMSv4(w,srect,shift, sf, oangle,osize,reps,bgangle,Cx,Cy,backg,numperiods,Diffdelay)
            %             akomsfinal(win,winRect,0,1,0.05,180,100,0,xcenter,ycenter,2,2,2)
        case 7
            bgrasterspots4(w,winRect,command(2),command(3),command(4),command(5),command(6),xcenter,ycenter, command(7),gray, command(8));
            %           rasterspots(win,winRect,10,.5,4,4,2,xcenter,ycenter)
        case 8
            %             fullfieldramp (win,screenid,srect,msinterval,reps);
            bgfullfieldfinalv3(w,winRect,command(2),command(3),gray,command(6))
%             bgfullfieldfinal (win,srect,msinterval,reps,backg,gray,graymultiple)
        case 9
%             gcontigratingv1(w,winRect, command(2), command(3), command(4),command(5), xcenter,ycenter,background,command(6),command(7), command(8));
            %             invertgrating(win,winRect,command(2),command(3),command(4),command(5),xcenter,ycenter)
            %             invertgrating(win,winRect,1,1,200,10,xcenter,ycenter)
        case 10
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
%             bgswitchigratingv4(w,winRect, command(2), command(3), command(4),command(5), xcenter,ycenter,command(6),command(7), command(8),locations,command(9),command(10),command(11),command(12),command(13),command(14),gray);
%             bgswitchigratingv3(w,srect,numreps,duration,pixelsPerPeriod,tiltInDegrees,xcen,ycen,centersize,mask,mtype,tetris,scale,rcenter,rectsize,selector,cort,topval,gray)
            bgswitchigratingv4(w,winRect, command(2), command(3), command(4),xcenter,ycenter,command(6),command(7), command(8),locations,command(9),command(10),command(11),command(12),command(13),gray)
        case 11
%             gakmovingspots(w,winRect,command(2),command(3),command(4),command(5),command(6),xcenter,ycenter,command(7));
            %             akmovingspots(window,srect,realxv,le,wi,periodtime,repeats,x,y,bardiv)
        case 12
            if command(5) == 1
                xcenter = command(2);
                ycenter = command(3);
                background = [0 command(4) command(4)];
            else
                background = [0 command(4) command(4)];
            end
        case 13
            gScreenchopv1(w ,winRect, command(2), command(3), command(4), command(5),gray, command(6));
%             gScreenchopv1(w ,srect,chopx,chopy,msinterval,flashnum,gray,graymultiple)
        case 14
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
            gomsjitterv2(w,winRect,command(2), command(3), command(4),command(5),command(6),command(7), command(8),xcenter,ycenter,command(9),command(10),background,command(11),locations,command(12),command(13),command(14),command(15),command(16))
            %             gomsjitterv1(win,winRect,command(2), command(3), command(4),command(5),command(6),command(7), command(8),xcenter,ycenter,command(9),command(10),background,command(11))
        case 15
            bgspotflashv3(w,winRect,command(2),command(3),command(4),command(5),command(6),xcenter,ycenter,gray,command(7));
%             bgspotflashv3(w,srect,size,msinterval,reps,onval,offval,cx,cy,gray,graymultiple)
        case 16
            %             barnoisefinal(win,winRect,command(2),command(3),command(4),command(5),command(6),command(7));
            %             barnoisefinal(win,winRect,1,320,1,1,0,20)
            bgWhiteBinaryv1(w,winRect,command(2),command(3),command(4), command(5),xcenter,ycenter,command(6),gray);
        case 17
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
%             gWNTetrisv1(w,winRect,command(2),command(3),command(4),locations,command(5),xcenter,ycenter);
            bgWNTetrisv1(w,winRect,command(2),command(3),command(4),locations,command(5),xcenter,ycenter,gray)
        case 18
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
            bgtetflashv3(w,winRect,command(2),command(3),command(4),command(5),command(6),command(7),locations,xcenter,ycenter,gray,command(8))
        case 19
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
            bgWNBTetrisv1(w,winRect,command(2),command(3),command(4),locations,background,command(5),xcenter,ycenter,gray);
%             bgWNBTetrisv1(w,winRect,rectsize,scale, frames,tetris,frate,XC,YC,gray)
        case 20
%             [Xidx,Yidx,xpos,ypos] = dmapper (w,winRect,command(2),command(3),command(4),command(5),command(6),command(7),command(8),xcenter,ycenter,background);
%             save('C:\Users\arjun\CloudStation\doughnut\xidx.txt','Xidx','-ascii','-double','-tabs');
%             save('C:\Users\arjun\CloudStation\doughnut\yidx.txt','Yidx','-ascii','-double','-tabs');
%             save('C:\Users\arjun\CloudStation\doughnut\xpos.txt','xpos','-ascii','-double','-tabs');
%             save('C:\Users\arjun\CloudStation\doughnut\ypos.txt','ypos','-ascii','-double','-tabs');
        case 21
%             gbackramp(w,winRect,command(2),command(3));
        case 22
%             gbrspot(w,winRect,command(2),command(3),command(4),command(5),xcenter,ycenter,command(6));
        case 23
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
            bgOMSv8(w,winRect,command(2), command(3), command(4),command(5), command(6), command(7), xcenter, ycenter,background,command(8),command(9),command(10),command(11),command(12),command(13),command(14),locations,command(15),command(16),gray)
        case 24
%             gswitchiseries(w,winRect, command(2), command(3), command(4),command(5), xcenter,ycenter,background,command(6),command(7), command(8),locations,command(9),command(10),command(11),command(12),command(13),command(14));
        case 25
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
%             gtetflashdelayv1(w,winRect,command(2),command(3),command(4),command(5),command(6),command(7),locations,background,xcenter,ycenter,command(8))
            %                gtetflashdelay (win,srect,rectsize,msinterval,reps,onval,offval,scale,tetris,backg,XC,YC)
            %                gtetflashdelayv1 (rectsize,msinterval,reps,onval,offval,scale,tetris,backg,XC,YC,whichdelay)
        case 26
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
%             gOMSdelayseries1(w,winRect,command(2), command(3), command(4),command(5),command(6),command(7),xcenter,ycenter,background,command(8),command(9),command(10),command(11),command(12),command(13),locations,command(14),command(15))
        case 27
%               gspotflashvdelay (w,winRect,command(2),command(3),command(4),command(5),command(6),xcenter,ycenter,background,command(7))
        case 28
              bgflickerv1(w,winRect,command(2),command(3),background,gray,command(4));
%             fbpv2(w,winRect, command(2), command(3),command(4),command(5),command(6),background,command(7));
        case 29
              ChR2fflash (w,winRect,command(2),command(3),background,command(6))
        case 30
              bgchirpv1(w,winRect,command(2),command(3),gray)
        case 31
            bgdkmovingspotsv1(w,winRect,command(2),command(3),command(4),command(5),command(6),command(7),xcenter,ycenter,background,command(8),gray);
        case 32
            [locations] = importfile('C:\Users\arjun\CloudStation\tester.txt');
       bgswitchigratingv5(w,winRect, command(2), command(3), command(4),xcenter,ycenter,command(6),command(7), command(8),locations,command(9),command(10),command(11),command(12),command(13),gray)
        case 33
            bgrasterboxJR(w,winRect,command(2),command(3),command(4),command(5),command(6),command(7), xcenter,ycenter,command(8),gray,command(9))
        case 34
            bgdkOrientationSelectivev1(w,winRect,command(2),command(3),command(4), command(5), command(6), xcenter, ycenter, command(7), gray, command(8));
        otherwise
            
            %i = i+1 just a counter to see if this code runs
    end
    
    % Check the state of the keyboard.
    [ keyIsDown, ~, keyCode ] = KbCheck;
    
    % If the user is pressing a key, then display its code number and name.
    if keyIsDown
        if keyCode(escapeKey)
            break;
        end
        
        while KbCheck;
        end
    end
    
end

Screen('CloseAll')
fclose(t);
delete(t);
end


