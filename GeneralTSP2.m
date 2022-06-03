function tsp_path = GeneralTSP2(G, stopsLat, stopsLon, M, Nobstacles, obsIDs, startpos)
    if(M>10)
        %divide and conquer
        [Gsect1,slat1, slon1,secObs] = RemoveSections2(G,1, M, stopsLat, stopsLon, obsIDs);
        startpos1 = (ceil(M/2))^2;
        while ~isempty(find(secObs == startpos1, 1))
            startpos1 = startpos1 - 1; %not the best
        end
        %startpos1 = M*(ceil(M/2)-1)+ceil(M/2);
        tsp_path1 = GenerateTSP(Gsect1, slat1, slon1, M, Nobstacles, secObs, startpos1, numnodes(Gsect1)-length(secObs));
        %add the obsids
        for oo = secObs
            fobs = find(tsp_path1 >= oo);
            for fo = fobs
                tsp_path1(fo) = tsp_path1(fo) + 1;
            end
        end
        %correct tsp_path
        tsp_path1 = transform.Path1(tsp_path1, M, ceil(M/2), ceil(M/2));
        
        [Gsect2,slat2, slon2,secObs] = RemoveSections2(G,2, M, stopsLat, stopsLon, obsIDs);
        startpos2 = (M-ceil(M/2))*(ceil(M/2)-1)+1;
        while ~isempty(find(secObs == startpos2, 1))
            startpos2 = startpos2 - 1; %not the best
        end
        %startpos2 = M*(ceil(M/2)-1)+ceil(M/2)+1;
        tsp_path2 = GenerateTSP(Gsect2, slat2, slon2, M, Nobstacles, secObs, startpos2,numnodes(Gsect2)-length(secObs));
        %add the obsids
        for oo = secObs
            fobs = find(tsp_path2 >= oo);
            for fo = fobs
                tsp_path2(fo) = tsp_path2(fo) + 1;
            end
        end
        %correct tsp_path
        tsp_path2 = transform.Path2(tsp_path2, M, (M-ceil(M/2)), ceil(M/2));
        
        [Gsect3,slat3, slon3,secObs] = RemoveSections2(G,3, M, stopsLat, stopsLon, obsIDs);
        startpos3 = ceil(M/2);
        while ~isempty(find(secObs == startpos3, 1))
            startpos3 = startpos3 + 1; %not the best
        end
        %startpos3 = M*(ceil(M/2))+ceil(M/2);
        tsp_path3 = GenerateTSP(Gsect3, slat3, slon3, M, Nobstacles, secObs, startpos3, numnodes(Gsect3)-length(secObs));
        %add the obsids
        for oo = secObs
            fobs = find(tsp_path3 >= oo);
            for fo = fobs
                tsp_path3(fo) = tsp_path3(fo) + 1;
            end
        end
        tsp_path3 = transform.Path3(tsp_path3, M, (ceil(M/2)), (M-ceil(M/2)));
        
        [Gsect4,slat4, slon4,secObs] = RemoveSections2(G,4, M, stopsLat, stopsLon, obsIDs);
        startpos4 = 1;
        while ~isempty(find(secObs == startpos4, 1))
            startpos4 = startpos4 + 1; %not the best
        end
        %startpos4 = M*(ceil(M/2))+ceil(M/2)+1;
        tsp_path4 = GenerateTSP(Gsect4, slat4, slon4, M, Nobstacles, secObs, startpos4, numnodes(Gsect4)-length(secObs));
        %add the obsids
        for oo = secObs
            fobs = find(tsp_path4 >= oo);
            for fo = fobs
                tsp_path4(fo) = tsp_path4(fo) + 1;
            end
        end
        tsp_path4 = transform.Path4(tsp_path4, M, (M-ceil(M/2)), (M-ceil(M/2)));
        
        tsp_path = [tsp_path1,tsp_path3, tsp_path4, tsp_path2];
        
        
    else
       tsp_path = GenerateTSP(G, stopsLat, stopsLon, M, Nobstacles, obsIDs, startpos, M^2-Nobstacles);
    end
end