ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('dm_namechanger:event')
AddEventHandler('dm_namechanger:event', function(identifier, fName, lName)
    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        MySQL.Async.execute(
            [[
                UPDATE users
                SET firstname = @fName, lastname = @lName
                WHERE identifier = @identifier
            ]],
            {
                ['@fName'] = fName,
                ['@lName'] = lName,
                ['@identifier'] = identifier
            },
            function(result)
                if result then
                    -- Notification
                    Notification(nil, 'Your names have been changed. Your name will shown after the server restart.', 'success', 'top', 5000)

                    -- Webhook
                    local dmsg =
                        '**Old Name:** ' .. xPlayer.name .. '\n' ..
                        '**Identifier:** ' .. xPlayer.identifier .. '\n' ..
                        '**New Names:**' .. '\n' ..
                        '**FirstName:** ' .. fName .. "\n" ..
                        '**LastName:** ' .. lName
                    DiscordLog(16753920, 'Someone changed their names', dmsg)
                else
                    Notification(nil, 'Failed to update names in the database.', 'error', 'top', 5000)
                end
            end
        )
    else
        Notification(nil, 'Player not found with the given identifier.', 'error', 'top', 5000)
    end
end)

-- Discord webhook function
function DiscordLog(color, title, message)
    local Embed = {
        {
            ['color'] = color,
            ['title'] = "**" .. title .. "**",
            ['description'] = message,
        }
    }
    PerformHttpRequest(Config.Discord.webhookURL, function(err, text, headers) end, 'POST',
        json.encode({ username = 'AGSCRIPTS', embeds = Embed }), { ['Content-Type'] = 'application/json' })
end

-- Notification function
function Notification(title, desc, type, position, duration)
    TriggerClientEvent('ox_lib:notify', -1, {
        title = title,
        description = desc,
        type = type,
        position = position,
        duration = duration
    })
end

ESX.RegisterCommand({'namechanger'}, 'admin', function(xPlayer, args, showError)
    TriggerClientEvent('dm_mainevent', xPlayer.source)
end, false, {help = 'Change The Player Name IG [ Admins Only ]'})
