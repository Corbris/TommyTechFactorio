if sciencecosttweaker and halve then
	for _, category in pairs({	"lab",
								}) do
	
		for _, item in pairs(data.raw[category]) do
			if item.energy_usage then
				item.energy_usage = multiply_number_unit(item.energy_usage, 0.5)
			end
		end
	end
end