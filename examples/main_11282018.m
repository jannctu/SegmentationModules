clear all; close all; clc

addpath('../modules/configs');

datapaths = configPaths();
ID = 'img_5976'; % filename
instanceData =  loadInstance(datapaths,ID); 

addpath('../modules/utils');
addpath('../modules/params');
cmap = randomcolormap();
kernelparams = lowpasskernels();
LowPassImage1 = imfilter(instanceData.depth ,kernelparams.lowpasskernel1,'same'); 
[ z ] = normalized1d( LowPassImage1,255 );

%% COMPUTE HISTOGRAM OF DEPTH
[counts,binLocations] = imhist(z);

%figure; imhist(z);
%figure; plot(counts);
%% SMOOTHING THE DEPTH HISTOGRAM SIGNAL 
order = 3;
framelen = 31;
sgf = sgolayfilt(counts,order,framelen); % Savitzky-Golay filtering
% plot(sgf); 

%figure; plot(sgf);
%% FIND LOCAL MINIMUM 
Data = sgf;
[Maxima,MaxIdx] = findpeaks(Data);
DataInv = 1.01*max(Data) - Data;
[Minima,MinIdx] = findpeaks(DataInv);
Minima = Data(MinIdx);

la = zeros(size(z));
bawah = 0; 
la(:,:) = 1;
for i=1:length(MinIdx)-2
    atas =  MinIdx(i);
    la(find(z>atas)) = i+1;
end

bdryhist = seg2bdry(la);
figure; imshow(label2rgb(la,cmap));
figure; imshow(bdryhist);

addpath('../modules/mynormalmap');
opt = params();
[rows,cols] = size(instanceData.depth);
%% convert depth to meter
real_depth = double(instanceData.depth) .* opt.depth_to_z;
%% PCd
pcd = DepthtoPoints(real_depth);
%% compute gradient and density
[g density norm] = compute_gradient(instanceData.depth,real_depth,pcd,opt);
norm2 = imfilter(norm ,kernelparams.lowpasskernel1,'same'); % FILTER THE DEPTH
figure; imshow(norm2);

addpath('../modules/srm');

%% GENERATE PLANAR BASED ON NORMAL MAP
% Choose different scales
% Segmentation parameter Q; Q small few segments, Q large may segments
Qlevels=2.^(8:-1:0);
% This creates the following list of Qs [256 128 64 32 16 8 4 2 1]
% Creates 9 segmentations
%% SRM FOR PLANAR INFORMATION
%[maps,images]=srm(norm2 .* 100.0,Qlevels);
[maps,images]=srm(norm2 .*100 ,Qlevels);
% And plot them
%srm_plot_segmentation(images,maps);
bdrynormal = seg2bdry(maps{3});
figure; imshow(bdrynormal);

%% COMBINE THE HISTOGRAM CONTOUR AND PLANAR INFORMATION
bdryhist(find(bdrynormal)) = 1;
BW2 = bwperim(bdryhist,8);
bdryfinal = imdilate(BW2, strel('disk',2));
%bdryfinal = imclose(bdryhist,BW3);
figure; imshow(bdryfinal);
%% LABEL THE NEW COMBINATION CONTOUR
label1 = bwlabeln(~bdryfinal);
figure; imshow(label2rgb(label1,cmap));

addpath('../modules/fillupregion');

zzz = cat(3,z,z,z);
[edges, tmp, neighbors, tmpLabImg, avg_seg_colors, ...
     polyfragments, poly_params] = seg2fragments(double(label1), zzz, 1000,5,cmap);
bdry = seg2bdry(tmpLabImg);
result = tmpLabImg; 
result(find(bdry)) = 0;
figure; imshow(label2rgb(tmpLabImg,cmap));
%save('tmpLabImg.mat','tmpLabImg');

BW11 = edge(instanceData.spweight,'Canny');
BW22 = bwperim(BW11,8);
BW33 = imdilate(BW22, strel('disk',2));
lll = bwlabeln(~BW33);
figure; imshow(label2rgb(lll,cmap));