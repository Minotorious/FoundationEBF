--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                UNIFIED PREFAB SPAWNER                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- CUSTOM COMPONENT ----------------------------]]--

local COMP_UNIFIED_PREFAB_SPAWNER = {
	TypeName = "COMP_UNIFIED_PREFAB_SPAWNER",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "SpawnedObjects", Type = "list<GAME_OBJECT>", Default = {}, Flags = { "SAVE_GAME" } }
    }
}

function COMP_UNIFIED_PREFAB_SPAWNER:mapSpawnByCount(SpawnCount, ExclusionRadius, AllowedRotations, AllowedSlope, OnWater, OnGround)
    local spawnedObjects = {}



    return spawnedObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:mapFillSpawn(ExclusionRadius, AllowedRotations, AllowedSlope, OnWater, OnGround)
    local spawnedObjects = {}



    return spawnedObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:radialSpawnByCount(SpawnCentre, SpawnRadius, SpawnCount, ExclusionRadius, AllowedRotations, AllowedSlope, OnWater, OnGround)
    local spawnedObjects = {}



    return spawnedObjects
end

function COMP_UNIFIED_PREFAB_SPAWNER:radialFillSpawn(SpawnCentre, SpawnRadius, ExclusionRadius, AllowedRotations, AllowedSlope, OnWater, OnGround)
    local spawnedObjects = {}



    return spawnedObjects
end

EBF:registerClass(COMP_UNIFIED_PREFAB_SPAWNER)