--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                       PLANTER                        | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_PLANTER = {
    TypeName = "BUILDING_FUNCTION_PLANTER",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "PlantPositionNodeName", Type = "string", Default = "PlantPosition" },
        { Name = "FollowPlantingPath", Type = "boolean", Default = false },
        { Name = "PlantingAnimation", Type = "string", Default = "SEED" },
        { Name = "GatheringAnimation", Type = "string", Default = "GATHER" },
        { Name = "GatheringRadius", Type = "float", Default = 0.85 },
        { Name = "PlantingRadius", Type = "float", Default = 0.50 }
    }
}

function BUILDING_FUNCTION_PLANTER:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    local compPlanter = gameObject:getOrCreateComponent("COMP_PLANTER")
    compPlanter:setPlanterData(self)
    compPlanter:createPots(gameObject, self.PlantPositionNodeName)

    return true
end

function BUILDING_FUNCTION_PLANTER:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    self:activateBuilding(gameObject)
end

EBF:registerClass(BUILDING_FUNCTION_PLANTER)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_PLANTER = {
	TypeName = "COMP_PLANTER",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "FollowPlantingPath", Type = "boolean", Default = false },
        { Name = "PlantingAnimation", Type = "string", Default = "SEED" },
        { Name = "GatheringAnimation", Type = "string", Default = "GATHER" },
        { Name = "GatheringRadius", Type = "float", Default = 0.85 },
        { Name = "PlantingRadius", Type = "float", Default = 0.50 }
    }
}

function COMP_PLANTER:setPlanterData(buildingFunctionPlanter)
    self.FollowPlantingPath = buildingFunctionPlanter.FollowPlantingPath
    self.PlantingAnimation = buildingFunctionPlanter.PlantingAnimation
    self.GatheringAnimation = buildingFunctionPlanter.GatheringAnimation
    self.GatheringRadius = buildingFunctionPlanter.GatheringRadius
    self.PlantingRadius = buildingFunctionPlanter.PlantingRadius
end

function COMP_PLANTER:createPots(gameObject, nodeName)
    gameObject:forEachChild(
        function(child)
            if starts_with(child.Name, nodeName) then
                local comp = child:getOrCreateComponent("COMP_PLANTING_POT")
            end
        end
    )
end

EBF:registerClass(COMP_PLANTER)

local COMP_PLANTING_POT = {
	TypeName = "COMP_PLANTING_POT",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "IsTargeted", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } },
        { Name = "IsOccupied", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } },
        { Name = "IsGrown", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } },
        { Name = "CurrentDay", Type = "integer", Default = 0, Flags = { "SAVE_GAME" } },
        { Name = "CurrentPlant", Type = "GAME_OBJECT", Default = nil, Flags = { "SAVE_GAME" } }
    }
}

function COMP_PLANTING_POT:isTargeted()
	return self.IsTargeted
end

function COMP_PLANTING_POT:setTargeted(flag)
	self.IsTargeted = flag
end

function COMP_PLANTING_POT:isOccupied()
	return self.IsOccupied
end

function COMP_PLANTING_POT:setOccupied(flag, gameObject)
	self.IsOccupied = flag
    self.CurrentPlant = gameObject
end

function COMP_PLANTING_POT:isGrown()
	return self.IsGrown
end

function COMP_PLANTING_POT:setGrown(flag)
	self.IsGrown = flag
end

function COMP_PLANTING_POT:resetPot()
	self.IsOccupied = false
    self.IsGrown = false
    self.CurrentDay = 0
    self.CurrentPlant = nil
end

function COMP_PLANTING_POT:advanceDay()
    self.CurrentDay = self.CurrentDay + 1
    
    return self.CurrentDay
end

function COMP_PLANTING_POT:initPlant()
    self.CurrentPlant:forEachChild(
        function(child)
            if starts_with(child.Name, "Base") then
                return
            else
                --child:setScale(0)
                child.Active = false
            end
        end
    )
end

function COMP_PLANTING_POT:growingStep(stepName)
    --EBF:log("Plant Growing: " .. stepName)
    self.CurrentPlant:forEachChild(
        function(child)
            if starts_with(child.Name, "Base") then
                return
            elseif starts_with(child.Name, stepName) then
                --child:setScale(1)
                child.Active = true
            elseif ends_with(child.Name, "Keep") then
                return
            else
                --child:setScale(0)
                child.Active = false
            end
        end
    )
end

function COMP_PLANTING_POT:onDestroy(isClearingLevel)
    if (not isClearingLevel) and self.CurrentPlant ~= nil then
        self.CurrentPlant:destroy()
    end
end

EBF:registerClass(COMP_PLANTING_POT)

local COMP_PLANTATION_PLANTABLE = {
	TypeName = "COMP_PLANTATION_PLANTABLE",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "PlantingPot", Type = "COMP_PLANTING_POT", Default = nil, Flags = { "SAVE_GAME" } }
    }
}

function COMP_PLANTATION_PLANTABLE:setPot(comp)
    self.PlantingPot = comp
end

function COMP_PLANTATION_PLANTABLE:onDestroy(isClearingLevel)
    if not isClearingLevel then
        self.PlantingPot:resetPot()
    end
end

EBF:registerClass(COMP_PLANTATION_PLANTABLE)