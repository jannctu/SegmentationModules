
clear all; clc; close all; 
im =  imread('../data/rgb_5001.png');
addpath('../modules/srm');

%% SRM
% Choose different scales
% Segmentation parameter Q; Q small few segments, Q large may segments
Qlevels=2.^(8:-1:0);
% This creates the following list of Qs [256 128 64 32 16 8 4 2 1]
% Creates 9 segmentations
[maps,images]=srm(double(im) ,Qlevels);
srm_plot_segmentation(images,maps);