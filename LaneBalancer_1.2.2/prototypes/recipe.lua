data:extend(
{
	{
		type = "recipe",
		name = "lane-balancer",
		enabled = "false",
		energy_required = 1,
		ingredients =
		{
			{ type = "item", name = "electronic-circuit", amount = 3 },
			{ type = "item", name = "iron-plate", amount = 2 },
			{ type = "item", name = "transport-belt", amount = 2 }
		},
		result = "lane-balancer"
	},
	{
		type = "recipe",
		name = "fast-lane-balancer",
		enabled = "false",
		energy_required = 1,
		ingredients =
		{
			{ type = "item", name = "electronic-circuit", amount = 6 },
			{ type = "item", name = "iron-gear-wheel", amount = 4 },
			{ type = "item", name = "lane-balancer", amount = 1 }
		},
		result = "fast-lane-balancer"
	},
	{
		type = "recipe",
		name = "express-lane-balancer",
		category = "crafting-with-fluid",
		enabled = "false",
		energy_required = 1,
		ingredients =
		{
			{ type = "item", name = "advanced-circuit", amount = 4 },
			{ type = "item", name = "iron-gear-wheel", amount = 4 },
			{ type = "item", name = "fast-lane-balancer", amount = 1 },
			{ type = "fluid", name = "lubricant", amount = 30 }
		},
		result = "express-lane-balancer"
	}
})
