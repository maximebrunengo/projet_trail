function [ trk ] = checkTrk( trk )
    
    for i=2:size(trk,1)
        if isempty(trk(i).Time)
            trk(i) = trk(i-1);        
        end
    end
    
    if isnan(trk(1).Elevation)
        trk(1).Elevation = trk(2).Elevation;
    end
    for i=2:size(trk,1)
        if isnan(trk(i).Elevation)
            trk(i).Elevation = trk(i-1).Elevation;
        end
    end
    
    % Check if trk.Latitude is nan or not 
    if isnan(trk(1).Latitude)
        trk(1) = trk(2);
    end
    for i=2:size(trk,1)
        if isnan(trk(i).Latitude)
            trk(i) = trk(i-1);
        end
    end

end

