function [ dist ] = computeDistance( trk1, trk2 )
    % Rayon de la terre en mètres
    R=6378137;
    
    dist = real(R*acos(cos(deg2rad(trk1.Latitude))*cos(deg2rad(trk2.Latitude))*cos(deg2rad(trk1.Longitude)-deg2rad(trk2.Longitude))+sin(deg2rad(trk1.Latitude))*sin(deg2rad(trk2.Latitude))));

end

