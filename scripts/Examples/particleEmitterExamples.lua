--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |              PARTICLE EMITTER EXAMPLES               | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/TriggerActivatedParticleEmitterPart", "PREFAB_TRIGGER_ACTIVATED_PARTICLE_EMITTER_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/TriggerDeactivatedParticleEmitterPart", "PREFAB_TRIGGER_DEACTIVATED_PARTICLE_EMITTER_PART")

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerActivatedParticleEmitterPart/Trigger.005", { DataType = "COMP_GROUNDED" })

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerActivatedParticleEmitterPart/ActivatedEmitter.000", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerActivatedParticleEmitterPart/ActivatedEmitter.001", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerActivatedParticleEmitterPart/ActivatedEmitter.002", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerActivatedParticleEmitterPart/ActivatedEmitter.003", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = false
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerDeactivatedParticleEmitterPart/Trigger.006", { DataType = "COMP_GROUNDED" })

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerDeactivatedParticleEmitterPart/Emitter.000", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerDeactivatedParticleEmitterPart/Emitter.001", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerDeactivatedParticleEmitterPart/DeactivatedEmitter.000", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerDeactivatedParticleEmitterPart/DeactivatedEmitter.001", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

EBF:registerPrefabComponent("models/FoundationEBF.fbx/Prefab/TriggerDeactivatedParticleEmitterPart/DeactivatedEmitter.002", {
    DataType = "COMP_PARTICLE_EMITTER",
    ParticleSystem = "PARTICLE_SYSTEM_HOUSING_SMOKE",
    IsPlaying = true,
    IsEmitting = true
})

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:register({
	DataType = "BUILDING_PART",
	Id = "TRIGGER_ACTIVATED_PARTICLE_EMITTER_PART",
    Name = "TRIGGER_ACTIVATED_PARTICLE_EMITTER_PART_NAME",
	--Description = "TRIGGER_ACTIVATED_PARTICLE_EMITTER_PART_DESC",
    Category = "CORE",
	ConstructorData = {
		DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
		CoreObjectPrefab = "PREFAB_TRIGGER_ACTIVATED_PARTICLE_EMITTER_PART"
	},
	BuildingZone = {
		ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 1, 1 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
			}
        }
    },
	ConstructionVisual = nil,
	Cost = {
		RessourcesNeeded = {}
	},
    AssetBuildingFunction = "BUILDING_FUNCTION_TRIGGER_ACTIVATED_PARTICLE_EMITTER_EXAMPLE",
    IsVisibleWhenBuilt = true
})

EBF:register({
	DataType = "BUILDING_PART",
	Id = "TRIGGER_DEACTIVATED_PARTICLE_EMITTER_PART",
    Name = "TRIGGER_DEACTIVATED_PARTICLE_EMITTER_PART_NAME",
	--Description = "TRIGGER_DEACTIVATED_PARTICLE_EMITTER_PART_DESC",
    Category = "CORE",
	ConstructorData = {
		DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
		CoreObjectPrefab = "PREFAB_TRIGGER_DEACTIVATED_PARTICLE_EMITTER_PART"
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
	ConstructionVisual = nil,
	Cost = {
		RessourcesNeeded = {}
	},
    AssetBuildingFunction = "BUILDING_FUNCTION_TRIGGER_DEACTIVATED_PARTICLE_EMITTER_EXAMPLE",
    IsVisibleWhenBuilt = true
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

EBF:register({
    DataType = "BUILDING_FUNCTION_TRIGGER_ACTIVATED_PARTICLE_EMITTER",
    Id = "BUILDING_FUNCTION_TRIGGER_ACTIVATED_PARTICLE_EMITTER_EXAMPLE",
    Name = "BUILDING_FUNCTION_TRIGGER_ACTIVATED_PARTICLE_EMITTER_NAME"
})

EBF:register({
    DataType = "BUILDING_FUNCTION_TRIGGER_DEACTIVATED_PARTICLE_EMITTER",
    Id = "BUILDING_FUNCTION_TRIGGER_DEACTIVATED_PARTICLE_EMITTER_EXAMPLE",
    Name = "BUILDING_FUNCTION_TRIGGER_DEACTIVATED_PARTICLE_EMITTER_NAME"
})