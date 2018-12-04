function [ z ] = normalized1d( dat,rangedata )    
    x = double(reshape(dat,1,[]));
    %x = double(reshape(instanceData.depth,1,[]));
    %normalized = double(x);
    normalized = ((x-min(x))/(max(x)-min(x))) * rangedata; % INTI NYA DISINI
    z = uint8(reshape(normalized,size(dat)));
end

