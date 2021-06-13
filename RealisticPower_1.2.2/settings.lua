data:extend(
{
	{
	type = "int-setting",
	name = "keniras-realistic-power-day-multiplier",
	setting_type = "startup",
	default_value = 205,
	minimum_value = 1,
	maximum_value = 2050,
	order = "a",
	},
	{
    type = "double-setting",
    name = "keniras-realistic-power-solar-multiplier",
    setting_type = "startup",
    default_value = 0.18,
	minimum_value = 0.001,
    maximum_value = 100,
    order = "a2",
    },
	{
	type = "bool-setting",
	name = "keniras-realistic-power-bob-wafer",
	setting_type = "startup",
	default_value = true,
	order = "b",
	},
	{
	type = "bool-setting",
	name = "keniras-realistic-power-item-costs",
	setting_type = "startup",
	default_value = false,
	order = "z",
	},
}
)