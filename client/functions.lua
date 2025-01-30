local QBCore = exports['qb-core']:GetCoreObject()
local isLoggedIn = LocalPlayer.state.isLoggedIn

function HasItem(items, amount)
	local amount = amount or 1
    local isTable = type(items) == 'table'
    local isArray = isTable and table.type(items) == 'array' or false
    local totalItems = items
    local count = 0
    local kvIndex = 2
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player has required item^7 '^3"..tostring(items).."^7'") end
    for _, itemData in pairs(QBCore.Functions.GetPlayerData().items) do
        if itemData and (itemData.name == items) then
			if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Item^7: '^3"..tostring(items).."^7' ^2Slot^7: ^3"..itemData.slot.." ^7x(^3"..tostring(itemData.amount).."^7)") end
			count += itemData.amount
		end
	end
	if count >= amount then
		if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^5FOUND^7 x^3"..count.."^7") end
		return true
	end
	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Items ^1NOT FOUND^7") end
    return false
end

--Help Function
function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end