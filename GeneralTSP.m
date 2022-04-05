function tsp_path = GeneralTSP(G, stopsLat, stopsLon, M, Nobstacles, obsIDs, startpos)
    if(M>10)
        %divide and conquer
        [Gsect1,slat1, slon1] = RemoveSections(G,1, M, stopsLat, stopsLon, obsIDs);
        startpos1 = (ceil(M/2))^2;
        %startpos1 = M*(ceil(M/2)-1)+ceil(M/2);
        tsp_path1 = GenerateTSP(Gsect1, slat1, slon1, M, Nobstacles, obsIDs, startpos1, numnodes(Gsect1));
        %correct tsp_path
        tsp_path1 = transform.Path1(tsp_path1, M, ceil(M/2), ceil(M/2));
        
        [Gsect2,slat2, slon2] = RemoveSections(G,2, M, stopsLat, stopsLon, obsIDs);
        startpos2 = (M-ceil(M/2))*(ceil(M/2)-1)+1;
        %startpos2 = M*(ceil(M/2)-1)+ceil(M/2)+1;
        tsp_path2 = GenerateTSP(Gsect2, slat2, slon2, M, Nobstacles, obsIDs, startpos2,numnodes(Gsect2));
        %correct tsp_path
        tsp_path2 = transform.Path2(tsp_path2, M, (M-ceil(M/2)), ceil(M/2));
        
        [Gsect3,slat3, slon3] = RemoveSections(G,3, M, stopsLat, stopsLon, obsIDs);
        startpos3 = ceil(M/2);
        %startpos3 = M*(ceil(M/2))+ceil(M/2);
        tsp_path3 = GenerateTSP(Gsect3, slat3, slon3, M, Nobstacles, obsIDs, startpos3, numnodes(Gsect3));
        tsp_path3 = transform.Path3(tsp_path3, M, (ceil(M/2)), (M-ceil(M/2)));
        
        [Gsect4,slat4, slon4] = RemoveSections(G,4, M, stopsLat, stopsLon, obsIDs);
        startpos4 = 1;
        %startpos4 = M*(ceil(M/2))+ceil(M/2)+1;
        tsp_path4 = GenerateTSP(Gsect4, slat4, slon4, M, Nobstacles, obsIDs, startpos4, numnodes(Gsect4));
        tsp_path4 = transform.Path4(tsp_path4, M, (M-ceil(M/2)), (M-ceil(M/2)));
        
        tsp_path = [tsp_path1,tsp_path3, tsp_path4, tsp_path2];
        
        
    else
       tsp_path = GenerateTSP(G, stopsLat, stopsLon, M, Nobstacles, obsIDs, startpos, M^2-Nobstacles);
    end
end