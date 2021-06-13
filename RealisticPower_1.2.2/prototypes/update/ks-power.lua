if data.raw["electric-energy-interface"]["wind-turbine-2"] then

	if halve then
		data.raw["electric-energy-interface"]["wind-turbine-2"].energy_source.output_flow_limit = multiply_number_unit(data.raw["electric-energy-interface"]["wind-turbine-2"].energy_source.output_flow_limit, 0.5)
	end

	for _, ingredient in pairs(data.raw.recipe["wind-turbine-2"].ingredients) do
		multiply_ingredient(ingredient, 5)
	end
	data.raw.recipe["wind-turbine-2"].energy_required = multiply_number(data.raw.recipe["wind-turbine-2"].energy_required, 4)
	
end


if data.raw.recipe["diesel-fuel"] and data.raw.recipe["burn-crude-oil"] and data.raw.recipe["burn-heavy-oil"] and data.raw.recipe["burn-light-oil"] then
	for _, recipe in pairs({	"diesel-fuel",
								"burn-crude-oil",
								"burn-heavy-oil",
								"burn-light-oil"
								}) do
		for _, ingredient in pairs(data.raw.recipe[recipe].ingredients) do
			if ingredient.name ~= "water" then
				multiply_ingredient(ingredient, 2)
			end
		end
	end
end	