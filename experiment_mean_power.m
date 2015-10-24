clc
clear all
close all
format compact

p = {};
p.datadir = 'data\\A0%dT.gdf.mat';
p.n = 9;
p.fs = 250; % sampling freq in Hz
p.csp = 1;
p.downsampling = 1;
p.trim_low = 3.5;
p.trim_high = 6;

test_all(@mean_signal_power, p, 'mean_signal_power.csv');

p.csp = 0;

test_all(@mean_signal_power, p, 'mean_signal_power-no_csp.csv');