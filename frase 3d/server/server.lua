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

RegisterServerEvent("3dtext:sendMessage")
AddEventHandler("3dtext:sendMessage", function(text, coords)
    local src = source
    local playerName = GetPlayerName(src)

    TriggerClientEvent("3dtext:displayMessage", -1, text, coords, playerName)
end)
