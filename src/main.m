close all; 
clear all;
clc;

trk = gpxread('../data/draftrunwithD', 'FeatureType', 'track');

% Classement des points
dist=0;
cpt_portion = 1;
portion = struct;
cpt_test = 0;
for i=2:size(trk,1)
    
    %dist = dist+computeDistance(trk(i),trk(i-1));
    
    % Compute elevation between the curent point and the previous point
    elevation_crt = trk(i).Elevation-trk(i-1).Elevation;
    
    % Compute distance
    portion(cpt_portion).Distance = computeDistance(trk(i),trk(i-1));
    
    % Compute elevation
    portion(cpt_portion).Slope = 100*asin(elevation_crt/portion(cpt_portion).Distance);
    
    % Compute duration
    timeStr_crt = strrep(trk(i).Time, 'T', ' ');
    timeStr_crt = strrep(timeStr_crt, 'Z', '');
    timeStr_prev = strrep(trk(i-1).Time, 'T', ' ');
    timeStr_prev = strrep(timeStr_prev, 'Z', '');
    trk(i).DateNumber = datenum(timeStr_crt, 31);
    trk(i-1).DateNumber = datenum(timeStr_prev, 31);
    portion(cpt_portion).Duration = etime(datevec(trk(i).DateNumber), datevec(trk(i-1).DateNumber));
    
    % Compute average speed
    portion(cpt_portion).Speed = 3.6 * portion(cpt_portion).Distance/portion(cpt_portion).Duration;
    cpt_test = cpt_test + portion(cpt_portion).Speed;
    
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
M = find([portion.Class] == 1);
D = find([portion.Class] == -1);
P = find([portion.Class] == 0);

% Compute average speed in climbs, descents and flats
v_M = 0;
for i=1:size(M,2)
    cpt = M(1,i);
    v_M = v_M + (portion(cpt).Speed)/size(M,2);
end

v_D = 0;
for i=1:size(D,2)
    cpt = D(1,i);
    v_D = v_D + (portion(cpt).Speed)/size(D,2);
end

v_P = 0;
for i=1:size(P,2)
    cpt = P(1,i);
    v_P = v_P + (portion(cpt).Speed)/size(P,2);
end

% Display
disp('Affichage de la vitesse moyenne du coureur en fonction du profil du terrain');

disp(['La vitesse moyenne en montée est ', num2str(v_M), 'km/h']);
disp(['La vitesse moyenne en descente est ', num2str(v_D), 'km/h']);
disp(['La vitesse moyenne sur plat est ', num2str(v_P), 'km/h']);


displayElevation(trk);
