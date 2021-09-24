--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                   PLANTATION PLANT                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BEHAVIOUR TREE NODE ----------------------------]]--

EBF:registerBehaviorTreeNode({
	Name = "PLANTATION_PLANT",
	
	VariableList = {
        AgentData = "BEHAVIOR_TREE_DATA_AGENT"
	},
	
	Update = function(self, instance)
        local workplace = self.AgentData.Agent:getOwner():getEnabledComponent("COMP_VILLAGER"):getJobInstance().Workplace
        
        if workplace ~= nil then
            local plantation = workplace:getOwner():getEnabledComponent("COMP_PLANTATION")
            
            --local compPot = nil
            --compPot = self.PlantingPot.Component
            comp = self.AgentData.Agent:getOwner():getEnabledComponent("COMP_SAVE_PLANTING_POT")
            if comp ~= nil then
                compPot = comp:getPlantingPot()
                
                if compPot ~= nil then
                    local pos = compPot:getOwner():getGlobalPosition()
                    local orientation = { 0, 0, 0, 1 }
                    quaternion.setEulerAngles(orientation, { 0, math.random()*360, 0 })
                    plantObject = plantation:getLevel():createObject(plantation.Plantable, pos, orientation)
                    
                    compPot:setOccupied(true, plantObject)
                    compPot:initPlant()
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