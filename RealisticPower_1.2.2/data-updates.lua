require("prototypes.entity.accumulator")
require("prototypes.entity.accumulator-drain")
require("prototypes.item.accumulator")
require("prototypes.item.accumulator-drain")
require("prototypes.recipe.accumulator")

data.raw["accumulator"]["accumulator"].energy_source.buffer_capacity = "5MJ" 			-- reset capacity to vanilla after DayNightExtender multiplied them


if data.raw["technology"]["electric-energy-accumulators"] then
	table.insert(data.raw["technology"]["electric-energy-accumulators"].effects,{type = "unlock-recipe", recipe = "accumulator-capacitor"})
else
	error("RealisticPower: technology electric-energy-accumulators not found")
end

if data.raw["rocket-silo"]["rocket-silo"] then
	data.raw["rocket-silo"]["rocket-silo"].energy_usage = multiply_number_unit(data.raw["rocket-silo"]["rocket-silo"].energy_usage, 0.5)
	data.raw["rocket-silo"]["rocket-silo"].active_energy_usage = multiply_number_unit(data.raw["rocket-silo"]["rocket-silo"].active_energy_usage, 0.5)
end

-- changes to technologies
--if data.raw["technology"]["nuclear-power"] then
--	if data.raw.tool["production-science-pack"] and data.raw.tool["high-tech-science-pack"] then
--		table.insert(data.raw["technology"]["nuclear-power"].unit.ingredients,{"production-science-pack", 1})
--		table.insert(data.raw["technology"]["nuclear-power"].unit.ingredients,{"high-tech-science-pack", 1})
--	end
--	data.raw["technology"]["nuclear-power"].unit.count = multiply_number(data.raw["technology"]["nuclear-power"].unit.count, 2)
--end

tech_add_science_pack("nuclear-power", "production-science-pack", 1)
if not SCTTweaks then
	tech_add_science_pack("nuclear-power", "high-tech-science-pack", 1)
end
tech_multiply_cost("nuclear-power", 2)

tech_multiply_cost("kovarex-enrichment-process", 2)

if settings.startup["Clockwork-cycle-length"] and settings.startup["Clockwork-cycle-length"].value then
	krp_day_mult = settings.startup["Clockwork-cycle-length"].value
end