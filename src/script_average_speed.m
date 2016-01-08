close all; 
clc;

Nom_coureur = 'Forichon';
Prenom_coureur = 'Matthieu';

trk1 = gpxread('../data/courses_Matthieu/activity_590163985', 'FeatureType', 'track');
trk2 = gpxread('../data/courses_Matthieu/activity_484048403', 'FeatureType', 'track');
trk3 = gpxread('../data/courses_Matthieu/activity_448562890', 'FeatureType', 'track');
trk4 = gpxread('../data/courses_Matthieu/activity_470911138', 'FeatureType', 'track');

load('coureur_struct.mat');

[Coureur] = main(Coureur, Nom_coureur, Prenom_coureur, trk1);

save('coureur_struct.mat', 'Coureur');