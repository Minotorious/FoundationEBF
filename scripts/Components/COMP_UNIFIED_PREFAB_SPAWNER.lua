--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                UNIFIED PREFAB SPAWNER                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- CUSTOM COMPONENT ----------------------------]]--

local COMP_UNIFIED_PREFAB_SPAWNER = {
	TypeName = "COMP_UNIFIED_PREFAB_SPAWNER",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "ObjectSetupList", Type = "UPS_OBJECT_SETUP_LIST", Default = nil },
        { Name = "SpawnedObjects", Type = "list<UPS_SPAWNED_OBJECT>", Default = {}, Flags = { "SAVE_GAME" } }
    }
}

function COMP_UNIFIED_PREFAB_SPAWNER:getSpawnedObjects()
    return self.SpawnedObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:getObjectSetupFromId(SpawnObjectId)
    for i, objectSetup in ipairs(self.ObjectSetupList.ObjectSetupList) do
        if objectSetup.ObjectId == SpawnObjectId then
            return objectSetup
        end
    end

    return nil
end

function COMP_UNIFIED_PREFAB_SPAWNER:reindexSpawnedObjects()
    local j, n = 1, #self.SpawnedObjects

    for i = 1,n do
        if (self.SpawnedObjects[i] ~= nil) then
            -- Move i's kept value to j's position, if it's not already there
            if (i ~= j) then
                self.SpawnedObjects[j] = self.SpawnedObjects[i]
                self.SpawnedObjects[i] = nil
            end
            j = j + 1 -- Increment position of where to place the next kept value
        end
    end
end

function COMP_UNIFIED_PREFAB_SPAWNER:rotateTranslatePoint(point, center, orientation, undoRotation)
    local theta = quaternion.getEulerAngles(orientation)
    if undoRotation == true then
        theta.y = -theta.y
    end

    local rotTransPoint = { center[1] + point[1]*math.sin(theta.y) + point[3]*math.cos(theta.y), point[2], center[3] + point[1]*math.cos(theta.y) - point[3]*math.sin(theta.y) }

    return rotTransPoint
end

function COMP_UNIFIED_PREFAB_SPAWNER:isPositionAllowed(position, objectSetup)
    local raycastResultTerrain = {}
    local raycastResultWater = {}
    local fromPosition = { position[1], position[2]+100, position[3] }
    local toPosition = { position[1], position[2]-100, position[3] }
    local flagTerrain = bit.bor(bit.lshift(1, OBJECT_FLAG.TERRAIN:toNumber()))
    local flagWater = bit.bor(bit.lshift(1, OBJECT_FLAG.WATER:toNumber()))

    self:getLevel():rayCast(fromPosition, toPosition, raycastResultTerrain, flagTerrain)
    self:getLevel():rayCast(fromPosition, toPosition, raycastResultWater, flagWater)

    local yAngle = 90

    if raycastResultWater.Position.y > raycastResultTerrain.Position.y then
        if not objectSetup.OnWater then
            return false
        end
        yAngle = 90 - 180*math.acos(raycastResultWater.Normal.y)/math.pi
    else
        if not objectSetup.OnTerrain then
            return false
        end
        yAngle = 90 - 180*math.acos(raycastResultTerrain.Normal.y)/math.pi
    end

    if yAngle > objectSetup.MinAllowedSlope then
        return true
    else
        return false
    end
end

function COMP_UNIFIED_PREFAB_SPAWNER:pickMapWideRandomPosition()
    local x = math.random()*1023
    local y = math.random()*1023

    local pos = { x, 0, y }

    return pos
end

function COMP_UNIFIED_PREFAB_SPAWNER:pickRadialRandomPosition(center, radius)
    local r = radius * math.sqrt(math.random())
    local theta =  math.random() * 2 * math.pi

    local pos = { center.x + r * math.cos(theta), 0, center.z + r * math.sin(theta) }

    return pos
end

function COMP_UNIFIED_PREFAB_SPAWNER:pickRectangularRandomPosition(center, orientation, rectangle)
    local x = ( math.random() * rectangle.x ) - rectangle.x/2
    local y = ( math.random() * rectangle.y ) - rectangle.y/2

    local pos = self:rotateTranslatePoint({ x, 0, y }, center, orientation, false)

    return pos
end

function COMP_UNIFIED_PREFAB_SPAWNER:pickRandomOrientation(allowedAngles)
    local quat = { 0, 0, 0, 1 }

    if allowedAngles.x < allowedAngles.y then
        local angle = allowedAngles.x + math.random()*(allowedAngles.y - allowedAngles.x)
        quaternion.setEulerAngles(quat, { 0, angle, 0 })

        return quat
    else
        local angle = allowedAngles.y + math.random()*(allowedAngles.x - allowedAngles.y)
        quaternion.setEulerAngles(quat, { 0, angle, 0 })

        return quat
    end
end

function COMP_UNIFIED_PREFAB_SPAWNER:checkPosAgainstSpawnedObjects(position, objectSetup)
    for i, object in pairs(self.SpawnedObjects) do
        if object ~= nil and object:is("UPS_SPAWNED_OBJECT") then
            local gameObject = object.Object
            if gameObject ~= nil and gameObject:is("GAME_OBJECT") then
                local posObj = object.Object:getGlobalPosition()

                if object.ObjectSetup ~= nil then
                    if object.ObjectSetup.ObjectId == objectSetup.ObjectId then
                        local distSq = (posObj.x - position[1])^2 + (posObj.z - position[3])^2
                        if distSq < objectSetup.SelfExclusionRadius^2 then
                            return false
                        end
                    end

                    local originTransPoint = { position[1] - posObj.x, position[2], position[3] - posObj.z}
                    local newPosition = self:rotateTranslatePoint(originTransPoint, posObj, object.Object:getGlobalOrientation(), true)

                    if  newPosition[1] > posObj.x - object.ObjectSetup.ObjectArea.x/2 and newPosition[1] < posObj.x + object.ObjectSetup.ObjectArea.x/2
                    and newPosition[3] > posObj.z - object.ObjectSetup.ObjectArea.y/2 and newPosition[3] < posObj.z + object.ObjectSetup.ObjectArea.y/2 then
                        return false
                    end
                else
                    self.SpawnedObjects[i] = nil
                end
            else
                self.SpawnedObjects[i] = nil
            end
        else
            self.SpawnedObjects[i] = nil
        end
    end

    return true
end

function COMP_UNIFIED_PREFAB_SPAWNER:checkPosAgainstBuildingParts(position, objectSetup)
    local posAllowed = true
    if objectSetup.BuildingPartExclusionRadius > 0 then
        self:getLevel():getComponentManager("COMP_BUILDING_PART"):getAllComponent():forEach(
            function(buildingPart)
                local posBP = buildingPart:getOwner():getGlobalPosition()
                local distSq = (posBP.x - position[1])^2 + (posBP.z - position[3])^2
                if distSq < objectSetup.BuildingPartExclusionRadius^2 then
                    posAllowed = false
                end
            end
        )
    end

    if not posAllowed then
        return false
    else
        return true
    end
end

function COMP_UNIFIED_PREFAB_SPAWNER:checkObjectBoundingBox(center, orientation, objectSetup)
    local boundingBox = {
        -- 4 Box Corners
        {  objectSetup.ObjectArea.x/2, center[2],  objectSetup.ObjectArea.y/2 },
        {  objectSetup.ObjectArea.x/2, center[2], -objectSetup.ObjectArea.y/2 },
        { -objectSetup.ObjectArea.x/2, center[2],  objectSetup.ObjectArea.y/2 },
        { -objectSetup.ObjectArea.x/2, center[2], -objectSetup.ObjectArea.y/2 }
    }

    -- xEdge Resolution
    if objectSetup.EdgeCheckResoluton.x > 0 then
        for i = 1,objectSetup.EdgeCheckResoluton.x do
            table.insert(boundingBox, { -objectSetup.ObjectArea.x/2 + i*objectSetup.ObjectArea.x/(objectSetup.EdgeCheckResoluton.x + 1), center[2],  objectSetup.ObjectArea.y/2 })
            table.insert(boundingBox, { -objectSetup.ObjectArea.x/2 + i*objectSetup.ObjectArea.x/(objectSetup.EdgeCheckResoluton.x + 1), center[2], -objectSetup.ObjectArea.y/2 })
        end
    end

    -- yEdge Resolution
    if objectSetup.EdgeCheckResoluton.y > 0 then
        for i = 1,objectSetup.EdgeCheckResoluton.y do
            table.insert(boundingBox, {  objectSetup.ObjectArea.x/2, center[2], -objectSetup.ObjectArea.y/2 + i*objectSetup.ObjectArea.y/(objectSetup.EdgeCheckResoluton.y + 1) })
            table.insert(boundingBox, { -objectSetup.ObjectArea.x/2, center[2], -objectSetup.ObjectArea.y/2 + i*objectSetup.ObjectArea.y/(objectSetup.EdgeCheckResoluton.y + 1) })
        end
    end

    for i, point in ipairs(boundingBox) do
        local rotTransPoint = self:rotateTranslatePoint(point, center, orientation, false)
        local check1 = self:checkPosAgainstSpawnedObjects(rotTransPoint, objectSetup)
        local check2 = self:isPositionAllowed(rotTransPoint, objectSetup)
        if not ( check1 and check2 ) then
            return false
        end
    end

    return true
end

function COMP_UNIFIED_PREFAB_SPAWNER:checkObjectInternalArea(center, orientation, objectSetup)
    local internalArea = {}
    local crossMode = ( objectSetup.AreaCheckMode == "Cross" or objectSetup.AreaCheckMode == "Combined" )
    local hourglassMode = ( objectSetup.AreaCheckMode == "Hourglass" or objectSetup.AreaCheckMode == "Combined" )

    if crossMode == true then
        -- xEdge Resolution
        if objectSetup.AreaCheckResolution.x > 0 then
            for i = 1,objectSetup.AreaCheckResolution.x do
                table.insert(internalArea, { i*objectSetup.ObjectArea.x/(objectSetup.AreaCheckResolution.x*2 + 2), center[2],  0 })
                table.insert(internalArea, { -i*objectSetup.ObjectArea.x/(objectSetup.AreaCheckResolution.x*2 + 2), center[2],  0 })
            end
        end

        -- yEdge Resolution
        if objectSetup.AreaCheckResolution.y > 0 then
            for i = 1,objectSetup.AreaCheckResolution.y do
                table.insert(internalArea, {  0, center[2], i*objectSetup.ObjectArea.y/(objectSetup.AreaCheckResolution.y*2 + 2) })
                table.insert(internalArea, {  0, center[2], -i*objectSetup.ObjectArea.y/(objectSetup.AreaCheckResolution.y*2 + 2) })
            end
        end
    end

    if hourglassMode == true then
        if objectSetup.AreaCheckResolution.x > 0 and objectSetup.AreaCheckResolution.y > 0 then
            local resolution = 1
            if objectSetup.AreaCheckResolution.x > objectSetup.AreaCheckResolution.y then
                resolution = objectSetup.AreaCheckResolution.x
            else
                resolution = objectSetup.AreaCheckResolution.y
            end

            -- diagonals Resolution
            for i = 1,resolution do
                table.insert(internalArea, { i*objectSetup.ObjectArea.x/(objectSetup.AreaCheckResolution.x*2 + 2), center[2],  i*objectSetup.ObjectArea.y/(objectSetup.AreaCheckResolution.y*2 + 2) })
                table.insert(internalArea, { i*objectSetup.ObjectArea.x/(objectSetup.AreaCheckResolution.x*2 + 2), center[2],  -i*objectSetup.ObjectArea.y/(objectSetup.AreaCheckResolution.y*2 + 2) })
                table.insert(internalArea, { -i*objectSetup.ObjectArea.x/(objectSetup.AreaCheckResolution.x*2 + 2), center[2],  i*objectSetup.ObjectArea.y/(objectSetup.AreaCheckResolution.y*2 + 2) })
                table.insert(internalArea, { -i*objectSetup.ObjectArea.x/(objectSetup.AreaCheckResolution.x*2 + 2), center[2],  -i*objectSetup.ObjectArea.y/(objectSetup.AreaCheckResolution.y*2 + 2) })
            end
        end
    end

    for i, point in ipairs(internalArea) do
        local rotTransPoint = self:rotateTranslatePoint(point, center, orientation, false)
        local check1 = self:checkPosAgainstSpawnedObjects(rotTransPoint, objectSetup)
        local check2 = self:isPositionAllowed(rotTransPoint, objectSetup)
        if not ( check1 and check2 ) then
            return false
        end
    end

    return true
end

function COMP_UNIFIED_PREFAB_SPAWNER:checkSpawning(pos, orient, objectSetup)
    local check0 = self:checkPosAgainstBuildingParts(pos, objectSetup)
    if check0 == true then
        local check1 = self:checkPosAgainstSpawnedObjects(pos, objectSetup)
        if check1 == true then
            local check2 = self:isPositionAllowed(pos, objectSetup)
            if check2 == true then
                local check3 = self:checkObjectBoundingBox(pos, orient, objectSetup)
                if check3 == true then
                    local check4 = self:checkObjectInternalArea(pos, orient, objectSetup)
                    if check4 == true then
                        return true
                    end
                end
            end
        end
    end

    return false
end

function COMP_UNIFIED_PREFAB_SPAWNER:radialCountSpawn(SpawnObjectId, center, radius, SpawnCount, AttemptCount)
    local objectSetup = self:getObjectSetupFromId(SpawnObjectId)

    if objectSetup ~= nil then
        local gameObjects = {}

        for i = 1, SpawnCount do
            for j = 1, AttemptCount do
                --EBF:log("Object: " .. tostring(i) .. " Attempt: " ..tostring(j))
                local pos = self:pickRadialRandomPosition(center, radius)
                local orient = self:pickRandomOrientation(objectSetup.AllowedAngles)

                local check = self:checkSpawning(pos, orient, objectSetup)
                if check == true then
                    local gameObject = self:getLevel():createObject(objectSetup.ObjectPrefab, pos, orient)
                    table.insert(gameObjects, gameObject)
                    --EBF:log("Spawned: " .. tostring(gameObject))

                    local spawnedObject = foundation.createData(
                        {
                            DataType = "UPS_SPAWNED_OBJECT"
                        }
                    )

                    spawnedObject.Object = gameObject
                    spawnedObject.ObjectSetup = objectSetup
                    table.insert(self.SpawnedObjects, spawnedObject)
                    break
                end
            end
        end

        self:reindexSpawnedObjects()

        return gameObjects
    end

    EBF:log("Error in function COMP_UNIFIED_PREFAB_SPAWNER:radialCountSpawn(...). No UPS_OBJECT_SETUP found with the provided SpawnObjectId!")
    return nil
end

function COMP_UNIFIED_PREFAB_SPAWNER:radialFillSpawn()
    local gameObjects = {}



    return gameObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:rectangularCountSpawn(SpawnObjectId, center, orientation, rectangle, SpawnCount, AttemptCount)
    local objectSetup = self:getObjectSetupFromId(SpawnObjectId)

    if objectSetup ~= nil then
        local gameObjects = {}

        for i = 1, SpawnCount do
            for j = 1, AttemptCount do
                --EBF:log("Object: " .. tostring(i) .. " Attempt: " ..tostring(j))
                local pos = self:pickRectangularRandomPosition(center, orientation, rectangle)
                local orient = self:pickRandomOrientation(objectSetup.AllowedAngles)

                local check = self:checkSpawning(pos, orient, objectSetup)
                if check == true then
                    local gameObject = self:getLevel():createObject(objectSetup.ObjectPrefab, pos, orient)
                    table.insert(gameObjects, gameObject)
                    --EBF:log("Spawned: " .. tostring(gameObject))

                    local spawnedObject = foundation.createData(
                        {
                            DataType = "UPS_SPAWNED_OBJECT"
                        }
                    )

                    spawnedObject.Object = gameObject
                    spawnedObject.ObjectSetup = objectSetup
                    table.insert(self.SpawnedObjects, spawnedObject)
                    break
                end
            end
        end

        self:reindexSpawnedObjects()

        return gameObjects
    end

    EBF:log("Error in function COMP_UNIFIED_PREFAB_SPAWNER:rectangularCountSpawn(...). No UPS_OBJECT_SETUP found with the provided SpawnObjectId!")
    return nil
end

function COMP_UNIFIED_PREFAB_SPAWNER:rectangularFillSpawn()
    local gameObjects = {}



    return gameObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:hexagonCountSpawn()
    local gameObjects = {}



    return gameObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:hexagonFillSpawn()
    local gameObjects = {}



    return gameObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:hexagonTargetedSpawn()
    local gameObjects = {}



    return gameObjects
end


function COMP_UNIFIED_PREFAB_SPAWNER:mapCountSpawn(SpawnObjectId, SpawnCount, AttemptCount)
    local objectSetup = self:getObjectSetupFromId(SpawnObjectId)

    if objectSetup ~= nil then
        local gameObjects = {}

        for i = 1, SpawnCount do
            for j = 1, AttemptCount do
                --EBF:log("Object: " .. tostring(i) .. " Attempt: " ..tostring(j))
                local pos = self:pickMapWideRandomPosition()
                local orient = self:pickRandomOrientation(objectSetup.AllowedAngles)

                local check = self:checkSpawning(pos, orient, objectSetup)
                if check == true then
                    local gameObject = self:getLevel():createObject(objectSetup.ObjectPrefab, pos, orient)
                    table.insert(gameObjects, gameObject)
                    --EBF:log("Spawned: " .. tostring(gameObject))

                    local spawnedObject = foundation.createData(
                        {
                            DataType = "UPS_SPAWNED_OBJECT"
                        }
                    )

                    spawnedObject.Object = gameObject
                    spawnedObject.ObjectSetup = objectSetup
                    table.insert(self.SpawnedObjects, spawnedObject)
                    break
                end
            end
        end

        self:reindexSpawnedObjects()

        return gameObjects
    end

    EBF:log("Error in function COMP_UNIFIED_PREFAB_SPAWNER:mapCountSpawn(...). No UPS_OBJECT_SETUP found with the provided SpawnObjectId!")
    return nil
end

function COMP_UNIFIED_PREFAB_SPAWNER:mapFillSpawn()
    local gameObjects = {}



    return gameObjects
end

EBF:registerClass(COMP_UNIFIED_PREFAB_SPAWNER)

EBF:registerPrefabComponent("PREFAB_MANAGER",
    {
        DataType = "COMP_UNIFIED_PREFAB_SPAWNER",
        Enabled = true,
        ObjectSetupList = "UPS_OBJECT_SETUP_LIST_DEFAULT"
    }
)
