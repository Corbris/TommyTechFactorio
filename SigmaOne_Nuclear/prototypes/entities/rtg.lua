data:extend({
  {
    type = "electric-energy-interface",
    name = "rtg",
    icon = "__SigmaOne_Nuclear__/graphics/items/rtg.png",
    icon_size = 32,
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "rtg"},
    max_health = 120,
    corpse = "big-remnants",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    enable_gui = false,
    energy_production = "50kW",
    energy_usage = "0kW",
    energy_source = {
      render_no_power_icon = false,
      type = "electric",
      buffer_capacity = "10kJ",
      input_flow_limit = "0kW",
      output_flow_limit = "600kW",
      usage_priority = "primary-output"
    },
    picture =
    {
      layers =
      {
        {
          filename = "__SigmaOne_Nuclear__/graphics/entities/rtg/rtg.png",
          priority = "extra-high",
          scale = 0.4,
          width = 241,
          height = 285,
          shift = {0, -0.1},
        },
        {
          filename = "__SigmaOne_Nuclear__/graphics/entities/rtg/rtg-shadow.png",
          priority = "extra-high",
          draw_as_shadow = true,
          scale = 0.4,
          width = 350,
          height = 193,
          shift = {0.8, 0.7},
        }
      }
    },
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound =
    {
      sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.4
      },
      idle_sound =
      {
        filename = "__base__/sound/electric-furnace.ogg",
        volume = 0.3
      },
      max_sounds_per_type = 5
    }
  },
})
