--[[
Copyright (c) 2019-2020 ZwerOxotnik <zweroxotnik@gmail.com>
Licensed under the MIT licence;

Also, you can find a simplier method in https://github.com/wube/factorio-data/blob/master/core/lualib/event_handler.lua

Script source: https://gitlab.com/ZwerOxotnik/factorio-event-listener

]]--

local last_lib_id = 0
local registered_libraries = {}
local module = {}
module.settings = {}
module.settings.debug_mode = (settings.global["EL_debug-mode"] and settings.global["EL_debug-mode"].value) or false
module.settings.log_mode = (settings.global["EL_logs-mode"] and not settings.global["EL_logs-mode"].value) or true
module.version = "0.9.4"

local function new_log(message)
	if module.settings.log_mode then return end

	log(message)
	if game then
		game.write_file("event_listener", message, true)
	end
end

local function undefined(name)
	local message = "Can't identify the event: '" .. name .. "'"
	new_log(message)
	if module.settings.debug_mode then
		error(message)
	end
end

local all_events_mt = {}
function all_events_mt.__newindex(self, event_id, value)
	if event_id == "lib_id" then return end
	if value == function() end then return
		rawset(self, event_id, nil)
	else
		rawset(self, event_id, value)
	end
	new_log("Event listener has updated a event: '" .. event_id .. "'")

	if script.get_event_handler(event_id) ~= nil then return end
	if type(event_id) == "number" then
		script.on_event(event_id, function(event)
			for _, func in pairs( self[event_id] ) do
				if func(event) then return end
			end
		end)
		new_log("Event listener has handled a event: '" .. event_id .. "'")
	elseif type(event_id) == "string" then
		script.on_event(event_id, function(event)
			for _, func in pairs( self[event_id] ) do
				func(event)
			end
		end)
		new_log("Event listener has handled a event: '" .. event_id .. "'")
	else
		undefined(event_id)
	end
end
local all_events = setmetatable({}, all_events_mt)

local is_nth_tick_attached = {}
local on_nth_tick_mt = {}
function on_nth_tick_mt.__newindex(self, tick, value)
	if tick == "lib_id" then return end
	if value == function() end then return
		rawset(self, tick, nil)
	else
		rawset(self, tick, value)
	end

	if not is_nth_tick_attached[tick] then
		is_nth_tick_attached[tick] = true
		script.on_nth_tick(tick, function(event)
			for _, func in pairs( self[tick] ) do
				func(event)
			end
		end)
	end
end
local on_nth_tick = setmetatable({}, on_nth_tick_mt)

-- This metatable in for case when a event variable is added during events on_load/on_init
local events_mt = {}
function events_mt.__newindex(self, event_id, value)
	rawset(self, event_id, value)
	if all_events[event_id] == nil then all_events[event_id] = {} end
	all_events[event_id][self.lib_id] = value
end

-- This metatable in for case when a event variable is added during events on_load/on_init
local private_on_nth_tick_mt = {}
function private_on_nth_tick_mt.__newindex(self, tick, value)
	rawset(self, tick, value)
	if on_nth_tick[tick] == nil then on_nth_tick[tick] = {} end
	on_nth_tick[tick][self.lib_id] = value
end

local function change_lib(lib)
	if lib.lib_id == nil then
		last_lib_id = last_lib_id + 1
		lib.lib_id = last_lib_id
	end
	lib.on_nth_tick = setmetatable(lib.on_nth_tick or {}, private_on_nth_tick_mt)
	lib.events = setmetatable(lib.events or {}, events_mt)
	rawset(lib.events, "lib_id", lib.events.lib_id or lib.lib_id) -- this is very dirty
	rawset(lib.on_nth_tick, "lib_id", lib.on_nth_tick.lib_id or lib.lib_id) -- this is very dirty
	table.insert(registered_libraries, lib)
end

-- Handle all possible events from libraries for the game
module.add_libraries = function(libraries)
	new_log('Event listener ' .. module.version .. ' adding libs, working inside "' .. script.mod_name .. '"')

	if type(libraries) == 'table' then
		for _, lib in pairs(libraries) do
			change_lib(lib)
		end
	else
		local message = 'Type of libraries is not table type!'
		new_log(message)
		if module.settings.debug_mode then
			error(message)
		end
	end
end

-- Handle all possible events from a lib for the game
module.add_lib = function(lib)
	new_log('Event listener ' .. module.version .. ' adding a lib, working inside "' .. script.mod_name .. '"')

	for _, current in pairs(registered_libraries) do
		if current == lib then
			local message = new_log("Trying to register same lib twice")
			new_log(message)
			if module.settings.debug_mode then
				error(message)
			end
			return
		end
	end

	change_lib(lib)
end

local setup_ran = false
local register_events = function()
	--Sometimes, in special cases, on_init and on_load can be run at the same time. Only register events once in this case.
	if setup_ran then return end

	for _, lib in pairs(registered_libraries) do
		if lib.events then
			for k, func in pairs (lib.events) do
				if k ~= "lib_id" then
					all_events[k] = all_events[k] or {}
					all_events[k][lib.lib_id] = func
				end
			end
		end

		if lib.on_nth_tick then
			for n, func in pairs(lib.on_nth_tick) do
				if n ~= "lib_id" then
					on_nth_tick[n] = on_nth_tick[n] or {}
					on_nth_tick[n][lib.lib_id] = func
				end
			end
		end

		if lib.add_remote_interface then
			lib.add_remote_interface()
		end

		if lib.add_commands then
			lib.add_commands()
		end
	end
end

local function after_register_events()
	if setup_ran then return end

	for _, lib in pairs(registered_libraries) do
		if lib.actions_after_init then
			lib.actions_after_init()
		end
	end
end

local lost_init_events = {}
local lost_load_events = {}
local lost_on_configuration_changed_events = {}
script.on_init(function()
	register_events()
	for _, func in pairs(lost_init_events) do
		func()
	end

	for _, lib in pairs(registered_libraries) do
		if lib.on_init then
			lib.on_init()
		end
	end
	after_register_events()
	setup_ran = true
end)

script.on_load(function()
	register_events()
	for _, func in pairs(lost_load_events) do
		func()
	end

	for _, lib in pairs(registered_libraries) do
		if lib.on_load then
			lib.on_load()
		end
	end
	after_register_events()
	setup_ran = true
end)

script.on_configuration_changed(function()
	for _, func in pairs(lost_on_configuration_changed_events) do
		func()
	end

	for _, lib in pairs(registered_libraries) do
		if lib.on_configuration_changed then
			lib.on_configuration_changed()
		end
	end
end)

script.on_init = function(func)
	table.insert(lost_init_events, func)
end
script.on_load = function(func)
	table.insert(lost_load_events, func)
end
script.on_configuration_changed = function(func)
	table.insert(lost_on_configuration_changed_events, func)
end

-- This is raw method (for dynamic events)
module.update_event = function(lib, event_id)
	all_events[event_id][lib.lib_id] = lib.events[event_id]
end

-- This is raw method (for dynamic events)
module.update_nth_tick = function(lib, tick)
	on_nth_tick[tick][lib.lib_id] = lib.on_nth_tick[tick]
end


-- Gathers events together
-- WIP
module.package_modules = function(modules)
	local new_module = {}
	new_module.included_modules = modules
	new_module.on_nth_tick = {}
	new_module.events = {}
	new_module.on_init = nil
	new_module.on_load = nil
	new_module.on_configuration_changed = nil
	new_module.actions_after_init = nil

	local gathered_tick_events = {}
	local gathered_events = {}
	local gathered_inits = {}
	local gathered_loads = {}
	local gathered_on_configuration_changed = {}
	local gathered_events_after_init = {}
	for _, module in pairs( modules ) do
		for tick, func in pairs( module.on_nth_tick ) do
			if gathered_tick_events[tick] == nil then gathered_tick_events[tick] = {} end
			table.insert(gathered_tick_events[tick], func)
		end
		for id, func in pairs( module.events ) do
			if gathered_events[id] == nil then gathered_events[id] = {} end
			table.insert(gathered_events[id], func)
		end
		for _, func in pairs( module.on_init ) do
			table.insert(gathered_inits, func)
		end
		for _, func in pairs( module.on_load ) do
			table.insert(gathered_loads, func)
		end
		for _, func in pairs( module.on_configuration_changed ) do
			table.insert(gathered_on_configuration_changed, func)
		end
		for _, func in pairs( module.actions_after_init ) do
			table.insert(gathered_events_after_init, func)
		end
	end

	for tick, func in pairs( gathered_tick_events ) do
		table.insert( new_module.on_nth_tick[tick], function(event)
			for _, func in pairs( gathered_tick_events[tick] ) do
				func(event)
			end
		end)
	end
	for id, func in pairs( gathered_events ) do
		table.insert( new_module.events[id], function(event)
			for _, func in pairs( gathered_events[id] ) do
				if func(event) then return end
			end
		end)
	end
	table.insert( new_module.on_init, function(event)
		for _, func in pairs( gathered_inits ) do
			func(event)
		end
	end)
	table.insert( new_module.on_load, function(event)
		for _, func in pairs( gathered_loads ) do
			func(event)
		end
	end)
	table.insert( new_module.on_configuration_changed, function(event)
		for _, func in pairs( gathered_on_configuration_changed ) do
			func(event)
		end
	end)
	table.insert( new_module.actions_after_init, function(event)
		for _, func in pairs( gathered_events_after_init ) do
			func(event)
		end
	end)

	return new_module
end

return module
