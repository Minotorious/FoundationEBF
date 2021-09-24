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
        AgentData = "BEHAVIOR_TREE_DATA_AGENT"
	},
	
	Update = function(self, instance)
        local workplace = self.AgentData.Agent:getOwner():getEnabledComponent("COMP_VILLAGER"):getJobInstance().Workplace
        
        if workplace ~= nil then
            comp = self.AgentData.Agent:getOwner():getEnabledComponent("COMP_SAVE_PLANTING_POT")
            if comp ~= nil then
                compPot = comp:getPlantingPot()
                
                if compPot ~= nil then
                    compPot.CurrentPlant:destroy()
                    compPot:resetPot()
                    compPot:setTargeted(false)
                    
                    self.AgentData.Agent:getOwner():removeComponent(comp)
                    
                    return BEHAVIOR_TREE_NODE_RESULT.TRUE
                else
                    return BEHAVIOR_TREE_NODE_RESULT.FALSE
                end
            else
                return BEHAVIOR_TREE_NODE_RESULT.FALSE
            end
        else
            return BEHAVIOR_TREE_NODE_RESULT.FALSE
        end
	end
})