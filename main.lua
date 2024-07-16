
ESX = exports["es_extended"]:getSharedObject()

function mainFnc()
    Citizen.CreateThread(function()
        local input = lib.inputDialog('Name Changer Menu', {
            {
                type = 'input',
                label = 'Char: Identifier Ending Number',
                placeholder = 'Enter The Player Identifier',
                icon = 'fa-solid fa-note-sticky',
                required = true,
                default = "char1:",
            },
            {
                type = 'input',
                label = 'FirstName',
                placeholder = 'Enter Your FirstName',
                icon = 'fa-solid fa-note-sticky',
                required = true,
                min = 2,
                max = 16,
            },
            {
                type = 'input',
                label = 'LastName',
                placeholder = 'Enter Your LastName',
                icon = 'fa-solid fa-note-sticky',
                required = true,
                min = 2,
                max = 16,
            },
        })

        if input then
            local identifier = input[1]
            local fName = input[2]
            local lName = input[3]
            TriggerServerEvent('dm_namechanger:event', identifier, fName, lName)
        end
    end)
end

RegisterNetEvent("dm_mainevent")
AddEventHandler("dm_mainevent", function()
    mainFnc()
end)
