%==========================================================================
%   Function that generates the obstacles for all AoIs
% In:
%   Gs - struct with info on AoIs
%
% Out:
%   Gs - struct with info on AoIs and Obstacles
%==========================================================================
function Gs = GetAoIObstacles(Gs)
    to = 0; %transfer obstacles
    for i = 1:length(Gs)
        
        if i == 1 %obstacles in the smallest AoI
            ansObs = questdlg('Are there Obstacles in the AoI?', ...
                ['Obstacles M =',num2str(Gs(i).M)], ...
                'Yes','No','No');
            switch ansObs
                case 'Yes'
                    
                    ansSel = questdlg('How do you want to select the Obstacles?', ...
                        ['Obstacles M =',num2str(Gs(i).M)], ...
                        'Define in script','Select one by one','Select one by one');
                    switch ansSel
                        case 'Define in script'
                            ansrandObs = questdlg('Do you want random obstacles?', ...
                                ['Obstacles M =',num2str(Gs(i).M)], ...
                                'Yes','No','Yes');
                            switch ansrandObs
                                case 'Yes'
                                    k = randi(floor(0.3*Gs(i).M^2));
                                    obsIDs = randperm(Gs(i).M^2,k);
                                case 'No'
                                    obsIDs = [4, 9, 14];
                                    
                                    for oo = obsIDs
                                        nn = neighbors(Gs(i).Graph,oo);
                                        for ee = nn
                                            Gs(i).Graph = rmedge(Gs(i).Graph,oo,ee);
                                        end
                                    end
                            end
                        case 'Select one by one'
                            prompt = {'Enter number of obstacles:'};
                            dlgtitle = ['Obstacle Selection AoI M =',num2str(Gs(i).M)];
                            dims = [1 35];
                            definput = {'1'};
                            answer = inputdlg(prompt,dlgtitle,dims,definput);
                            
                            Nobstacles = str2num(answer{1});
                            
                            if Nobstacles ~= 0 % there are obstacles
                                
                                obsIDs = zeros(1, Nobstacles);
                                for oo = 1:Nobstacles
                                    prompt = {'Enter obstacle position [ID of the cell]:'};
                                    dlgtitle = ['Obstacle Selection AoI M =',num2str(Gs(i).M)];
                                    dims = [1 35];
                                    definput = {'16'};
                                    answer = inputdlg(prompt,dlgtitle,dims,definput);
                                    
                                    obsIDs(oo) = str2num(answer{1});
                                    
                                end
                                
                                for oo = obsIDs
                                    nn = neighbors(Gs(i).Graph,oo);
                                    for ee = nn
                                        Gs(i).Graph = rmedge(Gs(i).Graph,oo,ee);
                                    end
                                    
                                end
                            end
                    end
                    
                case 'No'
                    obsIDs = [];
            end
            Gs(i).ObsIDs = sort(obsIDs);
        end
        
        
        if i == 2 && ~isempty(Gs(1).ObsIDs) %distinguish on the relation of the AoIs
            ansTransf = questdlg('Do you want to transfer the obstacles?', ...
                ['Obstacle Selection AoI M =',num2str(Gs(i).M)], ...
                'Yes','No','No');
            switch ansTransf
                case 'Yes'
                    to = 1;
            end
        end
        if i~= 1
            if i > 1 && to == 1
                Gs(i).ObsIDs = RecalibrateCells(Gs(1), Gs(i), Gs(1).ObsIDs);
            else
                ansObs = questdlg('Are there Obstacles in the AoI?', ...
                    ['Obstacle Selection AoI M =',num2str(Gs(i).M)], ...
                    'Yes','No','No');
                switch ansObs
                    case 'Yes'
                        ansSel = questdlg('How do you want to select the Obstacles?', ...
                            ['Obstacles M =',num2str(Gs(i).M)], ...
                            'Random','Select one by one','Select one by one');
                        switch ansSel
                            case 'Define in script'
                                ansrandObs = questdlg('Do you want random obstacles?', ...
                                    ['Obstacles M =',num2str(Gs(i).M)], ...
                                    'Yes','No','Yes');
                                switch ansrandObs
                                    case 'Yes'
                                        
                                        k =  randperm(floor(0.15*(Gs(i).M^2)));
                                        obsIDs = randperm(n,k);
                                    case 'No'
                                        obsIDs = [4, 9, 14];
                                        
                                        for oo = obsIDs
                                            nn = neighbors(Gs(i).Graph,oo);
                                            for ee = nn
                                                Gs(i).Graph = rmedge(Gs(i).Graph,oo,ee);
                                            end
                                        end
                                end
                            case 'Select one by one'
                                prompt = {'Enter number of obstacles:'};
                                dlgtitle = ['Obstacle Selection AoI M =',num2str(Gs(i).M)];
                                dims = [1 35];
                                definput = {'1'};
                                answer = inputdlg(prompt,dlgtitle,dims,definput);
                                
                                Nobstacles = str2num(answer{1});
                                
                                if Nobstacles ~= 0 % there are obstacles
                                    
                                    obsIDs = zeros(1, Nobstacles);
                                    for oo = 1:Nobstacles
                                        prompt = {'Enter obstacle position [ID of the cell]:'};
                                        dlgtitle = ['Obstacle Selection AoI M =',num2str(Gs(i).M)];
                                        dims = [1 35];
                                        definput = {'16'};
                                        answer = inputdlg(prompt,dlgtitle,dims,definput);
                                        
                                        obsIDs(oo) = str2num(answer{1});
                                        
                                    end
                                    
                                    for oo = obsIDs
                                        nn = neighbors(Gs(i).Graph,oo);
                                        for ee = nn
                                            Gs(i).Graph = rmedge(Gs(i).Graph,oo,ee);
                                        end
                                        
                                    end
                                end
                        end
                        
                    case 'No'
                        obsIDs = [];
                end
                
                Gs(i).ObsIDs = sort(obsIDs);
            end
        end
    end
end
