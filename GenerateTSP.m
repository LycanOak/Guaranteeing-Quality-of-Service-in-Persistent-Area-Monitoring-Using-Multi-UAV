function tsp_path = GenerateTSP(G, stopsLat, stopsLon, M, Nobstacles, obsIDs, startpos, nstops)
    %based on the algorithm provided by mathworks for solving the TSP
    %problem
    
    %CAUTION WITH OBSTACLES
    Gtsp = G;
    if Nobstacles ~= 0
        rcnt = 0;
        for ii = obsIDs
            Gtsp = rmnode(Gtsp, ii-rcnt);
            
            stopsLat = [stopsLat(1:(ii-rcnt-1)), stopsLat((ii-rcnt+1):end)];
            stopsLon = [stopsLon(1:(ii-rcnt-1)), stopsLon((ii-rcnt+1):end)];
            
            rcnt = rcnt + 1;
        end
    end
    
    
    locations = zeros(nstops,2);
    dist = [];
      
%     figure();
%     nfs = 15*ones(1,nstops);
%     hGraph = plot(Gtsp,'XData',stopsLat,'YData',stopsLon, 'NodeFontSize', nfs, 'LineStyle','none');
%     title('Initial Graph for TSP');
    
    
    %CALCULATE DISTANCE BETWEEN POINTS
    DbP = distances(Gtsp);
    idxs = nchoosek(1:nstops,2); %all pairs of stops
    
    %CONSTRAINTS
    % Create the linear constraints that each stop has two associated trips,
    %because there must be a trip to each stop and a trip departing each stop.
    
    Aeq = spalloc(nstops,length(idxs),nstops*(nstops-1)); % Allocate a sparse matrix
    
    for ii = 1:nstops
        whichIdxs = (idxs == ii); % Find the trips that include stop ii
        whichIdxs = sparse(sum(whichIdxs,2)); % Include trips where ii is at either end
        Aeq(ii,:) = whichIdxs'; % Include in the constraint matrix
    end
    
    beq = 2*ones(nstops,1);
    
    %BINARY BOUNDS
    lidxs = length(idxs);
    dist = zeros(1,lidxs);
    for jj = 1:lidxs
        dist(jj) = DbP(idxs(jj,1), idxs(jj,2));
    end
    
    lendist = length(dist);
    intcon = 1:lendist;
    lb = zeros(lendist,1);
    ub = ones(lendist,1);
    
    %OPTIMIZE USING intlinprog
    opts = optimoptions('intlinprog','Display','off');
    [x_tsp,costopt,exitflag,output] = intlinprog(dist,intcon,[],[],Aeq,beq,lb,ub,opts);
    
    x_tsp = logical(round(x_tsp));
    %Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2),[],numnodes(G));
    Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2)); % Also works in most cases
    
    
%     if (-1)^M == -1
%         %M is odd so we need to add virtual edge, assuming Mannathan Distances
%         [sOut,tOut] = findedge(Gsol);
%         GsolEdges = [sOut,tOut];
%         
%         for ii = 1:length(GsolEdges)
%             if findedge(Gtsp, GsolEdges(ii,1), GsolEdges(ii,2)) == 0
%                 Gtsp = addedge(Gtsp, GsolEdges(ii,1), GsolEdges(ii,2), 200); %weight of the virtual edge is 2
%             end
%         end
%         
%         %hGraph = plot(Gtsp,'XData',stopsLat,'YData',stopsLon, 'NodeFontSize', nfs, 'LineStyle','none');
%         %hGraph = plot(G,'XData',stopsLat,'YData',stopsLon, 'NodeFontSize', nfs);
%         
%     end
    
    %hold on
    %highlight(hGraph,Gsol,'LineStyle','-');
    %title('Solution with Subtours');
    
    %SUBTOUR CONSTRAINTS
    
    tourIdxs = conncomp(Gsol);
    numtours = max(tourIdxs); % number of subtours
    %fprintf('# of subtours: %d\n',numtours);
    
    A = spalloc(0,lendist,0); % Allocate a sparse linear inequality constraint matrix
    b = [];
    
    hold off;
    while numtours > 1 % Repeat until there is just one subtour
        % Add the subtour constraints
        b = [b;zeros(numtours,1)]; % allocate b
        A = [A;spalloc(numtours,lendist,nstops)]; % A guess at how many nonzeros to allocate
        for ii = 1:numtours
            rowIdx = size(A,1) + 1; % Counter for indexing
            subTourIdx = find(tourIdxs == ii); % Extract the current subtour
            %         The next lines find all of the variables associated with the
            %         particular subtour, then add an inequality constraint to prohibit
            %         that subtour and all subtours that use those stops.
            variations = nchoosek(1:length(subTourIdx),2);
            for jj = 1:length(variations)
                whichVar = (sum(idxs==subTourIdx(variations(jj,1)),2)) & ...
                    (sum(idxs==subTourIdx(variations(jj,2)),2));
                A(rowIdx,whichVar) = 1;
            end
            b(rowIdx) = length(subTourIdx) - 1; % One less trip than subtour stops
        end
        
        % Try to optimize again
        [x_tsp,costopt,exitflag,output] = intlinprog(dist,intcon,A,b,Aeq,beq,lb,ub,opts);
        x_tsp = logical(round(x_tsp));
        Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2),[],numnodes(Gtsp));
        % Gsol = graph(idxs(x_tsp,1),idxs(x_tsp,2)); % Also works in most cases
        
        %======
        [sOut,tOut] = findedge(Gsol);
        GsolEdges = [sOut,tOut];
        ff = 0;
        for ii = 1:length(GsolEdges)
            if findedge(Gtsp, GsolEdges(ii,1), GsolEdges(ii,2)) == 0
                Gtsp = addedge(Gtsp, GsolEdges(ii,1), GsolEdges(ii,2), 200); %weight of the virtual edge is 2
                ff = 1;
            end
        end
        if ff==1
            
            %hGraph = plot(Gtsp,'XData',stopsLat,'YData',stopsLon, 'NodeFontSize', nfs,'LineStyle','none');
            ff = 0;
        end
        
        % Visualize result
        % Remove the previous highlighted path
       % highlight(hGraph,Gsol,'LineStyle','-')
        drawnow
        
        % How many subtours this time?
        tourIdxs = conncomp(Gsol);
        numtours = max(tourIdxs); % number of subtours
        %fprintf('# of subtours: %d\n',numtours)
    end
    
    %title('Solution with Subtours Eliminated');
    %hold off
    
    %==========================00
    %EXTRACT PATH
    tsp_path = dfsearch(Gsol,startpos)';
end