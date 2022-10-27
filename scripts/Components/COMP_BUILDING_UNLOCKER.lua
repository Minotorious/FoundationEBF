--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                  BUILDING UNLOCKER                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- CUSTOM COMPONENT ----------------------------]]--

local COMP_BUILDING_UNLOCKER = {
    TypeName = "COMP_BUILDING_UNLOCKER",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "UnlockList", Type = "BUILDING_UNLOCKER_LIST", Default = nil }
    }
}

function COMP_BUILDING_UNLOCKER:onEnabled()
    local compBuildingManager = self:getLevel():find("COMP_BUILDING_MANAGER")

    for i, building in ipairs(self.UnlockList.Buildings) do
        compBuildingManager:unlockBuilding(building)
    end
end

EBF:registerClass(COMP_BUILDING_UNLOCKER)

EBF:registerPrefabComponent("PREFAB_MANAGER",
    {
        DataType = "COMP_BUILDING_UNLOCKER",
        Enabled = true,
        UnlockList = "BUILDING_UNLOCKER_LIST_DEFAULT"
    }
)
