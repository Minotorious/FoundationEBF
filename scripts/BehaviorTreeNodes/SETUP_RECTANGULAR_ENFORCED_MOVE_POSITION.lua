--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |       SETUP RECTANGULAR ENFORCED MOVE POSITION       | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BEHAVIOUR TREE NODE ----------------------------]]--

EBF:registerBehaviorTreeNode({
    Name = "SETUP_RECTANGULAR_ENFORCED_MOVE_POSITION",

    VariableList = {
        AgentData = "BEHAVIOR_TREE_DATA_AGENT",
        MovePosition = "BEHAVIOR_TREE_DATA_LOCATION"
    },

    Update = function(self, level, instance)
        local compAgent = nil
        compAgent = self.AgentData.Agent

        local comp = compAgent:getOwner():getComponent("COMP_ENFORCE_RECTANGLE")
        if comp ~= nil then
            local pos = comp:getPosition()

            if pos ~= nil then
                local moveSpot = nil
                moveSpot = self.MovePosition
                moveSpot:setDestination(pos)

                return BEHAVIOR_TREE_NODE_RESULT.TRUE
            else
                EBF:logError("Unable to get move position from COMP_ENFORCE_RECTANGLE! Check that you have set the Enforcer GAME_OBJECT!")
                return BEHAVIOR_TREE_NODE_RESULT.FALSE
            end
        else
            EBF:logError("Agent is missing Component: COMP_ENFORCE_RECTANGLE")
            return BEHAVIOR_TREE_NODE_RESULT.FALSE
        end
    end
})