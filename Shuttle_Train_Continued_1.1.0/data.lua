require("style")

do
	local data = _G.data

	local input = {
		type = "custom-input",
		name = "shuttle-lite-call-nearest",
		key_sequence = "CONTROL + J",
		consuming = "none",
	}

	local input2 = {
		type = "custom-input",
		name = "last-shuttle-to-depot",
		key_sequence = "CONTROL + SHIFT + J",
		consuming = "none",
	}

	local left = {
		type = "recipe",
		name = "shuttle-left",
		icon = "__Shuttle_Train_Continued__/graphics/left.png",
		icon_size = 32,
		enabled = false,
		energy_required = 300,
		ingredients = {
			{"coal", 1},
		},
		result = "iron-plate"
	}

	local right = {
		type = "recipe",
		name = "shuttle-right",
		icon = "__Shuttle_Train_Continued__/graphics/right.png",
		icon_size = 32,
		enabled = false,
		energy_required = 300,
		ingredients = {
			{"coal", 1},
		},
		result = "iron-plate"
	}

	local cat = {
		type = "equipment-category",
		name = "shuttle-lite"
	}

	local grid = {
		type = "equipment-grid",
		name = "shuttle-lite",
		width = 2,
		height = 2,
		equipment_categories = { "shuttle-lite" },
	}

	local recipe = {
		type = "recipe",
		name = "shuttle-lite",
		enabled = false,
		energy_required = 10,
		ingredients = {
			{"electronic-circuit", 10},
			{"iron-gear-wheel", 40},
			{"steel-plate", 20},
			-- {"solar-panel-equipment", 1},
			-- {"battery-equipment", 1},
			-- {"personal-roboport-equipment", 1},
			-- {"decider-combinator", 1}
		},
		result = "shuttle-lite"
	}

	local item = {
		type = "item",
		name = "shuttle-lite",
		icon = "__Shuttle_Train_Continued__/graphics/icon.png",
		icon_size = 32,
		placed_as_equipment_result = "shuttle-lite",
		
		subgroup = "equipment",
		order = "f[shuttle]-a[shuttle-lite]",
		stack_size = 5,
	}

	local eq = table.deepcopy(data.raw["solar-panel-equipment"]["solar-panel-equipment"])
	eq.name = "shuttle-lite"
	eq.take_result = "shuttle-lite"
	eq.sprite.filename = "__Shuttle_Train_Continued__/graphics/icon.png"
	eq.shape.width = 2
	eq.shape.height = 2
	eq.power = "100W"
	eq.categories = {"shuttle-lite"}

	local tech = {
		type = "technology",
		name = "shuttle-lite",
		icon = "__Shuttle_Train_Continued__/graphics/tech.png",
		icon_size = 128,
		effects = {
			{
				type = "unlock-recipe",
				recipe = "shuttle-lite"
			}
		},
		prerequisites = {"automated-rail-transportation"},
		unit =
		{
			count = 70,
			ingredients =
			{
				{"automation-science-pack", 2},
				{"logistic-science-pack", 1},
			},
			time = 20
		},
		order = "c-g-b-a"
	}

	data:extend({left, right, cat, grid, recipe, item, eq, tech, input, input2})

end
