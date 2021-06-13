-- requires at the bottom
halve = false	-- halve all power requirements of all entities halved

for _, category in pairs({	"reactor",
							}) do
	for _, item in pairs(data.raw[category]) do
		if not blacklisted(item.name) then
			--item.consumption = multiply_number_unit(item.consumption, 0.5)
			if data.raw.recipe[item.name] then
				local recipe_tiers = {	data.raw.recipe[item.name],
									data.raw.recipe[item.name].normal,
									data.raw.recipe[item.name].expensive
									}
				for _, recipe in pairs(recipe_tiers) do
					if recipe and recipe.energy_required then
						recipe.energy_required = 240
					end
					if recipe and recipe.ingredients then
						for _, ingredient in pairs(recipe.ingredients) do
							multiply_ingredient(ingredient, 4)
						end
					end
				end
			end
		end
	end
end

for _, category in pairs({	"generator",
							}) do
	
	for _, item in pairs(data.raw[category]) do
		if not blacklisted(item.name) then			
			if (string.match(item.name, "steam%-engine")) then
				if not keniras_rp_item_costs then
					factor = 4
				else
					factor = 1
				end
				if data.raw.recipe[item.name] then
					for _, recipe in pairs({	data.raw.recipe[item.name],
												data.raw.recipe[item.name].normal,
												data.raw.recipe[item.name].expensive
											}) do
						if recipe and recipe.ingredients then
							for _, ingredient in pairs(recipe.ingredients) do
								if (ingredient[1] ~= nil and not string.match(ingredient[1], "steam%-engine")) or (ingredient.name ~= nil and not string.match(ingredient.name, "steam%-engine")) then
									if (ingredient[1] ~= nil and string.match(ingredient[1], "gear%-wheel")) or (ingredient.name ~= nil and string.match(ingredient.name, "gear%-wheel")) then
										multiply_ingredient(ingredient, factor)
									else
										multiply_ingredient(ingredient, 2*factor)
									end
								end
							end
						end
						if recipe then
							if recipe.energy_required ~= nil then
								recipe.energy_required = math.max(20, multiply_number(recipe.energy_required, 2))
							else
								recipe.energy_required = 20
							end
						end
					end
				end
			end 
			
			if (string.match(item.name, "steam%-turbine")) then
				if data.raw.recipe[item.name] then						-- avoid issues with yuoki, specifically y-steam-turbine
					for _, recipe in pairs({	data.raw.recipe[item.name],
												data.raw.recipe[item.name].normal,
												data.raw.recipe[item.name].expensive
											}) do
						if recipe and recipe.ingredients then
							for _, ingredient in pairs(recipe.ingredients) do	-- do not multiply required steam engines for modded turbines that use steam engines as a crafting ingredient
								if (ingredient[1] ~= nil and not string.match(ingredient[1], "steam")) or (ingredient.name ~= nil and not string.match(ingredient.name, "steam")) then
										multiply_ingredient(ingredient, 4)
								end
							end
						end
						if recipe and recipe.energy_required then
							recipe.energy_required = multiply_number(recipe.energy_required, 3)
						elseif recipe then
							recipe.energy_required = 20
						end
					end
				end
			end
		end
	end
end

for _, category in pairs({	"boiler",
							}) do
	
	for _, item in pairs(data.raw[category]) do
		if not blacklisted(item.name) then
			--[[if item.effectivity then
				item.effectivity = multiply_number_unit(item.effectivity, 0.5)
			end]]
			--[[if item.fluid_usage_per_tick then
				item.fluid_usage_per_tick = multiply_number(item.fluid_usage_per_tick, 0.5)
			end]]
			
			if (string.match(item.name, "boiler")) then --(string.match(item.name, "steam") and not string.match(item.name, "turbine")) then
				
				if data.raw.recipe[item.name] then
					for _, recipe in pairs({	data.raw.recipe[item.name],
												data.raw.recipe[item.name].normal,
												data.raw.recipe[item.name].expensive
											}) do
						if recipe and recipe.ingredients then
							for _, ingredient in pairs(recipe.ingredients) do
								if (ingredient[1] ~= nil and not string.match(ingredient[1], "boiler")) or (ingredient.name ~= nil and not string.match(ingredient.name, "boiler")) then
									multiply_ingredient(ingredient, 4)
								end
							end
						end
					end
				end
			end
			
			if (string.match(item.name, "heat%-exchanger")) then
				
				if data.raw.recipe[item.name] then
					for _, recipe in pairs({	data.raw.recipe[item.name],
												data.raw.recipe[item.name].normal,
												data.raw.recipe[item.name].expensive
											}) do
						if recipe and recipe.ingredients then
							for _, ingredient in pairs(recipe.ingredients) do
								if (ingredient[1] ~= nil and not string.match(ingredient[1], "exchanger")) or (ingredient.name ~= nil and not string.match(ingredient.name, "exchanger")) then
									multiply_ingredient(ingredient, 4)
								end
							end
						end
					end
				end
			end
		end
	end
end


for _, category in pairs({	"solar-panel",
							}) do
	
	for _, item in pairs(data.raw[category]) do
		if not blacklisted(item.name) then
			if item.production then
				item.production = multiply_number_unit(item.production, krp_solar_multiplier)
			end
			
			if data.raw.recipe[item.name] then
				for _, recipe in pairs({	data.raw.recipe[item.name],
											data.raw.recipe[item.name].normal,
											data.raw.recipe[item.name].expensive
										}) do
					if recipe and recipe.ingredients then
						for _, ingredient in pairs(recipe.ingredients) do
							if (ingredient[1] ~= nil and not string.match(ingredient[1], "solar%-panel")) or (ingredient.name ~= nil and not string.match(ingredient.name, "solar%-panel")) then
								if (ingredient[1] ~= nil and not string.match(ingredient[1], "circuit")) or (ingredient.name ~= nil and not string.match(ingredient.name, "circuit")) then
									multiply_ingredient(ingredient, 0.5)
								else
									multiply_ingredient(ingredient, 2/3)
								end
							end
						end
					end
				end
			end
			
			if data.raw.item[item.name] and data.raw.item[item.name].stack_size then
				data.raw.item[item.name].stack_size = multiply_number(data.raw.item[item.name].stack_size, 6)
			end
		end
	end
end

for _, category in pairs({	"accumulator",
						}) do
	for _, item in pairs(data.raw[category]) do
		if not blacklisted(item.name) then
			item.energy_source.buffer_capacity = multiply_number_unit(item.energy_source.buffer_capacity, 100 * krp_day_multiplier/205)			
			
			-- adjust flow limits but make sure it's still always 25% above what you need to fully charge accumulators during the day
			if item.name ~= "accumulator-capacitor" then
				if item.energy_source.input_flow_limit then
					item.energy_source.input_flow_limit = math.max(1/6*value_number_si(item.energy_source.input_flow_limit), value_number_si(item.energy_source.buffer_capacity)*1.25/(7.2*3600)) .. 'W'
				end
				if item.energy_source.output_flow_limit then
					item.energy_source.output_flow_limit = math.max(1/6*value_number_si(item.energy_source.output_flow_limit), value_number_si(item.energy_source.buffer_capacity)*1.25/(7.2*3600)) .. 'W'
				end
			end
			
			if data.raw.recipe[item.name] then
				for _, recipe in pairs({	data.raw.recipe[item.name],
											data.raw.recipe[item.name].normal,
											data.raw.recipe[item.name].expensive
										}) do
					if recipe and recipe.ingredients then
						for _, ingredient in pairs(recipe.ingredients) do
							if (ingredient[1] ~= nil and not string.match(ingredient[1], "accumulator")) or (ingredient.name ~= nil and not string.match(ingredient.name, "accumulator")) then
									multiply_ingredient(ingredient, 3)
							end 
						end
					end
					if recipe then
						if recipe.energy_required ~= nil then
							recipe.energy_required = math.max(20, multiply_number(recipe.energy_required, 3))
						else
							recipe.energy_required = 20
						end
					end
				end
				if data.raw.item[item.name] and data.raw.item[item.name].stack_size then
					data.raw.item[item.name].stack_size = multiply_number(data.raw.item[item.name].stack_size, 2)
				end
			end
		end
	end
end

for _, item in pairs(data.raw.item) do
	if not blacklisted(item.name) then
		if item.fuel_value ~= nil then
			item.fuel_value = multiply_number_unit(item.fuel_value, 0.5) -- fuel value gets halved again later depending on settings
		end
	end
end

for _, category in pairs({	"assembling-machine",
							}) do
	for _, item in pairs(data.raw[category]) do
		if not blacklisted(item.name) then
			if (string.match(item.name, "centrifuge")) then
				item.energy_usage = multiply_number_unit(item.energy_usage, 2)		-- double energy usage for centrifuges
			end
		end
	end
end


if halve then
	-- double pollution production (per power) to compensate for overall halved power production
	for _, category in pairs({	"assembling-machine",
								"mining-drill",
								"pump",
								"furnace",
								"boiler",
								"pump",
								}) do
		
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				if item.energy_source and item.energy_source.emissions_per_minute then
					item.energy_source.emissions_per_minute = multiply_number(item.energy_source.emissions_per_minute, 2)
				end
				if item.burner and item.burner.emissions_per_minute then
					item.burner.emissions_per_minute = multiply_number(item.burner.emissions_per_minute, 2)
				end
			end
		end
	end

	for _, category in pairs({	"assembling-machine",
								"mining-drill",
								"pump",
								"furnace",
								--"boiler",
								"pump",
								"lamp",
								"beacon",
								}) do
		
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				if item.energy_usage then
					item.energy_usage = multiply_number_unit(item.energy_usage, 0.5)
				end
				--[[if item.energy_consumption then		-- for boilers
					item.energy_consumption = multiply_number_unit(item.energy_consumption, 0.5)
				end]]
				if item.energy_usage_per_tick then
					item.energy_usage_per_tick = multiply_number_unit(item.energy_usage_per_tick, 0.5)
				end
			end
		end
	end



	for _, category in pairs({	"electric-turret",
							}) do
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				if item.energy_source then
					item.energy_source.buffer_capacity = multiply_number_unit(item.energy_source.buffer_capacity, 0.5)
					item.energy_source.input_flow_limit = multiply_number_unit(item.energy_source.input_flow_limit, 0.5)
					if item.energy_source.drain then
						item.energy_source.drain = multiply_number_unit(item.energy_source.drain, 0.5)
					end
				end
				if item.attack_parameters.ammo_type.energy_consumption then
					item.attack_parameters.ammo_type.energy_consumption = multiply_number_unit(item.attack_parameters.ammo_type.energy_consumption, 0.5)
				end
			end
		end
	end

	for _, category in pairs({	"radar",
							}) do
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				item.energy_usage = multiply_number_unit(item.energy_usage, 0.5)
				item.energy_per_sector = multiply_number_unit(item.energy_per_sector, 0.5)
				item.energy_per_nearby_scan = multiply_number_unit(item.energy_per_nearby_scan, 0.5)
			end
		end
	end

	for _, category in pairs({	"inserter",
							}) do
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				if item.energy_source.drain then
					item.energy_source.drain = multiply_number_unit(item.energy_source.drain, 0.5)
				end
				if item.energy_per_movement then
					item.energy_per_movement = multiply_number_unit(item.energy_per_movement, 0.5)
				end
				if item.energy_per_rotation then
					item.energy_per_rotation = multiply_number_unit(item.energy_per_rotation, 0.5)
				end
			end
		end
	end

	for _, category in pairs({	"arithmetic-combinator",
								"decider-combinator"
							}) do
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				item.active_energy_usage = multiply_number_unit(item.active_energy_usage, 0.5)
			end
		end
	end

	for _, category in pairs({	"roboport",
							}) do
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				if item.energy_source and item.energy_source.input_flow_limit and item.energy_source.buffer_capacity then 
					item.energy_source.input_flow_limit = multiply_number_unit(item.energy_source.input_flow_limit, 0.5)
					item.energy_source.buffer_capacity = multiply_number_unit(item.energy_source.buffer_capacity, 0.5)
				end
				item.recharge_minimum = multiply_number_unit(item.recharge_minimum, 0.5)
				item.energy_usage = multiply_number_unit(item.energy_usage, 0.5)
				item.charging_energy = multiply_number_unit(item.charging_energy, 0.5)
			end
		end
	end

	for _, category in pairs({	"construction-robot",
								"logistic-robot"
							}) do
		for _, item in pairs(data.raw[category]) do
			if not blacklisted(item.name) then
				item.max_energy = multiply_number_unit(item.max_energy, 0.5)
				item.energy_per_tick = multiply_number_unit(item.energy_per_tick, 0.5)
				item.energy_per_move = multiply_number_unit(item.energy_per_move, 0.5)
			end
		end
	end

	for _, item in pairs(data.raw.fluid) do
		if not blacklisted(item.name) then
			if item.fuel_value ~= nil then
				item.fuel_value = multiply_number_unit(item.fuel_value, 0.5)
			end
		end
	end
	
	for _, item in pairs(data.raw.item) do
		if not blacklisted(item.name) then
			if item.fuel_value ~= nil then
				item.fuel_value = multiply_number_unit(item.fuel_value, 0.5)
				if item.name ~= "rocket-fuel" then
					item.stack_size = multiply_number(item.stack_size, 2)
				end
			end
		end
	end
end




--require("prototypes.update.reactors")
require("prototypes.update.wind-turbine")
require("prototypes.update.useful-space")
--require("prototypes.update.nucular")
--require("prototypes.update.uranium-power")
require("prototypes.update.ks-power")
require("prototypes.update.yuoki")
require("prototypes.update.bob")
require("prototypes.update.wind-turbines")
require("prototypes.update.science-cost-tweaker")
require("prototypes.update.py")
require("prototypes.update.geothermal")
--require("prototypes.update.scanning-radar")