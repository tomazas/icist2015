clc
clear all
close all
format compact

p = {};
p.datadir = 'data\\A0%dT.gdf.mat';
p.n = 9;
p.fs = 250; % sampling freq in Hz
p.csp = 0; % cannot be used, difference calculated from all 22 channels
p.downsampling = 1;
p.trim_low = 3.5;
p.trim_high = 6;

test_all(@channel_diff_feats, p, 'channel_diff_feats.csv');