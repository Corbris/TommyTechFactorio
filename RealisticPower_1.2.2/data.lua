if not realisticpower then realisticpower = {} end

require("blacklist")
require("functions")

krp_day_multiplier =		settings.startup["keniras-realistic-power-day-multiplier"].value
krp_solar_multiplier =		settings.startup["keniras-realistic-power-solar-multiplier"].value
--krp_generator_multiplier =	settings.startup["keniras-realistic-power-generator-multiplier"].value
krp_item_costs = 			settings.startup["keniras-realistic-power-item-costs"].value
krp_bob_wafer =				settings.startup["keniras-realistic-power-bob-wafer"].value


if settings.startup["Clockwork-mod-accumulators"] and settings.startup["Clockwork-mod-accumulators"].value then
	settings.startup["Clockwork-mod-accumulators"].value = false
	krp_day_multiplier = settings.startup["Clockwork-mod-accumulators-capacity"].value
	--settings.startup["Clockwork-mod-accumulators-capacity"].value = 37
end

--if settings.startup["Clockwork-mod-accumulators"] and settings.startup["Clockwork-mod-accumulators"].value then
--	settings.startup["Clockwork-mod-accumulators-capacity"].value = krp_day_multiplier
--end
--if settings.startup["Clockwork-cycle-length"] and settings.startup["Clockwork-cycle-length"].value then
--	settings.startup["Clockwork-cycle-length"].value = krp_day_multiplier
--end