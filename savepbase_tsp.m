function savepbase_tsp(size, p_base)
    fileID = fopen(['missionM',num2str(size),'_tsp_pbase'], 'a+');
    for i = p_base
        fprintf(fileID, ' %d', i);
    end
    fprintf(fileID, '\n');
    fclose(fileID); % Close file.
    
end