function [labels]=myregion_merging(image,init_labels,opt)
labels = init_labels ;
%
% Calculate region stats
% Stats are: region id, size, mean, standard deviation (one region per row)
%
sz_mn_sd = [] ;
for c=1:max(max(init_labels));
    sz_mn_sd(c,1) = c ;
    [sz_mn_sd(c,2),sz_mn_sd(c,3),sz_mn_sd(c,4),sz_mn_sd(c,5)] = region_stats(image,labels, c) ;
end;


% Sort Decending in size
sz_mn_sd = -1 * sz_mn_sd ;
sz_mn_sd = sortrows(sz_mn_sd,-2);
sz_mn_sd = -1 * sz_mn_sd ;

%
% Calculate neighnours
%
neighbours = calc_neighbours(labels) ;
%boundMerge = min(sensitivityMerging,size(sz_mn_sd,1));
boundMerge = opt.sensitivityMerging * size(sz_mn_sd,1);
% untuk sensitivityMerging regions paling kecil lakukan merge
for i=1:boundMerge 
    %ambil regions pertama
    regionI = sz_mn_sd(i,:);
    % check tetangga 
    tetangga = find(neighbours(regionI(1),:) == 1);
    % untuk tiap tetangga cari yang paling mirip (sementara average nya)
    minJarak = 100000;
    tetanggaMerge = 0;
    for j=1:length(tetangga)
        if sz_mn_sd(j,2) > 0
            tetanggaJ = find(sz_mn_sd(:,1) == tetangga(j));
            tetanggaJdata = sz_mn_sd(tetanggaJ,:);
            jarak = abs(regionI(5) - tetanggaJdata(5));
            if(jarak < minJarak)
                minJarak = jarak;
                tetanggaMerge = tetanggaJ;
            end
        end 
    end
    if( i < opt.minSize * boundMerge)
        labels = renumber_reg(sz_mn_sd(i,1), sz_mn_sd(tetanggaJ,1), labels);
        [sz_mn_sd(tetanggaJ,2),sz_mn_sd(tetanggaJ,3),sz_mn_sd(tetanggaJ,4),sz_mn_sd(tetanggaJ,5)] = region_stats(image, labels, sz_mn_sd(tetanggaJ,1)) ;      
        % Set size of oc region to zero
        sz_mn_sd(i,2) = 0 ;
        % Re-calculate neighbours
        neighbours = calc_neighbours(labels) ; 
        %segres22 = label2rgb(labels,cm);
        %figure(6); imshow(segres22);
        %pause(0.5);
    end
end







% ==========================

% function regs_are_homg


% ==========================



% ==========================

% region stats

% ==========================


