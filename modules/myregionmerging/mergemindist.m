function [ newlabel ] = mergemindist( aff,label,sobeledge,opt )
%MERGEMINDIST Summary of this function goes here
%   Detailed explanation goes here
    newlabel = label; 
    merged = false; 
    %thisfx = figure;
    %set(thisfx, 'Position', [900 300 560 425]);
    while(~merged)
        minvalue = min(min(aff)); % get minvalue
        if (minvalue == Inf)
            merged =  true; 
        end
        [minR minC] = find(aff==minvalue);   % get min value index
        [ rce1 cce1 ] = getCenter( label,minR(1));
        [ rce2 cce2 ] = getCenter( label,minC(1));
%         
         %dummylabel =  zeros(size(label));
         %dummylabel(find(label==minR(1))) = minR(1);
         %dummylabel(find(label==minC(1))) = minC(1);
%         
        % [ thisfx ] = viz2regsandege( dummylabel,minR(1),minC(1),sobeledge,rand(1000,3),thisfx );
        %pause(0.2);
        if (rce1 == rce2)
            rce2 = rce2+1;
        end
        [rline,cline]= fillline([ rce1 cce1 ],[ rce2 cce2 ],opt.numberofpixelforline);
        urline = floor(rline);
        ucline = floor(cline);
        linearInd = sub2ind(size(sobeledge),urline,ucline);
        uInd = unique(linearInd);
%         if(length(uInd) == 500)
%             length(uInd)
%         end
        checksum = sum(sobeledge(uInd));
        % vizualize the merged
        
        if(checksum>opt.edgetoleran)
            aff(minR(1),minC(1)) = Inf;
        else
%             dummylabel =  zeros(size(label));
%             dummylabel(find(label==minR(1))) = minR(1);
%             dummylabel(find(label==minC(1))) = minC(1);
%             [ fx ] = viz2regsandege( dummylabel,minR(1),minC(1),sobeledge,rand(1000,3) );
            newlabel(find(label==minR(1))) = minC(1);
            merged = true; 
        end
        
    end
    
%     if(checksum>0)
%         
%     end
end

