local Framework = nil

Citizen.CreateThread(function()
    if Config.Framework == "ESX" then
        TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
        while Framework == nil do Citizen.Wait(10) end
    elseif Config.Framework == "QBCore" then
        Framework = exports['qb-core']:GetCoreObject()
    else
        print("^1ERROR: Framework no soportado en config.lua (usa ESX o QBCore).^0")
    end
end)

local displayedSigns = {}

RegisterNetEvent("3dtext:displayMessage")
AddEventHandler("3dtext:displayMessage", function(text, coords, playerName)
    table.insert(displayedSigns, {text = text, coords = coords, name = playerName, time = GetGameTimer() + 10000})
end)

Citizen.CreateThread(function()
    while true do
        local waitTime = 500
        local playerCoords = GetEntityCoords(PlayerPedId())

        for i = #displayedSigns, 1, -1 do
            local sign = displayedSigns[i]
            if GetGameTimer() > sign.time then
                table.remove(displayedSigns, i)
            else
                local distance = #(playerCoords - sign.coords)
                if distance < Config.MaxDistance then
                    waitTime = 0
                    Draw3DText(sign.coords.x, sign.coords.y, sign.coords.z, sign.text, 0.35, {r = 255, g = 255, b = 255, a = 255})
                end
            end
        end

        Citizen.Wait(waitTime)
    end
end)

function Draw3DText(x, y, z, text, scale, color)
    SetTextScale(scale, scale)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(color.r, color.g, color.b, color.a)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end
