clc; clear all; close all;

NYUD_depth_path =  'C:\Users\Jan\Google Drive (Not Syncing)\Fall 2016\Code\sguptaNYUD\depth\';
NYUD_HHA_path = 'C:\Users\Jan\Downloads\NYUDHHA\HHA\';

imname = 'img_5976.png';
depth = imread(strcat(NYUD_depth_path,imname));   
HHA = saveHHA([], [], depth,depth);
