if GetResourceState("qb-core") ~= 'started' then return end 

QBCore = exports['qb-core']:GetCoreObject()
CaseList = CFG.CaseList 

for k, v in pairs(CaseList) do
    local item = k
    QBCore.Functions.CreateUseableItem(item, function(source, itemData)
        local caseItems = CaseList[item]
        openCase(source, caseItems)
        local Player = QBCore.Functions.GetPlayer(source)
        Player.Functions.RemoveItem(item, 1)
        if not Player.Functions.GetItemByName(item) then return end
    end)
end


function rewardPlayer(source, item)
    local reward = string.lower(item.item)
    local amount = item.amount
    local player = QBCore.Functions.GetPlayer(source)

    if reward == 'money' then
        player.Functions.AddItem("money", amount)
        TriggerClientEvent("loot_cases:client:notfiy", source, "You won $" .. GroupDigits(amount))
    elseif string.match(reward, 'weapon_') then
        player.Functions.AddItem(reward, 1)
        TriggerClientEvent("loot_cases:client:notfiy", source, "You won a " .. GetWeaponLabel(reward))
    else
        player.Functions.AddItem(reward, amount)
        TriggerClientEvent("loot_cases:client:notfiy", source, "You won x" .. amount .. GetItemLabel(reward))
    end
end




function GetItemLabel(item)
    local label = "N/A"
    for k,v in pairs(QBCore.Shared.Items) do
        if k == item then
            label = v.label
        end
    end
    return label
end

function GetWeaponLabel(weapon)
    local weapon = string.lower(weapon)
    local label = "N/A"
    for k,v in pairs(QBCore.Shared.Items) do
        if k == weapon then
            label = v.label
        end
    end
    return label
end


function GroupDigits(value)
    local formatted = tostring(value)
    local k

    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end

    return formatted
end