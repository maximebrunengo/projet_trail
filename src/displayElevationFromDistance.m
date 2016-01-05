function [  ] = displayElevationFromDistance( trk )
        
    figure
    minEle = min(trk.Elevation);
    trk.Elevation = trk.Elevation-minEle;
    area(trk.DistanceFromBeginning, trk.Elevation)
    ylabel('elevation (meters)')
    xlabel('distance from beginning (meters)')
    title({'Elevation Area Plot'});


end

