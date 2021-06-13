if data.raw["mining-drill"]["geothermal-well"] and halve then
	data.raw["mining-drill"]["geothermal-well"].mining_speed = multiply_number(data.raw["mining-drill"]["geothermal-well"].mining_speed, 0.5)
end