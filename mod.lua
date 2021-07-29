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
--EBF:dofile("scripts/examples.lua")