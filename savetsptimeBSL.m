function savetsptimeBSL(et,size, p_base)
    fileID = fopen(['missionM_bsl',num2str(size)], 'a+');
    fprintf(fileID, 'BSL obtained in = %f\r\n', et);
    for i = p_base
        fprintf(fileID, ' %d', i);
    end
    fprintf(fileID, '\n');
    fclose(fileID); % Close file.
end