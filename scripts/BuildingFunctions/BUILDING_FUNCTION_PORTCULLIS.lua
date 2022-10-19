--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                      PORTCULLIS                      | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_PORTCULLIS = {
    TypeName = "BUILDING_FUNCTION_PORTCULLIS",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "OpeningSpeed", Type = "float", Default = 3.0 },
        { Name = "OpenHoldTime", Type = "float", Default = 2.0 },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 4.0 },
        { Name = "DoorNodeName", Type = "string", Default = "Door" },
        { Name = "DoorRaiseDistance", Type = "float", Default = 3.0 }
    }
}

function BUILDING_FUNCTION_PORTCULLIS:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    local comp = gameObject:getOrCreateComponent("COMP_PORTCULLIS")
    comp:setPortcullisData(self)

    return true
end

function BUILDING_FUNCTION_PORTCULLIS:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    local comp = gameObject:getOrCreateComponent("COMP_PORTCULLIS")
    comp:setPortcullisData(self)
end

EBF:registerClass(BUILDING_FUNCTION_PORTCULLIS)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_PORTCULLIS = {
    TypeName = "COMP_PORTCULLIS",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "OpeningSpeed", Type = "float", Default = 3.0 },
        { Name = "OpenHoldTime", Type = "float", Default = 2.0 },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 4.0 },
        { Name = "DoorNodeName", Type = "string", Default = "Door" },
        { Name = "DoorRaiseDistance", Type = "float", Default = 3.0 }
    }
}

function COMP_PORTCULLIS:create()
    self.DataDelivered = false
    self.triggerPos = nil
    self.sequence = 0
    self.moveDistance = 0
    self.timer = 0
end

function COMP_PORTCULLIS:setPortcullisData(buildingFunctionData)
    self.OpeningSpeed = buildingFunctionData.OpeningSpeed
    self.OpenHoldTime = buildingFunctionData.OpenHoldTime
    self.TriggerNodeName = buildingFunctionData.TriggerNodeName
    self.TriggeringDistance = buildingFunctionData.TriggeringDistance
    self.DoorNodeName = buildingFunctionData.DoorNodeName
    self.DoorRaiseDistance = buildingFunctionData.DoorRaiseDistance

    self:getOwner():forEachChild(
        function(child)
            if starts_with(child.Name, self.TriggerNodeName) then
                self.triggerPos = child:getGlobalPosition()
            end
        end
    )

    self.DataDelivered = true
end

function COMP_PORTCULLIS:openingSequence()
    local dt = self:getLevel():getDeltaTime()
    local moveIncrement = dt*self.OpeningSpeed

    if self.moveDistance < self.DoorRaiseDistance then
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DoorNodeName) then
                    child:move({ 0, moveIncrement, 0 })
                end
            end
        )
        self.moveDistance = self.moveDistance + moveIncrement
    else
        local diff = self.moveDistance - self.DoorRaiseDistance
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DoorNodeName) then
                    child:move({ 0, -diff, 0 })
                end
            end
        )
        self.moveDistance = self.DoorRaiseDistance
        self.sequence = 2
    end
end

function COMP_PORTCULLIS:closingSequence()
    local dt = self:getLevel():getDeltaTime()
    local moveIncrement = dt*self.OpeningSpeed

    if self.moveDistance > 0 then
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DoorNodeName) then
                    child:move({ 0, -moveIncrement, 0 })
                end
            end
        )
        self.moveDistance = self.moveDistance - moveIncrement
    else
        local diff = 0 - self.moveDistance
        self:getOwner():forEachChild(
            function(child)
                if starts_with(child.Name, self.DoorNodeName) then
                    child:move({ 0, diff, 0 })
                end
            end
        )
        self.moveDistance = 0
    end
end

function COMP_PORTCULLIS:update()
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

EBF:registerClass(COMP_PORTCULLIS)