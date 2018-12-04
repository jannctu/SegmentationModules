function [ rce cce ] = getCenter( label,reg )
%GETCENTER Summary of this function goes here
%   Detailed explanation goes here
    
    [r c] = find(label == reg);
    
    rce =  floor((max(r) + min(r))/2);
    cce =  floor((max(c) + min(c))/2);
end

