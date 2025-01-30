name 'lu-diner'
author "Eliza Lasal"
description "Diner Job Script By Eliza Lasal"
version '24.2.29'
fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    "config.lua"
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua',
    '8.lua'
}

client_scripts {
	'client/*.lua',
    '8.lua'
}

escrow_ignore {
	'config.lua',
    '8.lua',
    'INSTALL/*'
}

dependencies { 
    'qb-input', 
    'qb-menu', 
    'qb-target'
}
