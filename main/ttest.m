clear all; close all; clc


addpath('../modules/configs');

datapaths = configPaths();
ID = 'img_5976'; % filename
instanceData =  loadInstance(datapaths,ID); 

load('tmpLabImg');

addpath('../modules/myregionmerging');
opt.sensitivityMerging = 0.9; %  0 ~ 1
opt.minSize = 0.9;

zzz = cat(3,instanceData.spweight,instanceData.spweight,instanceData.spweight);
[labels]=myregion_merging(zzz,tmpLabImg,opt);

addpath('../modules/utils');
addpath('../modules/params');
cmap = randomcolormap();
figure; imshow(instanceData.spweight);
figure; imshow(label2rgb(tmpLabImg,cmap));
figure; imshow(label2rgb(labels,cmap));

BW1 = edge(instanceData.spweight,'Canny');
figure; imshow(BW1);