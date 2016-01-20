close all;
clear all;
clc;

% Identité du coureur
Nom_coureur = 'Forichon';
Prenom_coureur = 'Matthieu';

% Course à estimer
trk1 = gpxread('../data/Forichon_Matthieu/activity_448562890', 'FeatureType', 'track');
trk2 = gpxread('../data/Forichon_Matthieu/activity_470911138', 'FeatureType', 'track');
trk3 = gpxread('../data/Forichon_Matthieu/activity_478883567', 'FeatureType', 'track');
trk4 = gpxread('../data/Forichon_Matthieu/activity_484048403', 'FeatureType', 'track');
trk5 = gpxread('../data/Forichon_Matthieu/activity_580201703', 'FeatureType', 'track');
trk6 = gpxread('../data/Forichon_Matthieu/activity_590163985', 'FeatureType', 'track');
trk7 = gpxread('../data/Forichon_Matthieu/activity_970465803', 'FeatureType', 'track');
trk8 = gpxread('../data/Forichon_Matthieu/activity_978782609', 'FeatureType', 'track');
trk9 = gpxread('../data/Forichon_Matthieu/activity_982783698', 'FeatureType', 'track');
trk10 = gpxread('../data/Forichon_Matthieu/activity_982783734', 'FeatureType', 'track');
trk11 = gpxread('../data/Forichon_Matthieu/activity_986267821', 'FeatureType', 'track');
trk12 = gpxread('../data/Forichon_Matthieu/activity_986267849', 'FeatureType', 'track');
trk13 = gpxread('../data/Forichon_Matthieu/activity_1002388846', 'FeatureType', 'track');
trk14 = gpxread('../data/Forichon_Matthieu/trailardechois57k', 'FeatureType', 'track');
trk15 = gpxread('../data/Forichon_Matthieu/trailstetiennelyon70k', 'FeatureType', 'track');

for i=1:15
    name = eval(['trk',num2str(i)]);
    
    [trk] = checkTrk(name);
    [timeFromBeginning] = estimation( Nom_coureur, trk );
    
    % Comparaison entre l'estimation et le temps réel.
    [duration] = computeDuration(trk);
    
    M(1,i) = timeFromBeginning;
    M(2,i) = duration;
    precision(1,i) = 100*(timeFromBeginning/duration);

    disp(['La précision est de : ', num2str(precision(1,i)), '%.']);
end

figure,
plot(1:15,precision(1,1:15),'*'),
    axis([0 17 0 120]), hold on
plot([0,17],[100 100], 'k-');
    
    
    
