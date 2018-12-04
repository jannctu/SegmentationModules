function [ g ] = LocalFiniteDifferencesPrimesense( v0,v1,v2,v3,v4 )
        v0f = double(v0);
		v1f = double(v1);
		v2f = double(v2);
		v3f = double(v3);
		v4f = double(v4);

		if(v0 == 0 && v4 == 0 && v1 ~= 0 && v3 ~= 0)
			g = v3f - v1f;
            return
        end

		left_invalid = (v0 == 0 || v1 == 0);
		right_invalid = (v3 == 0 || v4 == 0);
		if left_invalid && right_invalid 
			g = 0.0;
            return
        else
            if(left_invalid)
                g = v4f - v2f;
                return
            else
                if(right_invalid)
                    g = v2f - v0f;
                    return
                else 
                    a = abs(v2f + v0f - 2.0*v1f);
                    b = abs(v4f + v2f - 2.0*v3f);
                    p = 0.0;
                    q = 0.0;
                    if a + b == 0.0
                        p = 0.5;
                        q = 0.5;
                    else 
                        p = a/(a + b);
                        q = b/(a + b);
                    end
                    g = q*(v2f - v0f) + p*(v4f - v2f);
                end
            end
        end
end

