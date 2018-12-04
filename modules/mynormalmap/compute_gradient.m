function [ g,d,norm] = compute_gradient( depth,real_depth,pdc,opt )
    [rows,cols] = size(depth);
    g = zeros(rows,cols,2);
    d = zeros(rows,cols);
    for r=1:rows
		for c=1:cols
           g(r,c,:) = LocalDepthGradient(depth,r,c,opt);
           d(r,c) = compute_density(real_depth(r,c), g(r,c,:),opt);
           norm(r,c,:) = compute_normal(g(r,c,:),pdc(r,c,:));
           
        end
    end
    
end

