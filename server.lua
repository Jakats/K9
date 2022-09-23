local QBCore = exports['qb-core']:GetCoreObject()
RegisterServerEvent("K9:SendLanguage")
AddEventHandler("K9:SendLanguage", function()
    local src = source

    TriggerClientEvent("K9:UpdateLanguage", src, K9Config.Languages[K9Config.LanguageChoice])
end)

RegisterServerEvent("K9:RequestOpenMenu")
AddEventHandler("K9:RequestOpenMenu", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.job.name == "police" then
        TriggerClientEvent("K9:OpenMenu", src)
    end
end)

RegisterServerEvent("K9:RequestVehicleToggle")
AddEventHandler("K9:RequestVehicleToggle", function()
    local src = source

    TriggerClientEvent("K9:ToggleVehicle", src, K9Config.VehicleRestriction, K9Config.VehiclesList)
end)

RegisterServerEvent("K9:RequestItems")
AddEventHandler("K9:RequestItems", function()
    local src = source

    TriggerClientEvent("K9:SearchVehicle", src, K9Config.OpenDoorsOnSearch)
end)

RegisterServerEvent("K9:SearchItems")
AddEventHandler("K9:SearchItems", function(carplate, k9_name)
    local src = source
    local carplate = carplate
    local name = k9_name
    local drugs = false
    local trunkitems = GetOwnedVehicleItems(carplate)
    local gloveboxitems = GetOwnedVehicleGloveboxItems(carplate)

    for v, drug in pairs(K9Config.Items) do
        for k, item in pairs(trunkitems) do
            if item == drug then
                drugs = true
            end
        end

        for k, item in pairs(gloveboxitems) do
            if item == drug then
                drugs = true
            end
        end
    end

    if drugs then
        TriggerClientEvent('QBCore:Notify', src, name .. " found some drugs", "error", 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, name .. " didn't find any drugs", "success", 5000)
    end

end)

function GetOwnedVehicleItems(plate)
	local items = {}
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `trunkitems` WHERE `plate` = '"..plate.."'", function(result)
		if result[1] ~= nil then
			for k, item in pairs(result) do
				table.insert(items, item.name:lower())
			end
		else
			QBCore.Functions.ExecuteSql(true, "SELECT * FROM `trunkitemsnew` WHERE `plate` = '"..plate.."'", function(result)
				if result[1] ~= nil then
					if result[1].items ~= nil then
						result[1].items = json.decode(result[1].items)
						if result[1].items ~= nil then 
							for k, item in pairs(result[1].items) do
								table.insert(items, item.name:lower())
							end
						end
					end
				end
			end)
		end
	end)
	return items
end

function GetOwnedVehicleGloveboxItems(plate)
	local items = {}
	QBCore.Functions.ExecuteSql(true, "SELECT * FROM `gloveboxitems` WHERE `plate` = '"..plate.."'", function(result)
		if result[1] ~= nil then
			for k, item in pairs(result) do
				table.insert(items, item.name:lower())
			end
		else
			QBCore.Functions.ExecuteSql(true, "SELECT * FROM `gloveboxitemsnew` WHERE `plate` = '"..plate.."'", function(result)
				if result[1] ~= nil then 
					if result[1].items ~= nil then
						result[1].items = json.decode(result[1].items)
						if result[1].items ~= nil then 
							for k, item in pairs(result[1].items) do
								table.insert(items, item.name:lower())
							end
						end
					end
				end
			end)
		end
	end)
	return items
end
