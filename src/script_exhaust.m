close all;
clear all;
clc;

trk = gpxread('../data/Forichon_Matthieu/activity_986267821', 'FeatureType', 'track');

[values] = displayExhaust(trk);