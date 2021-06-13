if data.raw["generator"]["reactor-turbine-generator-01a"] then				-- if uranium power installed


for _, recipe in pairs({	"nuclear-fission-reactor-3-by-3",
							"nuclear-fission-reactor-5-by-5",
							"reactor-steam-generator-01", 
							"reactor-turbine-generator-01a",
							"reactor-turbine-generator-01b"
							}) do
    for _, ingredient in pairs(data.raw.recipe[recipe].ingredients) do
		multiply_ingredient(ingredient, 4)
    end
    data.raw.recipe[recipe].energy_required = multiply_number(data.raw.recipe[recipe].energy_required, 4)  --20
end


end