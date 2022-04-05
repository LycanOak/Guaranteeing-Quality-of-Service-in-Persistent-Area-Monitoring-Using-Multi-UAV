classdef transform
    methods(Static)
        function realP = Path1(tsp_path, M, ncols, nlins)
            realP = ones(1,length(tsp_path));
            rp = ones(1,length(tsp_path));
            fp = ones(1,length(tsp_path));
            z = 1;
            x = 0; %real id
            y = 0; %fake id
            for i = 1:nlins % lins
                for j = 1:ncols %cols
                    x = x + 1;
                    y = y + 1;
                    
                    rp(z) = x;
                    fp(z) = y;
                    z = z + 1;
                end
                x = x + (M-ceil(M/2));
            end
            
            for a = 1:length(tsp_path)
                here = find(fp == tsp_path(a),1);
                realP(a) = rp(here);
            end
            
        end
        
        function realP = Path2(tsp_path, M, ncols, nlins)
            realP = ones(1,length(tsp_path));
            rp = ones(1,length(tsp_path));
            fp = ones(1,length(tsp_path));
            z = 1;
            x = ceil(M/2); %real id
            y = 0; %fake id
            for i = 1:nlins % lins
                for j = 1:ncols %cols
                    x = x + 1;
                    y = y + 1;
                    
                    rp(z) = x;
                    fp(z) = y;
                    z = z + 1;
                end
                x = x + ceil(M/2);
            end
            
            for a = 1:length(tsp_path)
                here = find(fp == tsp_path(a),1);
                realP(a) = rp(here);
            end
            
        end
        
        function realP = Path3(tsp_path, M, ncols, nlins)
            realP = ones(1,length(tsp_path));
            rp = ones(1,length(tsp_path));
            fp = ones(1,length(tsp_path));
            z = 1;
            x = ceil(M/2)*M; %real id
            y = 0; %fake id
            for i = 1:nlins % lins
                for j = 1:ncols %cols
                    x = x + 1;
                    y = y + 1;
                    
                    rp(z) = x;
                    fp(z) = y;
                    z = z + 1;
                end
                x = x + (M-ceil(M/2));
            end
            
            for a = 1:length(tsp_path)
                here = find(fp == tsp_path(a),1);
                realP(a) = rp(here);
            end
            
        end
        
        function realP = Path4(tsp_path, M, ncols, nlins)
            realP = ones(1,length(tsp_path));
            rp = ones(1,length(tsp_path));
            fp = ones(1,length(tsp_path));
            z = 1;
            x = ceil(M/2)*M + ceil(M/2); %real id
            y = 0; %fake id
            for i = 1:nlins % lins
                for j = 1:ncols %cols
                    x = x + 1;
                    y = y + 1;
                    
                    rp(z) = x;
                    fp(z) = y;
                    z = z + 1;
                end
                x = x + ceil(M/2);
            end
            
            for a = 1:length(tsp_path)
                here = find(fp == tsp_path(a),1);
                realP(a) = rp(here);
            end
            
        end
    end
end
