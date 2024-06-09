CFG = {
    ItemImgFolder = 'inventory/html/img/*',
    RarityChance = { -- Lower is considered rarer
        ["Common"] = 80,
        ["Uncommon"] = 50,
        ["Rare"] = 30,
        ["Epic"] = 15,
        ["Legendary"] = 1,
    },
    CaseList = {
        ["common_case"] = {
            Title = "Common Case",
            Color = "#FFFFFF",
            Items = {
                {name = "9mm", item = "pistol_ammo", amount = 1, rarity = "Legendary", img = "https://cdn.discordapp.com/attachments/1179045543595491359/1231292394243096586/image_89.png?ex=66366d67&is=6623f867&hm=8315d60e44e13e35058038556d6129f8ac3a2e60c3698e8512857eb1ff1d72b4&"},
                {name = "DEEG", item = "WEAPON_REVOLVER", amount = 1, rarity = "Legendary", img = "https://cdn.discordapp.com/attachments/1179045543595491359/1231295775091200041/image_90.png?ex=6636708d&is=6623fb8d&hm=f3fbac77e28ff04b8e32b34bbf0c2f92861d8d32abed690fd176e3e4e9417a16&"},
                {name = "$1,000,000", item = "money", amount = 1000000, rarity = "Legendary", img = "https://cdn.discordapp.com/attachments/1179045543595491359/1231298002434523176/image_73.png?ex=663672a0&is=6623fda0&hm=db6c2ba633aaf7ea4da2e35418f36483b44cd69404ba6c8e9a4b7dfea0ca54c5&"},
                {name = "$1,000,000", item = "money", amount = 1000000, rarity = "Legendary", img = "https://cdn.discordapp.com/attachments/1179045543595491359/1231298002434523176/image_73.png?ex=663672a0&is=6623fda0&hm=db6c2ba633aaf7ea4da2e35418f36483b44cd69404ba6c8e9a4b7dfea0ca54c5&"},
                {name = "$1,000,000", item = "money", amount = 1000000, rarity = "Legendary", img = "https://cdn.discordapp.com/attachments/1179045543595491359/1231298002434523176/image_73.png?ex=663672a0&is=6623fda0&hm=db6c2ba633aaf7ea4da2e35418f36483b44cd69404ba6c8e9a4b7dfea0ca54c5&"},
            },
        },
    },

   ChatNotify = function(message)
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div> <b>ALW Loot Cases</b> {0} </div>',
            args = {message}
        })
   end
}
