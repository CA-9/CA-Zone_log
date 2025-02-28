fx_version 'cerulean'
game 'gta5'

author 'CA'
description 'CA-Zone_log'
version '1.0.0'

client_script {
    'client/client.lua',
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua'
}
server_script {
    'server/server.lua'
}

shared_scripts {
'config.lua',
}

dependencies {
    'qb-core',
    'PolyZone',
}

lua54 'yes'
