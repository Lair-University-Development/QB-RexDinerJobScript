print("^2LU^7-^2diner ^7v^41^7.^45 ^7- ^2diner Script by ^1Eliza Lasal^7")

-- If you need support I now have a discord available, it helps me keep track of issues and give better support.

-- https://discord.gg/7jUCGyKXMT
Config = {}

Config.Inventory = 'ps-inventory'

Config.Debug = false
Config.LoungeLocation = vector4(2539.12, 2586.55, 38.5, 155.2)
Config.WarehouseLocation = vector4(2704.03, 3457.5, 55.54, 343.93)
Config.OrderStockLocation = vector4(2544.97, 2579.22, 38.5, 182.42) 

Config.JobIsRequired = true
Config.JobName = {
    ['hoc'] = { bartender = 0, cigars = 2, attendant = 3, management = 4},
}
Config.StockPrice = 10000

-- Number of Items Per Delivery
Config.Glasses = 500
Config.Food = 50
Config.Drink = 125

Config.DutyLocations = {
    vector4(2545.15, 2582.75, 38.5, 260.01)
}

Config.DStorage = {
    vector4(2529.15, 2579.39, 38.5, 189.63),
    vector4(2533.0, 2584.21, 38.43, 178.33)
}

Config.DIceMakers = {
    vector4(2542.7, 2585.07, 38.43, 174.41)
}

Config.DTaps = { --grill
    vector4(2540.64, 2581.69, 38.35, 267.73),
    vector4(2540.5, 2579.02, 37.75, 235.37)
}

Config.DFridges = {
    vector4(2537.82, 2585.23, 38.66, 178.58),
    vector4(2536.18, 2582.66, 38.5, 0.36)
}

Config.DBarLocations = {
    vector4(2543.28, 2586.47, 38.66, 357.45),
    vector4(2536.33, 2585.18, 38.66, 181.45)
}

Config.DRollingLocations = {--bagging
    vector4(2535.88, 2578.99, 38.37, 176.79)

}


--Diner Settings

Config.CraftingMenus = {
    ["Icebox"] = {
        {
            ['ice'] = {
                
            },
            ["amount"] = 10
        }
    },
    ["Tap"] = {
        {
            ['lcsteak'] = {
                ['lcrawbeef'] = 5,
                ['lcseasoning'] = 1,
                ['lcvegoil'] = 1,
                
            },
            ["amount"] = 5
        },
        {
            ['burgerpatty'] = {
                ['lcbeefpatty'] = 5,
                ['lcseasoning'] = 1,
                ['lcvegoil'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['basket_fries'] = {
                ['slicedpotato'] = 3,
                ['lcseasoning'] = 1,
                ['lcvegoil'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['onionrings'] = {
                ['slicedonion'] = 5,
                ['lcseasoning'] = 1,
                ['lcvegoil'] = 1,
                ['lcflour'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['bacon'] = {
                ['rawbacon'] = 3,
                ['lcseasoning'] = 1,
                ['lcvegoil'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['lcfriedchicken'] = {
                ['lcrawchicken'] = 3,
                ['lcseasoning'] = 1,
                ['lcvegoil'] = 1,
                ['lcflour'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['lcfriedfish'] = {
                ['lcrawfish'] = 3,
                ['lcseasoning'] = 1,
                ['lcvegoil'] = 1,
                ['lcflour'] = 1,
            },
            ["amount"] = 5
        },
    },

    ["RollingTables"] = {
        {
            ['slicedonion'] = {
                ['onion'] = 5,
            },
            ["amount"] = 5
        },
        {
            ['slicedpotato'] = {
                ['lcpotato'] = 5,
            },
            ["amount"] = 5
        },

        {
            ['steakburger'] = {
                ['lcburgerbun'] = 3,
                ['lcsteak'] = 3,
                ['lccheese'] = 3,
                ['bacon'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['bcfries'] = {
                ['basket_fries'] = 3,
                ['lccheese'] = 3,
                ['bacon'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['hot_wings'] = {
                ['hotsauce'] = 3,
                ['lcfriedchicken'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['chopcheese'] = {
                ['lcsteak'] = 3,
                ['lccheese'] = 3,
                ['slicedonion'] = 3,
                ['lcbread'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['hamburgerfries'] = {
                ['lcburgerbun'] = 3,
                ['burgerpatty'] = 3,
                ['basket_fries'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['vw'] = {
                ['lcveggiepack'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['ftb'] = {
                ['lcbread'] = 3,
                ['bacon'] = 3,
                ['lcseasoning'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['fish_taco'] = {
                ['lcfriedfish'] = 3,
                ['lcveggiepack'] = 3,
                ['lcbread'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['eggsbacon'] = {
                ['bacon'] = 3,
                ['lcegg'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['coney'] = {
                ['lcbread'] = 3,
                ['lcsausage'] = 3,
                ['burgerpatty'] = 3,
                ['slicedonion'] = 3,
                ['dijon_mustard'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['chilli_dog'] = {
                ['lcbread'] = 3,
                ['lcsausage'] = 3,
                ['burgerpatty'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['cstrip'] = {
                ['lcfriedchicken'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['ccw'] = {
                ['lcfriedchicken'] = 3,
                ['lcveggiepack'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['sirloinsteak'] = {
                ['lcsteak'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['steak_potato'] = {
                ['lcsteak'] = 3,
                ['basket_fries'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['shephards_pie'] = {
                ['lcveggiepack'] = 3,
                ['slicedpotato'] = 3,
                ['lcseasoning'] = 3,
                ['slicedonion'] = 3,
                ['lcbutter'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['smeatballs'] = {
                ['burgerpatty'] = 3,
                ['lcmarinara'] = 3,
                ['basil'] = 3,
            },
            ["amount"] = 5
        }
    },

    ["CustomDrinks"] = {
        --Add Custom Drinks Here
	    {
            ['glass_of_bk'] = {
                ['lcmshine_sugar'] = 3,
                ['ice'] = 3,
                ['water'] = 3,
                ['lcglassjar'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_rk'] = {
                ['lcmshine_sugar'] = 3,
                ['ice'] = 3,
                ['water'] = 3,
                ['lcglassjar'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_cs'] = {
                ['lcmshine_sugar'] = 3,
                ['ice'] = 3,
                ['lcmilk'] = 3,
                ['twerks_candy'] = 3,
                ['lcglassjar'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_ccs'] = {
                ['lcmshine_sugar'] = 5,
                ['ice'] = 5,
                ['lcmilk'] = 5,
                ['chocolate'] = 5,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_ccs2'] = {
                ['lcmshine_sugar'] = 3,
                ['ice'] = 3,
                ['lcmilk'] = 3,
                ['gmo_cookies'] = 3,
                ['lcglassjar'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_bg'] = {
                ['lcglassjar'] = 3,
                ['ice'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_fl'] = {
                ['lcmshine_sugar'] = 3,
                ['ice'] = 3,
                ['water'] = 3,
                ['lclemon'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_hc'] = {
                ['lcmshine_sugar'] = 3,
                ['ice'] = 3,
                ['water'] = 3,
                ['chocolate'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_tl'] = {
                ['lcglassjar'] = 3,
                ['ice'] = 3,
                ['glass_of_fl'] = 3,
                ['lcteabag'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_sl'] = {
                ['lcglassjar'] = 3,
                ['ice'] = 3,
                ['glass_of_fl'] = 3,
                ['lcstrawberry'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_sm'] = {
                ['lcmshine_sugar'] = 3,
                ['ice'] = 3,
                ['lcmilk'] = 3,
                ['lcstrawberry'] = 3,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_belaire_luc_rare_rose'] = {
                ['wine_glass'] = 3,
                ['ice'] = 3,
                ['belaire_luc_rare_rose'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_cabernet_sauvignon'] = {
                ['wine_glass'] = 3,
                ['ice'] = 3,
                ['cabernet_sauvignon'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_merlot'] = {
                ['wine_glass'] = 3,
                ['ice'] = 3,
                ['merlot'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_chardonnay'] = {
                ['wine_glass'] = 3,
                ['ice'] = 3,
                ['chardonnay'] = 1,
            },
            ["amount"] = 5
        },
        {
            ['glass_of_pinot_grigio'] = {
                ['wine_glass'] = 3,
                ['ice'] = 3,
                ['pinot_grigio'] = 1,
            },
            ["amount"] = 5
        }
    },
}