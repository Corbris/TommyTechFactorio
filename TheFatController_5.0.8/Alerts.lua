--- Alerts
-- @module Alerts

--- Alerts
-- @type Alerts

local function temporary_station_name(record)
    if record.temporary then
        if record.rail and record.rail.valid then
            return {"gui-train.temporary", util.positiontostr(record.rail.position)}
        else
            return "Temporary"
        end
    else
        return record.station
    end
end

Alerts = {}--luacheck: allow defined top
Alerts.electric_locomotives = {
    ["electric-locomotive-mk1"] = true,
    ["electric-locomotive-mk2"] = true,
    ["electric-locomotive-mk3"] = true,
    ["hybrid-train"] = true
}
Alerts.set_alert = function(trainInfo, type, time, skipUpdate)
    trainInfo.alarm.active = true
    trainInfo.alarm.type = type
    trainInfo.alarm.message = time and ({"msg-alarm-" .. type, time}) or {"msg-alarm-" .. type}
    local schedule = trainInfo.train.schedule
    local records = schedule and schedule.records
    if records and table_size(records) > 0 then
        local current = schedule.current
        local current_record = records[current]

        if type == "noPath" then
            local station = temporary_station_name(current_record)
            trainInfo.alarm.message = {"msg-alarm-" .. type, station}
        end
        if type == "timeToStation" then
            local prev = current == 1 and table_size(schedule.records) or current - 1
            trainInfo.alarm.message = {"msg-alarm-" .. type, time, temporary_station_name(records[prev]), temporary_station_name(records[current])}
        end
    end
    if not skipUpdate then
        Alerts.update_filters()
    end
    if type ~= "noFuel" or trainInfo.alarm.last_message + 600 < game.tick then
        Alerts.alert_force(trainInfo.force, trainInfo)
    end
end

Alerts.check_alerts = function(trainInfo)
    local force = trainInfo.force
    local update = false
    if trainInfo.alarm.arrived_at_signal then
        local signalDuration = global.force_settings[force.name].signalDuration
        if trainInfo.last_state == defines.train_state.wait_signal and trainInfo.alarm.arrived_at_signal == game.tick - signalDuration then
            Alerts.set_alert(trainInfo, "timeAtSignal", signalDuration / 3600)
            update = true
        end
    end
    if trainInfo.alarm.left_station then
        local stationDuration = global.force_settings[force.name].stationDuration
        if trainInfo.alarm.left_station + stationDuration <= game.tick then
            Alerts.set_alert(trainInfo, "timeToStation", stationDuration / 3600)
            update = true
        end
    end
    return update
end

Alerts.check_noFuel = function(trainInfo, skipUpdate)
    if not trainInfo.train or not trainInfo.train.valid then
        return false
    end
    local noFuel = false
    local locos = trainInfo.train.locomotives
    local electric
    local fuel_inventory
    for _, carriage in pairs(locos.front_movers) do
        electric = Alerts.electric_locomotives[carriage.name]
        fuel_inventory = carriage.get_fuel_inventory()
        if (not electric and fuel_inventory and fuel_inventory.is_empty()) or (electric and carriage.energy == 0) then
            noFuel = true
            break
        end
    end
    if not noFuel then
        for _, carriage in pairs(locos.back_movers) do
            electric = Alerts.electric_locomotives[carriage.name]
            fuel_inventory = carriage.get_fuel_inventory()
            if (not electric and fuel_inventory and fuel_inventory.is_empty())
            or (electric and carriage.energy == 0)
            then
                noFuel = true
                break
            end
        end
    end
    local old_noFuel = trainInfo.noFuel
    if noFuel then
        Alerts.set_alert(trainInfo, "noFuel", false, skipUpdate)
    else
        if trainInfo.alarm.active and trainInfo.alarm.type == "noFuel" then
            trainInfo.alarm.active = false
            trainInfo.alarm.type = false
            if not skipUpdate then
                Alerts.update_filters()
            end
        end
    end
    trainInfo.noFuel = noFuel
    return old_noFuel ~= trainInfo.noFuel
end

Alerts.reset_alarm = function(trainInfo)
    trainInfo.alarm.active = false
    trainInfo.alarm.type = false
    trainInfo.alarm.left_station = false
    trainInfo.alarm.arrived_at_signal = false
    trainInfo.alarm.last_message = 0
    TickTable.remove_by_train("updateAlarms", trainInfo.train)
    Alerts.update_filters()
end

Alerts.update_filters = function()
    for _, player in pairs(game.players) do
        if player.connected then
            local guiSettings = global.gui[player.index]
            if guiSettings.filter_alarms then
                guiSettings.filtered_trains = TrainList.get_filtered_trains(player.force, guiSettings)
                guiSettings.pageCount = getPageCount(guiSettings, player)
                if guiSettings.fatControllerGui and guiSettings.fatControllerGui.valid and guiSettings.fatControllerGui.trainInfo then
                    GUI.newTrainInfoWindow(guiSettings, player)
                    GUI.refreshTrainInfoGui(guiSettings, player)
                end
            end
        end
    end
end

Alerts.alert_force = function(force, trainInfo)
    local alarm_type = trainInfo.alarm.type
    for _, player in pairs(force.players) do
        local guiSettings = global.gui[player.index]
        if guiSettings and guiSettings.alarm[alarm_type] then
            player.print(trainInfo.alarm.message)
        end
    end
    trainInfo.alarm.last_message = game.tick
end
