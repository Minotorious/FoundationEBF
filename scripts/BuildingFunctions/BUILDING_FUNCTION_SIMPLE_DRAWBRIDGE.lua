--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                     MAIN MOD FILE                    | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                   SIMPLE DRAWBRIDGE                  | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE = {
    TypeName = "BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "OpeningAngle", Type = "float", Default = 85.0 },
        { Name = "OpeningSpeed", Type = "float", Default = 2.0 },
        { Name = "OpenHoldTime", Type = "float", Default = 2.0 },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 2.0 },
        { Name = "DrawbridgeNodeName", Type = "string", Default = "Drawbridge" },
        { Name = "DrawbridgePivotPoint", Type = "vec3f", Default = { 0.0, 0.0, 0.0 } },
        { Name = "Chain1NodeName", Type = "string", Default = "Chain1" },
        { Name = "Chain1PivotNodeName", Type = "string", Default = "DrawbridgeChain1Pivot" },
        { Name = "Chain2NodeName", Type = "string", Default = "Chain2" },
        { Name = "Chain2PivotNodeName", Type = "string", Default = "DrawbridgeChain2Pivot" },
        { Name = "ChainRotationSpeed", Type = "float", Default = 1.0 },
        { Name = "ChainEclipsePoint", Type = "float", Default = 0.0 }
    }
}

function BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    local comp = gameObject:getOrCreateComponent("COMP_SIMPLE_DRAWBRIDGE")
    comp:setDrawbridgeData(self)

    return true
end

function BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    local comp = gameObject:getOrCreateComponent("COMP_SIMPLE_DRAWBRIDGE")
    comp:setDrawbridgeData(self)
end

EBF:registerClass(BUILDING_FUNCTION_SIMPLE_DRAWBRIDGE)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_SIMPLE_DRAWBRIDGE = {
    TypeName = "COMP_SIMPLE_DRAWBRIDGE",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "OpeningAngle", Type = "float", Default = 85.0 },
        { Name = "OpeningSpeed", Type = "float", Default = 2.0 },
        { Name = "OpenHoldTime", Type = "float", Default = 2.0 },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 2.0 },
        { Name = "DrawbridgeNodeName", Type = "string", Default = "Drawbridge" },
        { Name = "DrawbridgePivotPoint", Type = "vec3f", Default = { 0.0, 0.0, 0.0 } },
        { Name = "Chain1NodeName", Type = "string", Default = "Chain1" },
        { Name = "Chain1PivotNodeName", Type = "string", Default = "DrawbridgeChain1Pivot" },
        { Name = "Chain2NodeName", Type = "string", Default = "Chain2" },
        { Name = "Chain2PivotNodeName", Type = "string", Default = "DrawbridgeChain2Pivot" },
        { Name = "ChainRotationSpeed", Type = "float", Default = 1.0 },
        { Name = "ChainEclipsePoint", Type = "float", Default = 0.0 }
    }
}

function COMP_SIMPLE_DRAWBRIDGE:create()
    self.DataDelivered = false
    self.triggerPos1 = nil
    self.triggerPos2 = nil
    self.Chain1PivotNode = nil
    self.Chain2PivotNode = nil
    self.sequence = 2
    self.drawbridgeAngle = 0
    self.chainAngle = 0
    self.timer = 0
end

function COMP_SIMPLE_DRAWBRIDGE:setDrawbridgeData(buildingFunctionData)
    self.OpeningAngle = buildingFunctionData.OpeningAngle
    self.OpeningSpeed = buildingFunctionData.OpeningSpeed
    self.OpenHoldTime = buildingFunctionData.OpenHoldTime
    self.TriggerNodeName = buildingFunctionData.TriggerNodeName
    self.TriggeringDistance = buildingFunctionData.TriggeringDistance
    self.DrawbridgeNodeName = buildingFunctionData.DrawbridgeNodeName
    self.DrawbridgePivotPoint = buildingFunctionData.DrawbridgePivotPoint
    self.Chain1NodeName =  buildingFunctionData.Chain1NodeName
    self.Chain1PivotNodeName =  buildingFunctionData.Chain1PivotNodeName
    self.Chain2NodeName =  buildingFunctionData.Chain2NodeName
    self.Chain2PivotNodeName =  buildingFunctionData.Chain2PivotNodeName
    self.ChainRotationSpeed =  buildingFunctionData.ChainRotationSpeed
    self.ChainEclipsePoint =  buildingFunctionData.ChainEclipsePoint

    local i = 1
    self:getOwner():forEachChild(
        function(child)
            if starts_with(child.Name, self.TriggerNodeName) then
                if i == 1 then
                    self.triggerPos1 = child:getGlobalPosition()
                    i = i + 1
                else
                    self.triggerPos2 = child:getGlobalPosition()
                end
            elseif starts_with(child.Name, self.Chain1PivotNodeName) then
                self.Chain1PivotNode = child
            elseif starts_with(child.Name, self.Chain2PivotNodeName) then
                self.Chain2PivotNode = child
            end
        end
    )

    self.DataDelivered = true
end

function COMP_SIMPLE_DRAWBRIDGE:chainClosingSequence()
    local dt = self:getLevel():getDeltaTime()
    local rotation = dt*self.ChainRotationSpeed

    if self.chainAngle < self.OpeningAngle*math.pi/360 then
        local Chain1PivotPoint = self.Chain1PivotNode.Position
        local Chain2PivotPoint = self.Chain2PivotNode.Position

        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.Chain1NodeName) then
                    child:rotateAround(Chain1PivotPoint, { -1, 0, 0 }, -rotation)
                elseif starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(Chain2PivotPoint, { -1, 0, 0 }, -rotation)
                end
            end
        )
        self.chainAngle = self.chainAngle + rotation
    else
        local Chain1PivotPoint = self.Chain1PivotNode.Position
        local Chain2PivotPoint = self.Chain2PivotNode.Position

        --EBF:log("Chain Closing Correction")
        local diff = self.chainAngle - self.OpeningAngle*math.pi/360
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.Chain1NodeName) then
                    child:rotateAround(Chain1PivotPoint, { -1, 0, 0 }, diff)
                elseif starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(Chain2PivotPoint, { -1, 0, 0 }, diff)
                end
            end
        )
        self.chainAngle = self.OpeningAngle*math.pi/360
    end
end

function COMP_SIMPLE_DRAWBRIDGE:closingSequence()
    local dt = self:getLevel():getDeltaTime()
    local rotation = dt*self.OpeningSpeed

    if self.drawbridgeAngle < self.OpeningAngle*math.pi/180 then
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DrawbridgeNodeName) then
                    child:rotateAround(self.DrawbridgePivotPoint, { -1, 0, 0 }, rotation)
                elseif starts_with(child.Name, self.Chain1NodeName)
                or starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(self.DrawbridgePivotPoint, { -1, 0, 0 }, rotation)
                    if child.Position.z < self.ChainEclipsePoint then
                        child:setScale(0)
                    end
                end
            end
        )
        self.drawbridgeAngle = self.drawbridgeAngle + rotation
    else
        local diff = self.drawbridgeAngle - self.OpeningAngle*math.pi/180
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DrawbridgeNodeName)
                or starts_with(child.Name, self.Chain1NodeName)
                or starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(self.DrawbridgePivotPoint, { -1, 0, 0 }, -diff)
                end
            end
        )
        self:chainCorrection()
        self.drawbridgeAngle = self.OpeningAngle*math.pi/180
        self.sequence = 0
    end
end

function COMP_SIMPLE_DRAWBRIDGE:chainOpeningSequence()
    local dt = self:getLevel():getDeltaTime()
    local rotation = dt*self.ChainRotationSpeed

    if self.chainAngle > 0 then
        local Chain1PivotPoint = self.Chain1PivotNode.Position
        local Chain2PivotPoint = self.Chain2PivotNode.Position

        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.Chain1NodeName) then
                    child:rotateAround(Chain1PivotPoint, { -1, 0, 0 }, rotation)
                elseif starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(Chain2PivotPoint, { -1, 0, 0 }, rotation)
                end
            end
        )
        self.chainAngle = self.chainAngle - rotation
    else
        local Chain1PivotPoint = self.Chain1PivotNode.Position
        local Chain2PivotPoint = self.Chain2PivotNode.Position

        --EBF:log("Chain Opening Correction")
        local diff = 0 - self.chainAngle
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.Chain1NodeName) then
                    child:rotateAround(Chain1PivotPoint, { -1, 0, 0 }, -diff)
                elseif starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(Chain2PivotPoint, { -1, 0, 0 }, -diff)
                end
            end
        )
        self.chainAngle = 0
    end
end

function COMP_SIMPLE_DRAWBRIDGE:openingSequence()
    local dt = self:getLevel():getDeltaTime()
    local rotation = dt*self.OpeningSpeed

    if self.drawbridgeAngle > 0 then
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DrawbridgeNodeName) then
                    child:rotateAround(self.DrawbridgePivotPoint, { -1, 0, 0 }, -rotation)
                elseif starts_with(child.Name, self.Chain1NodeName)
                or starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(self.DrawbridgePivotPoint, { -1, 0, 0 }, -rotation)
                    if child.Position.z > self.ChainEclipsePoint then
                        child:setScale(1)
                    end
                end
            end
        )
        self.drawbridgeAngle = self.drawbridgeAngle - rotation
    else
        local diff = 0 - self.drawbridgeAngle
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DrawbridgeNodeName)
                or starts_with(child.Name, self.Chain1NodeName)
                or starts_with(child.Name, self.Chain2NodeName) then
                    child:rotateAround(self.DrawbridgePivotPoint, { -1, 0, 0 }, diff)
                end
            end
        )
        self:chainCorrection()
        self.drawbridgeAngle = 0
        self.sequence = 2
    end
end

function COMP_SIMPLE_DRAWBRIDGE:chainCorrection()
    self:getOwner():forEachChild(
        function(child)
            if starts_with(child.Name, self.Chain1NodeName)
            or starts_with(child.Name, self.Chain2NodeName) then
                if child.Position.z < self.ChainEclipsePoint then
                    child:setScale(0)
                else
                    child:setScale(1)
                end
            end
        end
    )
end

function COMP_SIMPLE_DRAWBRIDGE:update()
    if self.DataDelivered == true then
        self:getLevel():getComponentManager("COMP_AGENT"):getAllComponent():forEach(
            function(agent)
                local agentPos = agent:getOwner():getGlobalPosition()

                local distance1 = math.sqrt( (self.triggerPos1.x - agentPos.x)^2 + (self.triggerPos1.y - agentPos.y)^2 + (self.triggerPos1.z - agentPos.z)^2 )
                local distance2 = math.sqrt( (self.triggerPos2.x - agentPos.x)^2 + (self.triggerPos2.y - agentPos.y)^2 + (self.triggerPos2.z - agentPos.z)^2 )

                if distance1 <= self.TriggeringDistance or distance2 <= self.TriggeringDistance then
                    self.timer = self.OpenHoldTime
                    self.sequence = 1
                end
            end
        )

        if self.sequence == 1 then
            self:openingSequence()
            self:chainOpeningSequence()
        elseif self.sequence == 2 then
            if self.timer > 0 then
                local dt = self:getLevel():getDeltaTime()
                self.timer = self.timer - dt
            else
                self:closingSequence()
                self:chainClosingSequence()
            end
        end
    end
end

EBF:registerClass(COMP_SIMPLE_DRAWBRIDGE)