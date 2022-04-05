classdef HamiltonCycle
    methods(Static)
        function [path, visited] = Hup(p, visited, M)
            
            path = [p, p(end)+M];
            visited(p(end)) = 1;
        end
        
        function [path, visited] = Hright(p, visited)
            path = [p, p(end)+1];
            visited(p(end)) = 1;
        end
        
        function [path, visited] = Hdown(p, visited, M)
            path = [p, p(end)-M];
            visited(p(end)) = 1;
        end
        
        function [path, visited] = Hleft(p, visited)
            path = [p, p(end)-1];
            visited(p(end)) = 1;
        end
        
        function [path, visited] = Hdiag(p, visited, M)
            aux = p(end) - 1;
            path = [p, aux+M];
            visited(p(end)) = 1;
        end
        
        function [path, visited] = GoAround(p, visit, M)
            while p(end)+M < M^2
                [p, visit] = HamiltonCycle.Hup(p, visit,M);
            end
            while p(end)+1 <= M^2
                [p, visit] = HamiltonCycle.Hright(p, visit);
            end
            while p(end) > M
                [p, visit] = HamiltonCycle.Hdown(p, visit, M);
            end
            visited = visit;
            path = p;
        end
        
        function [path, visited] = GoInside(p, visited, M, xdata, ydata)
            
            mm = 0;
            if (-1)^M == 1
                while p(end)-1 ~= 1
                   
                    [p, visited] = HamiltonCycle.Hleft(p, visited);
                    if mm == 1
                        downnode = p(end)-M;
                        
                        while visited(downnode) == 0
                            [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                            downnode = p(end)-M;
                            if  p(end)-M <= 0
                                break;
                            end
                        end
                        
                        mm = 0;
                    else
                        upnode = p(end)+M;                
                        while visited(upnode) == 0
                            [p, visited] = HamiltonCycle.Hup(p, visited, M);
                            upnode = p(end)+M;
                        end
                        mm = 1;
                    end
                    
                end
                
            else
                mm = 0;
                while xdata(p(end)) > 3
                    [p, visited] = HamiltonCycle.Hleft(p, visited);
                    if xdata(p(end)) == 3
                        break;
                    end
                    if mm == 1
                        downnode = p(end)-M;
                        while visited(downnode) == 0
                            [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                            downnode = p(end)-M;
                            if  p(end)-M <= 0
                                break;
                            end
                            
                        end
                        mm = 0;
                    else
                        upnode = p(end)+M; 
                        while visited(upnode) == 0
                            [p, visited] = HamiltonCycle.Hup(p, visited, M);
                            upnode = p(end)+M; 
                        end
                        mm = 1;
                    end
                    
                    
                end
                
                if ydata(p(end)) <= 1
                    [p, visited] = HamiltonCycle.Hdiag(p, visited, M);
                else
                    [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                    [p, visited] = HamiltonCycle.Hdiag(p, visited, M);
                end
                
                if ydata(p(end))-1 > 1
                    [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                    [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                    
                else
                    [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                end
                
                while ydata(p(end)) > 1
                    nodeleft = p(end)+1;
                    if visited(nodeleft) == 0
                        [p, visited] = HamiltonCycle.Hright(p, visited);
                        [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                    else
                        [p, visited] = HamiltonCycle.Hleft(p, visited);
                        [p, visited] = HamiltonCycle.Hdown(p, visited, M);
                    end
                end
                
                while p(end) - 1 ~= 1
                    [p, visited] = HamiltonCycle.Hleft(p, visited);
                end
            end
            
            
            path = p;
        end
        
    end
end

