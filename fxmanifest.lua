fx_version 'cerulean' 
game 'gta5'

author 'Kratom'
description 'Redeemable Lootcases'
website 'https://discord.gg/wdev'
ui_page 'web/build/index.html'
lua54 'yes'

shared_script 'config.lua'

client_script {
    'client.lua',
    'bridge/client/*',
}

server_script {
    's_config.lua',
    'server.lua',
    'bridge/server/*',
}

escrow_ignore {
    'config.lua',
    'bridge/*',
}

files {
    'web/build/**/*'
}

dependency '/assetpacks'