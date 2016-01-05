close all;
clear all;
clc;

% Variable du coureur qu'il faudra appeler au lieu de les définir
v_M = 10.2905;
v_D = 11.3499;
v_P = 10.8734;

v_base = 10;

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Estimation d'une course %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Récupération du gpx
trk = gpxread('../data/tracetrail', 'FeatureType', 'track');

% Check if trk.Elevation is nan or not   
for i=2:size(trk,1)
    if isnan(trk(i).Elevation)
        trk(i).Elevation = trk(i-1).Elevation;
    end
end

trk(1).DistanceFromBeginning = 0;
for i=2:size(trk,1)
    distanceToAdd = computeDistance(trk(i),trk(i-1));
    trk(i).DistanceFromBeginning = trk(i-1).DistanceFromBeginning + distanceToAdd;
end
    
% Affichage du tracé
displayElevationFromDistance(trk);

% Estimation du temps total
portion = struct;

timeFromBeginning = 0;
cpt_portion = 1;
for i=2:size(trk,1)
    % Compute elevation between the curent point and the previous point
    elevation_crt = trk(i).Elevation-trk(i-1).Elevation;

    % Compute distance
    portion(cpt_portion).Distance = computeDistance(trk(i),trk(i-1));

    % Compute slope
    portion(cpt_portion).Slope = 100*asin(elevation_crt/portion(cpt_portion).Distance);
    
    % Compute class and average speed
    if elevation_crt < 0
        portion(cpt_portion).Class = -1;
        portion(cpt_portion).AverageSpeed = v_D;
    elseif elevation_crt > 0
        portion(cpt_portion).Class = 1;
        portion(cpt_portion).AverageSpeed = v_M;
    else
        portion(cpt_portion).Class = 0;
        portion(cpt_portion).AverageSpeed = v_P;
    end
    
    % Compute time needed to do the portion
    portion(cpt_portion).TimeNeeded = 3.6*portion(cpt_portion).Distance/portion(cpt_portion).AverageSpeed;
    
    timeFromBeginning = timeFromBeginning + portion(cpt_portion).TimeNeeded;
    timeEstimate = datestr(timeFromBeginning/86400, 'HH:MM:SS');

    cpt_portion = cpt_portion+1;
end

firstEstimation = 3.6*trk(size(trk,1)).DistanceFromBeginning/v_base;
firstEstimation = datestr(firstEstimation/86400, 'HH:MM:SS');

disp(['L''estimation avec une vitesse de 10km/h est : ', num2str(firstEstimation), '.']);
disp(['L''estimation de BG que l''on fait est : ', num2str(timeEstimate), '.']);


