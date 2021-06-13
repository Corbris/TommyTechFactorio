data:extend({
  {
    type = "electric-energy-interface",
    name = "accumulator-drain-1",
    icon = "__base__/graphics/icons/accumulator.png",
	icon_size = 32,
    flags = {"placeable-off-grid", "not-on-map"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "stone-brick"},
    selectable_in_game = false,
    max_health = 50,
    corpse = "small-remnants",
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.0, -0.0}, {0.0, 0.0}},
    vehicle_impact_sound =  {filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "300J",
      usage_priority = "secondary-input",
      input_flow_limit = "300W",
	  drain = "150W",
    },
  },

  {
    type = "electric-energy-interface",
    name = "accumulator-drain-2",
    icon = "__base__/graphics/icons/accumulator.png",
	icon_size = 32,
    flags = {"placeable-off-grid", "not-on-map"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "stone-brick"},
    selectable_in_game = false,
    max_health = 50,
    corpse = "small-remnants",
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.0, -0.0}, {0.0, 0.0}},
    vehicle_impact_sound =  {filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
    energy_source =
    {
      type = "electric",
      buffer_capacity = "30J",
      usage_priority = "secondary-input",
      input_flow_limit = "30W",
	  drain = "15W",
    },
  },

})
