require("prototypes.recipe.entity-recipe-updates")
require("prototypes.technology-updates")
require("prototypes.productivity-limitations")


data.raw.character.character.inventory_size = settings.startup["bobmods-plates-inventorysize"].value

if data.raw["god-controller"] and data.raw["god-controller"]["default"] then
  data.raw["god-controller"]["default"].inventory_size = settings.startup["bobmods-plates-inventorysize"].value
end


--Electrolyser power
if settings.startup["bobmods-plates-expensive-electrolysis"].value == true then
  data.raw["assembling-machine"]["electrolyser"].energy_usage = "1050kW"
end

--change icons.
if settings.startup["bobmods-colorupdate"].value == true then
  data.raw.item["battery"].icon = "__bobplates__/graphics/icons/battery-red.png"
  data.raw.item["battery"].icon_size = 64
  data.raw.item["battery"].icon_mipmaps = nil
  data.raw.recipe["battery"].crafting_machine_tint.primary = {r = 1.0, g = 0.2, b = 0.1, a = 1.000}

  data.raw.item["lithium-ion-battery"].icon = "__bobplates__/graphics/icons/battery-blue.png"
  data.raw.item["lithium-ion-battery"].icon_size = 64
  data.raw.recipe["lithium-ion-battery"].crafting_machine_tint.primary = {r = 0.1, g = 0.5, b = 1.0, a = 1.000}

  data.raw.item["silver-zinc-battery"].icon = "__bobplates__/graphics/icons/battery-purple.png"
  data.raw.item["silver-zinc-battery"].icon_size = 64
  data.raw.recipe["silver-zinc-battery"].crafting_machine_tint.primary = {r = 0.7, g = 0.9, b = 1.0, a = 1.000}
else
  data.raw.item["battery"].icon = "__bobplates__/graphics/icons/battery.png"
  data.raw.item["battery"].icon_size = 64
end


-- small storage tank recipe move.
if data.raw["item-subgroup"]["bob-storage-tank"] then
  data.raw.item["bob-small-storage-tank"].subgroup = "bob-storage-tank"
  data.raw.item["bob-small-inline-storage-tank"].subgroup = "bob-storage-tank"
end

-- add Assembling Machine catagory.
bobmods.lib.machine.type_if_add_category("assembling-machine", "crafting", "crafting-machine")
bobmods.lib.machine.type_if_add_category("assembling-machine", "crafting-with-fluid", "distillery") -- Adds distilling recipies to assembling machines that can handle fluids
bobmods.lib.machine.type_if_add_category("assembling-machine", "chemistry", "distillery") -- Adds distilling recipies to chemical plants

-- Water mining category, add to pumpjacks
bobmods.lib.machine.type_if_add_resource_category("mining-drill", "basic-fluid", "water")

-- Reduce cost of Steel and new Steel
if settings.startup["bobmods-plates-cheapersteel"].value == true then
  if settings.startup["bobmods-plates-newsteel"].value == true then
    data:extend({
    {
      type = "recipe",
      name = "steel-plate",
      category = "chemical-furnace",
      normal =
      {
        enabled = false,
        energy_required = 3.2,
        ingredients =
        {
          {"iron-plate", 1},
          {type = "fluid", name = "oxygen", amount = 10}
        },
        result = "steel-plate"
      },
      expensive =
      {
        enabled = false,
        energy_required = 6.4,
        ingredients =
        {
          {"iron-plate", 2},
          {type = "fluid", name = "oxygen", amount = 12.5}
        },
        result = "steel-plate"
      },
      allow_decomposition = false
    }})
  else
    data:extend({
    {
      type = "recipe",
      name = "steel-plate",
      category = "smelting",
      normal =
      {
        enabled = false,
        energy_required = 6.4,
        ingredients =
        {
          {"iron-plate", 2},
        },
        result = "steel-plate"
      },
      expensive =
      {
        enabled = false,
        energy_required = 12.8,
        ingredients =
        {
          {"iron-plate", 4},
        },
        result = "steel-plate"
      },
      allow_decomposition = false
    }})
  end

  if data.raw.recipe["metallurgy-steel-plate"] then
    if data.raw.fluid["molten-carbonated-iron"] then
      data.raw.recipe["metallurgy-steel-plate"].energy_required = 0.4
      data.raw.recipe["metallurgy-steel-plate"].ingredients = {{type="fluid", name="molten-carbonated-iron", amount=15},{type="fluid", name="water", amount=20}}
    end
  end
else
  if settings.startup["bobmods-plates-newsteel"].value == true then
    data:extend({
    {
      type = "recipe",
      name = "steel-plate",
      category = "chemical-furnace",
      normal =
      {
        enabled = false,
        energy_required = 16,
        ingredients =
        {
          {"iron-plate", 5},
          {type = "fluid", name = "oxygen", amount = 50}
        },
        result = "steel-plate",
        result_count = 2
      },
      expensive =
      {
        enabled = false,
        energy_required = 16,
        ingredients =
        {
          {"iron-plate", 5},
          {type = "fluid", name = "oxygen", amount = 50}
        },
        result = "steel-plate"
      },
      allow_decomposition = false
    }})
  end
end


if settings.startup["bobmods-plates-batteryupdate"].value == true then
  data.raw.technology["battery"].prerequisites = {"sulfur-processing", "plastics"}
  data.raw.recipe["battery"].normal.ingredients = {{"lead-plate", 2}, {type="fluid", name="sulfuric-acid", amount=20}, {"plastic-bar", 1}}
  data.raw.recipe["battery"].expensive.ingredients = {{"lead-plate", 2}, {type="fluid", name="sulfuric-acid", amount=40}, {"plastic-bar", 2}}
end

if settings.startup["bobmods-plates-newsteel"].value == true then
  data.raw.recipe["steel-plate"].category = "chemical-furnace"
  bobmods.lib.tech.add_prerequisite("steel-processing", "electrolysis-1")
  bobmods.lib.tech.add_prerequisite("steel-processing", "chemical-processing-1")
end

--Nuclear fuel update.
data.raw.item["uranium-fuel-cell"].fuel_glow_color = {r = 0, g = 1, b = 0}

if settings.startup["bobmods-plates-nuclearupdate"].value == true then
  bobmods.lib.recipe.replace_ingredient("uranium-fuel-cell", "iron-plate", "empty-nuclear-fuel-cell")

  data.raw.technology["nuclear-fuel-reprocessing"].icon = "__bobplates__/graphics/icons/technology/uranium-nuclear-fuel-reprocessing-new.png"
  data.raw.technology["nuclear-fuel-reprocessing"].icon_size = 128
  data.raw.technology["nuclear-fuel-reprocessing"].icon_mipmaps = nil

  data.raw.recipe["nuclear-fuel-reprocessing"].icon = "__bobplates__/graphics/icons/nuclear/nuclear-fuel-reprocessing.png"
  data.raw.recipe["nuclear-fuel-reprocessing"].icon_size = 32
  data.raw.recipe["nuclear-fuel-reprocessing"].icon_mipmaps = nil
  data.raw.recipe["nuclear-fuel-reprocessing"].crafting_machine_tint.secondary = {r=1, g=0.7, b=0} --Right hand module glows plutonium orange-yellow.

  data.raw.recipe["nuclear-fuel-reprocessing"].energy_required = 120 --up from 60
  if data.raw.recipe["nuclear-fuel-reprocessing"].normal then -- just in case someone split it to multiple difficulties.
    data.raw.recipe["nuclear-fuel-reprocessing"].normal.energy_required = 120
  end
  if data.raw.recipe["nuclear-fuel-reprocessing"].expensive then
    data.raw.recipe["nuclear-fuel-reprocessing"].expensive.energy_required = 120
  end

  bobmods.lib.recipe.add_ingredient("nuclear-fuel-reprocessing", {"used-up-uranium-fuel-cell", 5}) -- +5 from base
  bobmods.lib.recipe.set_result("nuclear-fuel-reprocessing", {type="item", name="uranium-238", amount=6, catalyst_amount=5})

  bobmods.lib.recipe.add_result("nuclear-fuel-reprocessing", {type="item", name="empty-nuclear-fuel-cell", amount=10, catalyst_amount=10})
  bobmods.lib.recipe.add_result("nuclear-fuel-reprocessing", {type="item", name="uranium-235", amount=1, probability=0.2})
  bobmods.lib.recipe.add_result("nuclear-fuel-reprocessing", {type="item", name="plutonium-239", amount=1, probability=0.8})
  bobmods.lib.recipe.add_result("nuclear-fuel-reprocessing", {type="item", name="fusion-catalyst", amount=1})
else
  bobmods.lib.recipe.replace_ingredient("uranium-fuel-cell", "iron-plate", "lead-plate")

  bobmods.lib.recipe.set_result("nuclear-fuel-reprocessing", {type="item", name="uranium-238", amount=3, catalyst_amount=2})
  bobmods.lib.recipe.add_result("nuclear-fuel-reprocessing", {type="item", name="lead-plate", amount=5, catalyst_amount=5})
  bobmods.lib.recipe.add_result("nuclear-fuel-reprocessing", {type="item", name="plutonium-239", amount=1, probability=0.1})
end



data.raw["item-subgroup"]["fill-barrel"].group = "bob-fluid-products"
data.raw["item-subgroup"]["empty-barrel"].group = "bob-fluid-products"

for i, recipe in pairs(data.raw.recipe) do
  if (string.sub(recipe.name, 1, 5) == "fill-" or string.sub(recipe.name, 1, 6) == "empty-") and recipe.category == "crafting-with-fluid" then
    data.raw.recipe[recipe.name].category = "barrelling"
  end
end



bobmods.lib.create_gas_bottle(data.raw.fluid["hydrogen"])
bobmods.lib.create_gas_bottle(data.raw.fluid["oxygen"])
bobmods.lib.create_gas_bottle(data.raw.fluid["nitrogen"])
bobmods.lib.create_gas_bottle(data.raw.fluid["chlorine"])
bobmods.lib.create_gas_bottle(data.raw.fluid["hydrogen-chloride"])
bobmods.lib.create_gas_bottle(data.raw.fluid["nitrogen-dioxide"])
bobmods.lib.create_gas_bottle(data.raw.fluid["sulfur-dioxide"])

bobmods.lib.create_gas_bottle(data.raw.fluid["deuterium"])
bobmods.lib.create_gas_bottle(data.raw.fluid["hydrogen-sulfide"])



if settings.startup["bobmods-plates-vanillabarrelling"].value == true then
  bobmods.lib.machine.type_if_add_category("assembling-machine", "crafting-with-fluid", "barrelling") -- Adds barrelling to assembling machines
  bobmods.lib.machine.type_if_add_category("assembling-machine", "crafting-with-fluid", "air-pump") -- Adds barrelling to assembling machines
end
data.raw.item["petroleum-gas-barrel"] = nil
data.raw.recipe["fill-petroleum-gas-barrel"] = nil
data.raw.recipe["empty-petroleum-gas-barrel"] = nil
bobmods.lib.create_gas_bottle(data.raw.fluid["petroleum-gas"])


if settings.startup["bobmods-plates-purewater"].value == true then
  bobmods.lib.resource.remove_result("ground-water", "water")
  bobmods.lib.resource.add_result("ground-water", { type = "fluid", name = "pure-water", amount = 10, probability = 1})

  bobmods.lib.recipe.replace_ingredient("water-electrolysis", "water", "pure-water")
  bobmods.lib.recipe.replace_ingredient("salt-water-electrolysis", "water", "pure-water")
  bobmods.lib.recipe.replace_ingredient("lithium-water-electrolysis", "water", "pure-water")

  bobmods.lib.recipe.remove_result("bob-heavy-water", "water") -- There is no replace_result.
  bobmods.lib.recipe.add_result("bob-heavy-water", {type = "fluid", name = "pure-water", amount = 99.5})

  bobmods.lib.tech.add_recipe_unlock("electrolysis-1", "bob-distillery")
  bobmods.lib.tech.add_recipe_unlock("electrolysis-1", "pure-water")
  bobmods.lib.tech.add_recipe_unlock("electrolysis-1", "pure-water-from-lithia")
end


local function set_canister(name, colour)
  data.raw.item[name .. "-barrel"].icons = {
    {
      icon = "__bobplates__/graphics/icons/empty-canister.png",
      icon_size = 32,
      tint = colour
    }
  }
  data.raw.item[name .. "-barrel"].localised_name = {"item-name.filled-canister", {"fluid-name." .. name}}
  data.raw.item[name .. "-barrel"].stack_size = 10

  data.raw.recipe["fill-" .. name .. "-barrel"].icons = {
    {
      icon = "__bobplates__/graphics/icons/empty-canister.png",
      icon_size = 32,
      tint = colour
    },
    {
      icon = data.raw.fluid[name].icon,
      icon_size = data.raw.fluid[name].icon_size,
      scale = 16.0 / data.raw.fluid[name].icon_size,
      shift = {-4, -8}
    }
  }
  data.raw.recipe["fill-" .. name .. "-barrel"].energy_required = 0.2
  data.raw.recipe["fill-" .. name .. "-barrel"].ingredients = {{type = "fluid", name = name, amount = 50}, {type = "item", name = "empty-canister", amount = 1}}
  data.raw.recipe["fill-" .. name .. "-barrel"].localised_name = {"recipe-name.fill-canister", {"fluid-name." .. name}}

  data.raw.recipe["empty-" .. name .. "-barrel"].icons = {
    {
      icon = "__bobplates__/graphics/icons/empty-canister.png",
      icon_size = 32,
      tint = colour
    },
    {
      icon = data.raw.fluid[name].icon,
      icon_size = data.raw.fluid[name].icon_size,
      scale = 16.0 / data.raw.fluid[name].icon_size,
      shift = {8, 8}
    }
  }
  data.raw.recipe["empty-" .. name .. "-barrel"].energy_required = 0.2
  data.raw.recipe["empty-" .. name .. "-barrel"].results = {{type = "fluid", name = name, amount = 50}, {type = "item", name = "empty-canister", amount = 1}}
  data.raw.recipe["empty-" .. name .. "-barrel"].localised_name = {"recipe-name.empty-filled-canister", {"fluid-name." .. name}}
end


set_canister("liquid-fuel", {r = 0.9, g = 0.2, b = 0})
set_canister("ferric-chloride-solution", {r = 0.5, g = 0.4, b = 0.3})



data.raw.fluid["petroleum-gas"].gas_temperature = -42
data.raw.fluid["petroleum-gas"].flow_color = {r=0.6, g=0.2, b=0.6}

data.raw.fluid["crude-oil"].fuel_value = "1.9MJ" --"3.8MJ"
data.raw.fluid["crude-oil"].emissions_multiplier = 10
data.raw.fluid["light-oil"].fuel_value = "1.5MJ" --"3MJ"
data.raw.fluid["light-oil"].emissions_multiplier = 2
data.raw.fluid["heavy-oil"].fuel_value = "1MJ" --"2MJ"
data.raw.fluid["heavy-oil"].emissions_multiplier = 3
data.raw.fluid["petroleum-gas"].fuel_value = "2.3MJ" --"4.6MJ"

data.raw.item["coal"].fuel_emissions_multiplier = 2
data.raw.item["solid-fuel"].fuel_emissions_multiplier = 0.8
data.raw.item["rocket-fuel"].fuel_emissions_multiplier = 1.2
data.raw.item["nuclear-fuel"].fuel_emissions_multiplier = 5




-- Stack Sizes
data.raw.item["iron-plate"].stack_size = 200
data.raw.item["copper-plate"].stack_size = 200
data.raw.item["steel-plate"].stack_size = 200
data.raw.item["coal"].stack_size = 200
data.raw.item["uranium-ore"].stack_size = 200
data.raw.item["sulfur"].stack_size = 200
data.raw.item["wood"].stack_size = 200




