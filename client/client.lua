local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local isLoggedIn = LocalPlayer.state.isLoggedIn
local OnDuty = true
local playerJob = nil
local Calledmeat = false
local Calledtools = false
local Calledfood = false
local Calledfrozen = false
local Calledfruit = false
local Tables = {}

local function isAllowed(type)
    if Config.JobName then
        local Player = QBCore.Functions.GetPlayerData()
        local playerHasJob = Config.JobName[Player.job.name]
        local jobGradeReq = nil
		
        if Config.JobName[Player.job.name] ~= nil then
            jobGradeReq = Config.JobName[Player.job.name][type]
        end

        if playerHasJob then
            if jobGradeReq ~= nil then
				if jobGradeReq == 0 then --bartenders
					if Player.job.grade.level == jobGradeReq then --Employee
						return true
					elseif Player.job.grade.level >= 24 then --Corporation
						return true
					elseif Player.job.grade.level == 3 then --Shift Manager
						return true
					elseif Player.job.grade.level == 4 then --Resturant Manager
						return true
                    elseif Player.job.grade.level == 13 then --Tier 2
						return true
                    elseif Player.job.grade.level == 14 then --Tier 2
						return true
                    elseif Player.job.grade.level == 15 then --Tier 2
						return true
                    elseif Player.job.grade.level == 19 then --Tier 3
						return true
                    elseif Player.job.grade.level == 21 then --Tier 3
						return true
                    elseif Player.job.grade.level == 22 then --Tier 3
						return true
                    elseif Player.job.grade.level == 23 then --Tier 4
						return true
					else
						return false
					end
				elseif jobGradeReq == 2 then --cooks
					if Player.job.grade.level == jobGradeReq then --Employee
						return true
					elseif Player.job.grade.level >= 24 then --Corporation
						return true
					elseif Player.job.grade.level == 3 then --Shift Manager
						return true
					elseif Player.job.grade.level == 4 then --Resturant Manager
						return true
                    elseif Player.job.grade.level == 13 then --Tier 2
						return true
                    elseif Player.job.grade.level == 14 then --Tier 2
						return true
                    elseif Player.job.grade.level == 15 then --Tier 2
						return true
                    elseif Player.job.grade.level == 19 then --Tier 3
						return true
                    elseif Player.job.grade.level == 21 then --Tier 3
						return true
                    elseif Player.job.grade.level == 22 then --Tier 3
						return true
                    elseif Player.job.grade.level == 23 then --Tier 4
						return true
					else
						return false
					end
				elseif jobGradeReq == 4 then --management
					if Player.job.grade.level == jobGradeReq then --Employee
						return true
					elseif Player.job.grade.level >= 24 then --Corporation
						return true
					else
						return false
					end
				end 
            else
                return false
            end
        else
            return false
        end
    else
        return true
    end
end
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    playerJob = QBCore.Functions.GetPlayerData().job
    OnDuty = playerJob.onduty
end)

CreateThread(function()
    for k, v in pairs(Config.DRollingLocations) do
       -- RequestModel(GetHashKey("prop_table_03"))
       --while not HasModelLoaded(GetHashKey("prop_table_03")) do
       --     Citizen.Wait(1) 
       -- end
		Tables["dinerRollingLocations"..k] =
        --CreateObject(GetHashKey("prop_table_03"),v.x, v.y, v.z,false,false,false)
        SetEntityHeading(Tables["dinerRollingLocations"..k], v.w)
        FreezeEntityPosition(Tables["dinerRollingLocations"..k], true)
        exports['qb-target']:AddBoxZone("dinerRollingLocations"..k, v.xyz, 1, 1.7, { name="dinerRollingLocations"..k, heading = v.w, debugPoly=Config.Debug, minZ = v.z-1, maxZ = v.z+1, },
			{ options = {
            {
                type = "client",
                event = "lu-diner:menu:OpenMenu",
                targeticon = 'fas fa-utensils',
                icon = 'fas fa-circle',
                label = "Expedite",
                craftable = Config.CraftingMenus["RollingTables"],
                header = "Expedite",
                coords = v,
                canInteract = function() return isAllowed('cigars') end
            }, 
        },
				distance = 3
		})
	end

    for k, v in pairs(Config.DutyLocations) do
        exports['qb-target']:AddBoxZone("dinerDuty"..k, v, 1, 1, {
            name = "dinerDuty"..k,
            heading = v.w,
            debugPoly = Config.Debug,
            minZ = v.z - 1,
            maxZ = v.z + 2,
            }, {
            options = {
                {
                    type = "client",
                    event = "lu-diner:client:duty",
                    targeticon = 'fas fa-clipboard-list',
                    icon = 'fas fa-circle',
                    label = "Go On/Off Duty",
                    canInteract = function() return isAllowed('cigars') end
                },
            },
            distance = 3.0
        })
    end

    for k, v in pairs(Config.DStorage) do
        exports['qb-target']:AddBoxZone("dinerStorage"..k, v, 1, 3, {
            name = "dinerStorage"..k,
            heading = v.w,
            debugPoly = Config.Debug,
            minZ = v.z - 1,
            maxZ = v.z + 2,
            }, {
            options = {
                {
                    type = "client",
                    action = function()
                        TriggerEvent('lu-diner:client:OpenStorage',k)
                    end,
                    targeticon = 'fas fa-box',
                    icon = 'fas fa-circle',
                    label = "Open Storage",
                    canInteract = function() return isAllowed('cigars') end
                },
                {
                    type = "client",
                    event = "lu-diner:unloadPallete",
                    icon = 'fas fa-box',
                    label = "Unload Pallete",
                    canInteract = function() return isAllowed('management') end
                },
            },
            distance = 3.0
        })
    end

    for k, v in pairs(Config.DIceMakers) do
        exports['qb-target']:AddBoxZone("dinerIceMaker"..k, v, 0.7, 1.5, {
            name = "dinerIceMaker"..k,
            heading = v.w,
            debugPoly = Config.Debug,
            minZ = v.z - 1,
            maxZ = v.z + 1,
            }, {
            options = {
                {
                    type = "client",
                    event = "lu-diner:menu:OpenMenu",
                    targeticon = 'fas fa-icicles',
                    icon = 'fas fa-circle',
                    label = "Open Ice Box",
                    craftable = Config.CraftingMenus["Icebox"],
                    header = "Ice Box",
                    coords = v,
                    canInteract = function() return isAllowed('bartender') end
                },
            },
            distance = 3.0
        })
    end

    for k, v in pairs(Config.DTaps) do
        exports['qb-target']:AddBoxZone("dinerTaps"..k, v, 1, 1, {
            name = "dinerTaps"..k,
            heading = v.w,
            debugPoly = Config.Debug,
            minZ = v.z - 1,
            maxZ = v.z + 1,
            }, {
            options = {
                {
                    type = "client",
                    event = "lu-diner:menu:OpenMenu",
                    targeticon = 'fas fa-solid fa-burger',
                    icon = 'fas fa-circle',
                    label = "Use Grill",
                    craftable = Config.CraftingMenus["Tap"],
                    header = "Grill",
                    coords = v,
                    canInteract = function() return isAllowed('bartender') end
                },
            },
            distance = 3.0
        })
    end

    for k, v in pairs(Config.DFridges) do
        exports['qb-target']:AddBoxZone("dinerFridge"..k, v, 1.2, 1.2, {
            name = "dinerFridge"..k,
            heading = v.w,
            debugPoly = Config.Debug,
            minZ = v.z - 1,
            maxZ = v.z + 1,
            }, {
            options = {
                {
                    type = "client",
                    action = function()
                        TriggerEvent('lu-diner:client:OpenFridge',k)
                    end,
                    targeticon = 'fas fa-box',
                    icon = 'fas fa-circle',
                    label = "Use Fridge",
                    canInteract = function() return isAllowed('bartender') end
                },
            },
            distance = 3.0
        })
    end

    for k, v in pairs(Config.DBarLocations) do
        exports['qb-target']:AddBoxZone("dinerBarLocations"..k, v, 0.7, 2.4, {
            name = "dinerBarLocations"..k,
            heading = v.w,
            debugPoly = Config.Debug,
            minZ = v.z - 1,
            maxZ = v.z + 2,
            }, {
            options = {
                {
                    type = "client",
                    action = function()
                        TriggerEvent('lu-diner:client:OpenBar',k)
                    end,
                    targeticon = 'fas fa-box',
                    icon = 'fas fa-circle',
                    label = "Grab Drinks",
                    canInteract = function() return isAllowed('bartender') end
                },
                {
                    type = "client",
                    event = "lu-diner:menu:OpenMenu",
                    targeticon = 'fas fa-wine-glass',
                    icon = 'fas fa-circle',
                    label = "Make Drinks",
                    craftable = Config.CraftingMenus["CustomDrinks"],
                    header = "Bar",
                    coords = v,
                    canInteract = function() return isAllowed('bartender') end
                },
            },
            distance = 3.0
        })
    end

    exports['qb-target']:AddBoxZone("dinerWarehouse", Config.WarehouseLocation, 1, 5, {
        name = "dinerWarehouse",
        heading = Config.WarehouseLocation.w,
        debugPoly = Config.Debug,
        minZ = Config.WarehouseLocation.z - 1,
        maxZ = Config.WarehouseLocation.z + 2.5,
        }, {
        options = {
            {
                type = "client",
                action = function()
                    TriggerEvent("lu-diner:client:warehouse")
                end,
                targeticon = 'fas fa-box',
                icon = 'fas fa-circle',
                label = "Retrieve Order",
            },
        },
        distance = 3.0
    })

    exports['qb-target']:AddBoxZone("dinerComputer", Config.OrderStockLocation, 1, 1, {
        name = "dinerComputer",
        heading = Config.OrderStockLocation.w,
        debugPoly = Config.Debug,
        minZ = Config.OrderStockLocation.z - 1,
        maxZ = Config.OrderStockLocation.z + 2,
        }, {
        options = {
            {
                type = "client",
                event = "lu-diner:client:getmeat",
                icon = 'fas fa-box',
                label = "Order Meat",
                canInteract = function() return isAllowed('management') end
            },
            {
                type = "client",
                event = "lu-diner:client:getglasses",
                icon = 'fas fa-box',
                label = "Order Glasses",
                canInteract = function() return isAllowed('management') end
            },
            {
                type = "client",
                event = "lu-diner:client:getfood",
                icon = 'fas fa-box',
                label = "Order Food",
                canInteract = function() return isAllowed('management') end
            },
            {
                type = "client",
                event = "lu-diner:client:getfruit",
                icon = 'fas fa-box',
                label = "Order Fruit",
                canInteract = function() return isAllowed('management') end
            },
            {
                type = "client",
                event = "lu-diner:client:getfrozen",
                icon = 'fas fa-box',
                label = "Order Frozen Food",
                canInteract = function() return isAllowed('management') end
            },
        },
        distance = 3.0
    })

    exports['qb-target']:AddBoxZone("BlueBox", vector3(2529.47, 2582.72, 38.5), 1.0, 1.0, { name="BlueBox", heading = 0, debugPoly=false, minZ = 37.5, maxZ = 39.5, },
    { options = { { event = "lu-diner:client:GrabBag", icon = "fas fa-bag-shopping", label = "Grab Empty To-Go Box", job = "hoc", }, },distance = 2.0 })
end)

RegisterNetEvent('lu-diner:client:duty')
AddEventHandler('lu-diner:client:duty', function()
    if OnDuty == true then
        TriggerEvent('inventory:client:busy:status', true)
        TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})
        QBCore.Functions.Progressbar('signing_out', 'Clocking Out..', 5000, false, false, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        }, {
        }, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('inventory:client:busy:status', false)
            OnDuty = false
            TriggerServerEvent("QBCore:ToggleDuty")
        end, function()
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('inventory:client:busy:status', false)
            QBCore.Functions.Notify('Cancelled..', 'error')
            
        end,"fas fa-clipboard-list")
    else
        TriggerEvent('inventory:client:busy:status', true)
        TriggerEvent('animations:client:EmoteCommandStart', {"clipboard"})
        QBCore.Functions.Progressbar('signing_in', 'Clocking In..', 5000, false, false, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = false,
        }, {
        }, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('inventory:client:busy:status', false)
            OnDuty = true
            TriggerServerEvent("QBCore:ToggleDuty")
        end, function()
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerEvent('inventory:client:busy:status', false)
            QBCore.Functions.Notify('Cancelled..', 'error')
            
        end,"fas fa-clipboard-list")
    end
end)

RegisterNetEvent('lu-diner:client:OpenStorage')
AddEventHandler('lu-diner:client:OpenStorage', function(index)
    if OnDuty == true then
        TriggerEvent("inventory:client:SetCurrentStash", "Diner Storage "..index)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Diner Storage "..index, {
            maxweight = 100000,
            slots = 40,
        })
    else
        QBCore.Functions.Notify('Your Not On Duty!', 'error')
    end
end)

RegisterNetEvent('lu-diner:client:OpenFridge')
AddEventHandler('lu-diner:client:OpenFridge', function(index)
    if OnDuty == true then
        TriggerEvent("inventory:client:SetCurrentStash", "Diner Fridge "..index)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Diner Fridge "..index, {
            maxweight = 500000,
            slots = 40,
        })
    else
        QBCore.Functions.Notify('Your Not On Duty!', 'error')
    end
end)

RegisterNetEvent('lu-diner:client:OpenBar')
AddEventHandler('lu-diner:client:OpenBar', function(index)
    if OnDuty == true then
        TriggerEvent("inventory:client:SetCurrentStash", "Diner Bar "..index)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", "Diner Bar "..index, {
            maxweight = 500000,
            slots = 40,
        })
    else
        QBCore.Functions.Notify('Your Not On Duty!', 'error')
    end
end)

RegisterNetEvent('lu-diner:client:getmeat')
AddEventHandler('lu-diner:client:getmeat', function()
    if (QBCore.Functions.GetPlayerData().job.grade.level == 4) or (QBCore.Functions.GetPlayerData().job.grade.level >= 24) then
        QBCore.Functions.TriggerCallback('lu-diner:takeManagementFunds', function(haspaid)
            if haspaid then
                SetNewWaypoint(Config.WarehouseLocation)
                Calledmeat = true
            end
        end)
    else
        QBCore.Functions.Notify("You are Not a Manager or Owner", "error")
    end
end)
RegisterNetEvent('lu-diner:client:getglasses')
AddEventHandler('lu-diner:client:getglasses', function()
    if (QBCore.Functions.GetPlayerData().job.grade.level == 4) or (QBCore.Functions.GetPlayerData().job.grade.level >= 24) then
        QBCore.Functions.TriggerCallback('lu-diner:takeManagementFunds', function(haspaid)
            if haspaid then
                SetNewWaypoint(Config.WarehouseLocation)
                Calledtools = true
            end
        end)
    else
        QBCore.Functions.Notify("You are Not a Manager or Owner", "error")
    end
end)
RegisterNetEvent('lu-diner:client:getfood')
AddEventHandler('lu-diner:client:getfood', function()
    if (QBCore.Functions.GetPlayerData().job.grade.level == 4) or (QBCore.Functions.GetPlayerData().job.grade.level >= 24) then
        QBCore.Functions.TriggerCallback('lu-diner:takeManagementFunds', function(haspaid)
            if haspaid then
                SetNewWaypoint(Config.WarehouseLocation)
                Calledfood = true
            end
        end)
    else
        QBCore.Functions.Notify("You are Not a Manager or Owner", "error")
    end
end)
RegisterNetEvent('lu-diner:client:getfruit')
AddEventHandler('lu-diner:client:getfruit', function()
    if (QBCore.Functions.GetPlayerData().job.grade.level == 4) or (QBCore.Functions.GetPlayerData().job.grade.level >= 24) then        
        QBCore.Functions.TriggerCallback('lu-diner:takeManagementFunds', function(haspaid)
            if haspaid then
                SetNewWaypoint(Config.WarehouseLocation)
                Calledfruit = true
            end
        end)
    else
        QBCore.Functions.Notify("You are Not a Manager or Owner", "error")
    end
end)
RegisterNetEvent('lu-diner:client:getfrozen')
AddEventHandler('lu-diner:client:getfrozen', function()
    if (QBCore.Functions.GetPlayerData().job.grade.level == 4) or (QBCore.Functions.GetPlayerData().job.grade.level >= 24) then
        QBCore.Functions.TriggerCallback('lu-diner:takeManagementFunds', function(haspaid)
            if haspaid then
                SetNewWaypoint(Config.WarehouseLocation)
                Calledfrozen = true
            end
        end)
    else
        QBCore.Functions.Notify("You are Not a Manager or Owner", "error")
    end
end)

RegisterNetEvent('lu-diner:unloadPallete', function()
    local frozcrate = HasItem('diner_frozencrate', 1)
    local fruitcrate = HasItem('diner_fruitcrate', 1)
    local foodcrate = HasItem('diner_foodcrate', 1)
    local toolcrate = HasItem('diner_toolcrate', 1)
    local meatcrate = HasItem('diner_meatcrate', 1)
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
		if PlayerData.job.onduty then
            if fruitcrate then
                TriggerEvent('lu-diner:items')
                QBCore.Functions.Notify('Unpacking Fruit Crate.', 'Success')
            elseif toolcrate then
                TriggerEvent('lu-diner:items')
                QBCore.Functions.Notify('Unpacking Glass Crate.', 'Success')
            elseif foodcrate then
                TriggerEvent('lu-diner:items')
                QBCore.Functions.Notify('Unpacking Food Crate.', 'Success')
            elseif frozcrate then
                TriggerEvent('lu-diner:items')
                QBCore.Functions.Notify('Unpacking Frozen Food Crate.', 'Success')
            elseif meatcrate then
                TriggerEvent('lu-diner:items')
                QBCore.Functions.Notify('Unpacking Meat Crate.', 'Success')
            else
                QBCore.Functions.Notify('You don\'t have any crates.', 'error')
            end
		else 
			QBCore.Functions.Notify('You must be Clocked into work', 'error')
		end
	end)
end)

RegisterNetEvent('lu-diner:items', function()
    local frozcrate = HasItem('diner_frozencrate', 1)
    local fruitcrate = HasItem('diner_fruitcrate', 1)
    local foodcrate = HasItem('diner_foodcrate', 1)
    local toolcrate = HasItem('diner_toolcrate', 1)
    local meatcrate = HasItem('diner_meatcrate', 1)
    if frozcrate then
        frozecrate = false
        TriggerServerEvent('lu-diner:server:toggleItem',false,'diner_frozencrate',1)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'sweetpotatoep',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'redvelvetcc',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'pcheesecake',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'chocolatecc',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'chocolate',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'gmo_cookies',Config.Food)
        QBCore.Functions.Notify('Ingredients have been unpacked!', 'success')
    elseif fruitcrate then 
        fruitcrate = false 
        TriggerServerEvent('lu-diner:server:toggleItem',false,'diner_fruitcrate',1)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcstrawberry',Config.Glasses)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lclemon',Config.Glasses)

        QBCore.Functions.Notify('Ingredients have been unpacked!', 'success')
    elseif foodcrate then 
        foodcrate = false 
        TriggerServerEvent('lu-diner:server:toggleItem',false,'diner_foodcrate',1)
		TriggerServerEvent('lu-diner:server:toggleItem',true,'lcmshine_sugar',Config.Drink)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcmilk',Config.Food)
		TriggerServerEvent('lu-diner:server:toggleItem',true,'lcteabag',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'water',Config.Drink)
		TriggerServerEvent('lu-diner:server:toggleItem',true,'lcvegoil',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcseasoning',Config.Drink)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'onion',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcpotato',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lccheese',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'hotsauce',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcbread',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcburgerbun',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcveggiepack',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'dijon_mustard',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcmarinara',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'basil',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcegg',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcflour',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'twerks_candy',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcbutter',Config.Food)

        QBCore.Functions.Notify('Ingredients have been unpacked!', 'success')
    elseif toolcrate then 
        toolcrate = false 
        TriggerServerEvent('lu-diner:server:toggleItem',false,'diner_toolcrate',1)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcglassjar',Config.Glasses)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'ice',Config.Glasses)
        QBCore.Functions.Notify('Ingredients have been unpacked!', 'success')
    elseif meatcrate then 
        meatcrate = false 
        TriggerServerEvent('lu-diner:server:toggleItem',false,'diner_meatcrate',1)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcrawbeef',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcbeefpatty',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'rawbacon',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcrawfish',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcrawchicken',Config.Food)
        TriggerServerEvent('lu-diner:server:toggleItem',true,'lcsausage',Config.Food)
        
        QBCore.Functions.Notify('Ingredients have been unpacked!', 'success')
    end 
end)

RegisterNetEvent('lu-diner:client:warehouse', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
		if PlayerData.job.onduty and not IsPedInAnyVehicle(PlayerPedId(), false) then
            if Calledmeat then
                TriggerServerEvent('lu-diner:server:toggleItem',true,'diner_meatcrate',1)
				QBCore.Functions.Notify('Deliver the ingredients back to the Bar', 'success')
				SetNewWaypoint(Config.OrderStockLocation)
				Calledmeat = false
            elseif Calledtools then
                TriggerServerEvent('lu-diner:server:toggleItem',true,'diner_toolcrate',1)
                QBCore.Functions.Notify('Deliver the ingredients back to the Bar', 'success')
                SetNewWaypoint(Config.OrderStockLocation)
                Calledtools = false    
            elseif Calledfood then
                TriggerServerEvent('lu-diner:server:toggleItem',true,'diner_foodcrate',1)
                QBCore.Functions.Notify('Deliver the ingredients back to the Bar', 'success')
                SetNewWaypoint(Config.OrderStockLocation)
                Calledfood = false 
            elseif Calledfruit then
                TriggerServerEvent('lu-diner:server:toggleItem',true,'diner_fruitcrate',1)
                QBCore.Functions.Notify('Deliver the ingredients back to the Bar', 'success')
                SetNewWaypoint(Config.OrderStockLocation)
                Calledfruit = false 
            elseif Calledfrozen then
                TriggerServerEvent('lu-diner:server:toggleItem',true,'diner_frozencrate',1)
                QBCore.Functions.Notify('Deliver the ingredients back to the Bar', 'success')
                SetNewWaypoint(Config.OrderStockLocation)
                Calledfrozen = false 
            else
				QBCore.Functions.Notify('You didnt call the warehouse first..', 'error')
			end
		else 
			QBCore.Functions.Notify('You must be Clocked in', 'error')
		end
	end)
end)

RegisterNetEvent('lu-diner:Client:MakeItem', function(data)
	local bartext = ""
	bartime = 7000
	animDictNow = "anim@heists@prison_heiststation@cop_reactions"
	animNow = "cop_b_idle"
	for i = 1, #Config.CraftingMenus["Icebox"] do
		for k, v in pairs(Config.CraftingMenus["Icebox"][i]) do
			if data.item == k then
				bartext = "Grabbing "
				bartime = 3000
				animDictNow = "mp_ped_interaction"
				animNow = "handshake_guy_a"
			end
		end
	end
    for i = 1, #Config.CraftingMenus["Tap"] do
		for k, v in pairs(Config.CraftingMenus["Tap"][i]) do
			if data.item == k then
				bartext = "Cooking "
				bartime = 3000
				animDictNow = "amb@prop_human_bbq@male@idle_a"
				animNow = "idle_b"
			end
		end
	end
	QBCore.Functions.Progressbar('making_food', bartext..QBCore.Shared.Items[data.item].label, bartime, false, true, { disableMovement = true, disableCarMovement = false, disableMouse = false, disableCombat = false, },
	{ animDict = animDictNow, anim = animNow, flags = 8, },
	{}, {}, function()
		TriggerServerEvent('lu-diner:server:GetItem', data.item, data.craft)
		Wait(500)
	end, function() -- Cancel
		TriggerEvent('inventory:client:busy:status', false)
	end, data.item)
end)

    RegisterNetEvent('lu-diner:client:GrabBag', function(data)
        QBCore.Functions.Progressbar('making_food', "Grabbing Empty To-Go Box", 2000, false, true, { disableMovement = false, disableCarMovement = false, disableMouse = false, disableCombat = false, },
        { animDict = "anim@heists@prison_heiststation@cop_reactions", anim = "cop_b_idle", flags = 8, },
        {}, {}, function()
            TriggerServerEvent("lu-diner:server:GrabBag")
            ClearPedTasks(PlayerPedId())
        end, function() -- Cancel
            TriggerEvent('inventory:client:busy:status', false)
            ClearPedTasks(PlayerPedId())
        end, "bluebox")
    end)

    RegisterNetEvent('lu-diner:Stash', function(data, stash)
        if stash then -- If it has a bag ID then open the limited stash
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "Diner_"..stash, { maxweight = 20000, slots = 5, })
            TriggerEvent("inventory:client:SetCurrentStash", "Diner_"..stash)
        else
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "Diner_"..data.stash)
            TriggerEvent("inventory:client:SetCurrentStash", "Diner_"..data.stash)
        end
    end)