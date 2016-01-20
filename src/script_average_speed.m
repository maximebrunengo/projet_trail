close all; 
clear all;
clc;

Nom_coureur = 'testffds';
Prenom_coureur = 'fdfdsfd';

trk = gpxread('../data/Forichon_Matthieu/activity_978782609', 'FeatureType', 'track');
% trk2 = gpxread('../data/10k-18k/activity_982783698', 'FeatureType', 'track');
% trk3 = gpxread('../data/10k-18k/activity_986267821', 'FeatureType', 'track');
% trk4 = gpxread('../data/10k-18k/activity_1002388846', 'FeatureType', 'track');
% trk5 = gpxread('../data/35k-45k/activity_178485251', 'FeatureType', 'track');
% trk6 = gpxread('../data/35k-45k/activity_478883567', 'FeatureType', 'track');
% trk7 = gpxread('../data/35k-45k/activity_580201703', 'FeatureType', 'track');
% trk8 = gpxread('../data/35k-45k/activity_680097465', 'FeatureType', 'track');
% trk9 = gpxread('../data/courses_Matthieu/activity_444556729', 'FeatureType', 'track');
% trk10 = gpxread('../data/courses_Matthieu/activity_448562890', 'FeatureType', 'track');
% trk11 = gpxread('../data/courses_Matthieu/activity_470911138', 'FeatureType', 'track');
% trk12 = gpxread('../data/courses_Matthieu/activity_484048403', 'FeatureType', 'track');
% trk13 = gpxread('../data/courses_Matthieu/activity_590163985', 'FeatureType', 'track');
% trk14 = gpxread('../data/courses_Matthieu/activity_606184240', 'FeatureType', 'track');
% trk15 = gpxread('../data/courses_Matthieu/activity_886087055', 'FeatureType', 'track');
% trk16 = gpxread('../data/courses_Matthieu/activity_949714253', 'FeatureType', 'track');
% trk17 = gpxread('../data/courses_Matthieu/activity_970465803', 'FeatureType', 'track');
% trk18 = gpxread('../data/courses_Matthieu/activity_982783734', 'FeatureType', 'track');
% trk19 = gpxread('../data/courses_Matthieu/activity_986267849', 'FeatureType', 'track');
% trk20 = gpxread('../data/courses_Matthieu/trailardechois57k', 'FeatureType', 'track');
%trk = gpxread('../data/Forichon_Matthieu/trailstetiennelyon70k', 'FeatureType', 'track');
% trk22 = gpxread('../data/Forichon_Matthieu/activity_978782609', 'FeatureType', 'track');
% trk23 = gpxread('../data/Forichon_Matthieu/activity_982783698', 'FeatureType', 'track');
% trk24 = gpxread('../data/Forichon_Matthieu/activity_986267821', 'FeatureType', 'track');

% for i=22:22
%     name = eval(['trk',num2str(i)]);
%     load('coureur_struct.mat');
%     [trk] = checkTrk(name);
%     [Coureur] = main(Coureur, Nom_coureur, Prenom_coureur, trk);
%     save('coureur_struct.mat', 'Coureur');
% end

load('coureur_struct.mat');
[trk] = checkTrk(trk);
[Coureur] = main(Coureur, Nom_coureur, Prenom_coureur, trk);
save('coureur_struct.mat', 'Coureur');
