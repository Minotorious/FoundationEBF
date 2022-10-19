--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                     PRODUCE TREE                     | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_PRODUCE_TREE = {
    TypeName = "BUILDING_FUNCTION_PRODUCE_TREE",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "DefaultSpawners", Type = "integer", Default = 6 },
        { Name = "SpawnerIncrease", Type = "integer", Default = 1 },
        { Name = "SpawnerIncreaseNodeName", Type = "string", Default = "SpawnerIncrease" },
        { Name = "SpawnerNodeName", Type = "string", Default = "ResourceSpawner" },
        { Name = "SpawnerScaling", Type = "boolean", Default = true },
        { Name = "SpawnerScalingSpeed", Type = "float", Default = 0.001 },
        { Name = "DaysToSpawn", Type = "integer", Default = 21 },
        { Name = "ResourceContainer", Type = "PREFAB", Default = nil },
        { Name = "ResourceContainersPerSpawner", Type = "integer", Default = 5 },
        { Name = "ResourceContainerFallingSpeed", Type = "vec2f", Default = { 0.4, 0.6 } }
    }
}

function BUILDING_FUNCTION_PRODUCE_TREE:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")

    local comp = gameObject:getOrCreateComponent("COMP_PRODUCE_TREE")
    comp:setProduceTreeData(self)
    comp:calculateNoSpawners()

    return true
end

function BUILDING_FUNCTION_PRODUCE_TREE:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    local comp = gameObject:getOrCreateComponent("COMP_PRODUCE_TREE")
    comp:setProduceTreeData(self)
end

EBF:registerClass(BUILDING_FUNCTION_PRODUCE_TREE)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local function randomFloat(low, high)
    return low + math.random()  * (high - low);
end

local COMP_FALLING_RESOURCE_CONTAINER = {
	TypeName = "COMP_FALLING_RESOURCE_CONTAINER",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "ResourceContainerFallingSpeed", Type = "float", Default = 1.0, Flags = { "SAVE_GAME" } },
        { Name = "GroundLevel", Type = "float", Default = 0.0, Flags = { "SAVE_GAME" } }
    }
}

function COMP_FALLING_RESOURCE_CONTAINER:update()
    local dt = self:getLevel():getDeltaTime()
    local pos = self:getOwner():getGlobalPosition()
    if pos.y > self.GroundLevel then
        self:getOwner():move({ 0, -self.ResourceContainerFallingSpeed*dt, 0 })
    else
        self:getOwner():setGlobalPosition({ pos.x, self.GroundLevel, pos.z })
        self:getOwner():removeComponent(self)
        --EBF:log("Falling Resource Container Component Removed")
    end
end

EBF:registerClass(COMP_FALLING_RESOURCE_CONTAINER)

local COMP_PRODUCE_TREE = {
	TypeName = "COMP_PRODUCE_TREE",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "DefaultSpawners", Type = "integer", Default = 6 },
        { Name = "SpawnerIncrease", Type = "integer", Default = 1 },
        { Name = "SpawnerIncreaseNodeName", Type = "string", Default = "SpawnerIncrease" },
        { Name = "SpawnerNodeName", Type = "string", Default = "ResourceSpawner" },
        { Name = "SpawnerScaling", Type = "boolean", Default = true },
        { Name = "SpawnerScalingSpeed", Type = "float", Default = 0.001 },
        { Name = "DaysToSpawn", Type = "integer", Default = 21 },
        { Name = "ResourceContainer", Type = "PREFAB", Default = nil },
        { Name = "ResourceContainersPerSpawner", Type = "integer", Default = 5 },
        { Name = "ResourceContainerFallingSpeedRange", Type = "vec2f", Default = { 0.8, 1.2 } },
        { Name = "ResourceContainerIdList", Type = "list<string>", Default = nil, Flags = { "SAVE_GAME" } },
        { Name = "CurrentScaling", Type = "float", Default = 0.0, Flags = { "SAVE_GAME" } },
        { Name = "CurrentDay", Type = "integer", Default = 0, Flags = { "SAVE_GAME" } },
        { Name = "NoSpawners", Type = "integer", Default = 0, Flags = { "SAVE_GAME" } }
    }
}

function COMP_PRODUCE_TREE:create()
    self.DataDelivered = false
    self.Sequence = 0
end

function COMP_PRODUCE_TREE:raycast(pos)
    local raycastResultTerrain = {}
    local FromPosition = { pos[1], pos[2]+100, pos[3] }
    local ToPosition = { pos[1], pos[2]-100, pos[3] }
    local flagTerrain = bit.bor(bit.lshift(1, OBJECT_FLAG.TERRAIN:toNumber()))

    self:getLevel():rayCast(FromPosition, ToPosition, raycastResultTerrain, flagTerrain)

    return raycastResultTerrain.Position.y
end

function COMP_PRODUCE_TREE:setStartingScaling()
    --EBF:log("Setting Starting Scaling: " .. tostring(self.CurrentScaling))
    local i = 0
    if self.SpawnerScaling == true then
        self:getOwner():forEachChild(
            function(child)
                if i < self.NoSpawners then
                    if starts_with(child.Name, self.SpawnerNodeName) then
                        i = i + 1
                        child:setScale(self.CurrentScaling)
                    end
                end
            end
        )
    end
end

function COMP_PRODUCE_TREE:triggerSpawning()
    --EBF:log("Spawn!!!")
    self:deleteResourceContainers()
    self:getOwner():forEachChild(
        function(child)
            if starts_with(child.Name, self.SpawnerNodeName) then
                if child.Scale.x == 1 then
                    --EBF:log(child.Name)
                    self:resourceContainerSpawningSequence(child:getGlobalPosition())
                end
            end
        end
    )
    self:calculateNoSpawners()
    self.CurrentScaling = 0
    self.Sequence = 0
    self.CurrentDay = 0
end

function COMP_PRODUCE_TREE:init()
    local compMainGameLoop = self:getLevel():find("COMP_MAIN_GAME_LOOP")
    event.register(self, compMainGameLoop.ON_NEW_DAY, 
        function()
            self.CurrentDay = self.CurrentDay + 1
            if self.CurrentDay >= self.DaysToSpawn then
                self:triggerSpawning()
            end
        end
    )
end

function COMP_PRODUCE_TREE:addToResourceContainerIdList(entry)
    table.insert(self.ResourceContainerIdList, entry)
end

function COMP_PRODUCE_TREE:setProduceTreeData(buildingFunctionProduceTree)
    self.DefaultSpawners = buildingFunctionProduceTree.DefaultSpawners
    self.SpawnerIncrease = buildingFunctionProduceTree.SpawnerIncrease
    self.SpawnerIncreaseNodeName = buildingFunctionProduceTree.SpawnerIncreaseNodeName
    self.SpawnerNodeName = buildingFunctionProduceTree.SpawnerNodeName
    self.SpawnerScaling = buildingFunctionProduceTree.SpawnerScaling
    self.SpawnerScalingSpeed = buildingFunctionProduceTree.SpawnerScalingSpeed
    self.DaysToSpawn = buildingFunctionProduceTree.DaysToSpawn
    self.ResourceContainer = buildingFunctionProduceTree.ResourceContainer
    self.ResourceContainerComponent = buildingFunctionProduceTree.ResourceContainerComponent
    self.ResourceContainersPerSpawner = buildingFunctionProduceTree.ResourceContainersPerSpawner
    self.ResourceContainerFallingSpeed = buildingFunctionProduceTree.ResourceContainerFallingSpeed

    self.DataDelivered = true
end

function COMP_PRODUCE_TREE:update()
    if self.DataDelivered == true then
        if self.Sequence == 0 then
            self:spawnerResetSequence()
            self:setStartingScaling()
            self.Sequence = 1
        elseif self.Sequence == 1 then
            self:spawnerScalingSequence()
        end
    end
end

function COMP_PRODUCE_TREE:resourceContainerSpawningSequence(centerPos)
    --EBF:log("Spawning Resource Containers")
    local spawnPos = 1
    for i=1,self.ResourceContainersPerSpawner do
        if spawnPos == 1 then
            local position = { centerPos.x, centerPos.y, centerPos.z }
            local orientation = { 0, 0, 0, 1 }
            quaternion.setEulerAngles(orientation, { 0, math.random(-90, 90), 0 })
            local resourceContainer = self:getLevel():createObject(self.ResourceContainer, position, orientation)
            local comp = resourceContainer:getOrCreateComponent("COMP_FALLING_RESOURCE_CONTAINER")
            comp.ResourceContainerFallingSpeed = randomFloat(self.ResourceContainerFallingSpeedRange.x, self.ResourceContainerFallingSpeedRange.y)
            comp.GroundLevel = self:raycast(position)
            self:addToResourceContainerIdList(resourceContainer:getId())
            spawnPos = 2
        elseif spawnPos == 2 then
            local position = { centerPos.x-0.2, centerPos.y, centerPos.z }
            local orientation = { 0, 0, 0, 1 }
            local resourceContainer = self:getLevel():createObject(self.ResourceContainer, position, orientation)
            local comp = resourceContainer:getOrCreateComponent("COMP_FALLING_RESOURCE_CONTAINER")
            comp.ResourceContainerFallingSpeed = randomFloat(self.ResourceContainerFallingSpeedRange.x, self.ResourceContainerFallingSpeedRange.y)
            comp.GroundLevel = self:raycast(position)
            self:addToResourceContainerIdList(resourceContainer:getId())
            spawnPos = 3
        elseif spawnPos == 3 then
            local position = { centerPos.x+0.2, centerPos.y, centerPos.z }
            local orientation = { 0, 0, 0, 1 }
            quaternion.setEulerAngles(orientation, { 0, math.random(-90, 90), 0 })
            local resourceContainer = self:getLevel():createObject(self.ResourceContainer, position, orientation)
            local comp = resourceContainer:getOrCreateComponent("COMP_FALLING_RESOURCE_CONTAINER")
            comp.ResourceContainerFallingSpeed = randomFloat(self.ResourceContainerFallingSpeedRange.x, self.ResourceContainerFallingSpeedRange.y)
            comp.GroundLevel = self:raycast(position)
            self:addToResourceContainerIdList(resourceContainer:getId())
            spawnPos = 4
        elseif spawnPos == 4 then
            local position = { centerPos.x, centerPos.y, centerPos.z-0.2 }
            local orientation = { 0, 0, 0, 1 }
            quaternion.setEulerAngles(orientation, { 0, math.random(-90, 90), 0 })
            local resourceContainer = self:getLevel():createObject(self.ResourceContainer, position, orientation)
            local comp = resourceContainer:getOrCreateComponent("COMP_FALLING_RESOURCE_CONTAINER")
            comp.ResourceContainerFallingSpeed = randomFloat(self.ResourceContainerFallingSpeedRange.x, self.ResourceContainerFallingSpeedRange.y)
            comp.GroundLevel = self:raycast(position)
            self:addToResourceContainerIdList(resourceContainer:getId())
            spawnPos = 5
        elseif spawnPos == 5 then
            local position = { centerPos.x, centerPos.y, centerPos.z+0.2 }
            local orientation = { 0, 0, 0, 1 }
            quaternion.setEulerAngles(orientation, { 0, math.random(-90, 90), 0 })
            local resourceContainer = self:getLevel():createObject(self.ResourceContainer, position, orientation)
            local comp = resourceContainer:getOrCreateComponent("COMP_FALLING_RESOURCE_CONTAINER")
            comp.ResourceContainerFallingSpeed = randomFloat(self.ResourceContainerFallingSpeedRange.x, self.ResourceContainerFallingSpeedRange.y)
            comp.GroundLevel = self:raycast(position)
            self:addToResourceContainerIdList(resourceContainer:getId())
            spawnPos = 1
        end
    end
end

function COMP_PRODUCE_TREE:deleteResourceContainers()
    --EBF:log("Deleting Old Resource Containers")
    for i, entry in pairs(self.ResourceContainerIdList) do
        local gameObject = self:getLevel():find(entry)
        if gameObject == nil then
            --EBF:log("Nil gameObject")
            self.ResourceContainerIdList[i] = nil
        else
            gameObject:destroy()
            self.ResourceContainerIdList[i] = nil
        end
    end
end

function COMP_PRODUCE_TREE:spawnerResetSequence()
    --EBF:log("Resetting Spawners")
    if self.SpawnerScaling == true then
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.SpawnerNodeName) then
                    child:setScale(0)
                end
            end
        )
    end
end

function COMP_PRODUCE_TREE:spawnerScalingSequence()
    --EBF:log("Scaling Spawners")
    local dt = self:getLevel():getDeltaTime()
    local i = 0
    if self.SpawnerScaling == true then
        self:getOwner():forEachChild(
            function(child)
                if i < self.NoSpawners then
                    if starts_with(child.Name, self.SpawnerNodeName) then
                        i = i + 1
                        if child.Scale.x < 1 then
                            child:setScale(child.Scale.x + self.SpawnerScalingSpeed*dt)
                            self.CurrentScaling = child.Scale.x
                        else
                            --EBF:log("Scaling Finished")
                            child:setScale(1)
                            self.CurrentScaling = 1
                            self.Sequence = 2
                        end
                    end
                end
            end
        )
    end
end

function COMP_PRODUCE_TREE:calculateNoSpawners()
    --EBF:log("Calculating Spawners")
    self.NoSpawners = self.DefaultSpawners
    --EBF:log("Current Number: " .. self.NoSpawners)
    local building = self:getOwner():findFirstObjectWithComponentUp("COMP_BUILDING")
    --EBF:log("Building: " .. tostring(building))
    if building ~= nil then
        local partList = {}
        local buildingParts = building:getBuildingPartList()
        --EBF:log("BuildingParts: " .. tostring(buildingParts))
        --EBF:log("BuildingPartsNumber: " .. tostring(#buildingParts))
        for i=1,#buildingParts do
            --EBF:log("i: " .. i)
            --EBF:log("BuildingPartName: " .. buildingParts[i]:getOwner().Name)
            --EBF:log("StartsWith: " ..tostring(starts_with(buildingParts[i]:getOwner().Name, self.SpawnerIncreaseNodeName)))
            if starts_with(buildingParts[i]:getOwner().Name, self.SpawnerIncreaseNodeName) == true then
                --EBF:log("LocalPartList: " .. tostring(partList))
                --EBF:log("SizePartList: " .. tostring(#partList))
                local partFound = false
                --EBF:log("partFound: " .. tostring(partFound))
                for _, part in ipairs(partList) do
                    --EBF:log("CurrentPartCheck: " .. tostring(part))
                    if buildingParts[i]:getOwner().Name == part.Name then
                        partFound = true
                        --EBF:log("partFound: " .. tostring(partFound))
                        break
                    end
                end

                if partFound == false then
                    self.NoSpawners = self.NoSpawners + self.SpawnerIncrease
                    --EBF:log("PreEditedLocalPartList: " .. tostring(partList))
                    table.insert(partList, buildingParts[i]:getOwner())
                    --EBF:log("EditedLocalPartList: " .. tostring(partList))
                    --EBF:log("New Number: " .. self.NoSpawners)
                end
            end
        end
        --EBF:log("New Number: " .. self.NoSpawners)
    end
end

function COMP_PRODUCE_TREE:onDestroy(isClearingLevel)
    if not isClearingLevel then
        self:deleteResourceContainers()
    end
end

EBF:registerClass(COMP_PRODUCE_TREE)