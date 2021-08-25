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
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/ResourceNodeExample", "PREFAB_RESOURCE_EXAMPLE")

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:register({
	DataType = "BUILDING_PART",
	Id = "DEFINED_RESOURCE_GENERATOR_PART",
    Name = "DEFINED_RESOURCE_GENERATOR_PART_NAME",
	--Description = "DEFINED_RESOURCE_GENERATOR_PART_DESC",
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

EBF:register({
	DataType = "BUILDING_PART",
	Id = "PRODUCE_TREE_PART",
    Name = "PRODUCE_TREE_PART_NAME",
	--Description = "PRODUCE_TREE_PART_DESC",
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

EBF:register({
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

EBF:register({
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

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

-- BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR

EBF:register({
    DataType = "BUILDING_FUNCTION_RESOURCE_GENERATOR",
    Id = "BUILDING_FUNCTION_RESOURCE_GENERATOR_GEMS",
    ResourceGenerated = "GEMS",
    IsForConsumer = true,
    IsInfinite = false --<-- IMPORTANT!!!
})

EBF:register({
    DataType = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR",
    Id = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR_EXAMPLE",
    Name = "BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR_NAME",
    ResourceGenerator = "BUILDING_FUNCTION_RESOURCE_GENERATOR_GEMS",
    MaxQuantity = 50,
    GrowRate = 2.5
})

-- BUILDING_FUNCTION_PRODUCE_TREE

EBF:registerPrefabComponent("PREFAB_RESOURCE_EXAMPLE", {
    DataType = "COMP_RESOURCE_CONTAINER",
    ResourceData = "BERRIES",
    IsReplenishable = false,
    ResourceValue = 1.0,
    AvailableQuantity = 1,
    Radius = 0.85,
    IsDestroyWhenEmpty = true,
    HasMaximumWorkstation = false
})

EBF:register({
    DataType = "BUILDING_FUNCTION_PRODUCE_TREE",
    Id = "BUILDING_FUNCTION_PRODUCE_TREE_EXAMPLE",
    Name = "BUILDING_FUNCTION_PRODUCE_TREE_EXAMPLE_NAME",
    DefaultSpawners = 2,
    DaysToSpawn = 7,
    SpawnerScalingSpeed = 0.01,
    ResourceContainer = "PREFAB_RESOURCE_EXAMPLE"
})