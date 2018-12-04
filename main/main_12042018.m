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

%[g density normals] = compute_gradient(z,real_depth,pcd,opt);
normals = pcnormals(ptCloud,6);
sampledistance = 5;
%[ fx ] = visualizeNormalMap(ptCloud,normals,sampledistance );


addpath(genpath('../modules/hha'));
[ N ] = normalfromhhacode( instanceData.depth,instanceData.depth );
[ fx ] = visualizeNormalMap(ptCloud,N,sampledistance );

