--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                     PLANTING POT                     | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_PLANTING_POT = {
    TypeName = "BUILDING_FUNCTION_PLANTING_POT",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "PlantPositionNodeName", Type = "string", Default = "PlantPosition" }
    }
}

function BUILDING_FUNCTION_PLANTING_POT:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    gameObject:forEachChild(
        function(child)
            if starts_with(child.Name, self.PlantPositionNodeName) then
                local comp = child:getOrCreateComponent("COMP_PLANTING_POT")
            end
        end
    )
    
    return true
end

function BUILDING_FUNCTION_PLANTING_POT:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")

end

EBF:registerClass(BUILDING_FUNCTION_PLANTING_POT)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_PLANTING_POT = {
	TypeName = "COMP_PLANTING_POT",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "IsOccupied", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } },
        { Name = "CurrentDay", Type = "integer", Default = 0, Flags = { "SAVE_GAME" } },
        { Name = "CurrentPlant", Type = "GAME_OBJECT", Default = nil, Flags = { "SAVE_GAME" } }
    }
}

function COMP_PLANTING_POT:isOccupied()
	return self.IsOccupied
end

function COMP_PLANTING_POT:setOccupied(flag)
	self.IsOccupied = flag
end

function COMP_PLANTING_POT:advanceDay()
    self.CurrentDay = self.CurrentDay + 1
    
    return self.CurrentDay
end

function COMP_PLANTING_POT:growingStep(stepName)
    self.CurrentPlant:forEachChild(
        function(child)
            if starts_with(child.Name, "Base") then
                return
            elseif ends_with(child.Name, "Keep") then
                return
            elseif starts_with(child.Name, stepName) then
                child:setScale(1)
            else
                child:setScale(0)
            end
        end
    )
    
    return self.CurrentPlant
end

EBF:registerClass(COMP_PLANTING_POT)