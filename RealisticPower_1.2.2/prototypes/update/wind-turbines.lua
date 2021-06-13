if data.raw.item["wind-turbine-mk1"] then

for _, ingredient in pairs(data.raw.recipe["wind-turbine-mk1"].ingredients) do
	multiply_ingredient(ingredient, 2)
end

for _, item in pairs({	"wind-turbine-mk1",
						"wind-turbine-mk2",
						"wind-turbine-mk3",
						"wind-turbine-mk4",
						"wind-turbine-mk5",
						"wind-turbine-mk6",
						"wind-turbine-mk7"
						}) do
	if data.raw.item[item] then
		data.raw.recipe[item].energy_required = multiply_number(data.raw.recipe[item].energy_required, 4)
	end
end

end