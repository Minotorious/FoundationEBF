--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                     MAIN MOD FILE                    | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |        FOUNDATION EXTENDED BUILDING FUNCTIONS        | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = foundation.createMod();

--[[-------------------------------- DO FILES ---------------------------------]]--

-- Building Functions

    -- Animations
    EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_DOUBLE_DOOR.lua")
    EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_SINGLE_DOOR.lua")
    EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_PORTCULLIS.lua")
    EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE.lua")

    -- Resource Production
    EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR.lua")
    EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_PRODUCE_TREE.lua")
    EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_PLANTATION.lua")

-- Components
EBF:dofile("scripts/Components/COMP_ENFORCE_RADIUS.lua")
EBF:dofile("scripts/Components/COMP_ENFORCE_RECTANGLE.lua")

-- Behaviour Tree Nodes
EBF:dofile("scripts/BehaviorTreeNodes/RANDOM_BOOLEAN.lua")
EBF:dofile("scripts/BehaviorTreeNodes/SETUP_RANDOM_WAIT_TIME.lua")
EBF:dofile("scripts/BehaviorTreeNodes/SETUP_RADIAL_ENFORCED_MOVE_POSITION.lua")
EBF:dofile("scripts/BehaviorTreeNodes/SETUP_RECTANGULAR_ENFORCED_MOVE_POSITION.lua")

-- Behaviour Trees
EBF:dofile("scripts/BehaviorTrees/BEHAVIOR_PRODUCE_TREE_COLLECTOR.lua")
EBF:dofile("scripts/BehaviorTrees/BEHAVIOR_PLANTATION_FARMER.lua")
EBF:dofile("scripts/BehaviorTrees/BEHAVIOR_RADIAL_CONFINED_AGENT.lua")
EBF:dofile("scripts/BehaviorTrees/BEHAVIOR_RECTANGULAR_CONFINED_AGENT.lua")

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
            Name = "FOUNDATIONEBF_EXAMPLE_PARTS_BEHAVIOR_TREES_CATEGORY",
            BuildingPartList = { 
                "RADIAL_ENFORCER_PART", "RECTANGULAR_ENFORCER_PART"
            }
        }
    }
})