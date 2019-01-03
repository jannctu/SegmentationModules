clear all; clc; close all; 

addpath(genpath('../Modules/hha/'))
%depth =  imread('../data/000000_depth.png');
depth =  imread('../data/0004d52d1aeeb8ae6de39d6bd993e992/000000_depth.png');
HHA = saveHHA([], [], depth,depth);

imshow(HHA)