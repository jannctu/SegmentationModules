function new_map = remap_index( map )
    un = unique(map);
    [rr cc] = size(map);
    for r = 1:rr
        for c=1:cc
            new_map(r,c) = find(un == map(r,c));
        end
    end
end

