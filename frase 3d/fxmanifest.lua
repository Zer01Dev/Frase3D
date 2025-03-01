fx_version 'adamant'
game 'gta5'

author 'Zer0.dev'
description 'Texto 3D'
version '1.1.0'

shared_scripts {
    'config.lua'
}

client_scripts {
    'client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

lua54 'yes'

escrow_ignore {
    'config.lua'
}