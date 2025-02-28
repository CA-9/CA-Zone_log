local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('polyzone:checkItems')
AddEventHandler('polyzone:checkItems', function(zoneName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local zoneConfig = nil

    for _, zone in ipairs(Cadev.Zones) do
        if zone.name == zoneName then
            zoneConfig = zone
            break
        end
    end

    if not zoneConfig then
        print("^1ERROR: Zone config not found for: " .. zoneName .. "^7")
        return
    end

    local hasAllItems = true
    local itemsDetails = {}

    for _, item in ipairs(zoneConfig.requiredItems) do
        local itemCount = Player.Functions.GetItemByName(item.name) and Player.Functions.GetItemByName(item.name).amount or 0
        if itemCount < item.count then
            hasAllItems = false
        end
        table.insert(itemsDetails, { name = item.name, count = itemCount })
    end
    if hasAllItems then
        TriggerClientEvent('polyzone:itemsCheckPassed', src, zoneName, itemsDetails)
        local citizenId = Player.PlayerData.citizenid
        local firstName = Player.PlayerData.charinfo.firstname
        local lastName = Player.PlayerData.charinfo.lastname
        local logMessage = string.format("Player %s %s (CitizenID: %s) entered zone %s with items: ", firstName, lastName, citizenId, zoneName)
        for _, item in ipairs(itemsDetails) do
            logMessage = logMessage .. string.format("%s (%d), ", item.name, item.count)
        end
        TriggerEvent('qb-log:server:CreateLog', 'CA_LOG', 'CA ZONE LOG', 'red', logMessage)
    else
        local citizenId = Player.PlayerData.citizenid
        local firstName = Player.PlayerData.charinfo.firstname
        local lastName = Player.PlayerData.charinfo.lastname
        local logMessage2 = string.format("Player %s %s (CitizenID: %s) entered zone %s without the required items", firstName, lastName, citizenId, zoneName)
        TriggerClientEvent('polyzone:itemsCheckFailed', src, zoneName)
        TriggerEvent('qb-log:server:CreateLog', 'CA_LOG', 'CA ZONE LOG', 'red', logMessage2)
    end
end)
