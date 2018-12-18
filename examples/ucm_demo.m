clear all; clc; close all; 
addpath('../modules/ucmsp');

edge = load('../data/img_5001.mat');

E = upsampleEdges(edge.EW);
S=bwlabel(E<mean(mean(edge.EW)),8); S=S(2:2:end,2:2:end)-1;
S(end,:)=S(end-1,:); S(:,end)=S(:,end-1);
E(end+1,:)=E(end,:); E(:,end+1)=E(:,end);
U=ucm_mean_pb(E,S); U=U(1:2:end-2,1:2:end-2);
figure; imshow(1-U,[]);