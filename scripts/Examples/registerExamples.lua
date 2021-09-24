--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                  REGISTER EXAMPLES                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--

EBF:registerAssetProcessor("models/FoundationEBF.fbx", { DataType = "BUILDING_ASSET_PROCESSOR" })

--[[-------------------------------- DO FILES ---------------------------------]]--

EBF:dofile("scripts/Examples/animationExamples.lua")
EBF:dofile("scripts/Examples/particleEmitterExamples.lua")
EBF:dofile("scripts/Examples/resourceProductionExamples.lua")

-- Behavior Tree Examples
EBF:dofile("scripts/Examples/BehaviorTreeExamples/radialConfinedAgent.lua")
EBF:dofile("scripts/Examples/BehaviorTreeExamples/rectangularConfinedAgent.lua")

--[[------------------------------ MAIN MONUMENT ------------------------------]]--

EBF:register({
	DataType = "BUILDING",
	Id = "FOUNDATIONEBF_EXAMPLES",
	Name = "FOUNDATIONEBF_EXAMPLES_NAME",
	Description = "FOUNDATIONEBF_EXAMPLES_DESC",
	BuildingType = "GENERAL",
	AssetCoreBuildingPart = "BUILDING_PART_MONUMENT_POLE",
    BuildingPartSetList = {
        {
            Name = "FOUNDATIONEBF_EXAMPLE_PARTS_ANIMATIONS_CATEGORY",
            BuildingPartList = { 
                "SINGLE_DOOR_PART", "DOUBLE_DOOR_PART", "PORTCULLIS_PART",
                "SIMPLE_DRAWBRIDGE_PART"
            }
        },
        {
            Name = "FOUNDATIONEBF_EXAMPLE_PARTS_PARTICLE_EMITTERS_CATEGORY",
            BuildingPartList = { 
                "TRIGGER_ACTIVATED_PARTICLE_EMITTER_PART", 
                "TRIGGER_DEACTIVATED_PARTICLE_EMITTER_PART"
            }
        },
        {
            Name = "FOUNDATIONEBF_EXAMPLE_PARTS_RESOURCE_PRODUCTION_CATEGORY",
            BuildingPartList = { 
                "DEFINED_RESOURCE_GENERATOR_PART"
            }
        },
        {
            Name = "FOUNDATIONEBF_EXAMPLE_PARTS_PRODUCE_TREE_CATEGORY",
            BuildingPartList = { 
                "PRODUCE_TREE_PART", "SPAWNER_INCREASE_1_PART", "SPAWNER_INCREASE_2_PART"
            }
        },
        {
            Name = "FOUNDATIONEBF_EXAMPLE_PARTS_PLANTATION_CATEGORY",
            BuildingPartList = { 
                "PLANTATION_PART", "PLANTER_1_PART", "PLANTER_2_PART"
            }
        },
        {
            Name = "FOUNDATIONEBF_EXAMPLE_PARTS_BEHAVIOR_TREES_CATEGORY",
            BuildingPartList = { 
                "RADIAL_ENFORCER_PART", "RECTANGULAR_ENFORCER_PART"
            }
        }
    }
})