-- migration to 1.2.0

local balancerTypes =
{
    ["lane-balancer"] = { speed = 8 },
    ["fast-lane-balancer"] = { speed = 4 },
    ["express-lane-balancer"] = { speed = 1 }
}

local function UpdateFilters(lb)
    for slot = 1, lb.entity.filter_slot_count do
        local filter = lb.entity.get_filter(slot)
        if filter then
            lb.isFiltered = true
        end
        lb.slots[filter or "nil"] = slot
    end
    if lb.isFiltered then
        lb.sameFilters = lb.entity.get_filter(1) == lb.entity.get_filter(2)
    end
end

global.LaneBalancer = { }
for _, type in pairs(balancerTypes)
do
    global.LaneBalancer[type.speed] = { }
end

for _, surface in pairs(game.surfaces)
do
    for _, entity in pairs(surface.find_entities_filtered{ name = { "lane-balancer", "fast-lane-balancer", "express-lane-balancer" } })
    do
        local lb =
        {
            entity = entity,
            unitNumber = entity.unit_number,
            position = entity.position,
            direction = entity.direction,
            speed = balancerTypes[entity.name].speed,

            inDevice = nil,
            outDevice = nil,

            isFiltered = false,
            sameFilters = false,
            slots = { }
        }

        if entity.valid
        then
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

game.print("LaneBalancer has been migrated to v1.2.0 data pattern.")
