function [ g ] = LocalDepthGradient( depth,j,i,opt )
        [rows,cols] = size(depth);
        d00 = depth(j,i);
        
		z_over_f = double(d00)* opt.depth_to_z / opt.focal_px;
		window = 0.1 * opt.radius / z_over_f;

		% compute w = base_scale*f/d
		w = max(round(window + 0.5), 4);
		if(mod(w,2) == 1)
            w = w+1;
        end
        
		% can not compute the gradient at the border, so return 0
		if(i <= w || i+w > cols || j <= w || j+w > rows)
			g = [0 0];
            return
        end

		dx = LocalFiniteDifferencesPrimesense(...
			depth(j-w,i),...
			depth(j-w/2,i),...
			d00,...
			depth(j+w/2,i),...
			depth(j+w,i)...
		);

		dy = LocalFiniteDifferencesPrimesense(...
			depth(j,i-w),...
			depth(j,i-w/2),...
			d00,...
			depth(j,i+w/2),...
			depth(j,i+w)...
		);

		%Theoretically scale == base_scale, but w must be an integer, so we
		%compute scale from the actually used w.

		%compute 1 / scale = 1 / (w*d/f)
		scl = 1.0 / (double(w) * z_over_f);

		g = (scl*opt.depth_to_z) * [double(dx) double(dy)];
end

