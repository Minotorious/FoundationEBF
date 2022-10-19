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

-- Mandates
--EBF:log("Registering Mandates")
--EBF:dofile("scripts/Mandates/registerMandates.lua")

-- Textures & Materials
EBF:log("Registering Textures and Materials")
EBF:dofile("scripts/Textures_Materials/registerTextures_Materials.lua")

-- Examples
--EBF:dofile("scripts/Examples/registerExamples.lua")