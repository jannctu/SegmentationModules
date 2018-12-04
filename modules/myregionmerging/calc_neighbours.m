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


end

