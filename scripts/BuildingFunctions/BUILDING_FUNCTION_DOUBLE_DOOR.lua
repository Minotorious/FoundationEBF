--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                     DOUBLE DOOR                      | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_DOUBLE_DOOR = {
    TypeName = "BUILDING_FUNCTION_DOUBLE_DOOR",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "OpeningAngle", Type = "float", Default = 90.0 },
        { Name = "OpeningSpeed", Type = "float", Default = 2.0 },
        { Name = "OpenHoldTime", Type = "float", Default = 2.0 },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 4.0 },
        { Name = "LeftSideNodeName", Type = "string", Default = "Left" },
        { Name = "LeftPivotPoint", Type = "vec3f", Default = { 0.0, 0.0, 0.0 } },
        { Name = "RightSideNodeName", Type = "string", Default = "Right" },
        { Name = "RightPivotPoint", Type = "vec3f", Default = { 0.0, 0.0, 0.0 } }
    }
}

function BUILDING_FUNCTION_DOUBLE_DOOR:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    local comp = gameObject:getOrCreateComponent("COMP_DOUBLE_DOOR")
    comp:setDoubleDoorData(self)

    return true
end

function BUILDING_FUNCTION_DOUBLE_DOOR:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    local comp = gameObject:getOrCreateComponent("COMP_DOUBLE_DOOR")
    comp:setDoubleDoorData(self)
end

EBF:registerClass(BUILDING_FUNCTION_DOUBLE_DOOR)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_DOUBLE_DOOR = {
    TypeName = "COMP_DOUBLE_DOOR",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "OpeningAngle", Type = "float", Default = 90.0 },
        { Name = "OpeningSpeed", Type = "float", Default = 2.0 },
        { Name = "OpenHoldTime", Type = "float", Default = 2.0 },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 4.0 },
        { Name = "LeftSideNodeName", Type = "string", Default = "Left" },
        { Name = "LeftPivotPoint", Type = "vec3f", Default = { 0.0, 0.0, 0.0 } },
        { Name = "RightSideNodeName", Type = "string", Default = "Right" },
        { Name = "RightPivotPoint", Type = "vec3f", Default = { 0.0, 0.0, 0.0 } }
    }
}

function COMP_DOUBLE_DOOR:create()
    self.DataDelivered = false
    self.triggerPos = nil
    self.sequence = 0
    self.angle = 0
    self.timer = 0
end

function COMP_DOUBLE_DOOR:setDoubleDoorData(buildingFunctionData)
    self.OpeningAngle = buildingFunctionData.OpeningAngle
    self.OpeningSpeed = buildingFunctionData.OpeningSpeed
    self.OpenHoldTime = buildingFunctionData.OpenHoldTime
    self.TriggerNodeName = buildingFunctionData.TriggerNodeName
    self.TriggeringDistance = buildingFunctionData.TriggeringDistance
    self.LeftSideNodeName = buildingFunctionData.LeftSideNodeName
    self.LeftPivotPoint = buildingFunctionData.LeftPivotPoint
    self.RightSideNodeName = buildingFunctionData.RightSideNodeName
    self.RightPivotPoint = buildingFunctionData.RightPivotPoint

    self:getOwner():forEachChild(
        function(child)
            if starts_with(child.Name, self.TriggerNodeName) then
                self.triggerPos = child:getGlobalPosition()
            end
        end
    )

    self.DataDelivered = true
end

function COMP_DOUBLE_DOOR:openingSequence()
    local dt = self:getLevel():getDeltaTime()
    local rotation = dt*self.OpeningSpeed

    if self.angle < self.OpeningAngle*math.pi/180 then
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.LeftSideNodeName) then
                    child:rotateAround(self.LeftPivotPoint, { 0, 1, 0 }, rotation)
                elseif starts_with(child.Name, self.RightSideNodeName) then
                    child:rotateAround(self.RightPivotPoint, { 0, 1, 0 }, -rotation)
                end
            end
        )
        self.angle = self.angle + rotation
    else
        local diff = self.angle - self.OpeningAngle*math.pi/180
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.LeftSideNodeName) then
                    child:rotateAround(self.LeftPivotPoint, { 0, 1, 0 }, -diff)
                elseif starts_with(child.Name, self.RightSideNodeName) then
                    child:rotateAround(self.RightPivotPoint, { 0, 1, 0 }, diff)
                end
            end
        )
        self.angle = self.OpeningAngle*math.pi/180
        self.sequence = 2
    end
end

function COMP_DOUBLE_DOOR:closingSequence()
    local dt = self:getLevel():getDeltaTime()
    local rotation = dt*self.OpeningSpeed

    if self.angle > 0 then
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.LeftSideNodeName) then
                    child:rotateAround(self.LeftPivotPoint, { 0, 1, 0 }, -rotation)
                elseif starts_with(child.Name, self.RightSideNodeName) then
                    child:rotateAround(self.RightPivotPoint, { 0, 1, 0 }, rotation)
                end
            end
        )
        self.angle = self.angle - rotation
    else
        local diff = 0 - self.angle
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.LeftSideNodeName) then
                    child:rotateAround(self.LeftPivotPoint, { 0, 1, 0 }, diff)
                elseif starts_with(child.Name, self.RightSideNodeName) then
                    child:rotateAround(self.RightPivotPoint, { 0, 1, 0 }, -diff)
                end
            end
        )
        self.angle = 0
    end
end

function COMP_DOUBLE_DOOR:update()
    if self.DataDelivered == true then
        self:getLevel():getComponentManager("COMP_AGENT"):getAllComponent():forEach(
            function(agent)
                local agentPos = agent:getOwner():getGlobalPosition()

                local distance = math.sqrt( (self.triggerPos.x - agentPos.x)^2 + (self.triggerPos.y - agentPos.y)^2 + (self.triggerPos.z - agentPos.z)^2 )

                if distance <= self.TriggeringDistance then
                    self.timer = self.OpenHoldTime
                    self.sequence = 1
                end
            end
        )

        if self.sequence == 1 then
            self:openingSequence()
        elseif self.sequence == 2 then
            if self.timer > 0 then
                local dt = self:getLevel():getDeltaTime()
                self.timer = self.timer - dt
            else
                self:closingSequence()
            end
        end
    end
end

EBF:registerClass(COMP_DOUBLE_DOOR)