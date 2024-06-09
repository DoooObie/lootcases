local rarityWeights = CFG.RarityChance
local caseItemsWon = {}

local function getRandomIndex(totalWeight, caseitems)
    local randomChance = math.random(1, totalWeight)
    local cumulativeWeight = 0
    local items = caseitems.Items
    local count = #items

    for i = 1, #count do
        local item = items[i].rarity
        cumulativeWeight += rarityWeights[item]
        if randomChance <= cumulativeWeight then
            return i
        end
    end

    return count
end

local function LogCrateOpening(source, caseRarity, itemAmount, itemLabel)
    return PerformHttpRequest(S_CFG.OpeningWebhook, function() end, 'POST', json.encode({username = "ALW Loot Crates", embeds = {
        {
            color = 1,
            title = 'ALW Loot Crates',
            description = GetPlayerName(source).." Just Opened A "..caseRarity.." Crate And Received x"..itemAmount.." ".. itemLabel,
            footer = {
                text = 'ALW Loot Crates',
                icon_url = 'https://i.imgur.com/ecmVFwa.png',
            },
        }
    }}), { ['Content-Type'] = 'application/json' })
end

local function OpenCase(serverid, caseitems)
    local totalWeight = 0

    for _, item in ipairs(caseitems.Items) do
        totalWeight += rarityWeights[item.rarity]
    end

    local randomIndex <const> = getRandomIndex(totalWeight, caseitems)
    local randomItem <const> = caseitems.Items[randomIndex]
    TriggerClientEvent('gg_lootcases:openCase', serverid, randomItem, caseitems)

    if CFG.RarityChance[randomItem.rarity] < 10 then 
        if randomItem.item == 'money' then
            CFG.ChatNotify("^3".. GetPlayerName(serverid).. "^7 won ^3$".. GroupDigits(randomItem.amount).."^7 from a ^3".. randomItem.rarity.."^7 case!")

            LogCrateOpening(serverid, randomItem.rarity, GroupDigits(randomItem.amount), 'Money')
        elseif randomItem.item:lower():find('WEAPON_') then
            CFG.ChatNotify("^3"..GetPlayerName(serverid).."^7 won a ^3"..GetWeaponLabel(randomItem.item).."^7 from a ^3"..randomItem.rarity.."^7 case!")
            LogCrateOpening(serverid, randomItem.rarity, 1, GetWeaponLabel(randomItem.item))
        else
            CFG.ChatNotify("^3"..GetPlayerName(serverid).."^7 won x"..randomItem.amount.." ^3".. GetItemLabel(randomItem.item).."^7 from a ^3"..randomItem.rarity.."^7 case!")
            LogCrateOpening(serverid, randomItem.rarity, randomItem.amount, GetItemLabel(randomItem.item))
        end
    end

    caseItemsWon[serverid] = randomItem
end





RegisterNetEvent('gg_lootcases:rewardPlayer', function()
    local won = caseItemsWon[source]
    if won then
        OpenCase(source, won)
        won = nil
    else
        print('gg_lootcases:rewardPlayer - No item found for source: ' .. source)
    end
end)
