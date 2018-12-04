function [ aff ] = aff1d( label,dat,adj )
%AFF1D Summary of this function goes here
%   Detailed explanation goes here
    singleindex =find(adj); 
    [I,J] = ind2sub(size(adj),singleindex);
    n = length(I);
    aff = Inf(size(adj));
    for a=1:n
        if(I(a) ~= J(a))
            regI = find(label==I(a));
            regJ = find(label==J(a));
            %check2regs( label,I(a),J(a),rand(100,3) )
            depthI = dat(regI);
            depthJ = dat(regJ);
            
            meanDepthI = mean(mean(depthI));
            meanDepthJ = mean(mean(depthJ));
            aff(I(a),J(a)) = abs(meanDepthI - meanDepthJ);
        end
    end
    
end

