--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                      PLANTATION                      | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_PLANTATION = {
    TypeName = "BUILDING_FUNCTION_PLANTATION",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "Plantable", Type = "PREFAB", Default = nil },
        { Name = "GrowingStepList", Type = "list<GROWING_STEP>", Default = nil },
        { Name = "ResourceData", Type = "RESOURCE", Default = nil },
        { Name = "AvailableQuantity", Type = "integer", Default = 1 }
    }
}

function BUILDING_FUNCTION_PLANTATION:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    
    return true
end

function BUILDING_FUNCTION_PLANTATION:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")

end

EBF:registerClass(BUILDING_FUNCTION_PLANTATION)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_PLANTATION = {
	TypeName = "COMP_PLANTATION",
	ParentType = "COMPONENT",
	Properties = {
        
    }
}

function COMP_PLANTATION:create()
    self.DataDelivered = false
end

function COMP_PLANTATION:init()
    local compMainGameLoop = self:getLevel():find("COMP_MAIN_GAME_LOOP")
    event.register(self, compMainGameLoop.ON_NEW_DAY, 
        function()
            parts = self:getOwner():getComponent("COMP_BUILDING"):getBuildingPartList()
        end
    )
end

function COMP_PLANTATION:setPlantationData(buildingFunctionPlantation)
    
    
    self.DataDelivered = true
end

function COMP_PLANTATION:update()
    
end

EBF:registerClass(COMP_PLANTATION)