function labels = renumber_reg(oc, refc, old_labels) ;

labels = old_labels ;

% Multiply old by mask => zeros at values to be changed
mask = (labels ~= oc) ;
imask = not(mask) ;
labels = labels .* mask ;

% Add new value at values to be changed
c = imask * refc ;
labels = labels + c ;

end

