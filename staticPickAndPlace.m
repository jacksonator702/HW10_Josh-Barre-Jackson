function staticPickAndPlace(optns)
%--------------------------------------------
% This a sub-optimal function. Requires manual work to update.
% Will change with new environments. 
%--------------------------------------------
    models = getModels(optns);

    % yBottle1 = get_model_pose(models.ModelNames{40},optns);
    % yBottle1 = structPose2Mat(yBottle1);
    
    % gCan1 = get_model_pose(models.ModelNames{24},optns);
    % gCan1 = structPose2Mat(gCan1);

    % rBottle1 = get_model_pose(models.ModelNames{35},optns);
    % rBottle1 = structPose2Mat(rBottle1);
    % 
    % rCan1 = get_model_pose(models.ModelNames{28},optns);
    % rCan1 = structPose2Mat(rCan1);
    % 
    % bBottle1 = get_model_pose(models.ModelNames{37},optns);
    % bBottle1 = structPose2Mat(bBottle1);
    % 
    % rCan2 = get_model_pose(models.ModelNames{29},optns);
    % rCan2 = structPose2Mat(rCan2);
    % 
    % gCan3 = get_model_pose(models.ModelNames{26},optns);
    % gCan3 = structPose2Mat(gCan3);
    
    % yBottle1 is laying down
    % need to turn fingers
    yBottle1 = [ 0  1  0  -0.5262;...
                 1  0  0  -0.043;...
                 %0  0 -1   0.0335;...
                 0  0  -1 -0.0665;...
                 0  0  0   1];
    yBottle1 = yBottle1*trotz(pi/2);
    
    % gCan1 is standing on top of carboard box
    gCan1    = [ 0  1  0  -0.3628;...
                 1  0  0  -0.0071;...
                 0  0 -1   0.067;...
                 0  0  0   1];
    % % 
    % rBottle1 is laying down
    % need to turn fingers% 
    rBottle1 = [ 0  1  0  -0.6193;...
                 1  0  0   0.32;...
                 0  0 -1   -0.0663;...
                 0  0  0   1];
    rBottle1 = rBottle1*trotz(pi/2);

     rCan1    = [ 0  1  0  -0.5024;...
                 1  0  0   0.255;...
                 0  0 -1   -0.0419;...
                 0  0  0   1];
    
    % rCan1 is standing up% % 
    spam    = [ 0  1  0  -0.45024;...
                 1  0  0   0.38;...
                 0  0 -1   -0.0419;...
                 0  0  0   1];
    spam = spam*trotz(pi/2);
    
    % bBottle1 is standing
    bBottle1 = [ 0  1  0   0.4602;...
                 1  0  0  -0.0702;...
                 0  0 -1   -0.0015;...
                 0  0  0   1];
    
    % rCan2 is standing on gCan3
    rCan2    = [ 0  1  0   0.66;...
                 1  0  0   0.0183;...
                 0  0 -1   0.0748;...
                 0  0  0   1];
    % gCan3 is under rCan2
    gCan3    = [ 0  1  0   0.66;... 
                 1  0  0   0.0192;...
                 0  0 -1   -0.0416;...
                 0  0  0   1];
    
  

    % easyObjects = { %Zone1
    %                "can" gCan1;...
    %                "bottle" yBottle1;...
    %                "can" rCan1;...
    %                "bottle" rBottle1;...
    %                % Zone 2
    %                "bottle" bBottle1;...
    %                "can" rCan2;...
    %                "can" gCan3};
    
    % move to Zone 1 config
    StartZone = [0.6482   -0.2317    1.4450   -1.2133    0.0003   -0.9226]; % Should not be set manually like this, but via a variable
    moveToQ("Custom",optns,StartZone); 
    pause(5);



% gCan1---------------------------------------------------------------

    % Hover over
    disp('gCan1')
    hover = lift(gCan1, 0.3);
    moveTo(hover, optns);
    pause(5);

    % Pick
    gCan1(3,4) = gCan1(3,4) + 0.18;
    moveToOG(gCan1, optns);
    pause(3);
    doGrip("pick", optns, 0.24);
    pause(5);

    % Place
    moveTo(hover, optns);
    moveToQ("Custom", optns, [5/8*pi 0 pi/2.3 -pi/2.3 0 0]); % Green
    doGrip("place", optns);
    pause(7);

    % Return to zone pose
    moveToQ("Custom",optns,StartZone); 

% spam---------------------------------------------------------------

    % Hover over
    disp('spam')
    hover = lift(spam, 0.5);
    moveTo(hover, optns);
    pause(5);

    % Pick
    spam(3,4) = spam(3,4)+.15;
    moveTo(spam, optns);
    pause(3);
    doGrip("pick", optns, 0.35);
    pause(5);

    % Place
    moveTo(hover, optns);
    moveToQ("Custom", optns, [5/8*pi 0 pi/2.3 -pi/2.3 0 0]); % Green
    doGrip("place", optns);
    pause(7);

    % Return to zone pose
    moveToQ("Custom",optns,StartZone);

% yBottle1------------------------------------------------------------        

    % Hover
    disp('yBottle1')
    hover = lift(yBottle1, 0.3);
    moveToOG(hover, optns);

    % Pick
    yBottle1(3,4) = yBottle1(3,4) + 0.14;
    moveToOG(yBottle1, optns);
    pause(3);
    doGrip("pick", optns, 0.21);
    pause(5);

    % Return to custom pose
    moveToOG(hover, optns);
    moveToQ("Custom", optns, [0 0 pi/2 -pi/2 0 0]); % pass through home position
    pause(2);

    % Place
    moveToQ("Custom", optns, [-0.8*pi 0 pi/2.3 -pi/2.3 0 0]); % Blue
    doGrip("place", optns);
    pause(7);

    % Return to zone pose
    moveToQ("Custom",optns,StartZone);         
% rCan1---------------------------------------------------------------

    % Hover
    disp('rCan1')
    hover = lift(rCan1, 0.3);        
    moveTo(hover, optns);

    % Pick
    rCan1(3,4) = rCan1(3,4) + 0.18;
    moveTo(rCan1, optns);
    pause(3);
    doGrip("pick", optns, 0.24);
    pause(10);

    % Place
    moveTo(hover, optns);
    moveToQ("Custom", optns, [5/8*pi 0 pi/2.3 -pi/2.3 0 0]); % Green
    doGrip("place", optns);
    pause(7);


    % Return to zone pose
    moveToQ("Custom",optns,StartZone); 

% rBottle1------------------------------------------------------------

    % Hover
    disp('rBottle1')
    hover = lift(rBottle1, 0.3);
    moveTo(hover, optns);

    % Pick
    rBottle1(3,4) = rBottle1(3,4) + 0.14;
    moveTo(rBottle1, optns);
    pause(3);
    doGrip("pick", optns, 0.21);
    pause(5);

    % Place
    moveTo(hover, optns);
    moveToQ("Custom", optns, [0 0 pi/2 -pi/2 0 0]); % pass through home position
    pause(2);

    moveToQ("Custom", optns, [-0.8*pi 0 pi/2.3 -pi/2.3 0 0]); % Blue
    doGrip("place", optns);
    pause(7);


    %% Set custom zone2 for the rest of these objects
    StartZone = [-1.8380   -0.0978    1.8084   -1.7105    0    4.4452];
    moveToQ("Custom",optns,StartZone); % move to Zone 2
    pause(7);

% bBottle1------------------------------------------------------------

    % Hover
    disp('bBottle1')
    hover = lift(bBottle1, 0.3);
    moveToOG(hover, optns);

    % Pick
    bBottle1(3,4) = bBottle1(3,4) + 0.24;
    moveToOG(bBottle1, optns);
    pause(3);
    doGrip("pick", optns, 0.51);
    pause(3);
    doGrip("pick", optns, 0.515);
    pause(3);

    % Place 
    moveToOG(hover, optns);
    pause(2);

    moveToQ("Custom", optns, [-0.8*pi 0 pi/2.3 -pi/2.3 0 0]); % Blue
    doGrip("place", optns);
    pause(7);

    % Move back to custom
    moveToQ("Custom", optns, [0 0 pi/2 -pi/2 0 0]); % pass through home position
    pause(2);
% 
% rCan2---------------------------------------------------------------

    % Hover
    disp('rCan2')
    hover = lift(rCan2, 0.3);
    moveToOG(hover, optns);

    % Pick
    rCan2(3,4) = rCan2(3,4) + 0.18;
    moveToOG(rCan2, optns);
    pause(3);
    doGrip("pick", optns, 0.24);
    pause(10);

    % Place w/ custom path
    moveToOG(hover, optns);
    pause(3);
    moveToQ("Custom", optns, [0 0 pi/2 -pi/2 0 0]); % pass through home position
    pause(2);

    moveToQ("Custom", optns, [5/8*pi 0 pi/2.3 -pi/2.3 0 0]); % Green
    pause(5);
    doGrip("place", optns);
    pause(7);
    doGrip("place", optns);
    pause(7);

    % Return to zone pose via home position - 2 motions
    moveToQ("Custom", optns, [0 0 pi/2 -pi/2 0 0]); % pass through home position
    pause(2);
    moveToQ("Custom",optns,StartZone);

% gCan3----------------------------------------------------------------
    
    % Hover
    disp('gCan3')
    hover = lift(gCan3, 0.5);
    moveToOG(hover, optns);
    pause(5);

    % Pick
    gCan3(3,4) = gCan3(3,4) + 0.18;
    moveToOG(gCan3, optns);
    pause(3);
    doGrip("pick", optns, 0.24);
    pause(5);

    % Place through home
    moveToOG(hover, optns);
    moveToQ("Custom", optns, [0 0 pi/2 -pi/2 0 0]); % pass through home position
    pause(2);

    moveToQ("Custom", optns, [5/8*pi 0 pi/2.3 -pi/2.3 0 0]); % Green
    doGrip("place", optns);
    pause(7);

    % Return to zone pose via home position - 2 motions
    moveToQ("Custom", optns, [0 0 pi/2 -pi/2 0 0]); % pass through home position
    pause(2);
    moveToQ("Custom",optns,StartZone);



end

