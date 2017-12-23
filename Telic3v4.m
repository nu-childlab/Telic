function [] = Telic3v4()
Screen('Preference', 'SkipSyncTests', 0);
close all;
sca
PsychDefaultSetup(2);
screens = Screen('Screens');
screenNumber = max(screens);
rng('shuffle');
KbName('UnifyKeyNames');

% tel=input('Condition a or t: ', 's');
% tel = telcheck(tel);
subj=input('Subject Number: ', 's');
subj = subjcheck(subj);
if strcmp(subj, 's998')
    list = 'none';
    pairs = {[4 5; 5 4]};
    displayTime = 1;
elseif strcmp(subj, 's999')
    list=input('List color: ', 's');
    list = listcheck(list);
    list = 'none';
    pairs = {[4 5; 5 4]};
    displayTime = 3;
else
    list=input('List color: ', 's');
    list = listcheck(list);
    displayTime = 3;
    %How long to display stimuli in obj conditions
end

% if strcmp(tel, 't')
% %     brk = 'equal';
%     breakList = {'equal';'random'};
% else
% %     brk = 'random';
%     breakList = {'random';'equal'};
% end


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

loopTime = .75;

loopFrames = round(loopTime / ifi) + 1;

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

textsize = 18;
textspace = 1.5;

rotateLoops = 1;
%Current options: 0 or 1
%1 means each loop is rotated a random number of degrees. 0 means they aren't.

quote = '''';
squote = ' ''';



%%%%%%Create List
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
    pairs = [pairs;pairs];

elseif strcmp(list, 'blue')
    pairs = {[4 5; 5 4;]; [4 6; 6 4]; [4 7; 7 4]; [4 8; 8 4]; [4 9; 9 4]; ...
        [9 4; 4 9]; [9 5; 5 9]; [9 6; 6 9]; [9 7; 7 9]; [9 8; 8 9]};
    pairs = [pairs;pairs];
    % pairs = [pairs;pairs];
elseif strcmp(list, 'pink')
    pairs = {[5 6; 6 5]; [5 7; 7 5]; [5 8; 8 5]; [5 9; 9 5]; [4 9; 9 4]; ...
        [9 4; 4 9]; [8 4; 4 8]; [8 5; 5 8]; [8 6; 6 8]; [8 7; 7 8]};
    pairs = [pairs;pairs];
    % pairs = [pairs;pairs];
elseif strcmp(list, 'green')
    pairs = {[6 7; 7 6]; [6 8; 8 6]; [6 9; 9 6]; [5 9; 9 5]; [4 9; 9 4]; ...
        [9 4; 4 9]; [8 4; 4 8]; [7 4; 4 7]; [7 5; 5 7]; [7 6; 6 7]};
    pairs = [pairs;pairs];
    % pairs = [pairs;pairs];
elseif strcmp(list, 'orange')
    pairs = {[7 8; 8 7]; [6 8; 8 6]; [5 8; 8 5]; [4 8; 8 4]; [4 9; 9 4]; ...
        [9 4; 4 9]; [9 5; 5 9]; [8 5; 5 8]; [7 5; 5 7]; [6 5; 5 6]};
    pairs = [pairs;pairs];
    % pairs = [pairs;pairs];
elseif strcmp(list, 'yellow')
    pairs = {[4 9; 9 4]; [5 9; 9 5]; [6 9; 9 6]; [7 9; 9 7]; [8 9; 9 8]; ...
        [5 4; 4 5]; [6 4; 4 6]; [7 4; 4 7]; [8 4; 4 8]; [9 4; 4 9]};
    pairs = [pairs;pairs];
    % pairs = [pairs;pairs];
end

%%%%%%
%THE ACTUAL FUNCTION!!!
%%%%%%

%%%%%%%Screen Prep
HideCursor;	% Hide the mouse cursor
Priority(MaxPriority(window));

%%%%%%Shape Prep

theImageLocation = 'star.png';
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





%%%%%%DATA FILES
%yscale is used to scale the images to be smaller or larger.
initprint = 0;
initprintsubj = 0;
if ~(exist('TELIC3Data.csv', 'file') == 2)
    initprint = 1;
end
if ~(exist([subj '.csv'], 'file') == 2)
    initprintsubj = 1;
end
dataFile = fopen('TELIC3Data.csv', 'a');
subjFile = fopen(sprintf([subj '.csv']),'a');
if initprint
    fprintf(dataFile, 'subj, time, telicity, cond, list, trial1, trial2, contrast, response \n');
end
if initprintsubj
    fprintf(subjFile, 'subj, time, telicity, cond, list, trial1, trial2, contrast, response \n');
end
lineFormat = '%s,%6.2f,%s,%s,%s,%d,%d,%d,%d\n';

instructions(window, screenXpixels, screenYpixels, textsize, textspace);

%%%%%BLOCK LOOP%%%%%

telicityBlockList = {'atelic', 'telic'};
eBlockList = telicityBlockList(randperm(length(telicityBlockList)));
oBlockList = telicityBlockList(randperm(length(telicityBlockList)));

blockList = {'o', 'o', 'e', 'e'};
blockList = blockList(randperm(length(blockList)));
c = 1;
%Time variables track the progression through object and event blocks
%independently
eventTime = 0;
objectTime = 0;

% for each block (two o blocks, two e blocks)
for block = blockList
    %set the stimuli type and telicity according to the block orders
    disp(class(block))
    cond = char(block);
    if strcmp(cond, 'e') 
        eventTime = eventTime + 1;
        if eventTime == 1
            telicity = eBlockList(1);
        else 
            telicity = eBlockList(2);
        end
    else
        objectTime = objectTime + 1;
        if objectTime == 1
            telicity = oBlockList(1);
        else
            telicity = oBlockList(2);
        end       
    end
    
    if strcmp(telicity,'atelic')
        brk = 'random';
    else
        brk='equal';
    end
    
    blockInstructions(window, textsize, textspace, cond);
    shuff = randperm(length(pairs));
    pairs = pairs(shuff,:);
    %randomization

    if strcmp(brk, 'random')
        if strcmp(cond, 'e')
            train1 = 'a star doing some GORPS';
            train2 = 'the star doing more GORPS';
            train3 = 'the star doing some GORPS';
            test1 = ' animations';
            test2 = ' the star doing some GORPS';
        else
            train1 = 'some BAMPS';
            train2 = 'more BAMPS';
            train3 = 'some BAMPS';
            test1 = ' images';
            test2 = ' some BAMPS';
        end
    else
        if strcmp(cond, 'e')
            train1 = 'a star doing some GLEEBING';
            train2 = 'the star doing more GLEEBING';
            train3 = 'the star doing some GLEEBING';
            test1 = ' animations';
            test2 = ' the star doing some GLEEBING';
        else
            train1 = 'some BLICK';
            train2 = 'more BLICK';
            train3 = 'some BLICK';
            test1 = ' images';
            test2 = ' some BLICK';
        end
    end

    trainintro = ['First, you' quote 're going to see ' train1 '.'];
    traincont = ['Now you' quote 're going to see ' train2 '.'];
    traincont2 = ['Let' quote 's see that again! You' quote 're going to see ' train3 '.']; 
    trainend = strcat('That', quote, 's it for the training period! \n\n',...
        'Now you', quote, 're going to the main experiment.\n\n',...
        'You will see pairs of ', test1, ', and your task is to answer',...
        ' the following question on a 1-to-7 scale, where ', squote, '1',...
        quote, ' is', squote, 'totally not similar', quote, ' and ',...
        squote, '7', quote, ' is ', squote, 'totally similar', quote, '.');
    testq = strcat('How similar were those ', test1, ' of ', test2, '?');

    training_options = [4;5;6;7;8;9];
    training_options = training_options(randperm(length(training_options)));
    % only the first three numbers
    training_options = training_options(1:3, :);
    Screen('Flip', window);
    vbl = Screen('Flip', window);


%%%%%TRAINING%%%%%

    if strcmp(cond, 'o')
        trainSentence1(window, textsize, textspace, trainintro, screenYpixels);
        objectTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
            loopFrames, minSpace, rotateLoops, displayTime, training_options(1));
        trainSentence2(window, textsize, textspace, traincont, screenYpixels);
        objectTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
            loopFrames, minSpace, rotateLoops, displayTime, training_options(2));
        trainSentence3(window, textsize, textspace, traincont2, screenYpixels);
        objectTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
            loopFrames, minSpace, rotateLoops, displayTime, training_options(3));
        endTraining(window, textsize, textspace, trainend, testq, screenYpixels);
    else
        trainSentence1(window, textsize, textspace, trainintro, screenYpixels);
        eventTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
            loopFrames, minSpace, ifi, imageTexture, vbl, breakTime, training_options(1));
        trainSentence2(window, textsize, textspace, traincont, screenYpixels);
        eventTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
            loopFrames, minSpace, ifi, imageTexture, vbl, breakTime, training_options(2));
        trainSentence3(window, textsize, textspace, traincont2, screenYpixels);
        eventTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
            loopFrames, minSpace, ifi, imageTexture, vbl, breakTime, training_options(3));
        endTraining(window, textsize, textspace, trainend, testq, screenYpixels);
    end

%%%%%TESTING%%%%%

    if strcmp(cond, 'o')
        yscale = screenYpixels / 15;
        xscale = yscale;
        for x = 1:numel(pairs)
            trial = pairs{x};
            compareLoops = trial(randi([1, 2], 1, 1), :);
            Screen('FillRect', window, grey);
            Screen('Flip', window);
            fixCross(xCenter, yCenter, black, window, crossTime);
            for loop = compareLoops
                points = getPoints(loop, loop * loopFrames);
                totalpoints = numel(points)/2;

                Breaks = makeBreaks(brk, totalpoints, loop, loopFrames, minSpace);
                points = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops);

                xpoints = (points(:, 1) .* xscale) + xCenter;
                ypoints = (points(:, 2) .* yscale) + yCenter;
                points = [xpoints ypoints];

                Screen('FillRect', window, grey);
                Screen('Flip', window);
                savepoint = 1;
                for p = 1:totalpoints - 2
                    if ~any(p == Breaks) && ~any(p+1 == Breaks)
                        Screen('DrawLine', window, black, xpoints(p), ypoints(p), ...
                        xpoints(p+1), ypoints(p+1), 5);
                    else
                        if strcmp(brk, 'equal') && p>1
                            Screen('DrawLine', window, black, xpoints(p), ypoints(p), ...
                                xpoints(savepoint), ypoints(savepoint), 5);
                            savepoint = p+1;
                        end
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
            [response, time] = getResponse(window, screenXpixels, screenYpixels, textsize, testq);
            fprintf(dataFile, lineFormat, subj, time*1000, brk, cond, list, compareLoops(1),...
                compareLoops(2), abs(compareLoops(1) - compareLoops(2)), str2double(response));
            fprintf(subjFile, lineFormat, subj, time*1000, brk, cond, list, compareLoops(1),...
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
            Screen('FillRect', window, grey);
            Screen('Flip', window);
            fixCross(xCenter, yCenter, black, window, crossTime);
            for loop = compareLoops
                %for each number of loops
                points = getPoints(loop, loop * loopFrames);
                totalpoints = numel(points)/2;
                Breaks = makeBreaks(brk, totalpoints, loop, loopFrames, minSpace);
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
                    Screen('DrawTexture', window, imageTexture, [], destRect, 0);
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
            [response, time] = getResponse(window, screenXpixels, screenYpixels, textsize, testq);
            fprintf(dataFile, lineFormat, subj, time*1000, brk, cond, list, compareLoops(1),...
                compareLoops(2), abs(compareLoops(1) - compareLoops(2)), str2double(response));
            fprintf(subjFile, lineFormat, subj, time*1000, brk, cond, list, compareLoops(1),...
                compareLoops(2), abs(compareLoops(1) - compareLoops(2)), str2double(response));
            vbl = Screen('Flip', window);
        end
    end
    if c < 4
        breakScreen(window, textsize, textspace);
        c = c+1;
    end
end

%After either e or o
finish(window, textsize, textspace);
fclose(dataFile);
fclose(subjFile);
sca
Priority(0);
end






%%%%%START/FINISH/BREAK FUNCTIONS%%%%%

function [] = instructions(window, screenXpixels, screenYpixels, textsize, textspace)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    textcolor = white;
    xedgeDist = floor(screenXpixels / 3);
    numstep = floor(linspace(xedgeDist, screenXpixels - xedgeDist, 7));
    squote = ' ''';
    quote = '''';
    intro = strcat('In this experiment, you will be asked to consider pairs of animations or',...
        ' images. Your task is to decide, for each pair, how similar what is ',...
        ' displayed in the two animations or images is. \n\n You will indicate your ',...
        ' judgment on a scale from 1-7, where 1 is', squote, 'not at all similar',...
        quote, ' and 7 is', squote, 'very similar', quote, ', using the number keys ',...
        ' at the top of the keyboard. While you will likely see pairs of animations or images',...
        ' that you judge to be at the endpoints of the scale, you should ',...
        ' also see pairs that require use of the intermediary points. That is, ',...
        ' please try to use the range provided by the scale. \n\n',...
        ' You will be able to make your judgement only after each pair of animations or images',...
        ' is displayed. The representation below will appear at that time to ',...
        ' remind you of the scale', quote, 's orientation.');

    DrawFormattedText(window, intro, 'center', 30, textcolor, 70, 0, 0, textspace);
    
    for x = 1:7
        DrawFormattedText(window, int2str(x), numstep(x), 5*screenYpixels/8, textcolor, 70);
    end
    DrawFormattedText(window, '  not  \n at all \nsimilar', numstep(1) - (xedgeDist / 25), ...
        5*screenYpixels/8 + 30, textcolor);
    DrawFormattedText(window, 'totally \nsimilar', numstep(7) - (xedgeDist / 25), ...
        5*screenYpixels/8 + 30, textcolor);
    
    intro2 = ['Please indicate to the experimenter if you have any questions, '...
        'or are ready to begin the experiment. \n When the experimenter has '...
        'left the room, you may press spacebar to begin.'];
    
    DrawFormattedText(window, intro2, 'center', 4*screenYpixels/5, textcolor, 70, 0, 0, textspace);
    Screen('Flip', window);
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
    RestrictKeysForKbCheck([]);
end

function [] = blockInstructions(window, textsize, textspace, type)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    textcolor = white;
    quote = '''';
    if strcmp(type, 'object')
        word = 'images';
    else
        word= 'animations';
    end
      intro = ['In this block, you will be asked to compare pairs of ' word '.'...
          ' You will now see a few examples of these ' word '.\n\n',...
           'Ready? Press spacebar.'];
    DrawFormattedText(window, intro, 'center', 'center', textcolor, 70, 0, 0, textspace);
    

    Screen('Flip', window);
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
    RestrictKeysForKbCheck([]);

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

function [] = breakScreen(window, textsize, textspace)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    Screen('FillRect', window, black);
    Screen('Flip', window);
    textcolor = white;
    quote = '''';
    DrawFormattedText(window, ['That' quote 's it for that part of the experiment! \n\n' ...
        'Ready to continue to the next part? Press spacebar.'], 'center', 'center',...
        textcolor, 70, 0, 0, textspace);
    Screen('Flip', window);
    % Wait for keypress
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
    RestrictKeysForKbCheck([]);
end




%%%%%%RESPONSE FUNCTION%%%%%

function [response, time] = getResponse(window, screenXpixels, screenYpixels, textsize, testq)
    black = BlackIndex(window);
    white = WhiteIndex(window);
    textcolor = white;
    xedgeDist = floor(screenXpixels / 3);
    numstep = floor(linspace(xedgeDist, screenXpixels - xedgeDist, 7));
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize);

    DrawFormattedText(window, testq, 'center', screenYpixels/3, textcolor, 70);
    for x = 1:7
        DrawFormattedText(window, int2str(x), numstep(x), 'center', textcolor, 70);
    end
    DrawFormattedText(window, '  not  \n at all \nsimilar', numstep(1) - (xedgeDist / 25),...
        screenYpixels/2 + 30, textcolor);
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
                % If only one key was pressed (valid response), the result
                % is a single char(acter), not a cell in a matrix
                % calculate response key and exit the loop waiting for
                % response.
                if ischar(response)
                    response = response(1);
                    inLoop=false;
                end
            end
        end
    end
    time = endtime - starttime;
end




%%%%%%FIXATION CROSS FUNCTION%%%%%

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




%%%%%%INPUT CHECKING FUNCTIONS%%%%%

function [subj] = subjcheck(subj)
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
end

function [tel] = telcheck(tel)
    while ~strcmp(tel, 'a') && ~strcmp(tel, 't')
        tel = input('Condition must be a or t. Please enter a or t:', 's');
    end
end

function [list] = listcheck(list)
    if strcmp(list, 'some') || strcmp(list, 'all')
        check = input('some and all are test lists. Type y to continue using a test list.', 's');
        if strcmp(check, 'y')
            return
        end
    end
    while ~strcmp(list, 'blue') && ~strcmp(list, 'pink') && ~strcmp(list, 'green') && ...
            ~strcmp(list, 'orange') && ~strcmp(list, 'yellow')
        list = input('List must be a valid color. Please enter blue, pink, green, orange, or yellow:', 's');
    end
end





%%%%%TRAINING FUNCTIONS%%%%%

function [] = trainSentence1(window, textsize, textspace, sent, screenYpixels)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize + 5);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    Screen('FillRect', window, black);
    Screen('Flip', window);
    DrawFormattedText(window, sent, 'center', 'center', white, 70, 0, 0, textspace);
    
    Screen('TextSize',window,textsize);
    DrawFormattedText(window, 'This is the training period for this subpart of the experiment.',...
        'center', screenYpixels/2-70, white, 70, 0, 0, textspace)
    DrawFormattedText(window, 'Ready? Press spacebar.', 'center', screenYpixels/2+50, white, 70, 0, 0, textspace)
    Screen('Flip', window);
    % Wait for keypress
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
    RestrictKeysForKbCheck([]);
end

function [] = trainSentence2(window, textsize, textspace, sent, screenYpixels)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize + 5);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    Screen('FillRect', window, black);
    Screen('Flip', window);
    DrawFormattedText(window, sent, 'center', 'center', white, 70, 0, 0, textspace);
    
    Screen('TextSize',window,textsize);
    DrawFormattedText(window, 'Ready? Press spacebar.', 'center', screenYpixels/2+50, white, 70, 0, 0, textspace);
    Screen('Flip', window);
    % Wait for keypress
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
    RestrictKeysForKbCheck([]);
end

function [] = trainSentence3(window, textsize, textspace, sent, screenYpixels)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize + 5);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    Screen('FillRect', window, black);
    Screen('Flip', window);
    DrawFormattedText(window, sent, 'center', 'center', white, 70, 0, 0, textspace);
    
    Screen('TextSize',window,textsize);
    DrawFormattedText(window, 'Ready? Press spacebar.', 'center', screenYpixels/2+50, white, 70, 0, 0, textspace);
    Screen('Flip', window);
    % Wait for keypress
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
    RestrictKeysForKbCheck([]);
end

function[] = objectTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
    loopFrames, minSpace, rotateLoops, displayTime, numberOfLoops)
    yscale = screenYpixels / 15;
    xscale = yscale;
    white = WhiteIndex(window);
    black = BlackIndex(window);
    grey = white/2;
    
    
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    fixCross(xCenter, yCenter, black, window, crossTime)
    points = getPoints(numberOfLoops, numberOfLoops * loopFrames);
    totalpoints = numel(points)/2;

    Breaks = makeBreaks(brk, totalpoints, numberOfLoops, loopFrames, minSpace);
    points = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops);
    Breaks = sort(Breaks);

    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];

    Screen('FillRect', window, grey);
    Screen('Flip', window);
    for p = 1:totalpoints-2
        if ~any(p == Breaks) && ~any(p+1 == Breaks)
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
end


function[] = eventTrainingStim(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
    loopFrames, minSpace, ifi, imageTexture, vbl, breakTime, numberOfLoops)
    yscale = screenYpixels / 8;
    xscale = yscale;
    white = WhiteIndex(window);
    black = BlackIndex(window);
    grey = white/2;


    Screen('FillRect', window, grey);
    Screen('Flip', window);
    fixCross(xCenter, yCenter, black, window, crossTime)
    
    points = getPoints(numberOfLoops, numberOfLoops * loopFrames);
    totalpoints = numel(points)/2;
    Breaks = makeBreaks(brk, totalpoints, numberOfLoops, loopFrames, minSpace);
    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];
    Breaks = sort(Breaks);
    
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
        Screen('DrawTexture', window, imageTexture, [], destRect, 0);
        Screen('DrawingFinished', window);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        pt = pt + 1;
        
    end
end

function[] = oneloopobj(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
    loopFrames, minSpace, rotateLoops, displayTime)
    yscale = screenYpixels / 15;
    xscale = yscale;
    white = WhiteIndex(window);
    black = BlackIndex(window);
    grey = white/2;
    
    
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    fixCross(xCenter, yCenter, black, window, crossTime)
    points = getPoints(3, 3 * loopFrames);
    totalpoints = numel(points)/2;

    Breaks = makeBreaks(brk, totalpoints, 3, loopFrames, minSpace);
    points = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops);
    Breaks = sort(Breaks);

    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];

    Screen('FillRect', window, grey);
    Screen('Flip', window);
    for p = 1:Breaks(1)
        if ~any(p == Breaks) && ~any(p+1 == Breaks)
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
end

function[] = twoloopobj(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
    loopFrames, minSpace, rotateLoops, displayTime)
    yscale = screenYpixels / 15;
    xscale = yscale;
    white = WhiteIndex(window);
    black = BlackIndex(window);
    grey = white/2;
    
    
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    fixCross(xCenter, yCenter, black, window, crossTime)
    points = getPoints(3, 3 * loopFrames);
    totalpoints = numel(points)/2;

    Breaks = makeBreaks(brk, totalpoints, 3, loopFrames, minSpace);
    points = rotateGaps(points, totalpoints, loopFrames, Breaks, rotateLoops);
    Breaks = sort(Breaks);

    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];

    Screen('FillRect', window, grey);
    Screen('Flip', window);
    for p = 1:Breaks(2)
        if ~any(p == Breaks) && ~any(p+1 == Breaks)
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
end

function[] = oneloopev(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
    loopFrames, minSpace, ifi, imageTexture, vbl, breakTime)
    yscale = screenYpixels / 8;
    xscale = yscale;
    white = WhiteIndex(window);
    black = BlackIndex(window);
    grey = white/2;


    Screen('FillRect', window, grey);
    Screen('Flip', window);
    fixCross(xCenter, yCenter, black, window, crossTime)
    
    points = getPoints(3, 3 * loopFrames);
    totalpoints = numel(points)/2;
    Breaks = makeBreaks(brk, totalpoints, 3, loopFrames, minSpace);
    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];
    Breaks = sort(Breaks);
    
    pt = 1;
    waitframes = 1;
    %t1 = GetSecs;
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    while pt <= Breaks(1)
        if any(pt == Breaks)
            WaitSecs(breakTime);
        end
        
        destRect = [points(pt, 1) - 128/2, ... %left
            points(pt, 2) - 128/2, ... %top
            points(pt, 1) + 128/2, ... %right
            points(pt, 2) + 128/2]; %bottom
        
        % Draw the shape to the screen
        Screen('DrawTexture', window, imageTexture, [], destRect, 0);
        Screen('DrawingFinished', window);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        pt = pt + 1;
        
    end
end

function[] = twoloopev(window, brk, screenYpixels, xCenter, yCenter, crossTime,...
    loopFrames, minSpace, ifi, imageTexture, vbl, breakTime)
    yscale = screenYpixels / 8;
    xscale = yscale;
    white = WhiteIndex(window);
    black = BlackIndex(window);
    grey = white/2;


    Screen('FillRect', window, grey);
    Screen('Flip', window);
    fixCross(xCenter, yCenter, black, window, crossTime)
    
    points = getPoints(3, 3 * loopFrames);
    totalpoints = numel(points)/2;
    Breaks = makeBreaks(brk, totalpoints, 3, loopFrames, minSpace);
    xpoints = (points(:, 1) .* xscale) + xCenter;
    ypoints = (points(:, 2) .* yscale) + yCenter;
    points = [xpoints ypoints];
    Breaks = sort(Breaks);
    
    pt = 1;
    waitframes = 1;
    %t1 = GetSecs;
    Screen('FillRect', window, grey);
    Screen('Flip', window);
    while pt <= Breaks(2)
        if any(pt == Breaks)
            WaitSecs(breakTime);
        end
        
        destRect = [points(pt, 1) - 128/2, ... %left
            points(pt, 2) - 128/2, ... %top
            points(pt, 1) + 128/2, ... %right
            points(pt, 2) + 128/2]; %bottom
        
        % Draw the shape to the screen
        Screen('DrawTexture', window, imageTexture, [], destRect, 0);
        Screen('DrawingFinished', window);
        % Flip to the screen
        vbl  = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
        pt = pt + 1;
        
    end
end

function [] = endTraining(window, textsize, textspace, trainend, testq, screenYpixels)
    Screen('TextFont',window,'Arial');
    Screen('TextSize',window,textsize+5);
    black = BlackIndex(window);
    white = WhiteIndex(window);
    Screen('FillRect', window, black);
    Screen('Flip', window);
    textcolor = white;
    DrawFormattedText(window, testq, 'center', 'center',...
        textcolor, 70, 0, 0, textspace);
    
    Screen('TextSize',window,textsize);
    DrawFormattedText(window, trainend, 'center', screenYpixels/2-220,...
        textcolor, 70, 0, 0, textspace);
    DrawFormattedText(window, 'Ready? Press spacebar.', 'center', screenYpixels/2+40,...
        textcolor, 70, 0, 0, textspace);
    
    Screen('Flip', window);
    % Wait for keypress
    RestrictKeysForKbCheck(KbName('space'));
    KbStrokeWait;
    Screen('Flip', window);
    RestrictKeysForKbCheck([]);
end






%%%%%STIMULUS MATH FUNCTIONS%%%%%


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
                if x ~= y && abs(Breaks(x) - Breaks(y)) < minSpace || Breaks(x) < minSpace ||...
                        (loops*loopFrames) - Breaks(x) < minSpace
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