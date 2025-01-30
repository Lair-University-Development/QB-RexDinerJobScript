local QBCore = exports['qb-core']:GetCoreObject()
local isLoggedIn = LocalPlayer.state.isLoggedIn

RegisterNetEvent('lu-diner:menu:OpenMenu', function(data)
	local Menu = {}
	Menu[#Menu + 1] = { header = data.header, txt = "", isMenuHeader = true }
	Menu[#Menu + 1] = { icon = "fas fa-circle-xmark", header = "", txt = "Close", params = { event = "" } }
	for i = 1, #data.craftable do
		for k, v in pairs(data.craftable[i]) do
			if k ~= "amount" then
				local text = ""
				setheader = QBCore.Shared.Items[tostring(k)].label
				if data.craftable[i]["amount"] ~= nil then setheader = setheader.." x"..data.craftable[i]["amount"] end
				local disable = false
				local checktable = {}
				for l, b in pairs(data.craftable[i][tostring(k)]) do
					if b == 1 then number = "" else number = " x"..b end
					text = text.."- "..QBCore.Shared.Items[l].label..number.."<br>"
					settext = text
					checktable[l] = HasItem(l, b)
				end
				for _, v in pairs(checktable) do if v == false then disable = true break end end
				if not disable then setheader = setheader.." ✅" end
				Menu[#Menu + 1] = { disabled = disable, icon = k, header = setheader, txt = settext, params = { event = "lu-diner:Client:MakeItem", args = { item = k, craft = data.craftable[i], craftable = data.craftable, header = data.header } } }
				settext, setheader = nil
			end
		end
	end
	exports['qb-menu']:openMenu(Menu)
end)