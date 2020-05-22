while gen < noGen

    gen = gen + 1;
    disp(gen);

    %% Simulation
    
    if gen == (preGen + 1)
        rX = iniX;
        [rY, rU] = simu(rX, ckt);
    else
        [offSpY, offSpU] = simu(offSpX, ckt);
            
        rX = [offSpX; sX];
        rY = [offSpY; sY];
        rU = [offSpU; sU];
    end
    
    %% Duration Estimation
    
    if gen == (preGen + 1)
        t1 = toc;
    end
    
    %% Elimination

    eli = elimination(rY,rU,specs);
    selE = eli.selInd;
    eliE = eli.elimInd;
    
    if sum(selE) < specs.popSize
        error('Not enough good member!');
    end
    
    X = rX(selE, :);
    Y = rY(selE, :);
    U = rU(selE, :);
    
    wX = rX(eliE, :);
    wY = rY(eliE, :);
    wU = rU(eliE, :);
          
    %% Raw Archive
    
    if gen ~= 0
        arch.rX(gen,:,:) = rX;
        arch.rY(gen,:,:) = rY;
        arch.rU(gen,:,:) = rU;
        arch.eli{gen} = eli;
    else
        arch.ini.rX = rX;
        arch.ini.rY = rY;
        arch.ini.rU = rU;
        arch.ini.eli = eli;
    end
    
    %% Selection
        
    [sel,C] = selection(Y, specs);
    
    sX = X(sel,:);
    sY = Y(sel,:);
    sU = U(sel,:);
   
    loop_plot;

    %% Matingpool
    
    [n,~] = size(X);
    matSel = randperm(n);
    
    %fr = nsgaData.frontLabel;
    %matSel = mating(fr, hete, specs.popSize);

    %% Crossover and Mutation with Boundary Elimination
    
    [offSpX, outOfRange] = crossMutation(matSel, X, lims, specs);
    
    %% Archiving
    
    if gen ~= 0
        arch.X(gen,:,:) = sX;
        arch.Y(gen,:,:) = sY;
        arch.U(gen,:,:) = sU;
        arch.C{gen} = C;
        arch.outOfRange(gen,:) = outOfRange;
    else
        arch.ini.X = sX;
        arch.ini.Y = sY;
        arch.ini.U = sU;
        arch.ini.C = C;
        arch.ini.outOfRange = outOfRange;
    end

    %% Last X and Z for Load
    continuum.X = [offSpX; sX];
    
    %% Temperature Update
    
    temperature_update;
    
    %% Cost Weight Update
    
    cost_weight_update;
    
    %% Duration Estimation
    
    duration_estimation;
    
end