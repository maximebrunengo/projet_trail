close all;
clear all;
clc;

% Liste des points intermédiaires
A = 10000;
B = 20000;
C = 30000;
D = 40000;
E = 50000;
F = 60000;
G = 70000;


Liste_points = [A, B, C, D, E, F, G];

trk = gpxread('../data/Forichon_Matthieu/trailstetiennelyon70k', 'FeatureType', 'track');

[trk] = checkTrk(trk);

% timeStr_crt = strrep(trk(1).Time, 'T', ' ');
% timeStr_crt = strrep(timeStr_crt, 'Z', '');
% trk(1).DateNumber = datenum(timeStr_crt, 31);
% duration = 0;
% dist = 0;
% j=1;

% for i=2:size(trk,1)
%     % Distance bewteen first point and current point
%     dist = dist + computeDistance(trk(i),trk(i-1));
%     
%     % Duration between first point and current point
%     timeStr_prev = strrep(trk(i).Time, 'T', ' ');
%     timeStr_prev = strrep(timeStr_prev, 'Z', '');
%     trk(i).DateNumber = datenum(timeStr_prev, 31);
%     duration = etime(datevec(trk(i).DateNumber), datevec(trk(1).DateNumber));
%     
%     if j <= size(Liste_points,2)
%         if dist >= Liste_points(1,j)
%             M(1,j) = Liste_points(1,j);
%             M(2,j) = duration;
%             j=j+1;
%         end
%     else
%         break;
%     end
%         
% end

timeFromBeginning = estimation_inter('Forichon', trk, Liste_points);