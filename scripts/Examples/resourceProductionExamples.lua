--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |             RESOURCE PRODUCTION EXAMPLES             | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/DefinedResourceGeneratorPart", "PREFAB_DEFINED_RESOURCE_GENERATOR_PART")

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/ProduceTreePart", "PREFAB_PRODUCE_TREE_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/SpawnerIncrease1Part", "PREFAB_SPAWNER_INCREASE_1_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/SpawnerIncrease2Part", "PREFAB_SPAWNER_INCREASE_2_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/ProduceTreeResourceNode", "PREFAB_PRODUCE_TREE_RESOURCE_NODE")

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/PlantationPart", "PREFAB_PLANTATION_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/Planter1Part", "PREFAB_PLANTER_1_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/Planter2Part", "PREFAB_PLANTER_2_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/PlantationPlantable", "PREFAB_PLANTATION_PLANTABLE")

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:configurePrefabFlagList("PREFAB_PLANTER_2_PART", { "PLATFORM" })

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "DEFINED_RESOURCE_GENERATOR_PART",
    Name = "DEFINED_RESOURCE_GENERATOR_PART_NAME",
    Description = "DEFINED_RESOURCE_GENERATOR_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_DEFINED_RESOURCE_GENERATOR_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 1, 1 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR_EXAMPLE",
    IsVisibleWhenBuilt = true
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "PRODUCE_TREE_PART",
    Name = "PRODUCE_TREE_PART_NAME",
    Description = "PRODUCE_TREE_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_PRODUCE_TREE_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 1, 1 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_PRODUCE_TREE_EXAMPLE",
    IsVisibleWhenBuilt = true
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "SPAWNER_INCREASE_1_PART",
    Name = "SPAWNER_INCREASE_1_PART_NAME",
    Description = "SPAWNER_INCREASE_1_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_SPAWNER_INCREASE_1_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createCircle(1),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            }
        }
    },
    IsVisibleWhenBuilt = true
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "SPAWNER_INCREASE_2_PART",
    Name = "SPAWNER_INCREASE_2_PART_NAME",
    Description = "SPAWNER_INCREASE_2_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_SPAWNER_INCREASE_2_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createCircle(1),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            }
        }
    },
    IsVisibleWhenBuilt = true
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "PLANTATION_PART",
    Name = "PLANTATION_PART_NAME",
    Description = "PLANTATION_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_PLANTATION_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 2, 2 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_PLANTATION_EXAMPLE",
    IsVisibleWhenBuilt = true
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "PLANTER_1_PART",
    Name = "PLANTER_1_PART_NAME",
    Description = "PLANTER_1_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_PLANTER_1_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 5, 5 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_PLANTER_1_EXAMPLE",
    IsVisibleWhenBuilt = true
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "PLANTER_2_PART",
    Name = "PLANTER_2_PART_NAME",
    Description = "PLANTER_2_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_PLANTER_2_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.5, 5.5 }, { 2.5, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            },
            {
                Polygon = polygon.createRectangle( { 5, 0.5 }, { 0, 2.5 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            },
            {
                Polygon = polygon.createRectangle( { 0.5, 5.5 }, { -2.5, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            },
            {
                Polygon = polygon.createRectangle( { 1.75, 0.5 }, { 1.75, -2.5 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            },
            {
                Polygon = polygon.createRectangle( { 1.75, 0.5 }, { -1.75, -2.5 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_PLANTER_2_EXAMPLE",
    IsVisibleWhenBuilt = true
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

-- BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_RESOURCE_GENERATOR",
    Id = "BUILDING_FUNCTION_RESOURCE_GENERATOR_GEMS",
    ResourceGenerated = "GEMS",
    IsForConsumer = true,
    IsInfinite = false --<-- IMPORTANT!!!
})

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR",
    Id = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR_EXAMPLE",
    Name = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR_EXAMPLE_DESC",
    ResourceGenerator = "BUILDING_FUNCTION_RESOURCE_GENERATOR_GEMS",
    MaxQuantity = 50,
    GrowRate = 2.5
})

-- BUILDING_FUNCTION_PRODUCE_TREE

EBF:registerPrefabComponent("PREFAB_PRODUCE_TREE_RESOURCE_NODE", {
    DataType = "COMP_RESOURCE_CONTAINER",
    ResourceData = "BERRIES",
    IsReplenishable = false,
    ResourceValue = 1.0,
    AvailableQuantity = 1,
    Radius = 0.85,
    IsDestroyWhenEmpty = true,
    HasMaximumWorkstation = false
})

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_PRODUCE_TREE",
    Id = "BUILDING_FUNCTION_PRODUCE_TREE_EXAMPLE",
    Name = "BUILDING_FUNCTION_PRODUCE_TREE_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_PRODUCE_TREE_EXAMPLE_DESC",
    DefaultSpawners = 2,
    DaysToSpawn = 7,
    SpawnerScalingSpeed = 0.01,
    ResourceContainer = "PREFAB_PRODUCE_TREE_RESOURCE_NODE"
})

-- BUILDING_FUNCTION_PLANTATION

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_PLANTATION",
    Id = "BUILDING_FUNCTION_PLANTATION_EXAMPLE",
    Name = "BUILDING_FUNCTION_PLANTATION_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_PLANTATION_EXAMPLE_DESC",
    WorkerCapacity = 3,
    RelatedJob = { Job = "PLANTATION_FARMER_EXAMPLE", Behavior = "BEHAVIOR_PLANTATION_FARMER" },
    ResourceProduced = {
        { Resource = "WATER", Quantity = 1 }
    },
    Plantable = "PREFAB_PLANTATION_PLANTABLE",
    PlantingDelay = 10,
    GatheringDelay = 10,
    GrowingStepList = {
        Days = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 },
        Steps = { "Step1.", "Step2.", "Step3.", "Step4.", "Step5.", "Step6.", "Step7.", "Step8.", "Step9.", "Step10." }
    }
    --[[
    GrowingStepList = {
        { Day = 1, StepName = "Step1." },
        { Day = 2, StepName = "Step2." },
        { Day = 3, StepName = "Step3." },
        { Day = 4, StepName = "Step4." },
        { Day = 5, StepName = "Step5." },
        { Day = 6, StepName = "Step6." },
        { Day = 7, StepName = "Step7." },
        { Day = 8, StepName = "Step8." },
        { Day = 9, StepName = "Step9." },
        { Day = 10, StepName = "Step10." }
    }
    ]]--
})

EBF:registerAsset({
    DataType = "JOB",
    Id = "PLANTATION_FARMER_EXAMPLE",
    JobName = "PLANTATION_FARMER_EXAMPLE_NAME",
    JobDescription = "PLANTATION_FARMER_EXAMPLE_DESC",
    IsLockedByDefault = false,
    UseWorkplaceBehavior = true,
    AssetJobProgression = "DEFAULT_JOB_PROGRESSION",
    CharacterSetup = {
        DataType = "CHARACTER_SETUP",
        WalkAnimation = "WALKING",
        IdleAnimation = "IDLE"
    }
})

local overridenCompatibleJobList = {
    Action = "APPEND",
    "PLANTATION_FARMER_EXAMPLE"
}
EBF:overrideAsset({ Id = "NEWCOMER", CompatibleJobList = overridenCompatibleJobList })
EBF:overrideAsset({ Id = "SERF", CompatibleJobList = overridenCompatibleJobList })

-- BUILDING_FUNCTION_PLANTER

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_PLANTER",
    Id = "BUILDING_FUNCTION_PLANTER_1_EXAMPLE",
    Name = "BUILDING_FUNCTION_PLANTER_1_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_PLANTER_1_EXAMPLE_DESC",
    GatheringAnimation = "SCYTHE",
    FollowPlantingPath = true
})

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_PLANTER",
    Id = "BUILDING_FUNCTION_PLANTER_2_EXAMPLE",
    Name = "BUILDING_FUNCTION_PLANTER_2_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_PLANTER_2_EXAMPLE_DESC",
    PlantingAnimation = "FORESTER",
    FollowPlantingPath = false
})