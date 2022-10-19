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
    ParentType = "BUILDING_FUNCTION_WORKPLACE",
    Properties = {
        { Name = "Plantable", Type = "PREFAB", Default = nil },
        { Name = "PlantingDelay", Type = "float", Default = 30.0 },
        { Name = "GatheringDelay", Type = "float", Default = 30.0 },
        { Name = "GrowingStepList", Type = "GROWING_STEP_LIST", Default = nil }
        --{ Name = "GrowingStepList", Type = "list<GROWING_STEP>", Default = nil }
    }
}

function BUILDING_FUNCTION_PLANTATION:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")

    local compWorkplace = gameObject:getOrCreateComponent("COMP_WORKPLACE")
    compWorkplace:setWorkplaceData(self)

    local compPlantation = gameObject:getOrCreateComponent("COMP_PLANTATION")
    compPlantation:setPlantationData(self)

    return true
end

function BUILDING_FUNCTION_PLANTATION:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    self:activateBuilding(gameObject)
    local compPlantation = gameObject:getEnabledComponent("COMP_PLANTATION")
    compPlantation:initPlants()
end

EBF:registerClass(BUILDING_FUNCTION_PLANTATION)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_PLANTATION = {
	TypeName = "COMP_PLANTATION",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "Plantable", Type = "PREFAB", Default = nil },
        { Name = "PlantingDelay", Type = "float", Default = 30.0 },
        { Name = "GatheringDelay", Type = "float", Default = 30.0 },
        { Name = "GrowingStepList", Type = "GROWING_STEP_LIST", Default = nil }
        --{ Name = "GrowingStepList", Type = "list<GROWING_STEP>", Default = nil }
    }
}

function COMP_PLANTATION:create()
    self.DataDelivered = false
end

function COMP_PLANTATION:init()
    local compMainGameLoop = self:getLevel():find("COMP_MAIN_GAME_LOOP")
    event.register(self, compMainGameLoop.ON_NEW_DAY,
        function()
            local building = self:getOwner():findFirstObjectWithComponentUp("COMP_BUILDING")
            building:getBuildingPartList():forEach(
                function(buildingPart)
                    buildingPart:getOwner():forEachChild(
                        function(child)
                            local compPot = child:getEnabledComponent("COMP_PLANTING_POT")
                            if (compPot ~= nil and compPot:isOccupied()) then
                                if compPot.CurrentDay <= self.GrowingStepList.Days[#self.GrowingStepList.Days] then
                                    local newDay = compPot:advanceDay()
                                    for i, day in ipairs(self.GrowingStepList.Days) do
                                        if day == newDay then
                                            compPot:growingStep(self.GrowingStepList.Steps[i])
                                            if i == #self.GrowingStepList.Days then
                                                compPot:setGrown(true)
                                            end
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    )
                end
            )
        end
    )
end

function COMP_PLANTATION:setPlantationData(buildingFunctionPlantation)
    self.Plantable = buildingFunctionPlantation.Plantable
    self.PlantingDelay = buildingFunctionPlantation.PlantingDelay
    self.GatheringDelay = buildingFunctionPlantation.GatheringDelay
    self.TendingDelay = buildingFunctionPlantation.TendingDelay

    local GrowingStepList = foundation.createData(
        {
            DataType = "GROWING_STEP_LIST",
            Days = buildingFunctionPlantation.GrowingStepList.Days,
            Steps = buildingFunctionPlantation.GrowingStepList.Steps
        }
    )
    self.GrowingStepList = GrowingStepList

    self.DataDelivered = true
end

function COMP_PLANTATION:initPlants()
    local building = self:getOwner():findFirstObjectWithComponentUp("COMP_BUILDING")
    building:getBuildingPartList():forEach(
        function(buildingPart)
            buildingPart:getOwner():forEachChild(
                function(child)
                    local compPot = child:getEnabledComponent("COMP_PLANTING_POT")
                    if (compPot ~= nil and compPot:isOccupied()) then
                        compPot:initPlant()
                        local currentDay = compPot.CurrentDay
                        for i, day in ipairs(self.GrowingStepList.Days) do
                            if currentDay >= day then
                                compPot:growingStep(self.GrowingStepList.Steps[i])
                            end
                        end
                    end
                end
            )
        end
    )
end

EBF:registerClass(COMP_PLANTATION)