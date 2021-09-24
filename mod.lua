--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                     MAIN MOD FILE                    | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |        FOUNDATION EXTENDED BUILDING FUNCTIONS        | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = foundation.createMod();

--[[-------------------------------- DO FILES ---------------------------------]]--

-- Global Utility Functions
EBF:log("Registering Global Utility Functions")
EBF:dofile("scripts/globalUtilityFunctions.lua")

-- Data & Assets
EBF:log("Registering Data and Assets")
EBF:dofile("scripts/Data_Assets/registerData_Assets.lua")

 -- Components
EBF:log("Registering Components")
EBF:dofile("scripts/Components/registerComponents.lua")

 
-- Building Functions
EBF:log("Registering Building Functions")
EBF:dofile("scripts/BuildingFunctions/registerBuildingFunctions.lua")

-- Behavior Tree Nodes
EBF:log("Registering Behavior Tree Nodes")
EBF:dofile("scripts/BehaviorTreeNodes/registerBehaviorTreeNodes.lua")

-- Behavior Trees
EBF:log("Registering Behavior Trees")
EBF:dofile("scripts/BehaviorTrees/registerBehaviorTrees.lua")

-- Examples
EBF:dofile("scripts/Examples/registerExamples.lua")

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