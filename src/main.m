close all; 
clc;

trk = gpxread('../data/draftrunwithD', 'FeatureType', 'track');

% Classement des points
dist=0;
cpt_portion = 1;
portion = struct;

for i=2:size(trk,1)
    
    %dist = dist+computeDistance(trk(i),trk(i-1));
    
    % Compute elevation between the curent point and the previous point
    elevation_crt = trk(i).Elevation-trk(i-1).Elevation;
    
    % Compute distance
    portion(cpt_portion).Distance = computeDistance(trk(i),trk(i-1));
    
    % Compute elevation
    portion(cpt_portion).Elevation = elevation_crt;
    
    % Compute duration
    % CORRIGER LA BONNE DUREE
    portion(cpt_portion).Duration = 3;
    
    % Compute average speed
    portion(cpt_portion).Speed = 3.6 * portion(cpt_portion).Distance/portion(cpt_portion).Duration;
    
    % Compute class
    if elevation_crt < 0
        portion(cpt_portion).Class = -1;  
    elseif elevation_crt > 0
        portion(cpt_portion).Class = 1;
    else
        portion(cpt_portion).Class = 0;
    end
    
    cpt_portion = cpt_portion+1;
end

% Find all the portions when the runner climbs
T = find([portion.Class] == 1);

displayElevation(trk);