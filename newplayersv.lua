function CreateEvent(EventName, EventRoutine)
	return RegisterNetEvent(EventName), AddEventHandler(EventName, EventRoutine)
end

CreateEvent(UnxPboy..":Register", function()
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.scalar('SELECT register FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result == 0 then
            for k , v in pairs(Config.Setting.Item) do
                local GetItem = xPlayer.getInventoryItem(v.Name)
                xPlayer.addInventoryItem(v.Name, v.Count)
            end
            MySQL.update.await("UPDATE users SET register=1 WHERE identifier = @identifier", {
                ['@identifier'] = xPlayer.identifier
            })
        else
            exports.pNotify:PushNotification(source, {
                title = 'แจ้งเตือน',
                type = 'error',
                description = 'คุณได้รับของไปแล้ว',
                duration = 3000,
                direction = 'right'
            })
        end
    end)
end)