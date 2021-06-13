if data.raw.item["wind-turbine"] then		

	for _, ingredient in pairs(data.raw.recipe["wind-turbine"].ingredients) do
		multiply_ingredient(ingredient, 5)
	end

	if halve then
		data.raw.recipe["wind-turbine"].energy_required = multiply_number(data.raw.recipe["wind-turbine"].energy_required, 10)					-- 5 base
		if data.raw["generator"]["wind-turbine"] then
			data.raw["generator"]["wind-turbine"].effectivity = multiply_number(data.raw["generator"]["wind-turbine"].effectivity, 2 * 0.3/2)		-- 2 base, 0.3 nets 107 kW max power (multiplier 2 in the front to compensate for halving all generator effectivities in data-final-fixes)
		elseif data.raw["electric-energy-interface"]["wind-turbine"] then
			data.raw["electric-energy-interface"]["wind-turbine"].effectivity = multiply_number(data.raw["electric-energy-interface"]["wind-turbine"].effectivity, 2 * 0.3/2)
		end
	end

end