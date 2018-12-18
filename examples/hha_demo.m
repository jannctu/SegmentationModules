clear all; clc; close all; 

addpath(genpath('../Modules/hha/'))
%depth =  imread('../data/000000_depth.png');
depth =  imread('../data/depth_5001.png');
HHA = saveHHA([], [], depth,depth);

imshow(HHA)