function [ d ] = compute_density(depth, g,opt )
		q = depth / (opt.radius * opt.focal_px);
		d = q * q / 3.1415 * sqrt(g(1)*g(1) + g(2)*g(2) + 1.0);
end

