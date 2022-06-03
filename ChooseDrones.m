

    
    %define starting position of the drones
    startpos = 1;
    if ~isempty(Gs(gg).ObsIDs) ~= 0
        %if the starting position considered is an obstacle, move the starting
        %position
        while ~isempty(find(Gs(gg).ObsIDs == startpos,1))
            startpos = startpos + 1;
        end
    end
    %Generate Base Path for the drones
    p_base = PathSelection(Gs(gg), startpos);
    
    
    %start timers for the cells
    
    cell_timers = zeros(1,(Gs(gg).M)^2);
    
    %line1 - time of last visit
    %line2 - drone that visited
    CellAlloc.TimeLastVisit = zeros(2,100000);
    CellAlloc.lat = 0;
    CellAlloc.long = 0;
    CellAlloc.Class = -1;
    
    cell = repmat(CellAlloc,(Gs(gg).M)^2,1);
    
    for cc = 1:(Gs(gg).M)^2
        if isempty(find(Gs(gg).ObsIDs == cc,1))
            % cell coordinates
            cell(cc).lat = Gs(gg).XD(cc);
            cell(cc).long = Gs(gg).YD(cc);
            
            cell(cc).Class = 1;
        end
        
    end
%     %add repetion of visitation to special cells
%     for sc = 1:length(Gs(gg).SpecIDs)
%         %the ratio should always be > 1 --> specD < D
%         ratio = (Gs(gg).DefaultDeadline)/(Gs(gg).Deadlines(Gs(gg).SpecIDs(sc)));
%         % ratio is the times the cell should be visited 
%         cell(Gs(gg).SpecIDs(sc)).Class = floor(ratio);
%         p_base = [p_base,Gs(gg).SpecIDs(sc)*ones(1,floor(ratio)-1)]; % -1 because it is already being visited once
%     end
%     
    looktab = Classes.LookTable(Gs(gg).DefaultDeadline);
    
    %add repetion of visitation to special cells
    
    for sc = 1:length(Gs(gg).SpecIDs)
        
        cell(Gs(gg).SpecIDs(sc)).Class = Classes.WhatClass(looktab,Gs(gg).Deadlines(Gs(gg).SpecIDs(sc)));
        if cell(Gs(gg).SpecIDs(sc)).Class > 1
            p_base = [p_base, Gs(gg).SpecIDs(sc)*ones(1,cell(Gs(gg).SpecIDs(sc)).Class - 1)]; % -1 because it is already being visited once  
        end
        
    end
    
    tabdist = distances(Gs(gg).Graph);
    
    %create drones
    DroneAlloc.path = [];
    %drones start mission in 'flying' mode
    % 1 - flying
    % 2 - sensing
    DroneAlloc.state = zeros(2,100000);
    %state marks when drone changes state
    %mission end ---> drones that finished their path
    DroneAlloc.mend = 0;
    DroneAlloc.tracker = zeros(4,100000);%gives the position of all drones.
    %l1: position
    %l2: eta to next cell to sense
    %l3: index of the next visit in path vector
    %l4: time instant
    drone = repmat(DroneAlloc,Ndrones,1);
    
    drone(1).path = p_base;
    
    if Ndrones ~= 1
        p = multidronep(Ndrones, p_base);
        
        for ii = 2:size(p,1)
            drone(ii).path = p(ii,:);
        end
    end
    
    for ii = 1:Ndrones
        % all drones start at the same point
        
        if drone(ii).path(1) == startpos %if the first cell to sense is the startpos
            drone(ii).tracker(1,1) = startpos;
            drone(ii).tracker(2,1) = 1;
            drone(ii).tracker(3,1) = 1;
            drone(ii).tracker(4,1) = 1;   
        else % the drone needs to move
            drone(ii).tracker(1,1) = startpos;
            drone(ii).tracker(2,1) = 1 + t_fly*tabdist(startpos,drone(ii).path(1));
            drone(ii).tracker(3,1) = 1;
            drone(ii).tracker(4,1) = 1;
            
        end
        
        if drone(ii).path(1) ~= startpos
            drone(ii).state(1,1) = 1;
            drone(ii).state(2,1) = 1;
        else
            %mode changes to sensing at the begining of the mission
            drone(ii).state(1,1) = 1;
            drone(ii).state(2,1) = 2;
        end
        
        %posetracker = tracker(1,:);
        
    end
