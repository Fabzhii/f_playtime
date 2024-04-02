
Config = {}

Config.Header = 'Reward'
Config.OverRideLimits = true

Config.Rewards = {
    {
        time = 60,
        notify = 'Vielen Dank das du auf unserem Server spielst!  \n  Als Dank bekommst du $600 und einen Apfel',
        reward = {
            items = {
                {'apple', 1},
            },
            money = {
                bank = 0,
                cash = 600,
            },
            exports = {
                client = {

                },
                server = {

                }
            },
        },
    },
}

Config.Notifcation = function(notify)
    lib.notify({
        position = 'top-right',
        description = notify,
        title = Config.Header,
        type = 'success',
    })
end 