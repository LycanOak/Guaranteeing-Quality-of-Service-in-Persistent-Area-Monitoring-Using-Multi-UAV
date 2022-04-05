%=========================================================
% Creates paths for the drones other than the first one
%
% In: 
%   Ndrones - number of drones
%   p - base path
%
% Out:
%   paths - matrix with all the paths
%=========================================================
function paths = multidronep(Ndrones, p)

    lenPath = length(p(1,:));
    step = floor(lenPath/Ndrones);
    
    aux = zeros(1,step);
    allpaths = p;
    
    for ii = 1:Ndrones-1
            aux = allpaths(ii,1:step);
            aux2 =  allpaths(ii,step+1:end);
            aux2 = [aux2,aux];
            allpaths = [allpaths;aux2];
    end
    
    paths = allpaths;
end