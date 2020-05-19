function [Ng] = t2Ng(T0, Tf, alpha)

Ng = (log(T0/Tf)*(log(T0/Tf) + 1)/2)*(log(Tf/T0)/log(alpha));

end

