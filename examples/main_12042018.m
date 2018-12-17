clear all; close all; clc
%% load modules
addpath('../modules/configs');
addpath('../modules/utils');
addpath('../modules/params');
addpath('../modules/fillupregion');
addpath('../modules/ucmsp');
%% INITIAL CONFIGS
datapaths = configPaths();
ID = 'img_5976'; % filename
instanceData =  loadInstance(datapaths,ID); 
cmap = randomcolormap();
kernelparams = lowpasskernels();

LowPassDepth = imfilter(instanceData.depth ,kernelparams.lowpasskernel1,'same'); 
[ z ] = normalized1d( LowPassDepth,255 );

addpath('../modules/mynormalmap');
opt = params();
[rows,cols] = size(instanceData.depth);
%% convert depth to meter
real_depth = double(instanceData.depth) .* opt.depth_to_z;
%% PCd
pcd = DepthtoPoints(real_depth);
ptCloud = pointCloud(pcd);
ptCloud.Color = instanceData.im;
sampledistance = 5;
%% MY NORMAL 
% [g density mynormals] = compute_gradient(z,real_depth,pcd,opt);
% figure; imshow(mynormals);
% [ myfx ] = visualizeNormalMap(ptCloud,mynormals,sampledistance );

%% MATLAB NORMAL 
% MatlabNormals = pcnormals(ptCloud,6);
% figure; imshow(MatlabNormals);
% [ fx,returnnormal] = visualizeNormalMap(ptCloud,MatlabNormals,sampledistance );
%figure; imshow(returnnormal);
%% HHA NORMAL 
addpath(genpath('../modules/hha'));
[ HHANormal ] = normalfromhhacode( instanceData.depth,instanceData.depth );
figure; imshow(HHANormal);
[ hhafx,returnnormal ] = visualizeNormalMap(ptCloud,HHANormal,sampledistance );

