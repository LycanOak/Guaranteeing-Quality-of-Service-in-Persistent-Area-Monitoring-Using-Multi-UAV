nm = 'Works_';
if LoadOrNew()
    filename = LoadPrev();
    load(filename{1});
        for m = 1:length(AoIsizes)
            PlotMap(Gs(m));
        end
else
    
    t_sensing = 20;
    t_fly = 30;
    
    Gs = Allgraphs(AoIsizes, t_sensing, t_fly);
    for m = 1:length(AoIsizes)
        PlotMap(Gs(m));
    end
    nmx = inputdlg({'Name'},...
              'Choose File Name', [1 35]);
    nm = nmx{1};
    FileName = [nm,'.mat'];
    save(FileName);
end


