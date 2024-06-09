RegisterNetEvent('gg_lootcases:openCase', function(itemRewarded, caseItems)
    caseOpener(itemRewarded, caseItems)
end)

caseOpener = function(itemRewarded, caseItems)
    SetNuiFocus(true, true)
    SendNUIMessage({type = "Open_caseOpener", CaseList = { Title = caseItems.Title, Color = caseItems.Color }, listItem = caseItems.Items, reward = itemRewarded.item})
end


RegisterNUICallback('sendBackEnd:getRewards', function()
    SetNuiFocus(false, false)
    SendNUIMessage({type = "Close_caseOpener"})
    TriggerServerEvent('gg_lootcases:rewardPlayer')
end)