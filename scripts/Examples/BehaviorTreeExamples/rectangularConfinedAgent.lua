--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |           RECTANGULAR CONFINED AGENT EXAMPLE         | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/RectangularEnforcerPart", "PREFAB_RECTANGULAR_ENFORCER_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/RectangularConfinedAgent", "PREFAB_RECTANGULAR_CONFINED_AGENT")

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

--[[ 
    Defining a Component to spawn our custom Agents in game:

    The HasAgents property only exists to prevent reloading
    from spawning extra new Agents every time. I highly
    recommend using something similar in your component!
 ]]--

local COMP_RECTANGULAR_ENFORCER = {
    TypeName = "COMP_RECTANGULAR_ENFORCER",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "HasAgents", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } },
        { Name = "Agents", Type = "list<GAME_OBJECT>", Default = {}, Flags = { "SAVE_GAME" } }
    }
}

function COMP_RECTANGULAR_ENFORCER:onEnabled()
    if not self.HasAgents then
        local pos = self:getOwner():getGlobalPosition()

        for i = 1,10,1 do
            local agent = self:getLevel():createObject("PREFAB_RECTANGULAR_CONFINED_AGENT", pos)
            table.insert(self.Agents, agent)

            local comp = agent:getComponent("COMP_ENFORCE_RECTANGLE")
            comp:setEnforcer(self:getOwner())
        end

        self.HasAgents = true
    end
end

function COMP_RECTANGULAR_ENFORCER:onDestroy()
    for i, agent in ipairs(self.Agents) do
        agent:destroy()
    end
end

EBF:registerClass(COMP_RECTANGULAR_ENFORCER)

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:registerPrefabComponent(
    "PREFAB_RECTANGULAR_ENFORCER_PART",
    {
        DataType = "COMP_RECTANGULAR_ENFORCER"
    }
)

EBF:registerPrefabComponent(
    "PREFAB_RECTANGULAR_CONFINED_AGENT",
    {
        DataType = "COMP_ENFORCE_RECTANGLE",
        Rectangle = { 10, 10 }
    }
)

EBF:registerPrefabComponent(
    "PREFAB_RECTANGULAR_CONFINED_AGENT",
    {
        DataType = "COMP_AGENT",
        BehaviorTree = "BEHAVIOR_RECTANGULAR_CONFINED_AGENT",
        WalkOnPlatform = true,
        RoadPaintSpeed = 0.0
    }
)
--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "RECTANGULAR_ENFORCER_PART",
    Name = "RECTANGULAR_ENFORCER_PART_NAME",
    Description = "RECTANGULAR_ENFORCER_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_RECTANGULAR_ENFORCER_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 2, 2 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false, GRASS_CLEAR = true  }
            }
        }
    },
    IsVisibleWhenBuilt = true
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--
