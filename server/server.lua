local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('lu-diner:takeManagementFunds', function(source, cb)
    local src = source
    local Ply = QBCore.Functions.GetPlayer(src)
    local account = exports['qb-management']:GetAccount("hoc")
    if account >= Config.StockPrice then
        TriggerClientEvent('QBCore:Notify', src, "Pick up the ingredients at the warehouse", 'success')
        exports['qb-management']:RemoveMoney("hoc", Config.StockPrice)
        cb(true)
    else
        TriggerClientEvent('QBCore:Notify', src, "There is not enough money in the account to do that", 'error')
        cb(false)
    end
end)

---Crafting
RegisterServerEvent('lu-diner:server:GetItem', function(ItemMake, craftable)
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	--This grabs the table from client and removes the item requirements
	local amount = 1
	if craftable then
		if craftable["amount"] then amount = craftable["amount"] end
		for k, v in pairs(craftable[ItemMake]) do TriggerEvent("lu-diner:server:toggleItem", false, tostring(k), v, src) end
	end
	--This should give the item, while the rest removes the requirements
	TriggerEvent("lu-diner:server:toggleItem", true, ItemMake, amount, src)
end)


RegisterNetEvent('lu-diner:server:toggleItem', function(give, item, amount, newsrc)
	local src = newsrc or source
	local amount = amount or 1
	local remamount = amount
	if not give then
		if HasItem(src, item, amount) then -- check if you still have the item
			if QBCore.Functions.GetPlayer(src).Functions.GetItemByName(item).unique then -- If unique item, keep removing until gone
				while remamount > 0 do
					QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, 1)
					remamount -= 1
				end
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount) -- Show removal item box when all are removed
				return
			end
			if QBCore.Functions.GetPlayer(src).Functions.RemoveItem(item, amount) then
				if Config.Debug then print("^5Debug^7: ^1Removing ^2from Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "remove", amount)
			end
        end
	elseif give then
		if QBCore.Functions.GetPlayer(src).Functions.AddItem(item, amount) then
			if Config.Debug then print("^5Debug^7: ^4Giving ^2Player^7(^2"..src.."^7) '^6"..QBCore.Shared.Items[item].label.."^7(^2x^6"..(amount or "1").."^7)'") end
			TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], "add", amount)
		end
	end
end)

function HasItem(source, items, amount)
	local amount = amount or 1
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return false end
    local totalItems = #items
    local count = 0
    local kvIndex = 2

	if Config.Debug then print("^5Debug^7: ^3HasItem^7: ^2Checking if player has required item^7 '^3"..tostring(items).."^7'") end

	for _, itemData in pairs(Player.PlayerData.items) do
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


RegisterNetEvent('lu-diner:server:removeItem', function(item)
	local Player = QBCore.Functions.GetPlayer(source)
	Player.Functions.RemoveItem(item, 1, item.slot)
end)


CreateThread(function()	
	QBCore.Functions.CreateUseableItem("bluebox", function(source, item) TriggerClientEvent('lu-diner:Stash', source, {}, item.info["id"], true) end)
end)

RegisterServerEvent("lu-diner:server:GrabBag", function()
	local src = source local Player = QBCore.Functions.GetPlayer(src)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["bluebox"], "add", 1)
	Player.Functions.AddItem("bluebox", 1, false, { ["id"] = math.random(1, 9999999) })
end)
