--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                     ROOF TOGGLE                      | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_ROOF_TOGGLE = {
    TypeName = "BUILDING_FUNCTION_ROOF_TOGGLE",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "RoofNodeName", Type = "string", Default = "Roof" },
    }
}

function BUILDING_FUNCTION_ROOF_TOGGLE:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    local building = gameObject:findFirstObjectWithComponentUp("COMP_BUILDING")
    local parts = building:getBuildingPartList()

    for i=1,#parts do
        if starts_with(parts[i]:getOwner().Name, self.RoofNodeName) then
            parts[i]:getOwner().Active = false
        --[[
        else
            parts[i]:getOwner():forEachChildRecursive(
                function(child)
                    if starts_with(child.Name, self.RoofNodeName) then
                        child.Active = false
                    end
                end
            )]]--
        end
    end

    return true
end

function BUILDING_FUNCTION_ROOF_TOGGLE:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    self:activateBuilding(gameObject)
end

function BUILDING_FUNCTION_ROOF_TOGGLE:removeBuildingFunction(gameObject)
    --EBF:log("Building Function Remove")
    local building = gameObject:findFirstObjectWithComponentUp("COMP_BUILDING")
    local parts = building:getBuildingPartList()

    for i=1,#parts do
        if starts_with(parts[i]:getOwner().Name, self.RoofNodeName) then
            parts[i]:getOwner().Active = true
        --[[
        else
            parts[i]:getOwner():forEachChildRecursive(
                function(child)
                    if starts_with(child.Name, self.RoofNodeName) then
                        child.Active = true
                    end
                end
            )]]--
        end
    end
end

EBF:registerClass(BUILDING_FUNCTION_ROOF_TOGGLE)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--
