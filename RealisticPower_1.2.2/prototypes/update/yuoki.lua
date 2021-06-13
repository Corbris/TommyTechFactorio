-- Yuoki main mod 0.4.63

-- entity.e_advmachinery

if data.raw.item["y_crusher2"] then	-- serves as check if Yuoki main mod installed


-- entity.e_electric

for _, item in pairs({	"y-accumulator-s",
						"y-accumulator-s-t2",
						"y-accumulator-m",
						"y-accumulator-b",
						"y-ups-flywheel-b",
						"y-accumulator-m-t2",
						"y-accumulator-b-t2",
						"y-accumulator-b-tx",
						"y-accumulator-crystal-m",
						"y_compensator_25"
						}) do
	if data.raw.item[item] then
		data.raw["accumulator"][item].energy_source.buffer_capacity = multiply_number_unit(data.raw["accumulator"][item].energy_source.buffer_capacity, 0.25) -- nerf yuoki accumulators a bit
		crit_power_in = math.max(1/6*value_number_si(data.raw["accumulator"][item].energy_source.input_flow_limit), value_number_si(data.raw["accumulator"][item].energy_source.buffer_capacity)*1.25/(7.2*3600)) .. 'W'
		crit_power_out = math.max(1/6*value_number_si(data.raw["accumulator"][item].energy_source.output_flow_limit), value_number_si(data.raw["accumulator"][item].energy_source.buffer_capacity)*1.25/(7.2*3600)) .. 'W'

		data.raw["accumulator"][item].energy_source.input_flow_limit = crit_power_in
		data.raw["accumulator"][item].energy_source.output_flow_limit = crit_power_out
	end
end

for _, item in pairs({	"y-accumulator-s-recipe",
						"y-accumulator-st2-recipe",
						"y-accumulator-m-recipe",
						"y-accumulator-b-recipe",
						"y-ups-flywheel-b-recipe",
						"y-accumulator-mt2-recipe",
						"y-accumulator-bt2-recipe",
						"y-accumulator-btx-recipe",
						"y-accumulator-crystal-m-recipe",
						"y_compensator_25-recipe"
						}) do
	if data.raw.recipe[item] then
		for _, ingredient in pairs(data.raw.recipe[item].ingredients) do
			multiply_ingredient(ingredient, 4)
		end
	end
end

-- entity.e_energy_gen

for _, item in pairs({	"y-steam-turbine-recipe",
						"y-obninsk-turbine-recipe",
						"y-steam-turbine-mk3-recipe",
						"y-notfall-generator-s1-recipe",
						"y-notfall-generator-s2-recipe",
						"y-seg-recipe",
						"y-seg-p-recipe",
						"y-meg-s-recipe",
						"y-beg-recipe",
						"y-heg-recipe"
						}) do
	if data.raw.recipe[item] then
		for _, ingredient in pairs(data.raw.recipe[item].ingredients) do
			if ingredient[1] ~= "y-seg" and ingredient[1] ~= "y-seg" then
				multiply_ingredient(ingredient, 4)
			end
		end
	end
end





-- item.y_items

--data.raw["item"]["coal"].stack_size=100
--data.raw["item"]["iron-ore"].stack_size=50
--data.raw["item"]["copper-ore"].stack_size=50


end -- end of Yuoki main mod




-- yi_engines 0.4.20

if data.raw["generator"]["ye_tfmw_generator-s"] then	
	for _, ingredient in pairs(data.raw.recipe["ye_tfmw_generator-s-recipe"].ingredients) do
		multiply_ingredient(ingredient, 4)
	end
end