function [cell_hist_info] = Overall_info(cell, class, Gs, t_sensing)

   %when there are multiple deadlines, if each cell has its own deadline
   % we have at most M^2 deadlines which is equivelent to plot an histogram
   % for each cell
   % MAYBE cells can be divided into classes according to their deadline
   
   aux.TimeBtwnVisits = [];
   HistINF = repmat(aux,(Gs.M)^2,1);
   for cc = 1:(Gs.M^2)
       if isempty(find(Gs.ObsIDs == cc,1)) && cell(cc).Class == class
           HistINF(cc).TimeBtwnVisits = GetTimeBetweenVisitsCell(cell(cc), t_sensing);   
       end 
   end
   
   cell_hist_info = HistINF;
end