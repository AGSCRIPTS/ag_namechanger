fx_version 'cerulean'

game 'gta5'

description 'A Simple Admin And PlayerIdentifier NameChanger Script Made For [ ESX ]'

version 'V1'

lua54 'yes'
author 'AG'

shared_scripts { '@es_extended/imports.lua', '@ox_lib/init.lua' }

server_scripts {
   '@es_extended/locale.lua',
   '@mysql-async/lib/MySQL.lua',
   'shared/Config.lua',
   'server/*.lua'
}

client_scripts {
   '@es_extended/locale.lua',
   'shared/Config.lua',
   'client/*.lua',
}
