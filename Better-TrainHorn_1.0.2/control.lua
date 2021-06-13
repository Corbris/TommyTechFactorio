script.on_event(defines.events.on_pre_player_died, function(event)
    if event.cause ~= nil then
        if event.cause.type == 'locomotive' or event.cause.type == 'cargo-wagon' or event.cause.type == 'fluid-wagon' or event.cause.type == 'artillery-wagon' then
			game.play_sound{path="train-horn-sound"}
        end
    end
	
	if event.cause ~= nil then
        if event.cause.type == 'tank' or event.cause.type == 'car' then
			game.play_sound{path="car-horn"}
        end
    end
end)

function playSoundAtEntity(sound, entity)
  entity.surface.play_sound
  {
    path = sound,
    position = entity.position
  }
end

script.on_event("honk-horn", function(event)
	local player = game.players[event.player_index]
	if player.vehicle then
		if player.vehicle.type == 'locomotive' then
			playSoundAtEntity("train-horn-sound", player.vehicle)
		elseif player.vehicle.type == 'car' or player.vehicle.type == 'tank' then
			playSoundAtEntity("car-horn", player.vehicle)
		end
	end
end)