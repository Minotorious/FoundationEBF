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