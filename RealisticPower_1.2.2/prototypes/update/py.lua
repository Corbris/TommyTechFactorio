for _,turbine in pairs({	"py-turbine",
							"gasturbinemk01",
							"gasturbinemk02",
							"gasturbinemk03",
						}) do
	if data.raw.generator[turbine] and halve then
		data.raw.generator[turbine].effectivity = multiply_number(data.raw.generator[turbine].effectivity, 0.25)
	end
end
		
tech_add_science_pack("fusion-mk01", "high-tech-science-pack", 1)
tech_add_science_pack("fusion-mk02", "high-tech-science-pack", 3)
tech_add_science_pack("fusion-mk03", "high-tech-science-pack", 5)
tech_add_science_pack("fusion-mk04", "high-tech-science-pack", 5)

tech_multiply_cost("fusion-mk01", 2)
tech_multiply_cost("fusion-mk02", 2)
tech_multiply_cost("fusion-mk03", 2)
tech_multiply_cost("fusion-mk04", 4)

tech_add_prerequisite("fusion-mk01", "nuclear-power")