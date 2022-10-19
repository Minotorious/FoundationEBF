--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |              PARTICLE EMITTER EXAMPLES               | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/ActivatedParticleEmitterPart", "PREFAB_ACTIVATED_PARTICLE_EMITTER_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/DeactivatedParticleEmitterPart", "PREFAB_DEACTIVATED_PARTICLE_EMITTER_PART")

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/ActivatedParticleEmitterPart/Trigger.005", { DataType = "COMP_GROUNDED" })

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/ActivatedParticleEmitterPart/ActivatedEmitter.000", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/ActivatedParticleEmitterPart/ActivatedEmitter.001", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/ActivatedParticleEmitterPart/ActivatedEmitter.002", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/ActivatedParticleEmitterPart/ActivatedEmitter.003", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/DeactivatedParticleEmitterPart/Trigger.006", { DataType = "COMP_GROUNDED" })

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/DeactivatedParticleEmitterPart/Emitter.000", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/DeactivatedParticleEmitterPart/Emitter.001", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/DeactivatedParticleEmitterPart/DeactivatedEmitter.000", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/DeactivatedParticleEmitterPart/DeactivatedEmitter.001", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/DeactivatedParticleEmitterPart/DeactivatedEmitter.002", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "ACTIVATED_PARTICLE_EMITTER_PART",
    Name = "ACTIVATED_PARTICLE_EMITTER_PART_NAME",
    Description = "ACTIVATED_PARTICLE_EMITTER_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_ACTIVATED_PARTICLE_EMITTER_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 1, 1 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_ACTIVATED_PARTICLE_EMITTER_EXAMPLE"
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "DEACTIVATED_PARTICLE_EMITTER_PART",
    Name = "DEACTIVATED_PARTICLE_EMITTER_PART_NAME",
    Description = "DEACTIVATED_PARTICLE_EMITTER_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_DEACTIVATED_PARTICLE_EMITTER_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 2, 1 }, { 3, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            },
            {
                Polygon = polygon.createRectangle( { 2, 1 }, { -3, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER_EXAMPLE"
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_ACTIVATED_PARTICLE_EMITTER",
    Id = "BUILDING_FUNCTION_ACTIVATED_PARTICLE_EMITTER_EXAMPLE",
    Name = "BUILDING_FUNCTION_ACTIVATED_PARTICLE_EMITTER_NAME",
    Description = "BUILDING_FUNCTION_ACTIVATED_PARTICLE_EMITTER_DESC"
})

EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER",
    Id = "BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER_EXAMPLE",
    Name = "BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER_NAME",
    Description = "BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER_DESC"
})