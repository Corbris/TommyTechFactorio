local const = { }

const.graphicsPath = "__LaneBalancer__/graphics/"
const.soundPath = "__base__/sound/"

const.balancerTechs =
{
	["logistics"] = "lane-balancer",
	["logistics-2"] = "fast-lane-balancer",
	["logistics-3"] = "express-lane-balancer",
}

const.balancerTypes =
{
    ["lane-balancer"] = { speed = 8 },
    ["fast-lane-balancer"] = { speed = 4 },
    ["express-lane-balancer"] = { speed = 1 }
}

const.eventsFilter =
{
	{ filter = "name", name = "lane-balancer" },
	{ filter = "name", name = "fast-lane-balancer" },
	{ filter = "name", name = "express-lane-balancer" },
}

const.north = defines.direction.north
const.east = defines.direction.east
const.south = defines.direction.south
const.west = defines.direction.west

const.facingDirections =
{
    [const.north] = const.south,
    [const.east] = const.west,
    [const.south] = const.north,
    [const.west] = const.east
}

return const
