if specs.temp > specs.temp_if(2) && gen >= specs.markov_cl
    specs.temp = specs.temp.*specs.cool_rate;
end