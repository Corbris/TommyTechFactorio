data:extend({
	{
	type = "resource",
    name = "fluorine-ore",
    icon = "__SigmaOne_Nuclear__/graphics/items/fluorine-ore.png",
    icon_size = 32,
    flags = {"placeable-neutral"},
    order="a-b-e",
    minable =
    {
      hardness = 0.3,
      mining_particle = "stone-particle",
      mining_time = 2,
      result = "fluorine-ore",
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},
    autoplace =
    {
      control = "fluorine-ore",
      sharpness = 1,
      richness_multiplier = 1500,
      richness_multiplier_distance_bonus = 40,
      richness_base = 500,
      coverage = 0.013,
      peaks =
      {
        {
          noise_layer = "fluorine-ore",
          noise_octaves_difference = -1.5,
          noise_persistence = 0.3,
        },
        {
          influence = -1.0,
          starting_area_weight_optimal = 1,
          starting_area_weight_range = 0,
          starting_area_weight_max_range = 2,
        }
      }
    },
    map_color = {r=242, g=170, b=233},
    stage_counts = {1000, 600, 400, 200, 100, 50, 20, 1},
    stages =
    {
      sheet =
      {
        filename = "__SigmaOne_Nuclear__/graphics/entities/fluorine-ore/fluorine-ore.png",
        priority = "extra-high",
        width = 64,
        height = 64,
        frame_count = 8,
        variation_count = 8,
        hr_version = {
          filename = "__SigmaOne_Nuclear__/graphics/entities/fluorine-ore/hr-fluorine-ore.png",
          priority = "extra-high",
          width = 128,
          height = 128,
          frame_count = 8,
          variation_count = 8,
          scale = 0.5
        }
      }
    }
	}
})
