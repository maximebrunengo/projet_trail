clear all;
clc;

trk1 = gpxread('../data/Forichon_Matthieu/activity_978782609', 'FeatureType', 'track');
trk2 = gpxread('../data/Forichon_Matthieu/activity_982783698', 'FeatureType', 'track');
trk3 = gpxread('../data/Forichon_Matthieu/activity_986267821', 'FeatureType', 'track');
trk4 = gpxread('../data/Forichon_Matthieu/activity_1002388846', 'FeatureType', 'track');
trk5 = gpxread('../data/Forichon_Matthieu/activity_478883567', 'FeatureType', 'track');
trk6 = gpxread('../data/Forichon_Matthieu/activity_580201703', 'FeatureType', 'track');
trk7 = gpxread('../data/Forichon_Matthieu/activity_448562890', 'FeatureType', 'track');
trk8 = gpxread('../data/Forichon_Matthieu/activity_470911138', 'FeatureType', 'track');
trk9 = gpxread('../data/Forichon_Matthieu/activity_484048403', 'FeatureType', 'track');
trk10 = gpxread('../data/Forichon_Matthieu/activity_590163985', 'FeatureType', 'track');
trk11 = gpxread('../data/Forichon_Matthieu/activity_949714253', 'FeatureType', 'track');
trk12 = gpxread('../data/Forichon_Matthieu/activity_970465803', 'FeatureType', 'track');
trk13 = gpxread('../data/Forichon_Matthieu/activity_982783734', 'FeatureType', 'track');
trk14 = gpxread('../data/Forichon_Matthieu/activity_986267849', 'FeatureType', 'track');
trk15 = gpxread('../data/Forichon_Matthieu/trailardechois57k', 'FeatureType', 'track');
trk16 = gpxread('../data/Forichon_Matthieu/trailstetiennelyon70k', 'FeatureType', 'track');

for i=1:17
    distance = 0;
    name = eval(['trk',num2str(i)]);
    load('coureur_struct.mat');
    [trk] = checkTrk(name);
    
    % Compute the duration in sec
    [ duration ] = computeDuration( trk );
    
    for j=2:size(trk,1)
        distance = distance + computeDistance(trk(j), trk(j-1));
    end
    
    M(1,i) = 3.6*distance/duration;
    M(2,i) = distance;
    
end

figure,
plot(M(1,:), M(2,:), '*');

