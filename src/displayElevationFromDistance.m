function [  ] = displayElevationFromDistance( trk )
    
    if isnan(trk(1).Elevation)
        trk(1).Elevation = trk(2).Elevation;
    end
    for i=2:size(trk,1)
        if isnan(trk(i).Elevation)
            trk(i).Elevation = trk(i-1).Elevation;
        end
    end
       
    
    for i=2:size(trk,1)
        if isempty(trk(i).Time)
            trk(i) = trk(i-1);        
        end
    end
    
    figure
    minEle = min(trk.Elevation);
    trk.Elevation = trk.Elevation-minEle;
    area(trk.DistanceFromBeginning, trk.Elevation)
    ylabel('elevation (meters)')
    xlabel('distance from beginning (meters)')
    title({'Elevation Area Plot'});


end

