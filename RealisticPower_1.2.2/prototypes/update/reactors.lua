if data.raw.item["reactor-interface"] then				-- check if reactors mod installed


-- multiply ingredients by four except steam engine and increase build time
for _, item in pairs({	--"steam-turbine",
						"peak-turbine",
						"nuclear-reactor",
						"cooling-tower"
						}) do
	if data.raw.item[item] then
		for _, ingredient in pairs(data.raw.recipe[item].ingredients) do
			if (ingredient[1] ~= nil and not string.match(ingredient[1], "steam")) or (ingredient.name ~= nil and not string.match(ingredient.name, "steam")) then
					multiply_ingredient(ingredient, 4)
			end
		end
		data.raw.recipe[item].energy_required = data.raw.recipe[item].energy_required * 3
		if item == "nuclear-reactor" then
		  data.raw.recipe[item].energy_required = data.raw.recipe[item].energy_required * 3
		end
	end
end

table.insert(data.raw.recipe["nuclear-reactor"].ingredients,{"processing-unit", 25})

end