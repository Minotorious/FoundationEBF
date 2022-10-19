--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                  ANIMATION EXAMPLES                  | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/SingleDoorPart", "PREFAB_SINGLE_DOOR_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/DoubleDoorPart", "PREFAB_DOUBLE_DOOR_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/PortcullisPart", "PREFAB_PORTCULLIS_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/SimpleDrawbridgePart", "PREFAB_SIMPLE_DRAWBRIDGE_PART")

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/SingleDoorPart/Trigger", { DataType = "COMP_GROUNDED" })
EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/DoubleDoorPart/Trigger.001", { DataType = "COMP_GROUNDED" })

EBF:configurePrefabFlagList("models/FoundationEBF.fbx/Prefab/PortcullisPart", { "PLATFORM" })
EBF:configurePrefabFlagList("models/FoundationEBF.fbx/Prefab/SimpleDrawbridgePart", { "PLATFORM" })

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "SINGLE_DOOR_PART",
    Name = "SINGLE_DOOR_PART_NAME",
    Description = "SINGLE_DOOR_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_SINGLE_DOOR_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.05, 0.05 }, { 1, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 0.05, 0.05 }, { -1.1, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 2, 0.05 }, { 0, 0 } ),
                Type = { GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_SINGLE_DOOR_EXAMPLE"
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "DOUBLE_DOOR_PART",
    Name = "DOUBLE_DOOR_PART_NAME",
    Description = "DOUBLE_DOOR_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_DOUBLE_DOOR_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.05, 5 }, { 2, 2.5 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 0.05, 5 }, { -2, 2.5 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 4, 0.05 }, { 0, 0 } ),
                Type = { GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_DOUBLE_DOOR_EXAMPLE"
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "PORTCULLIS_PART",
    Name = "PORTCULLIS_PART_NAME",
    Description = "PORTCULLIS_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_PORTCULLIS_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.05, 10 }, { 2, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 0.05, 10 }, { -2, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 4, 10 }, { 0, 0 } ),
                Type = { GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_PORTCULLIS_EXAMPLE"
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "SIMPLE_DRAWBRIDGE_PART",
    Name = "SIMPLE_DRAWBRIDGE_PART_NAME",
    Description = "SIMPLE_DRAWBRIDGE_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_SIMPLE_DRAWBRIDGE_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.05, 16 }, { 2, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 0.05, 16 }, { -2, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 4, 6 }, { 0, 5 } ),
                Type = { GRASS_CLEAR = true }
            },
            {
                Polygon = polygon.createRectangle( { 4, 6 }, { 0, -5 } ),
                Type = { GRASS_CLEAR = true }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE_EXAMPLE"
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_SINGLE_DOOR",
    Id = "BUILDING_FUNCTION_SINGLE_DOOR_EXAMPLE",
    Name = "BUILDING_FUNCTION_SINGLE_DOOR_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_SINGLE_DOOR_EXAMPLE_DESC",
    DoorPivotPoint = { 1, 1, 0 }
})

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_DOUBLE_DOOR",
    Id = "BUILDING_FUNCTION_DOUBLE_DOOR_EXAMPLE",
    Name = "BUILDING_FUNCTION_DOUBLE_DOOR_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_DOUBLE_DOOR_EXAMPLE_DESC",
    LeftPivotPoint = { 2, 1, 0 },
    RightPivotPoint = { -2, 1, 0 }
})

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_PORTCULLIS",
    Id = "BUILDING_FUNCTION_PORTCULLIS_EXAMPLE",
    Name = "BUILDING_FUNCTION_PORTCULLIS_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_PORTCULLIS_EXAMPLE_DESC"
})

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE",
    Id = "BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE_EXAMPLE",
    Name = "BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE_EXAMPLE_NAME",
    Description = "BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE_EXAMPLE_DESC",
    DrawbridgePivotPoint = { 0, 0.8, -2.2 },
    ChainEclipsePoint = -2.5
})