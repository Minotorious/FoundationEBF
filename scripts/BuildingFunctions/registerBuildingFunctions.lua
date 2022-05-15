--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |             REGISTER BUILDING FUNCTIONS              | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[-------------------------------- DO FILES ---------------------------------]]--

-- Animations
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_DOUBLE_DOOR.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_SINGLE_DOOR.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_PORTCULLIS.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE.lua")

-- Particle Emitters
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_ACTIVATED_PARTICLE_EMITTER.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER.lua")

-- Resource Production
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_DEFINED_RESOURCE_GENERATOR.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_PRODUCE_TREE.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_PLANTATION.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_PLANTER.lua")

-- Other
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_NUMBER_DISPLAY.lua")
EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_ROOF_TOGGLE.lua")
--EBF:dofile("scripts/BuildingFunctions/BUILDING_FUNCTION_DYNAMIC_INDICATOR.lua")
