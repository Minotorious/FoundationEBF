--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                   PLANTATION GATHER                  | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BEHAVIOUR TREE NODE ----------------------------]]--

EBF:registerBehaviorTreeNode({
    Name = "PLANTATION_GATHER",

    VariableList = {
        AgentData = "BEHAVIOR_TREE_DATA_AGENT",
        --ComponentData = "BEHAVIOR_TREE_DATA_COMPONENT"
        ComponentData = "BEHAVIOR_TREE_DATA_VOID_OBJECT"
    },

    Update = function(self, level, instance)
        local workplace = self.AgentData.Agent:getOwner():getEnabledComponent("COMP_VILLAGER"):getJobInstance().Workplace

        if workplace ~= nil then
            local compPot = self.ComponentData.Component

            if compPot ~= nil then
                compPot.CurrentPlant:destroy()
                compPot:resetPot()
                compPot:setTargeted(false)

                --self.ComponentData:clearComponent()
                self.ComponentData.Component = nil
                return BEHAVIOR_TREE_NODE_RESULT.TRUE
            else
                return BEHAVIOR_TREE_NODE_RESULT.FALSE
            end
        else
            return BEHAVIOR_TREE_NODE_RESULT.FALSE
        end
    end
})