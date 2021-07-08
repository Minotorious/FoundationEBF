--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                     MAIN MOD FILE                    | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |        FOUNDATION EXTENDED BUILDING FUNCTIONS        | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = foundation.createMod();

--[[---------------------------- GENERAL MATERIALS ----------------------------]]--

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

--[[------------------------------ MAIN MONUMENT ------------------------------]]--

--[[------------------------------- MAIN EVENT --------------------------------]]--

--[[-------------------------------- DO FILES ---------------------------------]]--

-- Animations
EBF:dofile("scripts/doubleDoor.lua")
EBF:dofile("scripts/singleDoor.lua")
EBF:dofile("scripts/portcullis.lua")
EBF:dofile("scripts/simpleDrawbridge.lua")

-- Resource Production
EBF:dofile("scripts/definedResourceGenerator.lua")
EBF:dofile("scripts/produceTree.lua")

-- Examples
--EBF:dofile("scripts/examples.lua")