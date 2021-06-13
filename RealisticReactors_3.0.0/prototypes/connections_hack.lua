local math2d = require("math2d")



local function map(t,f)
	local r = {} for k,v in pairs(t) do r[k] = f(v) end return r
end

local function encode(t)
	return table.concat(map(t,tostring), ",")
end

local function appendto(order,rest) -- don't remove order completely
	assert(not string.find(order, "\t"), "order already contains tab!")
	return string.format("%s\t%s", order, rest)
end




local function hack_connections(prototype)
	local connections = {}
	if prototype.heat_buffer then
		for _,connection in ipairs(prototype.heat_buffer.connections or {}) do
			local d = assert(connection.direction, "direction missing")
			local p = assert(connection.position, "position missing")
			p = math2d.position.ensure_xy(p)
			-- append triple
			table.insert(connections, d)
			table.insert(connections, p.x)
			table.insert(connections, p.y)
		end
	end
	prototype.order = appendto(prototype.order or "", encode(connections))
end




for _,type in ipairs{"reactor","heat-pipe"} do
	for _,prototype in pairs(data.raw[type]) do
		hack_connections(prototype)
	end
end

