local const = require("const")

local laneBalancers = { }

--
local function IsValid(entity)
    return entity ~= nil
    and entity.valid
end

--
local function IsLaneBalancer(entity)
    return const.balancerTypes[entity.name] ~= nil
end

--
local function NewLaneBalancer(entity)
    return
    {
        entity = entity,
        unitNumber = entity.unit_number,
        position = entity.position,
        direction = entity.direction,
        speed = const.balancerTypes[entity.name].speed,

        inDevice = nil,
        outDevice = nil,

        isFiltered = false,
        sameFilters = false,
        slots = { }
    }
end

--
local function NewDevice(entity, index1, index2)
    return
    {
        entity = entity,
        unitNumber = entity.unit_number,
        direction = entity.direction,
        laneId = 1,
        lanes =
        {
            entity.get_transport_line(index1),
            entity.get_transport_line(index2)
        }
    }
end

--
local function InitRepository()
	global.LaneBalancer = { }

	for _, type in pairs(const.balancerTypes)
	do
		global.LaneBalancer[type.speed] = { }
	end

    laneBalancers = global.LaneBalancer
end

--
local function UpdateFilters(lb)
    if not IsValid(lb.entity)
    or lb.outDevice == nil
    or not IsValid(lb.outDevice.entity)
    then
        game.print("LaneBalancer: Please lay down 'in' and 'out' devices before configuring filters.")
        game.print("Changes discarded for now.")
        return
    end

    if (lb.outDevice.entity.type == "transport-belt" or lb.outDevice.entity.type == "underground-belt")
    and lb.outDevice.direction == lb.direction
    then
        lb.isFiltered = false
        lb.sameFilters = false
        lb.slots = { }

        for slot = 1, lb.entity.filter_slot_count
        do
            local filter = lb.entity.get_filter(slot)
            if filter ~= nil
            then
                lb.isFiltered = true
            end
            lb.slots[filter or "nil"] = slot
        end
        if lb.isFiltered
        then
            lb.sameFilters = lb.entity.get_filter(1) == lb.entity.get_filter(2)
        end
    end
end

--
local function GetSurfaceLaneBalancers()
    InitRepository()

	for _, surface in pairs(game.surfaces)
	do
		for _, entity in pairs(surface.find_entities_filtered{ name = { "lane-balancer", "fast-lane-balancer", "express-lane-balancer" } })
        do
            if entity.valid
            then
                local lb = NewLaneBalancer(entity)
				UpdateFilters(lb)
				table.insert(global.LaneBalancer[lb.speed], lb)
            else
				if not entity.order_deconstruction(entity.force)
				then
					entity.destroy()
				end
            end
		end
	end

	laneBalancers = global.LaneBalancer
end

--
local function UpdateAnyBalancer(entity)
    if not IsValid(entity)
    then return end

    for _, type in pairs(const.balancerTypes)
    do
        for _, balancer in pairs(laneBalancers[type.speed])
        do
            if balancer.inDevice ~= nil
            and balancer.inDevice.unitNumber == entity.unit_number
            then
                balancer.inDevice = nil
            end
            if balancer.outDevice ~= nil
            and balancer.outDevice.unitNumber == entity.unit_number
            then
                balancer.outDevice = nil
            end
        end
    end
end

--
local function GetBalancer(entity)
    if not IsValid(entity)
    then return nil, nil end

    local type = const.balancerTypes[entity.name]
    if type == nil
    then return nil, nil end

    local unitNumber = entity.unit_number
    for key, balancer in pairs(laneBalancers[type.speed])
    do
        if balancer.unitNumber == unitNumber
        then
            return key, balancer
        end
    end

    return nil, nil
end

--
local function IsSameDirection(lb, entity)
    return entity ~= nil
    and const.facingDirections[entity.direction] ~= nil
    and lb.direction == entity.direction
end

--
local function FindTransportBelt(lb, scanArea)
    return lb.entity.surface.find_entities_filtered({ type = "transport-belt", area = scanArea })[1]
end

--
local function FindUndergroundBelt(lb, scanArea)
    return lb.entity.surface.find_entities_filtered({ type = "underground-belt", area = scanArea })[1]
end

--
local function FindSplitter(lb, scanArea)
    return lb.entity.surface.find_entities_filtered({ type = "splitter", area = scanArea })[1]
end

--
local function OffsetScanPos(lb, offsetDir)
    local scanPos = { x = lb.position.x, y = lb.position.y }
    if lb.direction == const.north
    then
		scanPos.x = scanPos.x + offsetDir
    elseif lb.direction == lb.east
    then
        scanPos.y = scanPos.y + offsetDir
    elseif lb.direction == const.south
    then
        scanPos.x = scanPos.x - offsetDir
    elseif lb.direction == const.west
    then
        scanPos.y = scanPos.y - offsetDir
    end

    return scanPos
end

--
local function IsRightTurn(previousDir, nextDir)
	return (previousDir + 2) % 8 == nextDir % 8
end

--
local function IsLeftTurn(previousDir, nextDir)
	return previousDir % 8 == (nextDir + 2) % 8
end

-- Get points to search for transport belts. Return BoundingBox.
local function GetScanArea(direction, position)
    if direction == const.north
    then
        -- return south scan coords
        return { { x = position.x - 0.3, y = position.y + 1.1 }, { x = position.x + 0.3, y = position.y + 0.8 } }

    elseif direction == const.east
    then
        -- return west scan coords
        return { { x = position.x - 1.1  , y = position.y - 0.3 }, { x = position.x - 0.8, y = position.y + 0.3 } }

    elseif direction == const.south
    then
        -- return north scan coords
        return { { x = position.x - 0.3, y = position.y - 1.1 }, { x = position.x + 0.3, y = position.y - 0.8 } }

    elseif direction == const.west
    then
        -- return east scan coords
        return { { x = position.x + 1.1  , y = position.y - 0.3 }, { x = position.x + 0.8, y = position.y + 0.3 } }
    end

    return { { x = position.x , y = position.y }, { x = position.x , y = position.y } }
end

--
local function SetInDevice(lb, entity, inLaneOffset)
    if not IsValid(entity)
    then return end

    local index1 = 1 + inLaneOffset
    local index2 = 2 + inLaneOffset
    lb.inDevice = NewDevice(entity, index1, index2)
end

--
local function GetInSplitter(lb, entity, offsetDir, inLaneOffset)
    local scanArea = GetScanArea(lb.direction, OffsetScanPos(lb, offsetDir))
    local splitter = FindSplitter(lb, scanArea)
    if splitter ~= nil
    and splitter == entity
    then
        SetInDevice(lb, entity, inLaneOffset)
        return true
    end
    return false
end

--
local function GetInDevice(lb)
    lb.inDevice = nil
    local scanArea = GetScanArea(lb.direction, lb.position)

    -- try to get in transport belt
    local entity = FindTransportBelt(lb, scanArea)
    if IsSameDirection(lb, entity)
    then
        SetInDevice(lb, entity, 0)
        return
    end

    -- try to get in underground belt
    entity = FindUndergroundBelt(lb, scanArea)
    if IsSameDirection(lb, entity)
    and entity.belt_to_ground_type == "output"
    then
        SetInDevice(lb, entity, 0)
        return
    end

    -- try to get in splitter
    entity = FindSplitter(lb, scanArea)
    if IsSameDirection(lb, entity)
    then

        -- try to get left in splitter
        if GetInSplitter(lb, entity, -1.0, 6)
        then return end

        -- try to get right in splitter
        if GetInSplitter(lb, entity, 1.0, 4)
        then return end
    end
end

--
local function SetOutDevice(lb, entity, outLaneMulti, outLaneForced)
    if not IsValid(entity)
    then return end

    local index1 = (1 * outLaneMulti) + outLaneForced
    local index2 = (2 * outLaneMulti) + outLaneForced
    lb.outDevice = NewDevice(entity, index1, index2)
end

--
local function GetOutSplitter(lb, entity, offsetDir)
    local scanArea = GetScanArea(const.facingDirections[lb.direction], OffsetScanPos(lb, offsetDir))
    local splitter = FindSplitter(lb, scanArea)
    if splitter ~= nil
    and splitter == entity
    then
        SetOutDevice(lb, entity, 1, 0)
        return true
    end
    return false
end

--
local function GetOutDevice(lb)
    lb.outDevice = nil
    local scanArea = GetScanArea(const.facingDirections[lb.direction], lb.position)

    -- try to get out transport belt
    local entity = FindTransportBelt(lb, scanArea)
    if entity ~= nil
    then
        if IsRightTurn(lb.direction, entity.direction)
        then
            SetOutDevice(lb, entity, 0, 2)
        elseif IsLeftTurn(lb.direction, entity.direction)
        then
            SetOutDevice(lb, entity, 0, 1)
        elseif lb.direction == const.facingDirections[entity.direction]
        then
            lb.outDevice = nil
        else
            SetOutDevice(lb, entity, 1, 0)
        end
        return
    end

    -- try to get out underground belt
    entity = FindUndergroundBelt(lb, scanArea)
    if IsSameDirection(lb, entity)
    and entity.belt_to_ground_type == "input"
    then
        SetOutDevice(lb, entity, 1, 0)
        return
    end

    -- try to get out splitter
    entity = FindSplitter(lb, scanArea)
    if IsSameDirection(lb, entity)
    then
        -- try to get left out splitter
        if GetOutSplitter(lb, entity, -1.0)
        then return end

        -- try to get right out splitter
        if GetOutSplitter(lb, entity, 1.0)
        then return end
    end
end

--
local function NextLane(device)
    device.laneId = (device.laneId == 1) and 2 or 1
end

--
local function GetContent(device)
    local lane = device.lanes[device.laneId]
    if lane.can_insert_at(0)
    then return { nil, nil } end

    return lane.get_contents()
end

--
local function MoveItem(lb, itemName)
    local outLane = lb.outDevice.lanes[lb.outDevice.laneId]
    if not outLane.can_insert_at_back()
    then return false end

    local inLane = lb.inDevice.lanes[lb.inDevice.laneId]
    local stack = { name = itemName, count = 1 }
    inLane.remove_item(stack)
    outLane.insert_at_back(stack)
    return true
end

--
local function Move(lb, itemName)
    for _ = 1, 2 do
        NextLane(lb.outDevice)
        if MoveItem(lb, itemName)
        then
			return true
		end
	end
	return false
end

--
local function StandardBalancing(lb)
    local itemName
	for _ = 1, 2 do
        itemName, _ = next(GetContent(lb.inDevice))
        if lb.outDevice.direction == lb.direction
        then
            if itemName ~= nil
            then
                if not Move(lb, itemName)
                then return end
            end
            NextLane(lb.inDevice)
		else
            if itemName == nil
            then
                NextLane(lb.inDevice)
            else
                if MoveItem(lb, itemName)
                then
                    NextLane(lb.inDevice)
                end
            end
		end
	end
end

--
local function FilteredBalancing(lb)
    local slot
    for _ = 1, 2 do
        for itemName, _ in pairs(GetContent(lb.inDevice))
        do
            if lb.entity.inserter_filter_mode == "whitelist"
            then
                slot = lb.slots[itemName] or lb.slots["nil"]
                if slot ~= nil
                then
                    if lb.sameFilters
                    then
                        if Move(lb, itemName)
                        then
                            break
                        end
                        return
                    else
                        lb.outDevice.laneId = slot
                        if MoveItem(lb, itemName)
                        then
                            if slot == lb.slots["nil"]
                            then
                                NextLane(lb.inDevice)
                                return
                            end
                            break
                        end
                    end
                end
            else
                if lb.slots[itemName] == nil
                then
                    if Move(lb, itemName)
                    then
                        break
                    end
                    NextLane(lb.inDevice)
                    return
                end
            end
        end
        NextLane(lb.inDevice)
    end
end


--#region Events processing

--
local function OnInit()
    InitRepository()
end

--
local function OnLoad()
    laneBalancers = global.LaneBalancer
end

--
local function OnConfigurationChanged()
    for _, force in pairs(game.forces)
    do
        for tech, recipe in pairs(const.balancerTechs)
        do
            if force.technologies[tech].researched
            then
				force.recipes[recipe].enabled = true
			end
		end
	end
end

--
local function OnNthTick(nthTickEvent)
	local balancers = laneBalancers[nthTickEvent.nth_tick]
    if next(balancers) == nil
    then return end

    local status = { }

    for _, balancer in pairs(balancers)
    do
        if balancer.entity.valid
        then
            status = balancer.entity.get_control_behavior()
            if status == nil
            or not status.disabled
            then
                if balancer.inDevice ~= nil
                and balancer.inDevice.entity.valid
                then
                    if balancer.outDevice ~= nil
                    and balancer.outDevice.entity.valid
                    then
                        if balancer.isFiltered
                        then
                            FilteredBalancing(balancer)
                        else
                            StandardBalancing(balancer)
                        end
                    else
                        GetOutDevice(balancer)
                    end
                else
                    GetInDevice(balancer)
                end
            end
        end
    end
end

--
local function RegisterEvents()
    for _, type in pairs(const.balancerTypes)
    do
        if next(laneBalancers[type.speed]) == nil
        then
            script.on_nth_tick({ type.speed }, nil)
        else
            script.on_nth_tick({ type.speed }, OnNthTick)
        end
    end
end

--
local function OnBuiltEntity(entity)
    if not IsValid(entity)
    or not IsLaneBalancer(entity)
    then return end

	local lb = NewLaneBalancer(entity)
    table.insert(laneBalancers[lb.speed], lb)
    RegisterEvents()
end

--
local function OnMinedEntity(entity)
    if entity == nil
    then return end

    if not IsLaneBalancer(entity)
    then
        UpdateAnyBalancer(entity)
        return
    end

    local key, lb = GetBalancer(entity)
    if lb ~= nil
    then
        table.remove(laneBalancers[lb.speed], key)
        RegisterEvents()
    end
end

--
local function OnPlayerRotatedEntity(entity)
    if not IsValid(entity)
    then return end

    if not IsLaneBalancer(entity)
    then
        UpdateAnyBalancer(entity)
        return
    end

    local _, balancer = GetBalancer(entity)
    if balancer == nil
    then return end

    balancer.direction = entity.direction
    balancer.inDevice = nil
    balancer.outDevice = nil
end

--
local function OnInterfaceGUIClosed(entity)
	if not IsValid(entity)
	or not IsLaneBalancer(entity)
    then return end

    local _, lb = GetBalancer(entity)
    if lb ~= nil
    then
        UpdateFilters(lb)
    end
end

--#endregion


--#region Events Handlers

--
local function OnInitHandler()
    OnInit()
end

--
local function OnLoadHandler()
    OnLoad()
end

--
local function OnConfigurationChangedHandler(event)
	OnConfigurationChanged()
end

--
local function OnBuiltEntityHandler(event)
    OnBuiltEntity(event.created_entity)
end

--
local function OnMinedEntityHandler(event)
    OnMinedEntity(event.entity)
end

--
local function OnPlayerRotatedEntityHandler(event)
    OnPlayerRotatedEntity(event.entity)
end

--
local function OnInterfaceGUIClosedHandler(event)
    OnInterfaceGUIClosed(event.entity)
end

--
local function OnFirstTickHandler(nthTickEvent)
    if global.LaneBalancer == nil
    then
        GetSurfaceLaneBalancers()
    end

    script.on_nth_tick({ 1 }, nil)
    RegisterEvents()
    game.print("LaneBalancer loaded.")
end

--#endregion


--#region Events register

-- startup events
script.on_init(OnInitHandler)
script.on_load(OnLoadHandler)
script.on_configuration_changed(OnConfigurationChangedHandler)

-- action events
script.on_event(defines.events.on_built_entity, OnBuiltEntityHandler, const.eventsFilter)
script.on_event(defines.events.on_robot_built_entity, OnBuiltEntityHandler, const.eventsFilter)

script.on_event(defines.events.on_pre_player_mined_item, OnMinedEntityHandler)
script.on_event(defines.events.on_robot_pre_mined, OnMinedEntityHandler)
script.on_event(defines.events.on_entity_died, OnMinedEntityHandler)

script.on_event(defines.events.on_player_rotated_entity, OnPlayerRotatedEntityHandler)

script.on_event(defines.events.on_gui_closed, OnInterfaceGUIClosedHandler)

-- on first tick event
script.on_nth_tick({ 1 }, OnFirstTickHandler)

--#endregion