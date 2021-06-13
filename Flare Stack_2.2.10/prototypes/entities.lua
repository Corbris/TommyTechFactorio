local ITEM_BURN_RATE_TOOLTIP = {}
if settings.startup["flare-stack-item-rate"].value == 1 then
  ITEM_BURN_RATE_TOOLTIP = {"flare-tooltips.item-burn-rate-single", settings.startup["flare-stack-item-rate"].value}
else
  ITEM_BURN_RATE_TOOLTIP = {"flare-tooltips.item-burn-rate", settings.startup["flare-stack-item-rate"].value}
end
local FLUID_BURN_RATE_TOOLTIP = {"flare-tooltips.fluid-burn-rate", settings.startup["flare-stack-fluid-rate"].value}

data:extend(
{
  -- Flare Stack *************************************************************************
  {
    type = "furnace",
    name = "flare-stack",
    localised_description = FLUID_BURN_RATE_TOOLTIP,
    icon = "__Flare Stack__/graphics/icon/flare-stack.png",
    icon_size = 32,
    flags = {"placeable-neutral","player-creation"},
    minable = {mining_time = 1, result = "flare-stack"},
    fast_replaceable_group = "fluid-incinerator",
    max_health = 250,
    corpse = "big-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    drawing_box = {{-0.5, -4.0}, {0.5, 0.5}},
    crafting_categories = {"flaring"},
    crafting_speed = 1,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 8
    },
    energy_usage = "1kW",
    ingredient_count = 1,
    source_inventory_size = 0,
    result_inventory_size = 0,
    animation =
    {
      filename = "__Flare Stack__/graphics/entity/flare-stack.png",
      priority="high",
      width = 160,
      height = 160,
      frame_count = 1,
      shift = {1.5, -1.59375}
    },
    working_visualisations =
    {
      {
        animation =
        {
          filename = "__Flare Stack__/graphics/entity/flare-stack-fire.png",
          priority = "extra-high",
          frame_count = 29,
          width = 48,
          height = 105,
          shift = {0, -5},
          run_mode="backward"
        },
        light = {intensity = 1, size = 32},
        constant_speed = true
      }
    },
    vehicle_impact_sound =
    {
      filename = "__base__/sound/car-metal-impact.ogg",
      volume = 0.65
    },
    working_sound =
    {
      sound = { filename = "__base__/sound/oil-refinery.ogg" },
      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
      apparent_volume = 2.5,
    },
    fluid_boxes =
    {
      {
        production_type = "input",
        pipe_picture =
        {
          north =
          {
            filename = "__core__/graphics/empty.png",
            priority = "extra-high",
            width = 1,
            height = 1
          },
          east =
          {
            filename = "__core__/graphics/empty.png",
            priority = "extra-high",
            width = 1,
            height = 1
          },
          south =
          {
            filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north.png",
            priority = "extra-high",
            width = 64,
            height = 64,
            frame_count = 1,
            shift = util.by_pixel(0, -32),
            hr_version = {
              filename = "__base__/graphics/entity/pipe-covers/hr-pipe-cover-north.png",
              priority = "extra-high",
              width = 128,
              height = 128,
              frame_count = 1,
              shift = util.by_pixel(0, -32),
              scale = 0.5
            }
          },
          west =
          {
            filename = "__core__/graphics/empty.png",
            priority = "extra-high",
            width = 1,
            height = 1
          }
        },
        pipe_covers = pipecoverspictures(),
        base_area = settings.startup["flare-stack-fluid-rate"].value / 10,
        base_level = -1,
        pipe_connections =
        {
          { position = {0, -1} }
        }
      -- },
      -- {
        -- production_type = "output",
        -- base_area = 1,
        -- base_level = 1,
        -- pipe_connections = { }
      }
    },
    pipe_covers = pipecoverspictures()
  },
  
  -- Incinerator smoke
  -- trivial_smoke {
    -- name = "incinerator-smoke",
    -- color = {r = 0.3, g = 0.3, b = 0.3, a = 0.3},
    -- duration = 150,
    -- spread_duration = 100,
    -- fade_away_duration = 100,
    -- start_scale = 0.4,
    -- end_scale = 1.5,
    -- affected_by_wind = true
  -- }
  
  {
    type = "trivial-smoke",
    name = "incinerator-smoke",
    duration = 150,
    fade_in_duration = 0,
    fade_away_duration = 100,
    spread_duration = 100,
    start_scale = 0.4,
    end_scale = 1.5,
    color = {r = 0.3, g = 0.3, b = 0.3, a = 0.3},
    cyclic = true,
    affected_by_wind = true,
    animation =
    {
      width = 152,
      height = 120,
      line_length = 5,
      frame_count = 60,
      shift = {-0.53125, -0.4375},
      priority = "high",
      animation_speed = 0.25,
      filename = "__base__/graphics/entity/smoke/smoke.png",
      flags = { "smoke" }
    }
  }
})

-- Incinerator ***************************************************************************
incinerator = (util.table.deepcopy(data.raw["furnace"]["flare-stack"]))
incinerator.name = "incinerator"
incinerator.localised_description = ITEM_BURN_RATE_TOOLTIP
incinerator.icon = "__Flare Stack__/graphics/icon/incinerator.png"
incinerator.minable = {mining_time = 1, result = "incinerator"}
incinerator.fast_replaceable_group = "item-incinerator"
incinerator.crafting_categories = {"incineration"}
incinerator.crafting_speed = settings.startup["flare-stack-item-rate"].value
incinerator.energy_usage = "320kW"
incinerator.working_visualisations = nil
incinerator.animation.filename = "__Flare Stack__/graphics/entity/incinerator.png"
incinerator.energy_source =
{
  type = "burner",
  effectivity = 1,
  fuel_inventory_size = 1,
  emissions_per_minute = 8,
  light_flicker =
  {
    minimum_intensity = 0,
    maximum_intensity = 0
  },    
  smoke =
  {
    {
      name = "incinerator-smoke",
      deviation = {0.1, 0.1},
      frequency = 15,
      north_position = {0.0, -4},
      south_position = {0.0, -4},
      east_position = {0.0, -4},
      west_position = {0.0, -4},
      starting_vertical_speed = 0.08,
      starting_frame_deviation = 60
    }
  }
}
incinerator.source_inventory_size = 1
incinerator.fluid_boxes = nil

-- Electric Incinerator ******************************************************************
eincinerator = (util.table.deepcopy(incinerator))
eincinerator.name = "electric-incinerator"
eincinerator.localised_description = ITEM_BURN_RATE_TOOLTIP
eincinerator.icon = "__Flare Stack__/graphics/icon/electric-incinerator.png"
eincinerator.minable = {mining_time = 1, result = "electric-incinerator"}
eincinerator.fast_replaceable_group = "item-incinerator"
eincinerator.crafting_categories = {"incineration", "fuel-incineration"}
eincinerator.crafting_speed = settings.startup["flare-stack-item-rate"].value
eincinerator.energy_usage = "320kW"
eincinerator.energy_source =
{
  type = "electric",
  usage_priority = "secondary-input",
  emissions_per_minute = 8,
  drain = "0W"
}
eincinerator.working_visualisations =
{
  {
    animation =
    {
      filename = "__Flare Stack__/graphics/entity/electric-incinerator-smoke.png",
      priority = "extra-high",
      frame_count = 29,
      width = 48,
      height = 105,
      shift = {-0.05, -5.65},
      animation_speed = 0.4,
      scale = 1.5,
      run_mode="backward"
    },
    constant_speed = true
  }
}

-- Vent Stack ****************************************************************************
ventstack = (util.table.deepcopy(data.raw["furnace"]["flare-stack"]))
ventstack.name = "vent-stack"
ventstack.localised_description = FLUID_BURN_RATE_TOOLTIP
ventstack.icon = "__Flare Stack__/graphics/icon/vent-stack.png"
ventstack.minable = {mining_time = 1, result = "vent-stack"}
ventstack.fast_replaceable_group = "fluid-incinerator"
ventstack.crafting_categories = {"flaring"}
ventstack.crafting_speed = 1
ventstack.energy_source.emissions_per_minute = 8
ventstack.working_visualisations =
{
  {
    animation =
    {
      filename = "__Flare Stack__/graphics/entity/vent-stack-fumes.png",
      priority = "extra-high",
      frame_count = 29,
      width = 48,
      height = 105,
      shift = {-0.05, -5.65},
      animation_speed = 0.5,
      scale = 1.5,
      run_mode="backward"
    },
    constant_speed = true
  }
}
ventstack.animation.filename = "__Flare Stack__/graphics/entity/vent-stack.png"

data:extend(
{
  incinerator,
  eincinerator,
  ventstack
})