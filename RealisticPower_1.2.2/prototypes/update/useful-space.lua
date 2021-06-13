if data.raw["generator"]["energy-receiver"] and halve then
	data.raw["generator"]["energy-receiver"].effectivity = multiply_number(data.raw["generator"]["energy-receiver"].effectivity, 0.5)	-- base 44, 11 not tested yet (NOTE: effectivity of all generators already halved in data-final-fixes)
end