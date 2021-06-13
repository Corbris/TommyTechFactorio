data:extend({
  {
    type = "recipe",
    name = "mox-fuel-reprocessing",
    energy_required = 60,
    enabled = false,
    category = "centrifuging",
    ingredients = {{"used-up-mox-fuel-cell", 5}},
    icon = "__SigmaOne_Nuclear__/graphics/recipes/mox-fuel-reprocessing.png",
    icon_size = 64, icon_mipmaps = 4,
    subgroup = "intermediate-product",
    order = "r[nuclear-fuel-reprocessing]-b[mox-fuel-reprocessing]",
    main_product = "",
    results = {
      {"uranium-238", 2}
    },
    allow_decomposition = false
  }
})
