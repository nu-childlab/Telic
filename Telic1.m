% Animations-Training language:
%     This is a gleebing.          COUNT
%     This is some gleebing.   MASS
% 
% Animations-test question: 
%     How similar were those two gleebings?
%     How similar were those two portions of gleebing?
% 
% Images-training language:
%     This is a gleeb.               COUNT 
%     This is some gleeb.        MASS 
% 
% Images-test:
%     How similar were those two gleebs?
%     How similar were those two portions of gleeb?



function [] = eventLoopsExperimentv8()
Screen('Preference', 'SkipSyncTests', 0);
close all;
sca
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
rng('shuffle');
KbName('UnifyKeyNames')

cond=input('Condition e or o: ', 's');
cond = condcheck(cond);
subj=input('Subject Number: ', 's');
subj = subjcheck(subj, cond);
list=input('List color: ', 's');
list = listcheck(list);


%%%%%%%%
%COLOR PARAMETERS
%%%%%%%%
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white/2;

%%%Screen Stuff

[window, windowRect] = PsychImaging('OpenWindow', screenNumber, black);
%opens a window in the most external screen and colors it)
Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
%Anti-aliasing or something? It's from a tutorial
ifi = Screen('GetFlipInterval', window);
%Drawing intervals; used to change the screen to animate the image
[screenXpixels, screenYpixels] = Screen('WindowSize', window);
%The size of the screen window in pixels
[xCenter, yCenter] = RectCenter(windowRect);
%The center of the screen window

%%%%%%
%FINISHED PARAMETERS
%%%%%%

shape = 'Star';
%Current Options: 'Oval', 'Square', 'Star'
%More image options can be added by copy-pasting the 'Star' case below and
%changing only the image location

color = [1 0 0];
%Current Options: see above, or make your own color. [r g b]
%Does not apply to 'Star'

loopTime = .75;

loopFrames = round(loopTime / ifi) + 1;

%disp(loopFrames)

%loopFrames = 50;
%Current options: 0 or more (recommended 50)
%To increase movement speed, decrease the loopFrames number. This number
%states how many points/image frames the animation has to cycle though for
%each loop. More frames means the loops will take longer to go through.

minSpace = 20;
%Current options: 0 or more
%minSpace only affects 'random'; it is the minimum possible number of
%frames between steps

breakTime = .5;
%Current options: 0 or more
%The number of seconds for each pause

crossTime = 1;
%Length of fixation cross time

pauseTime = .5;
%Length of space between loops presentation

displayTime = .5;
%how many seconds to display object stimuli

textsize = 18;
textspace = 1.5;

rotateLoops = 1;
%Current options: 0 or 1
%1 means each loop is rotated a random number of degrees. 0 means they aren't.

%%%%%%Argument Setup

% subj = 's999';
% cond = 'o';
% list = 'blue';

%%%%%%Create List
pairs = [];
BreakTypeList = {'equal';'equal';'equal';'equal';'equal';'equal';'equal';...
    'equal';'equal';'equal';'random';'random';'random';'random';'random';...
    'random';'random';'random';'random';'random';};
if strcmp(list, 'all')
    pairs = {[4 5; 5 4;]; [4 6; 6 4]; [4 7; 7 4]; [4 8; 8 4]; [4 9; 9 4]; ...
        [9 4; 4 9]; [9 5; 5 9]; [9 6; 6 9]; [9 7; 7 9]; [9 8; 8 9];...%blue
        [5 6; 6 5]; [5 7; 7 5]; [5 8; 8 5]; [5 9; 9 5]; [4 9; 9 4]; ...
        [9 4; 4 9]; [8 4; 4 8]; [8 5; 5 8]; [8 6; 6 8]; [8 7; 7 8];...%pink
        [6 7; 7 6]; [6 8; 8 6]; [6 9; 9 6]; [5 9; 9 5]; [4 9; 9 4]; ...
        [9 4; 4 9]; [8 4; 4 8]; [7 4; 4 7]; [7 5; 5 7]; [7 6; 6 7];...%green
        [7 8; 8 7]; [6 8; 8 6]; [5 8; 8 5]; [4 8; 8 4]; [4 9; 9 4]; ...
        [9 4; 4 9]; [9 5; 5 9]; [8 5; 5 8]; [7 5; 5 7]; [6 5; 5 6];...%orange
        [4 9; 9 4]; [5 9; 9 5]; [6 9; 9 6]; [7 9; 9 7]; [8 9; 9 8]; ...
        [5 4; 4 5]; [6 4; 4 6]; [7 4; 4 7]; [8 4; 4 8]; [9 4; 4 9]...%yellow
        };
    BreakTypeList = {'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';...
        'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';...
        'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';...
        'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';...
        'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';'equal';...
        'random';'random';'random';'random';'random';'random';'random';'random';'random';'random';...
        'random';'random';'random';'random';'random';'random';'random';'random';'random';'random';...
        'random';'random';'random';'random';'random';'random';'random';'random';'random';'random';...
        'random';'random';'random';'random';'random';'random';'random';'random';'random';'random';...
        'random';'random';'random';'random';'random';'random';'random';'random';'random';'random'...
        };
    pairs = [pairs;pairs];
    shuff = randperm(length(pairs));
    pairs = pairs(shuff,:);
    BreakTypeList = BreakTypeList(shuff);
elseif strcmp(list, 'blue')
    pairs = {[4 5; 5 4;]; [4 6; 6 4]; [4 7; 7 4]; [4 8; 8 4]; [4 9; 9 4]; ...
        [9 4; 4 9]; [9 5; 5 9]; [9 6; 6 9]; [9 7; 7 9]; [9 8; 8 9]};
    pairs = [pairs;pairs];
    pairs = [pairs;pairs];
    BreakTypeList = [BreakTypeList;BreakTypeList];
    shuff = randperm(length(pairs));
    %Only one permutation is randomized; it's used for both lists so they
    %match up
    pairs = pairs(shuff,:);
    BreakTypeList = BreakTypeList(shuff);
elseif strcmp(list, 'pink')
    pairs = {[5 6; 6 5]; [5 7; 7 5]; [5 8; 8 5]; [5 9; 9 5]; [4 9; 9 4]; ...
        [9 4; 4 9]; [8 4; 4 8]; [8 5; 5 8]; [8 6; 6 8]; [8 7; 7 8]};
    pairs = [pairs;pairs];
    pairs = [pairs;pairs];
    BreakTypeList = [BreakTypeList;BreakTypeList];
    shuff = randperm(length(pairs));
    pairs = pairs(shuff,:);
    BreakTypeList = BreakTypeList(shuff);
elseif strcmp(list, 'green')
    pairs = {[6 7; 7 6]; [6 8; 8 6]; [6 9; 9 6]; [5 9; 9 5]; [4 9; 9 4]; ...
        [9 4; 4 9]; [8 4; 4 8]; [7 4; 4 7]; [7 5; 5 7]; [7 6; 6 7]};
    pairs = [pairs;pairs];
    pairs = [pairs;pairs];
    BreakTypeList = [BreakTypeList;BreakTypeList];
    shuff = randperm(length(pairs));
    pairs = pairs(shuff,:);
    BreakTypeList = BreakTypeList(shuff);
elseif strcmp(list, 'orange')
    pairs = {[7 8; 8 7]; [6 8; 8 6]; [5 8; 8 5]; [4 8; 8 4]; [4 9; 9 4]; ...
        [9 4; 4 9]; [9 5; 5 9]; [8 5; 5 8]; [7 5; 5 7]; [6 5; 5 6]};
    pairs = [pairs;pairs];
    pairs = [pairs;pairs];
    BreakTypeList = [BreakTypeList;BreakTypeList];
    shuff = randperm(length(pairs));
    pairs = pairs(shuff,:);
    BreakTypeList = BreakTypeList(shuff);
elseif strcmp(list, 'yellow')
    pairs = {[4 9; 9 4]; [5 9; 9 5]; [6 9; 9 6]; [7 9; 9 7]; [8 9; 9 8]; ...
        [5 4; 4 5]; [6 4; 4 6]; [7 4; 4 7]; [8 4; 4 8]; [9 4; 4 9]};
    pairs = [pairs;pairs];
    pairs = [pairs;pairs];
    BreakTypeList = [BreakTypeList;BreakTypeList];
    shuff = randperm(length(pairs));
    pairs = pairs(shuff,:);
    BreakTypeList = BreakTypeList(shuff);
else
    pairs = {[4 8; 8 4]; [4 5; 5 4]};
    pairs = [pairs;pairs];
    BreakTypeList = {'equal'; 'random'; 'equal'; 'random'};
end

%%%%%%
%THE ACTUAL FUNCTION!!!
%%%%%%

%%%%%%%Screen Prep
HideCursor;	% Hide the mouse cursor
Priority(MaxPriority(window));

%%%%%%Shape Prep
switch shape
    case 'Oval'
        baseRect = OffsetRect([0 0 160 160], 10,150);
        fillShape = 'FillOval';
    case 'Square'
        baseRect = [0 0 200 200];
        fillShape = 'FillRect';
    case 'Star'
        theImageLocation = 'star3.png';
        %theImage = imread(theImageLocation);
        [imagename, ~, alpha] = imread(theImageLocation);
        imagename(:,:,4) = alpha(:,:);
        
        % Get the size of the image
        [s1, s2, ~] = size(imagename);

        % Here we check if the image is too big to fit on the screen and abort if
        % it is. See ImageRescaleDemo to see how to rescale an image.
        if s1 > screenYpixels || s2 > screenYpixels
            disp('ERROR! Image is too big to fit on the screen');
            sca;
            return;
        end

        % Make the image into a texture
        imageTexture = Screen('MakeTexture', window, imagename);

end

%%%%%%Actually do something

Screen('Flip', window);

instructions(window, screenXpixels, screenYpixels, textsize, cond, textspace);
RestrictKeysForKbCheck([]);

vbl = Screen('Flip', window);


%yscale is used to scale the images to be smaller or larger.
yscale = screenYpixels / 15;
xscale = yscale;
initprint = 0;
if ~(exist(['objeventData.csv'], 'file') == 2)
    initprint = 1;
end
dataFile = fopen('objeventData.csv', 'a');
subjFile = fopen(sprintf([subj cond '.csv']),'a');
if initprint
    fprintf(dataFile, 'subj, time, cond, break, list, trial1, trial2, contrast, response \n');
end
fprintf(subjFile, 'subj, time, cond, break, list, trial1, trial2, contrast, response \n');
lineFormat = '%s, %6.2f, %s, %s, %s, %d, %d, %d, %d \n';


% Screen('FillRect', window, grey);
% Screen('Flip', window);
if strcmp(cond, 'o')
    for x = 1:numel(pairs)
        trial = pairs{x};
        compareLoops = trial(randi([1, 2], 1, 1), :);
        breakType = BreakTypeList{x};
        Screen('FillRect', window, grey);
        Screen('Flip', window);
        fixCross(xCenter, yCenter, black, window, crossTime)
        for loop = compareLoops
            points = getPoints(loop, loop * loopFrames);
            totalpoints = numel(points)/2;
            
            Breaks = makeBreaks(breakType, totalpoints, loop, loopFrames, minSpace);
            points = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops);
            
            xpoints = (points(:, 1) .* xscale) + xCenter;
            ypoints = (points(:, 2) .* yscale) + yCenter;
            points = [xpoints ypoints];
            
            Screen('FillRect', window, grey);
            Screen('Flip', window);
            for p = 1:totalpoints - 2
                if ~any(p == Breaks) && ~any(p+1 == Breaks)
                    %Screen('DrawDots', window, [points(p, 1) points(p, 2)], 5, black, [], 2);
                    Screen('DrawLine', window, black, points(p, 1), points(p, 2), ...
                        points(p+1, 1), points(p+1, 2), 5);
                end
            end
            Screen('DrawingFinished', window);
            %t1 = GetSecs;
            vbl = Screen('Flip', window);
            %puts the image on the screen
            Screen('FillRect', window, black);
            WaitSecs(displayTime);
            vbl = Screen('Flip', window);
            %blanks the screen
            WaitSecs(pauseTime);
        end
        
        %KbStrokeWait;
        [response, time] = getResponse(window, screenXpixels, screenYpixels, textsize, cond);
        fprintf(dataFile, lineFormat, subj, time*1000, cond, breakType, list, compareLoops(1),...
            compareLoops(2), abs(compareLoops(1) - compareLoops(2)), str2double(response));
        fprintf(subjFile, lineFormat, subj, time*1000, cond, breakType, list, compareLoops(1),...
            compareLoops(2), abs(compareLoops(1) - compareLoops(2)), str2double(response));
        vbl = Screen('Flip', window);
    end
    
else %if cond is 'e'
    yscale = screenYpixels / 8;
    xscale = yscale;

    for x = 1:numel(pairs)
        %for each comparison pair in the list
        trial = pairs{x};
        compareLoops = trial(randi([1, 2], 1, 1), :);
        breakType = BreakTypeList{x};
        Screen('FillRect', window, grey);
        Screen('Flip', window);
        fixCross(xCenter, yCenter, black, window, crossTime);
        for loop = compareLoops
            %for each number of loops
            points = getPoints(loop, loop * loopFrames);
            totalpoints = numel(points)/2;
            Breaks = makeBreaks(breakType, totalpoints, loop, loopFrames, minSpace);
            xpoints = (points(:, 1) .* xscale) + xCenter;
            ypoints = (points(:, 2) .* yscale) + yCenter;
            points = [xpoints ypoints];
            
            pt = 1;
            waitframes = 1;
            %t1 = GetSecs;
            Screen('FillRect', window, grey);
            Screen('Flip', window);
            while pt <= totalpoints
                if any(pt == Breaks)
                    WaitSecs(breakTime);
                end

                destRect = [points(pt, 1) - 128/2, ... %left
                            points(pt, 2) - 128/2, ... %top
                            points(pt, 1) + 128/2, ... %right
                            points(pt, 2) + 128/2]; %bottom

                % Draw the shape to the screen
                if strcmp(shape, 'Star')
                    Screen('DrawTexture', window, imageTexture, [], destRect, 0);
                else
                    % Center the shape on the starting point
                    centeredRect = CenterRectOnPointd(baseRect, points(pt, 1), points(pt, 2));
                    Screen(fillShape, window, color, centeredRect);
                end
                Screen('DrawingFinished', window);
                % Flip to the screen
                vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
                pt = pt + 1;
                            
            end
            %t2 = GetSecs;
            %time = t2 - t1
            Screen('FillRect', window, black);
            vbl = Screen('Flip', window);
            %blanks the screen
            WaitSecs(pauseTime);
        end
        [response, time] = getResponse(window, screenXpixels, screenYpixels, textsize, cond);
        fprintf(dataFile, lineFormat, subj, time*1000, cond, breakType, list, compareLoops(1),...
            compareLoops(2), abs(compareLoops(1) - compareLoops(2)), str2double(response));
        fprintf(subjFile, lineFormat, subj, time*1000, cond, breakType, list, compareLoops(1),...
            compareLoops(2), abs(compareLoops(1) - compareLoops(2)), str2double(response));
        vbl = Screen('Flip', window);
    end
end

%After either e or o
finish(window, textsize, textspace);
fclose(dataFile);
sca
Priority(0);
end






%%%%%
%OTHER FUNCTIONS
%%%%%

function [] = instructions(window, screenXpixels, screenYpixels, textsize, cond, textspace)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    textcolor = white;
    xedgeDist = floor(screenXpixels / 3);
    numstep = floor(linspace(xedgeDist, screenXpixels - xedgeDist, 7));
    quote = '''';
    if strcmp(cond, 'o')        
        intro = strcat('In this experiment, you will be asked to consider pairs',...
            ' of images. Your task is to decide, for each pair, how similar',...
            ' what is displayed in the two images is. \n \n',...
            'You will indicate your judgment on a scale from 1-7, where 1 ',...
            ' is ', quote, 'not at all similar', quote, ' and 7 is ', quote, 'very ',...
            ' similar', quote, ', using the number keys at the top of the keyboard. While ',...
            ' you will likely see pairs of images that you judge to be at the ',...
            ' endpoints of the scale, you should also see pairs that require ',...
            ' use of the intermediary points. That is, please try to use the',...
            ' range provided by the scale. \n \n',...
            'You will be able to make your judgment only after each pair ',...
            ' of images is displayed. The representation below will appear',...
            ' at that time to remind you of the scale', quote, 's orientation. ');
    else
        intro = strcat('In this experiment, you will be asked to consider pairs',...
            ' of animations. Your task is to decide, for each pair, how similar',...
            ' what happens in the two animations is. \n \n',...
            'You will indicate your judgment on a scale from 1-7, where 1 ',...
            ' is ', quote, 'not at all similar', quote, ' and 7 is ', quote, 'very ',...
            ' similar', quote, ', using the number keys at the top of the keyboard. While ',...
            ' you will likely see pairs of animations that you judge to be at the ',...
            ' endpoints of the scale, you should also see pairs that require ',...
            ' use of the intermediary points. That is, please try to use the',...
            ' range provided by the scale. \n \n',...
            'You will be able to make your judgment only after each pair ',...
            ' of animations is displayed. The representation below will appear',...
            ' at that time to remind you of the scale', quote, 's orientation. ');
    end

    DrawFormattedText(window, intro, 'center', screenYpixels/8, textcolor, 70, 0, 0, textspace);
    
    for x = 1:7
        DrawFormattedText(window, int2str(x), numstep(x), 5*screenYpixels/8, textcolor, 70);
    end
    DrawFormattedText(window, '  not  \n at all \nsimilar', numstep(1) - (xedgeDist / 25), 5*screenYpixels/8 + 30, textcolor);
    DrawFormattedText(window, 'totally \nsimilar', numstep(7) - (xedgeDist / 25), 5*screenYpixels/8 + 30, textcolor);
    
    intro2 = ['Please indicate to the experimenter if you have any questions, '...
        'or are ready to begin the experiment. \n When the experimenter has '...
        'left the room, you may press spacebar to begin.'];
    
    DrawFormattedText(window, intro2, 'center', 4*screenYpixels/5, textcolor, 70, 0, 0, textspace);
    Screen('Flip', window);
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
end

function [] = finish(window, textsize, textspace)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    textcolor = white;
    closing = ['Thank you for your participation.\n\nPlease let the ' ...
        'experimenter know that you are finished.'];
    DrawFormattedText(window, closing, 'center', 'center', textcolor, 70, 0, 0, textspace);
    Screen('Flip', window);
    % Wait for keypress
    RestrictKeysForKbCheck(KbName('ESCAPE'));
    KbStrokeWait;
    Screen('Flip', window);
end

function [subj] = subjcheck(subj, cond)
    if ~strncmpi(subj, 's', 1)
        %forgotten s
        subj = ['s', subj];
    end
    numstrs = ['1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; '0'];
    for x = 2:numel(subj)
        if ~any(subj(x) == numstrs)
            subj = input(['Subject ID' subj ' is invalid. It should ' ...
                'consist of an "s" followed by only numbers. Please use a ' ...
                'different ID:'], 's');
            subj = subjcheck(subj, cond);
            return
        end
    end
    if exist([subj cond '.csv'], 'file') == 2
        temp = input(['Subject ID ' subj ' has already completed '...
            'the ' cond ' condition. \n Please enter a new subject ID, or type'...
            ' cancel to abort the program:'], 's');
        if strcmp('cancel', temp)
            error('Process Aborted')
        else
            subj = subjcheck(temp, cond);
        end
    end
end

function [cond] = condcheck(cond)
    while ~strcmp(cond, 'e') && ~strcmp(cond, 'o')
        cond = input('Condition must be e or o. Please enter e or o:', 's');
    end
end

function [list] = listcheck(list)
    if strcmp(list, 'some') || strcmp(list, 'all')
        check = input('some and all are test lists. Type y to continue using a test list.', 's');
        if strcmp(check, 'y')
            return
        end
    end
    while ~strcmp(list, 'blue') && ~strcmp(list, 'pink') && ~strcmp(list, 'green') && ~strcmp(list, 'orange') && ~strcmp(list, 'yellow')
        list = input('List must be a valid color. Please enter blue, pink, green, orange, or yellow:', 's');
    end
end

function [points] = getPoints(loops, steps)
    start = pi/loops;
    theta = linspace(start, start + 2*pi, steps);
    thetalist = reshape(theta, [numel(theta), 1]);
    rholist = zeros([numel(theta), 1]);
    for m = 1:numel(theta)
        rholist(m, 1) = 1 + cos(loops*thetalist(m, 1));
    end
    %Creates two arrays; theta and rho. Theta defines the intervals and
    %distance around the circle, while rho looks at the amplitude.

    points = zeros([numel(theta), 2]);


    for m = 1:numel(theta)
        points(m, 1) = rholist(m, 1)*cos(thetalist(m, 1));
        points(m, 2) = rholist(m, 1)*sin(thetalist(m, 1));
    end

    %The polar coordinates from theta and rho are translated into Cartesian
    %coordinates. For a brief explanation, see
    %https://www.mathsisfun.com/polar-cartesian-coordinates.html
end

function [Breaks] = makeBreaks(breakType, totalpoints, loops, loopFrames, minSpace)
    if strcmp(breakType, 'equal')
        Breaks = int16(linspace(loopFrames, totalpoints, loops));

    elseif strcmp(breakType, 'random')
        Breaks = randi([1 (loops*loopFrames)], 1, loops-1);
        x = 1;
        y = 2;
        while x <= numel(Breaks)
            while y <= numel(Breaks)
                if x ~= y && abs(Breaks(x) - Breaks(y)) < minSpace || Breaks(x) < minSpace || (loops*loopFrames) - Breaks(x) < minSpace
                    Breaks(x) =  randi([1, (loops*loopFrames)], 1, 1);
                    x = 1;
                    y = 0;
                end
                y = y + 1;
            end
            x = x + 1;
            y = 1;
        end

    else
        Breaks = [];
    end
end

function[] = fixCross(xCenter, yCenter, black, window, crossTime)
    fixCrossDimPix = 40;
    xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
    yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
    allCoords = [xCoords; yCoords];
    lineWidthPix = 4;
    Screen('DrawLines', window, allCoords,...
        lineWidthPix, black, [xCenter yCenter], 2);
    Screen('Flip', window);
    WaitSecs(crossTime);
end

function [response, time] = getResponse(window, screenXpixels, screenYpixels, textsize, cond)
    black = BlackIndex(window);
    white = WhiteIndex(window);
    textcolor = white;
    xedgeDist = floor(screenXpixels / 3);
    numstep = floor(linspace(xedgeDist, screenXpixels - xedgeDist, 7));
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize);
    if strcmp(cond, 'o')
        intro = 'How similar were those two images?';
    else
        intro = 'How similar were those two animations?';
    end

    DrawFormattedText(window, intro, 'center', screenYpixels/3, textcolor, 70);
    for x = 1:7
        DrawFormattedText(window, int2str(x), numstep(x), 'center', textcolor, 70);
    end
    DrawFormattedText(window, '  not  \n at all \nsimilar', numstep(1) - (xedgeDist / 25), screenYpixels/2 + 30, textcolor);
    DrawFormattedText(window, 'very \nsimilar', numstep(7) - (xedgeDist / 25), screenYpixels/2 + 30, textcolor);
    Screen('Flip',window);

    % Wait for the user to input something meaningful
    inLoop=true;
    oneseven = [KbName('1!') KbName('2@') KbName('3#') KbName('4$')...
        KbName('5%') KbName('6^') KbName('7&')];
%     numkeys = [89 90 91 92 93 94 95];
    starttime = GetSecs;
    while inLoop
        %code = [];
        [keyIsDown, ~, keyCode]=KbCheck;
        if keyIsDown
            code = find(keyCode);
            if any(code(1) == oneseven)
                endtime = GetSecs;
                response = KbName(code);
                response = response(1);
                inLoop=false;
            end
        end
    end
    time = endtime - starttime;
end

function [rpoints] = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops)
    petalnum = 0;
    rpoints = points;
    halfLoop = floor(loopFrames / 2);

    %move to origin
    for m = 1:totalpoints-1 
        if any(m == Breaks)
            petalnum = petalnum + 1;
        end
        rpoints(m, 1) = points(m, 1) - points(halfLoop + (loopFrames * petalnum), 1) / 2;
        rpoints(m, 2) = points(m, 2) - points(halfLoop + (loopFrames * petalnum), 2) / 2;
    end  

    nrpoints = rpoints;
    f = randi(360);

    if rotateLoops
        %rotate (not transform-dependent)
        for m = 1:totalpoints-1
            if any(m == Breaks)
                f = randi(360);
            end 
            rpoints(m, 1) = nrpoints(m, 1)*cos(f) - nrpoints(m, 2)*sin(f);
            rpoints(m, 2) = nrpoints(m, 2)*cos(f) + nrpoints(m, 1)*sin(f);
        end
    end

    nrpoints = rpoints;
    petalnum = 0;

    %push based on new tip direction.
    for m = 1:totalpoints-1
        if any(m == Breaks)
            petalnum = petalnum + 1;
        end
        rpoints(m, 1) = nrpoints(m, 1) + (points(halfLoop + (loopFrames * petalnum), 1) *2);
        rpoints(m, 2) = nrpoints(m, 2) + (points(halfLoop + (loopFrames * petalnum), 2) *2);
    end
end