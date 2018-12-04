function h = regs_are_homg(stats1, stats2) 

d = abs(stats1(3) - stats2(3)) ; % Difference between means


if d >0.000001;
    h = 1 ;
else;
    h = 0;
end;



%if low2>=low1 && low2<=high1 && high2>=low1 && high2<=high1; 
%    h = 1 ;
%elseif low1>=low2 && low1<=high2 && high1>=low2 && high1<=high2;
%    h = 1 ;
%else;
%    h = 0 ;
%end ;
