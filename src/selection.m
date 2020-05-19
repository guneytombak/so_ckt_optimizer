function [S,C] = selection(Y, specs)

%% Normalization of Parameters

lims = specs.lims;

yLo = lims.yLo; yUp = lims.yUp;

nanLo = isnan(yLo); 
nanUp = isnan(yUp);

yLo(nanLo) = 0;
yUp(nanUp) = 0;

yLo = nanLo.*min(Y) + (~nanLo).*yLo;
yUp = nanUp.*max(Y) + (~nanUp).*yUp;
yRa = yUp - yLo;

Yn = (Y - yLo)./yRa;

%% Redefine Parameters

R = (~specs.highY).*Yn - specs.highY.*Yn;

%% Cost Calculation

C = R*specs.cost_weight';

%% Probability Calculation 

P = specs.cost2prob(C, specs.temp);
Pn = P/max(P);

%% Selection

[Ni,~] = size(R);

S = false(Ni, 1);

while sum(S) < specs.popSize
    
    find_p = find(Pn >= rand);
    
    len_p = length(find_p);
    
    S(find_p(randi(len_p))) = true;
    
end

end
