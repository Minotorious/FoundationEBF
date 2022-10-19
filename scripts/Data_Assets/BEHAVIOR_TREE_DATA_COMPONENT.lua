--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |             BEHAVIOR TREE DATA COMPONENT             | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------------- ASSETS ----------------------------------]]--

local BEHAVIOR_TREE_DATA_COMPONENT = {
    TypeName = "BEHAVIOR_TREE_DATA_COMPONENT",
    ParentType = "BEHAVIOR_TREE_DATA",
    Properties = {
        { Name = "Component", Type = "COMPONENT", Default = nil }
    }
}

function BEHAVIOR_TREE_DATA_COMPONENT:setComponent(comp)
    self.Component = comp
end

function BEHAVIOR_TREE_DATA_COMPONENT:clearComponent()
    self.Component = nil
end

function BEHAVIOR_TREE_DATA_COMPONENT:finalizeClone(source)
    self.Component = source.Component
end

EBF:registerClass(BEHAVIOR_TREE_DATA_COMPONENT)