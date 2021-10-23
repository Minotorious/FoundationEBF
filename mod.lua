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
if (foundation.getGameVersion() == nil or version.cmp(foundation.getGameVersion(), "1.8") < 0) then
    EBF:dofile("scripts_1.7/globalUtilityFunctions.lua")
else
    EBF:dofile("scripts/globalUtilityFunctions.lua")
end
    
-- Data & Assets
EBF:log("Registering Data and Assets")
if (foundation.getGameVersion() == nil or version.cmp(foundation.getGameVersion(), "1.8") < 0) then
    EBF:dofile("scripts_1.7/Data_Assets/registerData_Assets.lua")
else
    EBF:dofile("scripts/Data_Assets/registerData_Assets.lua")
end

 -- Components
EBF:log("Registering Components")
if (foundation.getGameVersion() == nil or version.cmp(foundation.getGameVersion(), "1.8") < 0) then
    EBF:dofile("scripts_1.7/Components/registerComponents.lua")
else
    EBF:dofile("scripts/Components/registerComponents.lua")
end

-- Building Functions
EBF:log("Registering Building Functions")
if (foundation.getGameVersion() == nil or version.cmp(foundation.getGameVersion(), "1.8") < 0) then
    EBF:dofile("scripts_1.7/BuildingFunctions/registerBuildingFunctions.lua")
else
    EBF:dofile("scripts/BuildingFunctions/registerBuildingFunctions.lua")
end

-- Behavior Tree Nodes
EBF:log("Registering Behavior Tree Nodes")
if (foundation.getGameVersion() == nil or version.cmp(foundation.getGameVersion(), "1.8") < 0) then
    EBF:dofile("scripts_1.7/BehaviorTreeNodes/registerBehaviorTreeNodes.lua")
else
    EBF:dofile("scripts/BehaviorTreeNodes/registerBehaviorTreeNodes.lua")
end

-- Behavior Trees
EBF:log("Registering Behavior Trees")
if (foundation.getGameVersion() == nil or version.cmp(foundation.getGameVersion(), "1.8") < 0) then
    EBF:dofile("scripts_1.7/BehaviorTrees/registerBehaviorTrees.lua")
else
    EBF:dofile("scripts/BehaviorTrees/registerBehaviorTrees.lua")
end

-- Examples
if (foundation.getGameVersion() == nil or version.cmp(foundation.getGameVersion(), "1.8") < 0) then

else
    --EBF:dofile("scripts/Examples/registerExamples.lua")
end