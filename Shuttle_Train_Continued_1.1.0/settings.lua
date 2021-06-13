_G.data:extend({
	{
		type = "bool-setting",
		name = "folk-shuttle-add-grids",
		setting_type = "startup",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "folk-shuttle-dot-to-go",
		setting_type = "runtime-per-user",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "folk-shuttle-clear-filters",
		setting_type = "runtime-per-user",
		default_value = true,
	},
	{
		type = "bool-setting",
		name = "mg-shuttle-full-GUI",
		setting_type = "runtime-per-user",
		default_value = false,
	},
	{
		type = "string-setting",
		name = "mg-shuttle-exit-action",
		setting_type = "runtime-per-user",
		default_value = "None",
		allowed_values = { "None", "Hibernate", "Depot", "Manual"}, 
		allow_blank = false,
	},
	{
		type = "string-setting",
		name = "folk-shuttle-ignore-stations",
		setting_type = "runtime-per-user",
		default_value = "",
		allow_blank = true,
	},
	{
		type = "string-setting",
		name = "mg-shuttle-depot-name",
		setting_type = "runtime-per-user",
		default_value = "Shuttle Train Depot",
		allow_blank = false,
	},
	 {
      type = "int-setting",
      name = "mg-shuttle-gui-size",
      setting_type = "runtime-per-user",
      default_value = 10,
      minimum_value = 1,
      maximum_value = 25,
   }
})
