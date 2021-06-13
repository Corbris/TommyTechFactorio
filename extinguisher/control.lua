local function extinguish_fire(event)
  if event.entity.name == 'extinguisher-remnants' then
    local position = event.entity.position;
    local area_start = {position.x - 1, position.y - 1}
    local area_end = {position.x + 1, position.y + 1}
--    local tile = game.surfaces['nauvis'].get_tile(position.x, position.y)
--    local tile_props = game.surfaces['nauvis'].get_tileproperties(position.x, position.y)

    for _, entity in pairs(event.entity.surface.find_entities{area_start, area_end}) do
      if entity.valid then
        if entity.type == 'fire' then
          entity.destroy()
--        elseif entity.type == 'transport-belt' or tile.name == 'deepwater' or tile.name == 'water' then
--          if event.entity.valid then
--            event.entity.destroy()
--          end
        end

        if event.entity.valid then
          event.entity.destroy()
        end
      end
    end
  end
end

script.on_event(defines.events.on_trigger_created_entity, extinguish_fire)


-------------

function Print(Text)
	game.players[1].print(""..Text)
end

function PrintTab(Table)
	for i,d in pairs(Table) do
		local T = type(d)
		if T == "table" then
			Print("Table: "..i)
			PrintTab(d)
		else
			Print(i.." : "..tostring(d))
		end
	end
end

function PrintTable(Table)
	PrintTab(Table)
end
