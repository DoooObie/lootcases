if GetResourceState('core') ~= 'started' then return end

ESX = exports.core:getSharedObject()
CaseList = CFG.CaseList

for k, v in pairs(CaseList) do
    local item = k
    ESX.RegisterUsableItem(item, function(source)
        local caseItems = CaseList[item]
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.removeInventoryItem(item, 1)
        openCase(source, caseItems)
    end)
end


-- RegisterCommand('givecase', function(source, args)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     xPlayer.addInventoryItem('common_case', 1)
--     xPlayer.addInventoryItem('uncommon_case', 1)
--     print('Added cases to ' .. xPlayer.getName() .. ' (' .. xPlayer.getIdentifier() .. ')')
-- end)

function rewardPlayer(source, item)
    local reward = string.lower(item.item)
    local amount = item.amount
    local xPlayer = ESX.GetPlayerFromId(source)

    if reward == 'money' then
        xPlayer.addMoney(amount)
        TriggerClientEvent('esx:showNotification', source, 'You won $' .. GroupDigits(amount))
    elseif string.match(reward, 'weapon_') then
        xPlayer.addWeapon(reward, 500)
        TriggerClientEvent('esx:showNotification', source, 'You won a ' .. GetWeaponLabel(reward))
    else
        xPlayer.addInventoryItem(reward, amount)
        TriggerClientEvent('esx:showNotification', source, 'You won a ' .. GetItemLabel(reward))
    end
end

function GroupDigits(amount)
    return ESX.Math.GroupDigits(amount)
end

function GetWeaponLabel(weapon)
    return ESX.GetWeaponLabel(weapon)
end

function GetItemLabel(item)
    return ESX.GetItemLabel(item)
end