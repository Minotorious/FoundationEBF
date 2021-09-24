--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |            REGISTER BEHAVIOR TREE NODES              | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[-------------------------------- DO FILES ---------------------------------]]--

EBF:dofile("scripts/BehaviorTreeNodes/RANDOM_BOOLEAN.lua")
EBF:dofile("scripts/BehaviorTreeNodes/SETUP_RANDOM_WAIT_TIME.lua")
EBF:dofile("scripts/BehaviorTreeNodes/SETUP_RADIAL_ENFORCED_MOVE_POSITION.lua")
EBF:dofile("scripts/BehaviorTreeNodes/SETUP_RECTANGULAR_ENFORCED_MOVE_POSITION.lua")
EBF:dofile("scripts/BehaviorTreeNodes/PLANTATION_SETUP_PLANT.lua")
EBF:dofile("scripts/BehaviorTreeNodes/PLANTATION_SETUP_GATHER.lua")
--EBF:dofile("scripts/BehaviorTreeNodes/PLANTATION_SETUP_TEND.lua")
EBF:dofile("scripts/BehaviorTreeNodes/PLANTATION_PLANT.lua")
EBF:dofile("scripts/BehaviorTreeNodes/PLANTATION_GATHER.lua")