
local ox_inventory = exports.ox_inventory

Citizen.CreateThread(function()
    while true do 
        for k,v in pairs(ESX.GetPlayers()) do 
            local identifier = ESX.GetPlayerFromId(v).identifier

            MySQL.Async.fetchAll('SELECT * FROM users WHERE identifer = @identifer', {
                ['@identifer']  = identifier,
            }, function(data)

                local newtime = data[1].playtime
                MySQL.Async.execute('UPDATE users SET playtime = @playtime WHERE identifer = @identifer', {
                    ['@identifer']  = identifier,
                    ['@playtime'] = newtime,
                })

                for o,i in pairs(Config.Rewards) do 
                    if i.time == newtime then 
                        reward(ESX.GetPlayerFromId(v), i.reward, i.notify)
                    end 
                end 


            end)
        end

        Citizen.Wait(60 * 1000)
    end 
end)

function reward(xPlayer, reward, notify)
    TriggerClientEvent((GetCurrentResourceName()..':notifyClient'), xPlayer.source, notify)
    TriggerClientEvent((GetCurrentResourceName()..':triggerExports'), xPlayer.source, reward.exports.client)

    for k,v in pairs(reward.items) do 
        if exports.ox_inventory:CanCarryItem(xPlayer.source, v[1], v[2]) or Config.OverRideLimits then
            exports.ox_inventory:AddItem(xPlayer.source, v[1], v[2])
        end
    end

    if reward.money.cash ~= nil and reward.money.cash > 0 then 
        exports.ox_inventory:AddItem(xPlayer.source, 'money', reward.money.cash)
    end 

    if reward.money.bank ~= nil and reward.money.bank > 0 then 
        xPlayer.addAccountMoney('bank', reward.money.bank)
    end 

    for k,v in pairs(reward.exports.server) do 
        exports(v)
    end

end

