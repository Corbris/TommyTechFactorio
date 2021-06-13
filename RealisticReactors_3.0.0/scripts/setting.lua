local Setting = {}

local function get_setting(type, key)
	return settings[type][key].value
end


function Setting.startup(key)
	return get_setting('startup', key)
end

function Setting.map(key)
	return get_setting('global', key)
end

function Setting.appearance(key)
	return Setting.startup(key .. "-appearance")
end

function Setting.duration(key)
	return Setting.startup(key .. "-duration")
end

function Setting.reactor_duration(key)
	return Setting.map("reactor-" .. key .. "-duration")
end

function Setting.behavior(key)
	return Setting.map(key .. "-behaviour")
end

function Setting.formula()
	return Setting.map("calculate-stats-function")
end

function Setting.ingos_formula()
	local option = Setting.formula()
	return option == "ingo"
end

function Setting.ownlys_formula()
	local option = Setting.formula()
	return option == "ownly"
end


return Setting -- exports
