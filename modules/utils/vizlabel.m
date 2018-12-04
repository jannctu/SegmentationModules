function [fx] = vizlabel( label, cmap )
%VIZLABEL Summary of this function goes here
%   Detailed explanation goes here
    allLabel = unique(label);
    fx = figure;
    r = zeros(size(label));
    g = zeros(size(label));
    b = zeros(size(label));
    %rgbimage = cat(3,r,g,b);
    
    for i=1:length(allLabel)
        if(allLabel(i)>0)
            r(find(label==allLabel(i))) = cmap(i,1);
            g(find(label==allLabel(i))) = cmap(i,2);
            b(find(label==allLabel(i))) = cmap(i,3);
            rgbimage = cat(3,r,g,b);
            figure(fx);imshow(rgbimage);
            pause(0.1);
            %pause;
        end
    end
    

end

