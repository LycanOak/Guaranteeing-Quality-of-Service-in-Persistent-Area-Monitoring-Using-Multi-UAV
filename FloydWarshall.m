%Floyd-Warshall
% let dist be a |V| × |V| array of minimum distances initialized to ∞ (infinity)
% for each edge (u, v) do
%     dist[u][v] ← w(u, v)  // The weight of the edge (u, v)
% for each vertex v do
%     dist[v][v] ← 0
% for k from 1 to |V|
%     for i from 1 to |V|
%         for j from 1 to |V|
%             if dist[i][j] > dist[i][k] + dist[k][j]
%                 dist[i][j] ← dist[i][k] + dist[k][j]
%             end if
function dist = FloydWarshall(Gs, gg)
    dist = 999*ones(size(Gs(gg).Graph.Nodes,1));
    
    for edg = 1:size(Gs(gg).Graph.Edges,1)
        u = Gs(gg).Graph.Edges.EndNodes(edg,1);
        v = Gs(gg).Graph.Edges.EndNodes(edg,2);
        dist(u,v) = Gs(gg).Graph.Edges.Weight(edg);
        dist(v,u) = Gs(gg).Graph.Edges.Weight(edg);
    end
    for vrt = 1:size(Gs(gg).Graph.Nodes,1)
        dist(vrt,vrt) = 0;
    end
    for k = 1:size(Gs(gg).Graph.Nodes,1)
        for i = 1:size(Gs(gg).Graph.Nodes,1)
            for j = 1:size(Gs(gg).Graph.Nodes,1)
                if dist(i,j) > dist(i,k) + dist(k,j)
                    dist(i,j) = dist(i,k) + dist(k,j);
                    dist(j,i) = dist(i,k) + dist(k,j);
                end
            end
        end
    end
end
