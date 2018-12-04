% function [labels,stats] = region_merge(image, init_labels)
% Stats are: region id, size, mean, standard deviation (one region per row)

function [labels,stats]=region_merge(image,init_labels)
labels = init_labels ;
%
% Calculate region stats
% Stats are: region id, size, mean, standard deviation (one region per row)
%
sz_mn_sd = [] ;
for c=1:max(max(init_labels));
    sz_mn_sd(c,1) = c ;
    [sz_mn_sd(c,2),sz_mn_sd(c,3),sz_mn_sd(c,4)] = region_stats(image,labels, c) ;
end;


% Sort Decending in size
sz_mn_sd = -1 * sz_mn_sd ;
sz_mn_sd = sortrows(sz_mn_sd,2);
sz_mn_sd = -1 * sz_mn_sd ;

%
% Calculate neighnours
%
neighbours = calc_neighbours(labels) ;

%
% Merge neighbouring regions that meet some homogeneity 
% criteria. Start with the largest. Loop until no changes made (chd==0).
% (A better strategy might be to merge the 'most similar' first.)
%

chd = 1 ;
while chd==1;
    chd = 0 ;
    for refc=1:max(max(labels));
        if (sz_mn_sd(refc,2)>0);
            for oc=refc:max(max(labels));
                if (refc ~= oc) && (sz_mn_sd(oc,2)>0);
                    if (neighbours(sz_mn_sd(refc,1),sz_mn_sd(oc,1))==1) ;
                        homog = regs_are_homg(sz_mn_sd(refc,:), sz_mn_sd(oc,:)) ;
                        if (homog == 1) ;
                           % Are homogeneous
                            chd = 1 ;
                            %sprintf('merging %d and %d : %f %f %f %f', sz_mn_sd(refc,1), sz_mn_sd(oc,1), sz_mn_sd(refc,3), sz_mn_sd(refc,4), sz_mn_sd(oc,3), sz_mn_sd(oc,4))
                            sprintf('merging %d and %d : %f %f ', sz_mn_sd(refc,1), sz_mn_sd(oc,1))
                            % Merge other region into ref, by re-numbering
                            labels = renumber_reg(sz_mn_sd(oc,1), sz_mn_sd(refc,1), labels);
                            % Update stats of refc region                    
                            [sz_mn_sd(refc,2),sz_mn_sd(refc,3),sz_mn_sd(refc,4)] = region_stats(image, labels, sz_mn_sd(refc,1)) ;      
                            % Set size of oc region to zero
                            sz_mn_sd(oc,2) = 0 ;
                            % Re-calculate neighbours
                            neighbours = calc_neighbours(labels) ; 
                        end
                    end ;
                end;
            end;
        end;
    end;
    %imagesc(labels);
    %r = input('press return') ;
end;
   
stats = sz_mn_sd ;
 
% ==========================

% function regs_are_homg


% ==========================

% Calculate neighbours matrix
function nb = calc_neighbours(labels) 

nlabs = max(max(labels)) ;

nb = zeros(nlabs,nlabs) ;

for rc=1:size(labels,1);
    for cc=1:size(labels,2);
        if(rc<size(labels,1));
            nb(labels(rc,cc),labels(rc+1,cc)) = 1 ;
            nb(labels(rc+1,cc),labels(rc,cc)) = 1 ;
        end;

        if(cc<size(labels,2));
            nb(labels(rc,cc),labels(rc,cc+1)) = 1 ;
            nb(labels(rc,cc+1),labels(rc,cc)) = 1 ;
        end;
    end ;
end ;

% ==========================

% region stats

% ==========================
function labels = renumber_reg(oc, refc, old_labels) ;

labels = old_labels ;

% Multiply old by mask => zeros at values to be changed
mask = (labels ~= oc) ;
imask = not(mask) ;
labels = labels .* mask ;

% Add new value at values to be changed
c = imask * refc ;
labels = labels + c ;
