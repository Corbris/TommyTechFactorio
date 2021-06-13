data:extend({
  {
    type = "item",
    name = "mox-fuel-cell",
    icon = "__SigmaOne_Nuclear__/graphics/items/mox-fuel-cell.png",
    pictures =
    {
      layers =
      {
        {
          size = 64,
          filename = "__SigmaOne_Nuclear__/graphics/items/mox-fuel-cell.png",
          scale = 0.25,
          mipmap_count = 4
        },
        {
          draw_as_light = true,
          blend_mode = "additive",
          size = 64,
          filename = "__SigmaOne_Nuclear__/graphics/items/mox-fuel-cell.png",
          scale = 0.25,
          tint = {r = 0.3, g = 0.3, b = 0.3, a = 0.3},
          mipmap_count = 4
        }
      }
    },
    icon_size = 64, icon_mipmaps = 4,
    flags = {},
    subgroup = "intermediate-product",
    order = "r[uranium-fuel-cell]-a[mox-fuel-cell]",
    fuel_category = "nuclear",
    burnt_result = "used-up-mox-fuel-cell",
    fuel_value = "8.5GJ",
    stack_size = 50
  }
})
