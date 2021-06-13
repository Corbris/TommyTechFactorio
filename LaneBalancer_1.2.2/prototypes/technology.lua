local consts = require("__LaneBalancer__.const")

function Empty()
	return
	{
		filename = consts.graphicsPath.."empty.png",
		priority = "extra-high",
		width = 1,
		height = 1
	}
end

data:extend({
	{
		type = "inserter",
		name = "lane-balancer",
		icon = consts.graphicsPath.."balancer1.png",
		icon_size = 32,
		flags = { "placeable-neutral", "player-creation" },
		minable = { hardness = 0.2, mining_time = 0.5, result = "lane-balancer" },
		max_health = 150,
		corpse = "small-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 90
			}
		},
		working_sound =
		{
			match_progress_to_activity = true,
			sound =
			{
				{
					filename = consts.soundPath.."inserter-basic-1.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-basic-2.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-basic-3.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-basic-4.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-basic-5.ogg",
					volume = 0.75
				}
			}
		},
		collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
		selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
		pickup_position = { 0, 1 },
		insert_position = { 0, -1 },
		energy_per_movement = "0W",
		energy_per_rotation = "0W",
		energy_source =
		{
			type = "void",
		},
		hand_base_picture = Empty(),
		hand_closed_picture = Empty(),
		hand_open_picture = Empty(),
		hand_base_shadow = Empty(),
		hand_closed_shadow = Empty(),
		hand_open_shadow = Empty(),
		platform_picture =
		{
			sheet =
			{
				filename = consts.graphicsPath.."balancer-belt1.png",
				priority = "extra-high",
				width = 64,
				height = 44,
			}
		},
		extension_speed = 1,
		rotation_speed = 1,
		filter_count = 2,
		uses_arm_movement = "basic-inserter",

		circuit_wire_connection_points = circuit_connector_definitions["inserter"].points,
		circuit_connector_sprites = circuit_connector_definitions["inserter"].sprites,
		circuit_wire_max_distance = inserter_circuit_wire_max_distance,
		default_stack_control_input_signal = inserter_default_stack_control_input_signal
	},
	{
		type = "inserter",
		name = "fast-lane-balancer",
		icon = consts.graphicsPath.."balancer2.png",
		icon_size = 32,
		flags = { "placeable-neutral", "player-creation" },
		minable = { hardness = 0.2, mining_time = 0.5, result = "fast-lane-balancer" },
		max_health = 160,
		corpse = "small-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 90
			}
		},
		working_sound =
		{
			match_progress_to_activity = true,
			sound =
			{
				{
					filename = consts.soundPath.."inserter-fast-1.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-2.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-3.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-4.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-5.ogg",
					volume = 0.75
				}
			}
		},
		collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
		selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
		pickup_position = { 0, 1 },
		insert_position = { 0, -1 },
		energy_per_movement = "0W",
		energy_per_rotation = "0W",
		energy_source =
		{
			type = "void",
		},
		hand_base_picture = Empty(),
		hand_closed_picture = Empty(),
		hand_open_picture = Empty(),
		hand_base_shadow = Empty(),
		hand_closed_shadow = Empty(),
		hand_open_shadow = Empty(),
		platform_picture =
		{
			sheet =
			{
				filename = consts.graphicsPath.."balancer-belt2.png",
				priority = "extra-high",
				width = 64,
				height = 44,
			}
		},
		extension_speed = 2,
		rotation_speed = 2,
		filter_count = 2,
		uses_arm_movement = "basic-inserter",

		circuit_wire_connection_points = circuit_connector_definitions["inserter"].points,
		circuit_connector_sprites = circuit_connector_definitions["inserter"].sprites,
		circuit_wire_max_distance = inserter_circuit_wire_max_distance,
		default_stack_control_input_signal = inserter_default_stack_control_input_signal
	},
	{
		type = "inserter",
		name = "express-lane-balancer",
		icon = consts.graphicsPath.."balancer3.png",
		icon_size = 32,
		flags = { "placeable-neutral", "player-creation" },
		minable = { hardness = 0.2, mining_time = 0.5, result = "express-lane-balancer" },
		max_health = 170,
		corpse = "small-remnants",
		resistances =
		{
			{
				type = "fire",
				percent = 90
			}
		},
		working_sound =
		{
			match_progress_to_activity = true,
			sound =
			{
				{
					filename = consts.soundPath.."inserter-fast-1.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-2.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-3.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-4.ogg",
					volume = 0.75
				},
				{
					filename = consts.soundPath.."inserter-fast-5.ogg",
					volume = 0.75
				}
			}
		},
		collision_box = { { -0.29, -0.29 }, { 0.29, 0.29 } },
		selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
		pickup_position = { 0, 1 },
		insert_position = { 0, -1 },
		energy_per_movement = "0W",
		energy_per_rotation = "0W",
		energy_source =
		{
			type = "void",
		},
		hand_base_picture = Empty(),
		hand_closed_picture = Empty(),
		hand_open_picture = Empty(),
		hand_base_shadow = Empty(),
		hand_closed_shadow = Empty(),
		hand_open_shadow = Empty(),
		platform_picture =
		{
			sheet =
			{
				filename = consts.graphicsPath.."balancer-belt3.png",
				priority = "extra-high",
				width = 64,
				height = 44,
			}
		},
		extension_speed = 3,
		rotation_speed = 3,
		filter_count = 2,
		uses_arm_movement = "basic-inserter",

		circuit_wire_connection_points = circuit_connector_definitions["inserter"].points,
		circuit_connector_sprites = circuit_connector_definitions["inserter"].sprites,
		circuit_wire_max_distance = inserter_circuit_wire_max_distance,
		default_stack_control_input_signal = inserter_default_stack_control_input_signal
	},
})
