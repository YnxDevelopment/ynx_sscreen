ESX = exports['es_extended']:getSharedObject()


RegisterCommand('ss', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local group = xPlayer.getGroup()

    if isAllowedGroup(group) then
        local targetId = tonumber(args[1]) 
        if targetId then
         
            TriggerClientEvent('ss:showMessage', targetId, source, Config)
        else
            TriggerClientEvent('esx:showNotification', source, "Adj meg egy idt.")
        end
    else
        TriggerClientEvent('esx:showNotification', source, "Ehez nincs jogod.")
    end
end, false)


RegisterCommand('cancelss', function(source, args, rawCommand)
    local targetId = tonumber(args[1])
    if targetId then

        TriggerClientEvent('ss:cancelMessage', targetId)
    else
        TriggerClientEvent('esx:showNotification', source, "Adj meg egy idt.")
    end
end, false)


function isAllowedGroup(group)
    for _, allowedGroup in ipairs(Config.AllowedGroups) do
        if group == allowedGroup then
            return true
        end
    end
    return false
end
