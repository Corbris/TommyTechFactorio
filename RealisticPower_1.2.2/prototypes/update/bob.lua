-- bobpower 0.14.0
if bobmods then

	if bobmods.power then

		if data.raw.item["large-accumulator"] then
		  table.insert(data.raw["recipe"]["large-accumulator"].ingredients,{"electronic-circuit", 12})
		end

		if bobs_wafer == 1 then
			if data.raw.item["silicon-wafer"] then
				table.insert(data.raw["technology"]["solar-energy"].prerequisites,"silicon-processing")
				table.insert(data.raw["recipe"]["solar-panel-small"].ingredients,{"silicon-wafer", 4})
				table.insert(data.raw["recipe"]["solar-panel"].ingredients,{"silicon-wafer", 9})
				table.insert(data.raw["recipe"]["solar-panel-large"].ingredients,{"silicon-wafer", 16})
				table.insert(data.raw["recipe"]["solar-panel-small-2"].ingredients,{"silicon-wafer", 8})
				table.insert(data.raw["recipe"]["solar-panel-2"].ingredients,{"silicon-wafer", 18})
				table.insert(data.raw["recipe"]["solar-panel-large-2"].ingredients,{"silicon-wafer", 32})
			end
		end

	end

	if bobmods.plates then
		--data.raw.item["iron-plate"].stack_size = 100
		--data.raw.item["copper-plate"].stack_size = 100
		--data.raw.item["steel-plate"].stack_size = 100
		--data.raw.item["coal"].stack_size = 100
        --
		--data.raw.item["empty-barrel"].stack_size = 10
		--data.raw.item["crude-oil-barrel"].stack_size = 10
		--data.raw.item["raw-wood"].stack_size = 200
		--data.raw.item["wood"].stack_size = 200
	end
	
end -- end of bobpower