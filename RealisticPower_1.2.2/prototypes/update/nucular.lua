if data.raw.technology["nuclear-reactor"] then		-- check if nucular mod installed (other mods have "nuclear-reactor" entities too so can't just check for that)

	for _, recipe in pairs({	"nuclear-reactor",
								"steam-turbine",
								"steam-boiler",
								}) do
		for _, ingredient in pairs(data.raw.recipe[recipe].ingredients) do
			multiply_ingredient(ingredient, 4)
		end
	end

	table.insert(data.raw["recipe"]["nuclear-reactor"].ingredients,{"processing-unit", 25})

	data.raw.recipe["nuclear-reactor"].energy_required = 120
	data.raw.recipe["steam-turbine"].energy_required = 60
	data.raw.recipe["steam-boiler"].energy_required = 10
end



