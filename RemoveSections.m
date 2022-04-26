function [Gsect,SLAT, SLON, secObs] = RemoveSections(G,sect2keep, M, stopsLat, stopsLon, obsIDS)
    %AOI sections: 
    % |3|4|
    % |1|2|
    keep = [];
    k = 1;
    switch sect2keep
        case 1
            %remove 2
            %remove 3
            %remove 4
            secObs = [];
            for l = 1:M
                for c = 1:M
                    if ( 1<=c && c<=ceil(M/2))&&(1<=l && l<=ceil(M/2))
                        keep = [keep;k];
                        if ~isempty(find(obsIDS == k,1))
                            secObs = [secObs, k];
                        end
                    end
                    
                    k = k + 1;
                end
            end
        case 2
            %remove 1
            %remove 3
            %remove 4
            secObs = [];
            for l = 1:M
                for c = 1:M
                        if ( ceil(M/2)<c && c<=M)&&(1<=l && l<=ceil(M/2))
                            keep = [keep;k];
                            if ~isempty(find(obsIDS == k,1))
                                secObs = [secObs, k];
                            end
                        end
                    k = k + 1;
                end
            end     
        case 3
            %remove 1
            %remove 2
            %remove 4
            secObs = [];
            for l = 1:M
                for c = 1:M
                    
                    if ( 1<=c && c<=ceil(M/2))&&(ceil(M/2)<l && l<=M)
                        keep = [keep;k];
                        if ~isempty(find(obsIDS == k,1))
                            secObs = [secObs, k];
                        end
                    end
                    
                    
                    k = k + 1;
                end
            end
            
        otherwise
            %remove 1
            %remove 2
            %remove 3
            secObs = [];
            for l = 1:M
                for c = 1:M
                    if ( ceil(M/2)<c && c<=M)&&(ceil(M/2)<l && l<=M)
                        keep = [keep;k];
                        if ~isempty(find(obsIDS == k,1))
                            secObs = [secObs, k];
                        end
                    end
                    
                    
                    k = k + 1;
                end
            end
    end
    
    [Gsect,SLAT,SLON, secObs] = Remove(G,M,stopsLat,stopsLon, keep, secObs);
end

function [GSect,SLA,SLO,newobs] = Remove(G,M,stopsLat,stopsLon, keep, obsIDs)
    oldobs = obsIDs;
    rcnt = 0;
    k = 1;
    Gsect = G;
    for l = 1:M
        for c = 1:M
            if isempty(find(keep==k,1))
                Gsect = rmnode(Gsect, k-rcnt);
                for ii = 1:length(oldobs)
                    if oldobs(ii) >= k-rcnt
                        oldobs(ii) = oldobs(ii) - 1;
                    end
                end
                stopsLat = [stopsLat(1:(k-rcnt-1)), stopsLat((k-rcnt+1):end)];
                stopsLon = [stopsLon(1:(k-rcnt-1)), stopsLon((k-rcnt+1):end)];
                rcnt = rcnt + 1;             
                
            end
            k = k + 1;
        end
    end
    newobs = oldobs;
    GSect = Gsect;
    SLO = stopsLon;
    SLA = stopsLat;
    
end
