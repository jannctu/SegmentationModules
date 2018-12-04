function [ N ] = normalfromhhacode( D,RD )
    

    %addpath('rgbdutils/');
    %C camera Matrix
    load('C.mat');
    % AUTORIGHTS
    D = double(D)./1000;
    missingMask = RD == 0;
    [pc, N, yDir, h, pcRot, NRot] = processDepthImage(D*100, missingMask, C);
end

