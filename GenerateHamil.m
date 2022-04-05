function Ham_path = GenerateHamil(stopsLat, stopsLon, M)
   p = 1; %startingpos
   visited = zeros(1,M^2);
   
   [p,visited] = HamiltonCycle.GoAround(p, visited, M);
   
   [p,visited] = HamiltonCycle.GoInside(p, visited, M, stopsLat, stopsLon);
   
   Ham_path = p;
   
end