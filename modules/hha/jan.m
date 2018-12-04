clc; clear all; close all;
%load('00000001.mat');
%NYUD_depth_path = 'C:\Users\Jan\Google Drive\TMP\RGBD data\scene_labeling_cvpr2012\nyu_depth\depth_uint16\';
%NYUD_HHA_path = 'C:\Users\Jan\Google Drive\Fall 2016\Data\NYUD\HHA\';

NYUD_depth_path =  'C:\Users\Jan\Google Drive (Not Syncing)\Fall 2016\Code\sguptaNYUD\depth\';
NYUD_HHA_path = 'C:\Users\Jan\Downloads\NYUDHHA\HHA\';
%ext_depth = 'png';
ext_hha = 'png';
%generate_name;
%upperbound = 1449;
%name = '00000001';

% for di = 1:upperbound 
%     name = names{di};
%     fullname = [NYUD_depth_path name '.' ext_depth];
%     %load(fullname);
%     depth = imread(fullname);
%     HHA = saveHHA([], [], depth,depth);
%     filename=[NYUD_HHA_path name '.' ext_hha];
%     imwrite(HHA, filename);
% end

fileList = dir(fullfile(NYUD_depth_path,'*.png'));
%% detect and display superpixels (see spDetect.m)
Nimages =  length(fileList);


for i=1:Nimages
    imname = fileList(i).name; % get file name 
    dataname = strsplit(imname,'.');
    depth = imread(strcat(NYUD_depth_path,imname));
        
    HHA = saveHHA([], [], depth,depth);
    HHAfname = strcat(NYUD_HHA_path, dataname{1}, '.', ext_hha);
    imwrite(HHA, HHAfname);
    fprintf('%s is DONE! \n',imname);
end