function [ opt ] = params(  )
    opt.focal_px = 540.0;
    opt.depth_to_z = 0.001;
    opt.radius = 0.025;
    opt.centroid_window_filter = 24;
    opt.geo_weight = 200;
    opt.color_weight = 5;
    opt.depth_weight = 1200;
    opt.normal_weight = 800;

    opt.iteration = 5;
    opt.lambda = 16;
    opt.connectivity = 8;
    %% NYUD params 2
    opt.thrs_color = 500; % NYUD
    opt.thrs_depth = 2.25; % NYUD
    opt.thrs_normal = 0.1; % NYUD
    opt.thrs_geo = 100; % NYUD
    
    opt.min_cluster = 185; % NYUD
    opt.max_depth = 6;
    opt.min_depth = 0.5;

    opt.b_c = [51 102 255];
    
    
    opt.min_size1 = 150;
    opt.min_size2 = 350;
    
    % bounded merging params
    opt.numberofpixelforline = 500;
    opt.edgetoleran = 0;
    
    opt.numberregions = 30;
    
end


