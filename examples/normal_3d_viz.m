clear all; close all; clc
addpath('../modules/utils');
depth =  imread('../data/000000_depth.png');


pcd = DepthtoPoints(depth);
ptCloud = pointCloud(pcd);
sampledistance = 5;
%% MATLAB NORMAL 
% MatlabNormals = pcnormals(ptCloud,6);
% figure; imshow(MatlabNormals);
% [ fx,returnnormal] = visualizeNormalMap(ptCloud,MatlabNormals,sampledistance );
% figure; imshow(returnnormal);
%% HHA NORMAL 
addpath(genpath('../modules/hha'));
[ HHANormal ] = normalfromhhacode( depth,depth );
figure; imshow(HHANormal);
[ hhafx,returnnormal ] = visualizeNormalMap(ptCloud,HHANormal,sampledistance );

