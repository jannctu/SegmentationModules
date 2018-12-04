clf;
clear all
close all;
%get Depth Images Data
folder_depth = 'D:\EFPL Dataset\epfl_corridor\20141008_141430_00\rawDepth';
files_depth = dir([folder_depth '\*.png']);
%get Refined Depth Data
folder_rdepth = 'D:\EFPL Dataset\epfl_corridor\20141008_141430_00\refinedDepth';
files_rdepth = dir([folder_rdepth '\*.png']);

for i = 1:length(files_depth)
    depthName=files_depth(i).name;%get depth image as input
    rdepthName=files_rdepth(i).name;%get depth image as input
    RD=imread(depthName); %read depth image 
    D=imread(rdepthName);
    HHA = saveHHA([], [], RD, RD);
    filename=['HHA' num2str(i,'%06d') '.png'];
	imwrite(HHA, fullfile('D:\EFPL Dataset\epfl_corridor\20141008_141430_00\HHA',filename));
%     rHHA = saveHHA([], [], D, RD);
%     filename=['rHHA' num2str(i,'%06d') '.png'];
% 	imwrite(rHHA, fullfile('D:\EFPL Dataset\epfl_corridor\20141008_141430_00\rHHA',filename));
end