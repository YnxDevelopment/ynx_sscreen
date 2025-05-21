local showMessage = false  
local originalCoords = nil  

RegisterNetEvent('ss:showMessage')
AddEventHandler('ss:showMessage', function(adminId, config)
    local message = config.Message
    local playerId = GetPlayerServerId(PlayerId())
    
 
    if config.ShouldTeleport then
        originalCoords = GetEntityCoords(GetPlayerPed(-1))
    end

 
    showMessage = true

    Citizen.CreateThread(function()
        while showMessage do  
            Citizen.Wait(0)


            if config.BlackScreen then

                DrawRect(0.5, 0.5, 2.0, 2.0, 0, 0, 0, 255) 
            end

            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(1.5, 1.5)  
            SetTextColour(255, 0, 0, 255)  
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(message .. "\nA játékos id-ja: " .. playerId)
            DrawText(0.5, 0.45)  




       
            if config.DisableWeapon then
                local playerPed = PlayerPedId()
                TriggerEvent('ox_inventory:clearWeapons', playerPed)
            end
        end
    end)
end)

RegisterNetEvent('ss:cancelMessage')
AddEventHandler('ss:cancelMessage', function()
 
    showMessage = false


    local playerPed = GetPlayerPed(-1)
    SetEntityVisible(playerPed, true, true) 

  
    SetTimecycleModifier("default")  

    
    if originalCoords then
        print("Visszateleportálás az eredeti koordinátákra: " .. originalCoords.x .. ", " .. originalCoords.y .. ", " .. originalCoords.z)
        SetEntityCoords(playerPed, originalCoords.x, originalCoords.y, originalCoords.z)
        originalCoords = nil 
    end


    ClearPedTasksImmediately(playerPed)
end)
