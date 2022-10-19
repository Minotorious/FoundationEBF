--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                  DYNAMIC INDICATOR                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------- DEFAULT PREFABS & MATERIALS -----------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/IndicatorDisplay", "PREFAB_INDICATOR_DISPLAY")
--[[
function registerDefaulIndicator(indicator)
    EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/Default" .. indicator, "PREFAB_" .. string.upper(indicator) .. "_DEFAULT")
    EBF:registerAssetId("textures/Default" .. indicator .. ".png", "DEFAULT_" .. string.upper(indicator) .. "_TEXTURE")

    EBF:registerAssetId("models/FoundationEBF.fbx/Materials/Material." .. indicator, "MATERIAL_" .. string.upper(indicator))
    EBF:overrideAsset({
        Id = "MATERIAL_" .. string.upper(indicator),
        AlbedoTexture = "DEFAULT_" .. string.upper(indicator) .. "_TEXTURE",
        HasAlphaTest = true,
        HasShadow = false,
        BackFaceVisible = true,
        RenderMode = "UNLIT"
    })
end

local indicatorList = { "Paused", "Arrow", "Shield", "Swords" }

for i, indicator in ipairs(indicatorList) do
    registerDefaulDigit(indicator)
end
]]--

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_DYNAMIC_INDICATOR = {
    TypeName = "BUILDING_FUNCTION_DYNAMIC_INDICATOR",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "Offset", Type = "vec3f", Default = { 0, 10, 0 } }
    }
}

function BUILDING_FUNCTION_DYNAMIC_INDICATOR:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    local compDynamicIndicator = gameObject:getOrCreateComponent("COMP_DYNAMIC_INDICATOR")
    compDynamicIndicator:setDynamicIndicatorData(self)

    return true
end

function BUILDING_FUNCTION_DYNAMIC_INDICATOR:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    self:activateBuilding(gameObject)
end

EBF:registerClass(BUILDING_FUNCTION_DYNAMIC_INDICATOR)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_DYNAMIC_INDICATOR = {
	TypeName = "COMP_DYNAMIC_INDICATOR",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "Offset", Type = "vec3f", Default = { 0, 10, 0 } },
        { Name = "Indicators", Type = "list<GAME_OBJECT>", Default = nil, Flags = { "SAVE_GAME" } }
    }
}

function COMP_DYNAMIC_INDICATOR:create()
    self.valueChanged = false
end

function COMP_DYNAMIC_INDICATOR:setDynamicIndicatorData(buildingFunctionData)
    self.Offset = buildingFunctionData.Offset
end

function COMP_DYNAMIC_INDICATOR:createIndicatorGameObject(prefab, parent)
    local gameObject = self:getLevel():createObject(prefab, parent:getGlobalPosition(), parent:getGlobalOrientation())

    if parent ~= nil then
        gameObject:setParent(parent, true)
    end
end

function COMP_DYNAMIC_INDICATOR:setIndicator(prefab)
    if self.IsInitialised then



        self.valueChanged = true
    end
end

function COMP_DYNAMIC_INDICATOR:update()
    self:getOwner():globalLookAt(self:getLevel():find("Camera"):getGlobalPosition(), false)
end

EBF:registerClass(COMP_DYNAMIC_INDICATOR)
EBF:registerPrefabComponent("PREFAB_INDICATOR_DISPLAY", {  DataType = "COMP_DYNAMIC_INDICATOR" })