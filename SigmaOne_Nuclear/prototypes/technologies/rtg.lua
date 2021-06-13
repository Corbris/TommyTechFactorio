data:extend({
  {
    type = "technology",
    name = "rtg",
    icon_size = 128,
    icon = "__SigmaOne_Nuclear__/graphics/technologies/rtg.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "rtg"
      }
    },
    prerequisites = {"nuclear-fuel-reprocessing"},
    unit =
    {
      ingredients =
      {
        {"automation-science-pack", 2},
        {"chemical-science-pack", 1}
      },
      time = 30,
      count = 500
    },
    order = "e-p-b-c"
  },
})
