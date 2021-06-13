local consts = require("__LaneBalancer__.const")

data:extend(
{
	{
		type = "item",
		name = "lane-balancer",
		icon = consts.graphicsPath.."balancer1.png",
		icon_size = 32,
		subgroup = "belt",
		order = "e[balancer]-a[lane-balancer]",
		place_result = "lane-balancer",
		stack_size = 50
	},
	{
		type = "item",
		name = "fast-lane-balancer",
		icon = consts.graphicsPath.."balancer2.png",
		icon_size = 32,
		subgroup = "belt",
		order = "e[balancer]-b[fast-lane-balancer]",
		place_result = "fast-lane-balancer",
		stack_size = 50
	},
{
		type = "item",
		name = "express-lane-balancer",
		icon = consts.graphicsPath.."balancer3.png",
		icon_size = 32,
		subgroup = "belt",
		order = "e[balancer]-c[express-lane-balancer]",
		place_result = "express-lane-balancer",
		stack_size = 50
	}
})
