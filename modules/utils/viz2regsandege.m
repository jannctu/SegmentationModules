function [ thisfx ] = viz2regsandege( label,r1,r2,ed,cmap,thisfx)
%CHECK2REGS Summary of this function goes here
%   Detailed explanation goes here
    newlabel = zeros(size(label)); 
    newlabel(find(label==r1)) = 1;
    newlabel(find(label==r2)) = 2;
    newlabel(find(ed)) = 3;
    %fx = figure; 
    
    figure(thisfx);imshow(label2rgb(newlabel,cmap));

end

