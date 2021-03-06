--[[ Copyright (c) 2017 Optera
 * Part of Loader Redux
 *
 * See LICENSE.md in the project directory for license information.
--]]

data:extend({
  {
    type = "recipe",
    name = "loader",
    enabled = false,
    hidden = false,
    energy_required = 5,
    ingredients = {
      {"iron-plate", 10},
      {"electronic-circuit", 10},
      {"inserter", 5},
      {"transport-belt", 5},
    },
    result = "loader"
  },
  {
    type = "recipe",
    name = "fast-loader",
    enabled = false,
    hidden = false,
    energy_required = 5,
    ingredients = {
      {"iron-gear-wheel", 20},
      {"electronic-circuit", 20},
      {"advanced-circuit", 1},
      {"loader", 1},
    },
    result = "fast-loader"
  },
  {
    type = "recipe",
    name = "express-loader",
    category = "crafting-with-fluid",
    enabled = false,
    hidden = false,
    energy_required = 5,
    ingredients = {
      {"iron-gear-wheel", 20},
      {"advanced-circuit", 20},
      {"fast-loader", 1},
      {type="fluid", name="lubricant", amount=80},
    },
    result = "express-loader"
  },
})


-- boblogistics and bobplates change all recipes
if mods["boblogistics"] then
  if mods["bobplates"] then
    data.raw.recipe["loader"].ingredients = {
      {"tin-plate", 10},
      {"electronic-circuit", 5},
      {"inserter", 5},
      {"transport-belt", 2},
    }
    data.raw.recipe["fast-loader"].ingredients = {
      {"bronze-alloy", 10},
      {"steel-gear-wheel", 14},
      {"electronic-circuit", 5},
      {"loader", 1},
    }
    data.raw.recipe["express-loader"].category = nil
    data.raw.recipe["express-loader"].ingredients = {
      {"aluminium-plate", 10},
      {"cobalt-steel-gear-wheel", 14},
      {"cobalt-steel-bearing", 14},
      {"advanced-circuit", 5},
      {"fast-loader", 1},
    }
    data:extend({
      {
        type = "recipe",
        name = "purple-loader",
        enabled = "false",
        energy_required = 5,
        ingredients = {
          {"titanium-plate", 10},
          {"titanium-bearing", 14},
          {"titanium-gear-wheel", 14},
          {"processing-unit", 5},
          {"express-loader", 1},
        },
        result = "purple-loader"
      },
      {
        type = "recipe",
        name = "green-loader",
        enabled = "false",
        energy_required = 5,
        ingredients = {
          {"nitinol-alloy", 10},
          {"nitinol-bearing", 14},
          {"nitinol-gear-wheel", 14},
          {"advanced-processing-unit", 5},
          {"purple-loader", 1},
        },
        result = "green-loader"
      },
    })
  else
    data.raw.recipe["loader"].ingredients = {
      {"iron-plate", 10},
      {"electronic-circuit", 5},
      {"inserter", 5},
      {"transport-belt", 2},
    }
    data.raw.recipe["fast-loader"].ingredients = {
      {"steel-plate", 15},
      {"iron-gear-wheel", 20},
      {"electronic-circuit", 5},
      {"loader", 1},
    }
    data.raw.recipe["express-loader"].category = nil
    data.raw.recipe["express-loader"].ingredients = {
      {"steel-plate", 15},
      {"iron-gear-wheel", 20},
      {"advanced-circuit", 5},
      {"fast-loader", 1},
    }
    data:extend({
      {
        type = "recipe",
        name = "purple-loader",
        enabled = "false",
        energy_required = 5,
        ingredients = {
          {"steel-plate", 15},
          {"iron-gear-wheel", 20},
          {"processing-unit", 5},
          {"express-loader", 1},
        },
        result = "purple-loader"
      },
      {
        type = "recipe",
        name = "green-loader",
        enabled = "false",
        energy_required = 5,
        ingredients = {
          {"steel-plate", 15},
          {"iron-gear-wheel", 20},
          {"processing-unit", 10},
          {"purple-loader", 1},
        },
        result = "green-loader"
      },
    })
  end
end
