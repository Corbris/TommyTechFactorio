--[[
    This was written in an afternoon of boredom by a programmer who knows very little. So if you're here laughing at my code, I don't blame you.
    However if you have improvements I will accept them on github or the factorio mod page discussion.
--]]

script.on_event(defines.events.on_console_chat, function(event)
  game.write_file("ChatLog.log","\r\n[" .. (event.player_index and game.players[event.player_index].name or "Server") .. "]" .. event.message, false, 0)
end)

script.on_event(defines.events.on_player_joined_game, function(event)
  game.write_file("PlayerLog.log","\r\n" .. game.players[event.player_index].name .. " has joined the server.", false, 0)
end)

script.on_event(defines.events.on_player_left_game, function(event)
  game.write_file("PlayerLog.log","\r\n" .. game.players[event.player_index].name .. " has left.", false, 0)
end)

script.on_event(defines.events.on_player_died, function(event)
  local reason = "an unknown force, maybe a landmine or godly power";
  if (event.cause == nil or event.cause == "") then;
  elseif (event.cause.name == "small-worm-turret") then reason = "a Small Worm";
  elseif (event.cause.name == "medium-worm-turret") then reason = "a Medium Worm";
  elseif (event.cause.name == "big-worm-turret") then reason = "a Big Worm";
  elseif (event.cause.name == "small-biter") then reason = "a Small Biter";
  elseif (event.cause.name == "medium-biter") then reason = "a Medium Biter";
  elseif (event.cause.name == "big-biter") then reason = "a Big Biter";
  elseif (event.cause.name == "behemoth-biter") then reason = "a Behemoth Biter";
  elseif (event.cause.name == "small-spitter") then reason = "a Small Spitter";
  elseif (event.cause.name == "medium-spitter") then reason = "a Medium Spitter";
  elseif (event.cause.name == "big-spitter") then reason = "a Big Spitter";
  elseif (event.cause.name == "behemoth-spitter") then reason = "a Behemoth Spitter";
  elseif (event.cause.type == "locomotive" or event.cause.type == "cargo-wagon" or event.cause.type == "fluid-wagon") then reason = "a moving train";
  elseif (event.cause.type == "car") then reason = "a moving car";
  elseif (event.cause.type == "player") then reason = event.cause.player.name;
  elseif (event.cause.name == "gun-turret") then reason = "a Gun Turret";
  elseif (event.cause.name == "laser-turret") then reason = "a Laser Turret";
  elseif (event.cause.name == "flamethrower-turret") then reason = "a Flamethrower Turret";
  elseif (event.cause.name == "artillery-turret") then reason = "a Artillery Turret";
  elseif (event.cause.name == "artillery-wagon") then reason = "a Artillery Wagon";
  end
  game.write_file("PlayerLog.log","\r\n" .. game.players[event.player_index].name .. " was killed by " .. reason .. ".", false, 0)
end)