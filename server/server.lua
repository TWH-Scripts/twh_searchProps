local VORPcore = {}
local VorpInv = {}

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

TriggerEvent("getCore", function(core)
    VORPcore = core
end)


local alreadySearched = {}
local alreadySearchedProp = {}

RegisterServerEvent("twh_searchProps:interactionLoot")
AddEventHandler("twh_searchProps:interactionLoot", function(searcher,searched,model)
    local _source = source
    local User = VORPcore.getUser(_source) 
    local Character = User.getUsedCharacter
    local entityModel = model

    if not alreadySearched[searched] then
        alreadySearched[searched] = searcher
        local found = false
        if Config.interactionLoot[entityModel] then
            for k, v in pairs(Config.interactionLoot[entityModel].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item) : caseof {
                        ["money"]   = function()
                            Character.addCurrency(0, v.amount)
    
                        end,
                        ["gold"]   = function()
                            Character.addCurrency(1, v.amount)
    
                        end,
                        default = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                        end
                    }         
                end
                
            end
        else
            for k, v in pairs(Config.interactionLoot["default"].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item) : caseof {
                        ["money"]   = function()
                            Character.addCurrency(0, v.amount)
    
                        end,
                        ["gold"]   = function()
                            Character.addCurrency(1, v.amount)
    
                        end,
                        default = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                        end
                    }         
                end
                
            end
        end
        Citizen.Wait(1000)
        if found then
            VORPcore.NotifyRightTip(_source,_U("found"),4000)
        else
            VORPcore.NotifyRightTip(_source,_U("nothingFound"),4000)
        end
        

    else
        if Config.alreadySearchedMessage then
            Citizen.Wait(1000)
            VORPcore.NotifyRightTip(_source,_U("alreadySearched"),4000)
        end  
    end

end)



RegisterServerEvent("twh_searchProps:propLoot")
AddEventHandler("twh_searchProps:propLoot", function(prop,coords)
    local _source = source
    local User = VORPcore.getUser(_source)
    local Character = User.getUsedCharacter

    local propFound = false
    if alreadySearchedProp[prop] then
        for k, v in pairs(alreadySearchedProp[prop]) do
            print(v)
            print(v.x)
            if CheckPos(coords.x,coords.y,coords.z,v.x,v.y,v.z,2) then
                propFound = true
            end
        end
        alreadySearchedProp[prop][#alreadySearchedProp[prop]+1] = coords 
    else
        alreadySearchedProp[prop] = {coords}
    end

    if not propFound then
        local found = false
        if Config.propLoot[prop] then
            for k, v in pairs(Config.propLoot[prop].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item) : caseof {
                        ["money"]   = function()
                            Character.addCurrency(0, v.amount)
    
                        end,
                        ["gold"]   = function()
                            Character.addCurrency(1, v.amount)
    
                        end,
                        default = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                        end
                    }         
                end
                
            end
        else
            for k, v in pairs(Config.propLoot["default"].loot) do
                local chance = math.random()
                if chance <= v.chance then
                    found = true
                    switch(v.item) : caseof {
                        ["money"]   = function()
                            Character.addCurrency(0, v.amount)
    
                        end,
                        ["gold"]   = function()
                            Character.addCurrency(1, v.amount)
    
                        end,
                        default = function()
                            VorpInv.addItem(_source, v.item, v.amount)
                        end
                    }         
                end
                
            end
        end
        Citizen.Wait(1000)
        if found then
            VORPcore.NotifyRightTip(_source,_U("found"),4000)
        else
            VORPcore.NotifyRightTip(_source,_U("nothingFound"),4000)
        end
        

    else
        if Config.alreadySearchedMessage then
            Citizen.Wait(1000)
            VORPcore.NotifyRightTip(_source,_U("alreadySearched"),4000)
        end  
    end

end)