
RegisterNetEvent((GetCurrentResourceName()..':notifyClient'))
AddEventHandler((GetCurrentResourceName()..':notifyClient'), function(notify)
    Config.Notifcation(notify)
end)

RegisterNetEvent((GetCurrentResourceName()..':triggerExports'))
AddEventHandler((GetCurrentResourceName()..':triggerExports'), function(clExports)
    for k,v in pairs(clExports) do 
        exports(v)
    end
end)
