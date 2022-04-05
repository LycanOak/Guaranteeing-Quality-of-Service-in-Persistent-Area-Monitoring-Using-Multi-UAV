%==========================================================================
%   Function that generates special cells for all AoIs
% In:
%   Gs - struct with info on AoIs
%
% Out:
%   Gs - struct with info on AoIs and Special Cells
%==========================================================================
function Gs = GetAoISpecialCells(Gs)
    tsc = 0;
    for i = 1:length(Gs)
        if i == 1 % special cells in the smallest AoI
            SpecYN = questdlg('Are there Special Cells?', ...
                ['Special M = ',num2str(Gs(i).M)], ...
                'Yes','No','No');
            switch SpecYN
                case 'Yes'
                    
                    ans2 = questdlg('How do you want to select the Special Cells?', ...
                        ['Spec M =',num2str(Gs(i).M)], ...
                        'Define in script','Select one by one','Select one by one');
                    switch ans2
                        case 'Define in script'
                            ansrandspec = questdlg('Do you want random special cells?', ...
                                ['Obstacles M =',num2str(Gs(i).M)], ...
                                'Yes','No','Yes');
                            switch ansrandspec
                                case 'Yes'
                                    k = randi(floor(0.49*Gs(i).M^2));
                                    specIDs = randperm(Gs(i).M^2,k);
                                    while ~isempty(intersect(specIDs,Gs(i).ObsIDs))
                                        k = randi(floor(0.49*Gs(i).M^2));
                                        specIDs = randperm(Gs(i).M^2,k);
                                    end
                                    
                                case 'No'
                                    specIDs = [2, 15, 9];
                                    for ss = specIDs
                                        Gs(i).Deadlines(specIDs(ss)) = Gs(i).DefaultDeadline/2;
                                    end
                                    
                            end
                        case 'Select one by one'
                            prompt = {'Enter number of special cells:'};
                            dlgtitle = ['Special M = ',num2str(Gs(i).M)];
                            dims = [1 35];
                            definput = {'1'};
                            answer = inputdlg(prompt,dlgtitle,dims,definput);
                            
                            NspecialC = str2num(answer{1});
                            
                            
                            specIDs = zeros(1, NspecialC);
                            
                            for oo = 1:NspecialC
                                prompt = {'Enter special Cells [ID of the cell]:'};
                                dlgtitle = ['Special M = ',num2str(Gs(i).M)];
                                dims = [1 35];
                                definput = {'13'};
                                answer = inputdlg(prompt,dlgtitle,dims,definput);
                                
                                specIDs(oo) = str2num(answer{1});
                                
                            end
                            specIDs = sort(specIDs);
                            for oo = 1:NspecialC
                                prompt = {['Enter Deadline for cell ',num2str(specIDs(oo))]};
                                dlgtitle = ['Special M = ',num2str(Gs(i).M)];
                                dims = [1 35];
                                definput = {num2str((Gs(i).DefaultDeadline)/2)};
                                answer = inputdlg(prompt,dlgtitle,dims,definput);
                                Gs(i).Deadlines(specIDs(oo)) = str2num(answer{1});
                                
                            end
                    end
                    
                    
                    
                case 'No'
                    specIDs = [];
                    
            end
            Gs(i).SpecIDs = specIDs;
        end
        
        % TO DO  - adapt below
        if i == 2 && ~isempty(Gs(1).SpecIDs) %distinguish on the relation of the AoIs
            answer = questdlg('Do you want to transfer special cells?', ...
                ['Special M = ',num2str(Gs(i).M)], ...
                'Yes','No','No');
            switch answer
                case 'Yes'
                    tsc = 1;
            end
        end
        if i > 1
            if tsc == 1
                Gs(i).SpecIDs = RecalibrateCells(Gs(1), Gs(i), Gs(1).SpecIDs);
                
                for ss = 1:length(Gs(i).SpecIDs)
                    prompt = {['Enter Deadline for cell ',num2str(Gs(i).SpecIDs(ss))]};
                    dlgtitle = ['Special M = ',num2str(Gs(i).M)];
                    dims = [1 35];
                    definput = {num2str((Gs(i).DefaultDeadline)/2)};
                    answer = inputdlg(prompt,dlgtitle,dims,definput);
                    Gs(i).Deadlines(Gs(i).SpecIDs(ss)) = str2num(answer{1});
                end
            else
                answer = questdlg('Are there Special Cells?', ...
                    ['Special M = ',num2str(Gs(i).M)], ...
                    'Yes','No','No');
                switch answer
                    case 'Yes'
                        
                        prompt = {'Enter number of special cells:'};
                        dlgtitle = ['Special M = ',num2str(Gs(i).M)];
                        dims = [1 35];
                        definput = {'1'};
                        answer = inputdlg(prompt,dlgtitle,dims,definput);
                        
                        NspecialC = str2num(answer{1});
                        
                        
                        specIDs = zeros(1, NspecialC);
                        
                        for oo = 1:NspecialC
                            prompt = {'Enter special Cells [ID of the cell]:'};
                            dlgtitle = ['Special M = ',num2str(Gs(i).M)];
                            dims = [1 35];
                            definput = {'13'};
                            answer = inputdlg(prompt,dlgtitle,dims,definput);
                            
                            specIDs(oo) = str2num(answer{1});
                            
                        end
                        specIDs = sort(specIDs);
                        for oo = 1:NspecialC
                            prompt = {['Enter Deadline for cell ',num2str(specIDs(oo))]};
                            dlgtitle = ['Special M = ',num2str(Gs(i).M)];
                            dims = [1 35];
                            definput = {num2str((Gs(i).DefaultDeadline)/2)};
                            answer = inputdlg(prompt,dlgtitle,dims,definput);
                            Gs(i).Deadlines(specIDs(oo)) = str2num(answer{1});
                        end
                        
                        
                    case 'No'
                        specIDs = [];
                        
                end
                Gs(i).SpecIDs = specIDs;
            end
        end
    end
end