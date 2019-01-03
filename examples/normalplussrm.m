clear all; clc; close all; 

addpath(genpath('../Modules/hha/'))
im =  imread('../data/0004d52d1aeeb8ae6de39d6bd993e992/000000_mlt.png');
depth =  imread('../data/0004d52d1aeeb8ae6de39d6bd993e992/000000_depth.png');
figure; imshow(depth,[]);
%% load modules
%addpath('../modules/utils');
%addpath('../modules/params');
%addpath('../modules/mynormalmap');
opt = params();
[rows,cols] = size(depth);
real_depth = double(depth) .* opt.depth_to_z;
%% PCd
pcd = DepthtoPoints(real_depth);
ptCloud = pointCloud(pcd);
ptCloud.Color = im;
sampledistance = 5;
%% MY NORMAL 
%[g density mynormals] = compute_gradient(depth,real_depth,pcd,opt);
%figure; imshow(mynormals);
%[ myfx ] = visualizeNormalMap(ptCloud,mynormals,sampledistance );

%% MATLAB NORMAL 
%MatlabNormals = pcnormals(ptCloud,6);
%figure; imshow(MatlabNormals);
%[ fx,returnnormal] = visualizeNormalMap(ptCloud,MatlabNormals,sampledistance );
%% HHA NORMAL 
addpath(genpath('../modules/hha'));
[ HHANormal ] = normalfromhhacode( depth,depth );
%figure; imshow(HHANormal);
[ hhafx,returnnormal ] = visualizeNormalMap(ptCloud,HHANormal,sampledistance );

addpath('../modules/srm');

%% SRM
% Choose different scales
% Segmentation parameter Q; Q small few segments, Q large may segments
Qlevels=2.^(8:-1:0);
% This creates the following list of Qs [256 128 64 32 16 8 4 2 1]
% Creates 9 segmentations
[maps,images]=srm(double(HHANormal .* 100) ,Qlevels);
srm_plot_segmentation(images,maps);

