--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                  REGISTER EXAMPLES                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------------- ICONS ----------------------------------]]--

EBF:registerAssetId("textures/icons/Icon_Unlockable_FoundationEBF_Examples.png", "ICON_UNLOCKABLE_FOUNDATIONEBF_EXAMPLES", "ATLAS_CELL")

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--

EBF:registerAssetProcessor("models/FoundationEBF.fbx", { DataType = "BUILDING_ASSET_PROCESSOR" })

--[[-------------------------------- DO FILES ---------------------------------]]--

-- Animation Examples
EBF:dofile("scripts/Examples/animationExamples.lua")
EBF:dofile("scripts/Examples/particleEmitterExamples.lua")
EBF:dofile("scripts/Examples/resourceProductionExamples.lua")
EBF:dofile("scripts/Examples/numberDisplayExamples.lua")

-- Behavior Tree Examples
EBF:dofile("scripts/Examples/BehaviorTreeExamples/radialConfinedAgent.lua")
EBF:dofile("scripts/Examples/BehaviorTreeExamples/rectangularConfinedAgent.lua")

-- Other Examples
EBF:dofile("scripts/Examples/unifiedPrefabSpawnerExamples.lua")

--[[------------------------------ MAIN BUILDING ------------------------------]]--

EBF:registerAsset({
    DataType = "BUILDING",
    Id = "FOUNDATIONEBF_EXAMPLES",
    Name = "FOUNDATIONEBF_EXAMPLES_NAME",
    Description = "FOUNDATIONEBF_EXAMPLES_DESC",
    BuildingType = BUILDING_TYPE.MODS,
    AssetCoreBuildingPart = "BUILDING_PART_MONUMENT_POLE",
    AssetBuildingPartList = {},
    SubAssetBuildingList = {
        "FOUNDATIONEBF_EXAMPLE_PARTS_ANIMATIONS_CATEGORY",
        "FOUNDATIONEBF_EXAMPLE_PARTS_PARTICLE_EMITTERS_CATEGORY",
        "FOUNDATIONEBF_EXAMPLE_PARTS_RESOURCE_PRODUCTION_CATEGORY",
        "FOUNDATIONEBF_EXAMPLE_PARTS_PRODUCE_TREE_CATEGORY",
        "FOUNDATIONEBF_EXAMPLE_PARTS_PLANTATION_CATEGORY",
        "FOUNDATIONEBF_EXAMPLE_PARTS_BEHAVIOR_TREES_CATEGORY",
        "FOUNDATIONEBF_EXAMPLE_PARTS_NUMBER_DISPLAY_CATEGORY",
        "FOUNDATIONEBF_EXAMPLE_PARTS_UPS_CATEGORY"
    },
    IsManuallyUnlocked = true,
    IsDestructible = true,
    IsEditable = true,
    IsClearTrees = true
})

--[[------------------------------ SUB BUILDINGS ------------------------------]]--

local function registerEBFSubBuilding(subBuildingInfo)
    EBF:registerAsset({
        DataType = "BUILDING",
        Id = "FOUNDATIONEBF_EXAMPLE_PARTS_" .. subBuildingInfo[1] .. "_CATEGORY",
        Name = "FOUNDATIONEBF_EXAMPLE_PARTS_" .. subBuildingInfo[1] .. "_CATEGORY_NAME",
        Description = "FOUNDATIONEBF_EXAMPLE_PARTS_" .. subBuildingInfo[1] .. "_CATEGORY_DESC",
        BuildingType = BUILDING_TYPE.MODS,
        AssetCoreBuildingPart = "BUILDING_PART_MONUMENT_POLE",
        AssetBuildingPartList = subBuildingInfo[2],
        SubAssetBuildingList = {},
        IsManuallyUnlocked = false,
        IsDestructible = true,
        IsEditable = false,
        IsClearTrees = true
    })
end

local subBuildingInfoList = {
    { "ANIMATIONS", { "SINGLE_DOOR_PART", "DOUBLE_DOOR_PART", "PORTCULLIS_PART", "SIMPLE_DRAWBRIDGE_PART" } },
    { "PARTICLE_EMITTERS", { "ACTIVATED_PARTICLE_EMITTER_PART", "DEACTIVATED_PARTICLE_EMITTER_PART" } },
    { "RESOURCE_PRODUCTION", { "DEFINED_RESOURCE_GENERATOR_PART" } },
    { "PRODUCE_TREE", { "PRODUCE_TREE_PART", "SPAWNER_INCREASE_1_PART", "SPAWNER_INCREASE_2_PART" } },
    { "PLANTATION", { "PLANTATION_PART", "PLANTER_1_PART", "PLANTER_2_PART" } },
    { "BEHAVIOR_TREES", { "RADIAL_ENFORCER_PART", "RECTANGULAR_ENFORCER_PART" } },
    { "NUMBER_DISPLAY", { "NUMBER_DISPLAY_EXAMPLE_1_PART", "NUMBER_DISPLAY_EXAMPLE_2_PART", "NUMBER_DISPLAY_EXAMPLE_3_PART" } },
    { "UPS", { "UPS_EXAMPLE_1_PART" } }
}

for i, subBuildingInfo in ipairs(subBuildingInfoList) do
    registerEBFSubBuilding(subBuildingInfo)
end

--[[------------------------------- UNLOCKABLES -------------------------------]]--

EBF:registerAsset({
    DataType = "UNLOCKABLE",
    Id = "UNLOCKABLE_FOUNDATION_EBF_EXAMPLES",
    Name = "UNLOCKABLE_FOUNDATION_EBF_EXAMPLES_NAME",
    Description = "UNLOCKABLE_FOUNDATION_EBF_EXAMPLES_DESC",
    DataCost = {
        DataInfluenceCostList = {},
        ResourceCollection = {}
    },
    PrerequisiteUnlockableList = {},
    ActionList = {
        {
            DataType = "GAME_ACTION_UNLOCK_BUILDING_LIST",
            BuildingProgressData = {
                AssetBuildingList = {
                    "FOUNDATIONEBF_EXAMPLES"
                }
            }
        }
    },
    UnlockableImage = "ICON_UNLOCKABLE_FOUNDATIONEBF_EXAMPLES"
})

EBF:overrideAsset({
    Id = "PROGRESS_TIER_COMMON_T1",
    UnlockableList = {
        Action = "APPEND",
        "UNLOCKABLE_FOUNDATION_EBF_EXAMPLES"
    }
})