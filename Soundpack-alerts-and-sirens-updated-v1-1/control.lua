-- check mod state
script.on_configuration_changed(function(data)
    -- midgame installation
    if data.mod_changes ~= nil and data.mod_changes["Soundpack-alerts-and-sirens"] ~= nil and data.mod_changes["Soundpack-alerts-and-sirens"].old_version == nil then
        -- anounce installation
        notification({"SPAS-notification-midgame-update", {"SPAS-prefix"}, data.mod_changes["Soundpack-alerts-and-sirens"].new_version})

    -- midgame update
    elseif data.mod_changes ~= nil and data.mod_changes["Soundpack-alerts-and-sirens"] ~= nil and data.mod_changes["Soundpack-alerts-and-sirens"].old_version ~= nil then
        local oldver = data.mod_changes["Soundpack-alerts-and-sirens"].old_version
        local newver = data.mod_changes["Soundpack-alerts-and-sirens"].new_version
        notification({"SPAS-notification-new-version", {"SPAS-prefix"}, oldver, newver})
    end
end)

function notification(txt, force)
    if force ~= nil then
        force.print(txt)
    else
        for k, p in pairs (game.players) do
            game.players[k].print(txt)
        end
    end
end