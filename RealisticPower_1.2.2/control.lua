require("data")

script.on_event(defines.events.on_player_created, function(event)
	local player = game.players[event.player_index]
	player.surface.daytime = 0.5 		-- sets time to midnight when starting
	if remote.interfaces.daynight then
		remote.call("daynight", "multi", keniras_rp_day_multiplier)		
		realistic_power_adjust_day_multiplier = true
	end
end)

--script.on_configuration_changed()

local battery_accumulator = {
	["accumulator"] = true,
	["y-accumulator-s"] = true,
	["y-accumulator-m"] = true,
	["y-accumulator-b"] = true,
	["y-accumulator-s-t2"] = true,
	["y-accumulator-m-t2"] = true,
	["y-accumulator-b-t2"] = true,
	["y-accumulator-m-tx"] = true,
	["y-accumulator-crystal-m"] = true,
	["large-accumulator"] = true,
	["slow-accumulator"] = true,
	["large-accumulator-2"] = true,
	["slow-accumulator-2"] = true,
	["large-accumulator-3"] = true,
	["slow-accumulator-3"] = true,
}

local capacitor_accumulator = {
	["accumulator-capacitor"] = true,
	["y-ups-flywheel-b"] = true,
	["y_compensator_25"] = true,
	["fast-accumulator"] = true,
	["fast-accumulator-2"] = true,
	["fast-accumulator-3"] = true,
}

script.on_init(function()
	if global["accumulators"] == nil then
		global["accumulators"] = {}
	end
end)

script.on_configuration_changed(function()
	if global["accumulators"] == nil then
		global["accumulators"] = {}
	end
	if not realistic_power_adjust_day_multiplier then
		if remote.interfaces.daynight then
			remote.call("daynight", "multi", keniras_rp_day_multiplier)
			realistic_power_adjust_day_multiplier = true
		end
	end
end)



function BuiltEntity(event)
	local e = event.created_entity
	
	if (battery_accumulator[e.name]) then	
		local struct = { accumulator = e }
		struct.drain = e.surface.create_entity{name = "accumulator-drain-1", position = e.position, force = e.force}
		struct.drain.destructible = false
		table.insert(global["accumulators"], struct)
	end

	if (capacitor_accumulator[e.name]) then	
		local struct = { accumulator = e }
		struct.drain = e.surface.create_entity{name = "accumulator-drain-2", position = e.position, force = e.force}
		struct.drain.destructible = false
		table.insert(global["accumulators"], struct)
	end

end


function MinedEntity(event)
	local e = event.entity
	
	if (battery_accumulator[e.name]) or (capacitor_accumulator[e.name]) then	
		local found_struct
		local index

		for key, struct in pairs(global["accumulators"]) do
			if struct.accumulator == e then
				found_struct = struct
				index = key
				break
			end
		end
		table.remove(global["accumulators"], index)
		if found_struct ~= nil then
			found_struct.drain.destroy()
			found_struct.drain = nil
		end
	end
end

script.on_event(defines.events.on_built_entity, BuiltEntity)
script.on_event(defines.events.on_robot_built_entity, BuiltEntity)
script.on_event(defines.events.on_pre_player_mined_item, MinedEntity)
script.on_event(defines.events.on_entity_died, MinedEntity)
script.on_event(defines.events.on_robot_pre_mined , MinedEntity)


--function my_on_tick()
--	if game.tick % 300 == 0 then
--		for _, struct in pairs(global["accumulators"]) do
--			local stored_energy = struct.accumulator.energy
--			local max_stored_energy = struct.accumulator.electric_buffer_size
--			local max_drain = struct.drain.electric_input_flow_limit
--			local drain = max_drain * (stored_energy/max_stored_energy)
--			struct.drain.electric_drain = drain
--		end
--	end
--end
--script.on_event(defines.events.on_tick, my_on_tick)
