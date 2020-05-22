if isnan(specs.noGen)
	specs.noGen = ceil(t2Ng(specs.temp_if(1), specs.temp_if(2), ...
        specs.cool_rate) + specs.markov_cl);
    noGen = specs.noGen;
end

specs.cost_weight = specs.cost_weight ./ norm(specs.cost_weight);
naming.file_name = file_name;