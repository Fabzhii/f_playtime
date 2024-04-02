
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
    

end