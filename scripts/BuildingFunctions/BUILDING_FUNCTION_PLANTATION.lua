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

local COMP_PLANTING_POT = {
	TypeName = "COMP_PLANTING_POT",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "IsOccupied", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } }
    }
}

function COMP_PLANTING_POT:isOccupied()
	return self.IsOccupied
end

function COMP_PLANTING_POT:setOccupied(flag)
	self.IsOccupied = flag
end

EBF:registerClass(COMP_PLANTING_POT)


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
    
end

function COMP_PLANTATION:setPlantationData(buildingFunctionPlantation)
    
    
    self.DataDelivered = true
end

function COMP_PLANTATION:update()
    
end

EBF:registerClass(COMP_PLANTATION)