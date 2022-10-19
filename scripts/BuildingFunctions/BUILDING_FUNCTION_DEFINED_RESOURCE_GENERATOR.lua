--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |              DEFINED RESOURCE GENERATOR              | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR = {
    TypeName = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "ResourceGenerator", Type = "BUILDING_FUNCTION_RESOURCE_GENERATOR", Default = "BUILDING_FUNCTION_WELL"},
        { Name = "MaxQuantity", Type = "integer", Default = 1000 },
        { Name = "GrowRate", Type = "float", Default = 1.0 }
    }
}

function BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR:activateBuilding(gameObject)
    local comp = gameObject:getOrCreateComponent("COMP_RESOURCE_GENERATOR")
    comp:setResourceGeneratorData(self.ResourceGenerator)
    comp:setMaxQuantity(self.MaxQuantity)
    comp.GrowRate = self.GrowRate

    return true
end

function BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR:reloadBuildingFunction(gameObject)
    self:activateBuilding(gameObject)
end

EBF:registerClass(BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR)