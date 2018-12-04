function [ dt ] = loadInstance( datapaths,ID )
%LOADINSTANCE Summary of this function goes here
%   Detailed explanation goes here
    affinity = load(strcat(datapaths.Aff,ID,'.mat'));
    dt.affinity = affinity.A;
    edge = load(strcat(datapaths.Edg,ID,'.mat'));
    dt.edge = edge.E;
    sp = load(strcat(datapaths.Sp,ID,'.mat'));
    dt.sp = sp.S;
    spim = imread(strcat(datapaths.SpIm,ID,'.png'));
    dt.spim = spim;
    spweight = load(strcat(datapaths.SpWeight,ID,'.mat'));
    dt.spweight = spweight.EW;
%     BB = load(strcat(datapaths.Bb,ID,'.mat'));
%     dt.bb = BB.boxes_cell; % format c r c r
    dt.im = imread(strcat(datapaths.im,ID,'.png'));
    dt.depth = imread(strcat(datapaths.depth,ID,'.png'));
    dt.hha = imread(strcat(datapaths.Hha,ID,'.png'));
    dt.gt = imread(strcat(datapaths.gt,ID,'.png'));

end