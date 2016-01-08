close all; 
clc;

% Identité du coureur
Nom_coureur = 'Forichon';
Prenom_coureur = 'Matthieu';

% Course à estimer
trk = gpxread('../data/courses_Matthieu/activity_986267849', 'FeatureType', 'track');

estimation( Nom_coureur, trk );

