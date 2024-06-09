if GetResourceState('qb-core') ~= 'started' then return end

QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("loot_cases:client:notfiy", function(text, textType, length)
    QBCore.Functions.Notify(text, textType, length)
end)