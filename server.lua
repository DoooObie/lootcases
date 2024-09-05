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


serverSetup = false
CaseList = CFG.CaseList
rarityWeights = CFG.RarityChance
caseItemsWon = {}

OpenServerCase = function(serverid, caseitems)

    local totalWeight = 0

    for _, item in ipairs(caseitems.Items) do
        totalWeight = totalWeight + rarityWeights[item.rarity]
    end

    local function getRandomIndex()
        local randomChance = math.random(1, totalWeight)
        local cumulativeWeight = 0

        for i, item in ipairs(caseitems.Items) do
            cumulativeWeight = cumulativeWeight + rarityWeights[item.rarity]
            if randomChance <= cumulativeWeight then
                return i
            end
        end

        return #caseitems.Items
    end

    local randomIndex = getRandomIndex()
    local randomItem = caseitems.Items[randomIndex]
    TriggerClientEvent('gg_lootcases:openCase', serverid, randomItem, caseitems)

    if CFG.RarityChance[randomItem.rarity] < 10 then 
        if randomItem.item == 'money' then
            CFG.ChatNotify(("^3%s^7 won ^3$%s^7 from a ^3%s^7 case!"):format(GetPlayerName(serverid), GroupDigits(randomItem.amount), randomItem.rarity))
            LogCrateOpening(serverid, randomItem.rarity, GroupDigits(randomItem.amount), 'Money')
        elseif string.match(string.lower(randomItem.item), 'weapon_') then
            CFG.ChatNotify(("^3%s^7 won a ^3%s^7 from a ^3%s^7 case!"):format(GetPlayerName(serverid), GetWeaponLabel(randomItem.item), randomItem.rarity))
            LogCrateOpening(serverid, randomItem.rarity, 1, GetWeaponLabel(randomItem.item))
        else
            CFG.ChatNotify(("^3%s^7 won x%s ^3%s^7 from a ^3%s^7 case!"):format(GetPlayerName(serverid), randomItem.amount, GetItemLabel(randomItem.item), randomItem.rarity))
            LogCrateOpening(serverid, randomItem.rarity, randomItem.amount, GetItemLabel(randomItem.item))
        end
    end

    caseItemsWon[serverid] = randomItem
end


function LogCrateOpening(source, caseRarity, itemAmount, itemLabel)
    local playername = GetPlayerName(source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = v
        end
    end

    local embed = {
        {
            ["color"] = 1,
            ["title"] = 'ALW Loot Crates',
            -- ["description"] = "Player: **"..playername.."** Just used a cloned card | "..license.." **"..text.."**",
            ["description"] = ("%s Just Opened A %s Crate And Received x%s %s"):format(playername, caseRarity, itemAmount, itemLabel),
            ["footer"] = {
                ["text"] = 'ALW Loot Crates',
                ["icon_url"] = 'https://i.imgur.com/ecmVFwa.png',
            },
        }
    }
    PerformHttpRequest(S_CFG.OpeningWebhook, function(err, text, headers) end, 'POST', json.encode({username = "ALW Loot Crates", embeds = embed}), { ['Content-Type'] = 'application/json' })
end


RegisterNetEvent('gg_lootcases:rewardPlayer', function()
    if caseItemsWon[source] then
        RewardServerPlayer(source, caseItemsWon[source])
        caseItemsWon[source] = nil
    else
        print(string.format('^1%s ^7may have just tried to exploit the case system', source))
    end
end)