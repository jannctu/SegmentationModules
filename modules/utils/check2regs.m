function [ fx ] = check2regs( label,r1,r2,cmap )
%CHECK2REGS Summary of this function goes here
%   Detailed explanation goes here
    newlabel = zeros(size(label)); 
    newlabel(find(label==r1)) = 1;
    newlabel(find(label==r2)) = 2;
    
    fx = figure; 
    
    figure(fx);imshow(label2rgb(newlabel,cmap));

end

