--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |            UNIFIED PREFAB SPAWNER EXAMPLES           | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/UPSExample1Part", "PREFAB_UPS_EXAMPLE_1_PART")

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/UPSExampleSpawn1", "PREFAB_UPS_EXAMPLE_SPAWN_1")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/UPSExampleSpawn2", "PREFAB_UPS_EXAMPLE_SPAWN_2")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/UPSExampleSpawn3", "PREFAB_UPS_EXAMPLE_SPAWN_3")

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

--[[ 
    Defining a Component to trigger UPS
]]--

local COMP_UPS_EXAMPLE_1 = {
    TypeName = "COMP_UPS_EXAMPLE_1",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "HasSpawned", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } },
        { Name = "SpawnedObjects", Type = "list<GAME_OBJECT>", Default = {}, Flags = { "SAVE_GAME" } }
    }
}

function COMP_UPS_EXAMPLE_1:onEnabled()
    if not self.HasSpawned then
        local compUPS = self:getLevel():find("COMP_UNIFIED_PREFAB_SPAWNER")

        if compUPS ~= nil then
            local pos = self:getOwner():getGlobalPosition()
            local objects3 = compUPS:radialCountSpawn("UPSExampleSpawn3", pos, 50, 10, 10)
            local objects2 = compUPS:radialCountSpawn("UPSExampleSpawn2", pos, 50, 10, 10)
            local objects1 = compUPS:radialCountSpawn("UPSExampleSpawn1", pos, 50, 10, 10)

            for i, object in ipairs(objects3) do
                table.insert(self.SpawnedObjects, object)
            end

            for i, object in ipairs(objects2) do
                table.insert(self.SpawnedObjects, object)
            end

            for i, object in ipairs(objects1) do
                table.insert(self.SpawnedObjects, object)
            end

            self.HasSpawned = true
        end
    end
end

function COMP_UPS_EXAMPLE_1:onFinalize(isClearingLevel)
    if not isClearingLevel then
        for i, object in ipairs(self.SpawnedObjects) do
            if object ~= nil and object:is("GAME_OBJECT") then
                object:destroy()
            end
        end
    end
end

EBF:registerClass(COMP_UPS_EXAMPLE_1)

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:registerPrefabComponent("PREFAB_UPS_EXAMPLE_1_PART", { DataType = "COMP_UPS_EXAMPLE_1", Enabled = true })

EBF:registerPrefabComponent("PREFAB_UPS_EXAMPLE_SPAWN_1", { DataType = "COMP_GROUNDED", GroundToWater = true, AutoDisable = true, Enabled = true })
EBF:registerPrefabComponent("PREFAB_UPS_EXAMPLE_SPAWN_2", { DataType = "COMP_GROUNDED", AutoDisable = true, Enabled = true })
EBF:registerPrefabComponent("PREFAB_UPS_EXAMPLE_SPAWN_3", { DataType = "COMP_GROUNDED", AutoDisable = true, Enabled = true })

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "UPS_EXAMPLE_1_PART",
    Name = "UPS_EXAMPLE_1_PART_NAME",
    Description = "UPS_EXAMPLE_1_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_UPS_EXAMPLE_1_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 2, 2 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            }
        }
    }
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

EBF:registerAsset({
    DataType = "UPS_OBJECT_SETUP",
    Id = "UPS_OBJECT_SETUP_EXAMPLE_SPAWN_1",
    ObjectId = "UPSExampleSpawn1",
    ObjectPrefab = "PREFAB_UPS_EXAMPLE_SPAWN_1",
    ObjectArea = { 2, 2 },
    AreaCheckResolution = { 1, 1 },
    SelfExclusionRadius = 10,
    OnTerrain = false,
    OnWater = true,
    MinAllowedSlope = 60
})

EBF:registerAsset({
    DataType = "UPS_OBJECT_SETUP",
    Id = "UPS_OBJECT_SETUP_EXAMPLE_SPAWN_2",
    ObjectId = "UPSExampleSpawn2",
    ObjectPrefab = "PREFAB_UPS_EXAMPLE_SPAWN_2",
    ObjectArea = { 10, 4 },
    EdgeCheckResoluton = { 4, 1 },
    AreaCheckMode = "Cross",
    AreaCheckResolution = { 4, 1 },
    SelfExclusionRadius = 10
})

EBF:registerAsset({
    DataType = "UPS_OBJECT_SETUP",
    Id = "UPS_OBJECT_SETUP_EXAMPLE_SPAWN_3",
    ObjectId = "UPSExampleSpawn3",
    ObjectPrefab = "PREFAB_UPS_EXAMPLE_SPAWN_3",
    ObjectArea = { 6, 6 },
    EdgeCheckResoluton = { 2, 2 },
    AreaCheckMode = "Combined",
    AreaCheckResolution = { 2, 2 },
    SelfExclusionRadius = 10
})

EBF:overrideAsset({
    Id = "UPS_OBJECT_SETUP_LIST_DEFAULT",
    ObjectSetupList = {
        Action = "APPEND",
        "UPS_OBJECT_SETUP_EXAMPLE_SPAWN_1",
        "UPS_OBJECT_SETUP_EXAMPLE_SPAWN_2",
        "UPS_OBJECT_SETUP_EXAMPLE_SPAWN_3"
    }
})