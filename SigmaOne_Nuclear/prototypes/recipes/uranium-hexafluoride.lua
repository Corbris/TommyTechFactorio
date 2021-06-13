data:extend({
  {
    type = "recipe",
    name = "uranium-hexafluoride",
    category = "chemistry",
    crafting_machine_tint =
    {
      primary = {r = 232, g = 155, b = 220, a = 120},
      secondary = {r = 220, g = 140, b = 206, a = 226},
      tertiary = {r = 185, g = 120, b = 174, a = 120},
    },
    energy_required = 5,
    enabled = false,
    subgroup = "raw-material",
    order = "i[uranium-hexafluoride]",
    ingredients =
    {
        {type="item", name="fluorine-ore", amount=6},
        {type="item", name="uranium-ore", amount=1},
    },
    results =
    {
      {type="fluid", name="uranium-hexafluoride", amount=25},
    },
  }
})
