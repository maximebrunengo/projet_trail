close all; 
clc;

% Identit� du coureur
Nom_coureur = 'Forichon';
Prenom_coureur = 'Matthieu';

% Course � estimer
trk = gpxread('../data/courses_Matthieu/activity_986267849', 'FeatureType', 'track');

estimation( Nom_coureur, trk );

