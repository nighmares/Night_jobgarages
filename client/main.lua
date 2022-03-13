
RegisterNetEvent('esx:playerLoaded') 
AddEventHandler('esx:playerLoaded', function(xPlayer, isNew)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:playerLogout') 
AddEventHandler('esx:playerLogout', function(xPlayer, isNew)
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local PlayerData = {}
local genderNum = 0
local distancecheck = false
local night = false
local admin = false


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(100)
		for k,v in pairs (Config.main) do
			local id = GetEntityCoords(PlayerPedId())
			local distancia = #(id - v.coords)
			
			if distancia < Config.Distancia and distancecheck == false then
				spawn(v.modelo, v.coords, v.heading, v.gender, v.animDict, v.animName)
				distancecheck = true
			end
			if distancia >= Config.Distancia and distancia <= Config.Distancia + 1 then
				
				distancecheck = false
				DeletePed(ped)
			end
		end
	end
	
	
end)

function spawn(modelo, coords, heading, gender, animDict, animName)
	
	RequestModel(GetHashKey(modelo))
	while not HasModelLoaded(GetHashKey(modelo)) do
		Citizen.Wait(1)
	end
	
	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	end	

	
	local x, y, z = table.unpack(coords)
	ped = CreatePed(genderNum, GetHashKey(modelo), x, y, z - 1, heading, false, true)
		
	
	
	SetEntityAlpha(ped, 255, false)
	FreezeEntityPosition(ped, true) 
	SetEntityInvincible(ped, true) 
	SetBlockingOfNonTemporaryEvents(ped, true) 
	
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	
	
end


RegisterNetEvent('Night:garages', function()

    for k,v in pairs(Config.garages) do

        if ESX.PlayerData.job and ESX.PlayerData.job.name == v.job and ESX.PlayerData.job.grade_name == v.grade then
            local points = {}

            for i = 1, #v.models do

            table.insert(points, {
                id = k,
                header = v.models[i].label,
                txt = '',
                params = {
                    event = 'NIGHT:SPAWN',
                    args = {

                        society = v.society,
                        price = v.money,
                        model = v.models[i].model,
                        coords = v.coords,
                        heading = v.heading,
                        plate = v.plate,

                    }
                }

            })
        end
        TriggerEvent('nh-context:sendMenu', points) 
        end 

    end 

end)

AddEventHandler('NIGHT:SPAWN', function (data)

    if Config.societymoney then
        ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(societyname)
            if societyname >= data.price then
                print(societyname)
                if ESX.Game.IsSpawnPointClear(data.coords, 2)  then

                    if  ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
                        ESX.Game.SpawnVehicle(data.model, data.coords, data.heading, function(car)
                            SetVehicleNumberPlateText(car, data.plate)
                        end)
                        admin = true
                    elseif not night then
                        ESX.Game.SpawnVehicle(data.model, data.coords, data.heading, function(car2)
                            SetVehicleNumberPlateText(car2, data.plate)
                        end)
                        TriggerServerEvent('esx_society:withdrawMoney', data.society, data.price)
                        TriggerServerEvent('night_money:garage','money',100)
                        night = true
                    else
                        notifies('you can only take out one vehicle!')
                    end    
            
                else
                    notifies('move vehicle please!')
                end
            else
                notifies('you dont have enought money!')
            end
        end, data.society)    
    else
        if ESX.Game.IsSpawnPointClear(data.coords, 2)  then

            if  ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
                ESX.Game.SpawnVehicle(data.model, data.coords, data.heading, function(car)
                end)
                admin = true
            elseif not night then
                ESX.Game.SpawnVehicle(data.model, data.coords, data.heading, function(car)
                end)
                night = true
            else
                notifies('you can only take out one vehicle!')
            end    
    
        else
            notifies('move vehicle please!')
        end  
    end        
end)

---- delete cars
RegisterNetEvent('Night:cardelete')
AddEventHandler('Night:cardelete', function()

    if night then
        cardelete()
        notifies('Thanks for bring it back bad!')
        night = false

    elseif admin then

        cardelete()
        notifies('Thanks for bring it back bad!')
        admin = false
    end         
      
end)

function cardelete()

    local vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
    SetEntityAsMissionEntity(vehicle, true, true)
    TaskLeaveVehicle(PlayerPedId(), vehicle, 0)
    Wait(2000)
    NetworkFadeOutEntity(vehicle, true,false)
    Wait(2000)
    ESX.Game.DeleteVehicle(vehicle)

end    

function notifies(message)

    if Config.notitype == 'esx' then
        ESX.ShowNotification(message)
    elseif Config.notitype == 'mythic' then
        exports['mythic_notify']:SendAlert('success', message, 10000)
    end

end 

exports.qtarget:AddBoxZone("Garage1", vector3(1869.29, 3686.78, 33.78), 0.51, 0.60, {
    name="Garage1",
    heading=0,
    debugPoly=false,
    minZ=32.55,
    maxZ=34.90,
    }, {
        options = {
            {
                event = "Night:garages",
                icon = "fas fa-sign-in-alt",
                label = "Open Menu",
                job = "police",
            },

            {
                event = "Night:cardelete",
                icon = "fas fa-sign-in-alt",
                label = "Return car",
                job = "police",
            },
        },
        distance = 2.0
})

exports.qtarget:AddBoxZone("Garage2", vector3(294.65, -600.49, 43.3), 0.51, 0.60, {
    name="Garage2",
    heading=0,
    debugPoly=false,
    minZ=42.24,
    maxZ=44.20,
    }, {
        options = {
            {
                event = "Night:garages",
                icon = "fas fa-sign-in-alt",
                label = "Open Menu",
                job = "ambulance",
            },

            {
                event = "Night:cardelete",
                icon = "fas fa-sign-in-alt",
                label = "Return Car",
                job = "ambulance",
            },
        },
        distance = 2.0
})



