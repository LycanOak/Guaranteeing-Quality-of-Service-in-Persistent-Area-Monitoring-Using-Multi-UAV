%=========================================================================
% creates graph with MxM nodes. The edges can represent euclidean distances
% In:
%   M - lateral size of the AoI
%
% Out:
%   g - graph
%   xdata - node coordinates in x
%   ydata - node coordinates in y
%=========================================================================
function [g,xdata,ydata] = create_graph(M)
    AOIsize = M^2;
    xdata = zeros(1,M^2);
    ydata = zeros(1,M^2);
    
    g = graph();
    
    mode = 2;
    g = addnode(g, AOIsize);
    node = 1;
    switch mode
        case 1 %mannhatan distances
            for l = 1:M
                for c = 1:M
                    xdata(node) = c;
                    ydata(node) = l;
                    if l ~= M
                        
                        if c ~= M
                            g = addedge(g, node, node+1, 1);
                            g = addedge(g, node, node+M, 1);
                            
                        else
                            g = addedge(g, node, node+M, 1);
                        end
                        
                    else
                        
                        if c ~= M
                            g = addedge(g, node, node+1, 1);
                        end
                    end
                    node = node + 1;
                end
            end
        case 2 %semi-euclidean distances
            for l = 1:M
                for c = 1:M
                    xdata(node) = c;
                    ydata(node) = l;
                    if l ~= M
                        
                        if c ~= M && c ~= 1
                            g = addedge(g, node, node+1, 1);
                            g = addedge(g, node, node+M, 1);
                            
                            g = addedge(g, node, node+M-1, 1.4);
                            g = addedge(g, node, node+M+1, 1.4);
                            
                        elseif c ~= M %c == 1
                            g = addedge(g, node, node+1, 1);
                            g = addedge(g, node, node+M, 1);
                            
                            g = addedge(g, node, node+M+1, 1.4);
                            
                        else % c == M
                            g = addedge(g, node, node+M, 1);
                            
                            g = addedge(g, node, node+M-1, 1.4);
                            
                        end
                        
                    else                   
                        if c ~= M
                            g = addedge(g, node, node+1, 1);
                        end
                    end
                    node = node + 1;
                end
            end
    end
    end