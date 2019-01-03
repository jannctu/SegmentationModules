function [ N,hha ] = normalfromhhacode( D,RD )
    

    %addpath('rgbdutils/');
    %C camera Matrix
    load('C.mat');
    % AUTORIGHTS
    D = double(D)./1000;
    missingMask = RD == 0;
    [pc, N, yDir, h, pcRot, NRot] = processDepthImage(D*100, missingMask, C);
    angl = acosd(min(1,max(-1,sum(bsxfun(@times, N, reshape(yDir, 1, 1, 3)), 3))));
    
      % Making the minimum depth to be 100, to prevent large values for disparity!!!
      pc(:,:,3) = max(pc(:,:,3), 100); 
      I(:,:,1) = 31000./pc(:,:,3); 
      I(:,:,2) = h;
      I(:,:,3) = (angl+128-90); %Keeping some slack
      hha = uint8(I);
end

