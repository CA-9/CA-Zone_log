local QBCore = exports['qb-core']:GetCoreObject()

Citizen.CreateThread(function()
    for _, zone in ipairs(Cadev.Zones) do
        local createdZone = CircleZone:Create(zone.coords, zone.radius, {
            name = zone.name,
            useZ = zone.useZ or false,
            debugPoly = zone.debugPoly or false
        })

        if not createdZone then
            print("^1ERROR: Failed to create zone: " .. zone.name .. "^7")
            return
        end

        createdZone:onPlayerInOut(function(isInside)
            if isInside then
                print("Entered zone: " .. zone.name)
                TriggerServerEvent('polyzone:checkItems', zone.name)
            else
                print("Exited zone: " .. zone.name)
            end
        end)
    end
end)

RegisterNetEvent('polyzone:itemsCheckPassed')
AddEventHandler('polyzone:itemsCheckPassed', function(zoneName, itemsDetails)
    local itemsMessage = "Items in inventory: "
    for _, item in ipairs(itemsDetails) do
        itemsMessage = itemsMessage .. string.format("%s (%d), ", item.name, item.count)
    end
    print("You have the required items for zone: " .. zoneName .. ". " .. itemsMessage)
end)

RegisterNetEvent('polyzone:itemsCheckFailed')
AddEventHandler('polyzone:itemsCheckFailed', function(zoneName)
    print("You do not have the required items for zone: " .. zoneName)
end)
