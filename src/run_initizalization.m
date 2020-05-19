if isempty(load_name)
    preGen = -1; % no previous generation
    iniX = population_initialization(specs);
else
    preGen = preData.noGen;
    iniX = preData.continuum.X;
end

specs.temp = specs.temp_if(1);

gen = preGen; % generation count

disp(specs);