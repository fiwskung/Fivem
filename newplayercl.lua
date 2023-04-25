function CreateEvent(EventName, EventRoutine)
	return RegisterNetEvent(EventName), AddEventHandler(EventName, EventRoutine)
end
Freeze = false

CreateThread(function()
	if Config.Setting.NPC.Show then
		RequestModel(GetHashKey(Config.Setting.NPC.ModelName))
		while not HasModelLoaded(GetHashKey(Config.Setting.NPC.ModelName)) do
			Wait(1)
		end
		ped =  CreatePed(4, GetHashKey(Config.Setting.NPC.ModelHash) ,Config.Setting.Pos.x, Config.Setting.Pos.y, Config.Setting.Pos.z-1, 3374176, false, true)
		SetEntityHeading(ped, Config.Setting.Pos.w)
		FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		TaskPlayAnim(ped, Config.Setting.NPC.AnimDictionary, Config.Setting.NPC.AnimationName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	end
	while true do
		SleepLoop = 500
		if #(GetEntityCoords(PlayerPedId()) - vector3(Config.Setting.Pos.x, Config.Setting.Pos.y, Config.Setting.Pos.z)) < 5.0 and IsPedOnFoot(PlayerPedId()) then
			SleepLoop = 0
			ShowToolTip(Config.Setting.Alert.DisplayHelpText, Config.Setting.Pos)
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.Setting.Pos.x, Config.Setting.Pos.y, Config.Setting.Pos.z, true ) < 1.5 and IsPedOnFoot(PlayerPedId()) then
				if IsControlJustReleased(0, 38) and IsPedOnFoot(PlayerPedId()) and not Freeze then
                    Freeze = true
					TriggerServerEvent(UnxPboy..":Register")
					Wait(1000)
					Freeze = false
                end
			end
		end
		Wait(SleepLoop)
	end
end)

ShowToolTip = function (msg, coords)
	AddTextEntry(GetCurrentResourceName(), msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp(GetCurrentResourceName())
	EndTextCommandDisplayHelp(2, false, false, -1)
end