% Calc size, mean and variance of a region
%function [sz, mn_r,mn_g,mn_b,sd_r,sd_g,sd_b] = region_stats(image, labels, region_no)
function [sz, mn_i, sd_i,sum_i] = region_stats(image, labels, region_no)
R        = image(:, :, 1);           % red
G        = image(:, :, 2);           % blue
B        = image(:, :, 3);           % green
reg = (labels==region_no) ;
sz = sum(sum(reg)) ;
if(sz==0);
    mn_i = 0; 
    sd_i = 0;
    return ;
end ;

% image data 
mn_r = mean(R(labels == region_no));
mn_g = mean(G(labels == region_no));
mn_b = mean(B(labels == region_no));
mn_i = (mn_r + mn_g + mn_b)/3;
sum_i = sum(sum(R(labels == region_no)));
sd_r = std(double(R(labels == region_no)));
sd_g = std(double(G(labels == region_no)));
sd_b = std(double(B(labels == region_no)));
sd_i = (sd_r + sd_g + sd_b)/3;



