-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
        -- FIVEM LOOT CASE SCRIPT --
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

-- DISCORD.GG/WDEV

local function OpenCase(itemRewarded, caseItems)
    SetNuiFocus(true, true)
    SendNUIMessage({type = "Open_caseOpener", CaseList = { Title = caseItems.Title, Color = caseItems.Color }, listItem = caseItems.Items, reward = itemRewarded.item})
end


RegisterNetEvent('gg_lootcases:openCase', OpenCase)


RegisterNUICallback('sendBackEnd:getRewards', function()
    SetNuiFocus(false, false)
    SendNUIMessage({type = "Close_caseOpener"})
    TriggerServerEvent('gg_lootcases:rewardPlayer')
end)

AddEventHandler('onClientResourceStart', function (resourceName)
    if(GetCurrentResourceName() ~= resourceName) then
      return
    end
    
    if GetResourceState('ox_inventory') == 'started' then return end
    --[[update the inventory path]]

    SendNUIMessage({
        type = "updateInventoryPath",
        payload = CFG.ItemImgFolder
    })
end)