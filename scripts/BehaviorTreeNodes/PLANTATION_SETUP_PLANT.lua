--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                PLANTATION SETUP PLANT                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BEHAVIOUR TREE NODE ----------------------------]]--

EBF:registerBehaviorTreeNode({
    Name = "PLANTATION_SETUP_PLANT",

    VariableList = {
        AgentData = "BEHAVIOR_TREE_DATA_AGENT",
        PotPosition = "BEHAVIOR_TREE_DATA_LOCATION",
        PlantWaitData = "BEHAVIOR_TREE_DATA_WAIT",
        --ComponentData = "BEHAVIOR_TREE_DATA_COMPONENT"
        ComponentData = "BEHAVIOR_TREE_DATA_VOID_OBJECT"
    },

    Update = function(self, level, instance)
        local potFound = false

        local workplace = self.AgentData.Agent:getOwner():getEnabledComponent("COMP_VILLAGER"):getJobInstance().Workplace

        if workplace ~= nil then
            local building = workplace:getOwner():findFirstObjectWithComponentUp("COMP_BUILDING")

            if building ~= nil then
                building:getBuildingPartList():forEach(
                    function(buildingPart)
                        if potFound == false then
                            buildingPart:getOwner():forEachChild(
                                function(child)
                                    if potFound == false then
                                        local compPot = child:getEnabledComponent("COMP_PLANTING_POT")
                                        if (compPot ~= nil and (not compPot:isOccupied()) and (not compPot:isTargeted())) then

                                            compPot:setTargeted(true)

                                            --self.ComponentData:setComponent(compPot)
                                            self.ComponentData.Component = compPot

                                            local moveSpot = nil
                                            moveSpot = self.PotPosition

                                            local planter = child:findFirstObjectWithComponentUp("COMP_PLANTER")

                                            if planter.FollowPlantingPath == true then
                                                moveSpot:setDestination(planter:getOwner())
                                            else
                                                local theta =  math.random() * 2 * math.pi
                                                local offset = { planter.PlantingRadius * math.cos(theta), planter.PlantingRadius * math.sin(theta) }
                                                moveSpot:setDestination(child, offset, false)
                                            end

                                            local waitData = nil
                                            waitData = self.PlantWaitData

                                            local plantation = workplace:getOwner():getEnabledComponent("COMP_PLANTATION")

                                            waitData.TimeToWait = plantation.PlantingDelay
                                            waitData.Animation = planter.PlantingAnimation

                                            potFound = true
                                        end
                                    end
                                end
                            )
                        end
                    end
                )
            else
                return BEHAVIOR_TREE_NODE_RESULT.FALSE
            end
        else
            return BEHAVIOR_TREE_NODE_RESULT.FALSE
        end

        if potFound == true then
            --EBF:log("Unoccupied Pot Found")
            return BEHAVIOR_TREE_NODE_RESULT.TRUE
        else
            --EBF:log("No Unoccupied Pot Found")
            return BEHAVIOR_TREE_NODE_RESULT.FALSE
        end
    end
})