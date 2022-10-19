--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |             DEACTIVATED PARTICLE EMITTER             | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER = {
    TypeName = "BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
		{ Name = "EmitterNodeName", Type = "string", Default = "DeactivatedEmitter" },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 4.0 },
        { Name = "TriggerDuration", Type = "float", Default = 10.0 }
    }
}

function BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    local comp = gameObject:getOrCreateComponent("COMP_DEACTIVATED_PARTICLE_EMITTER")
    comp:setTriggeredParticleEmitterData(self)

    return true
end

function BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    local comp = gameObject:getOrCreateComponent("COMP_DEACTIVATED_PARTICLE_EMITTER")
    comp:setTriggeredParticleEmitterData(self)
end

EBF:registerClass(BUILDING_FUNCTION_DEACTIVATED_PARTICLE_EMITTER)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_DEACTIVATED_PARTICLE_EMITTER = {
    TypeName = "COMP_DEACTIVATED_PARTICLE_EMITTER",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "EmitterNodeName", Type = "string", Default = "DeactivatedEmitter" },
        { Name = "TriggerNodeName", Type = "string", Default = "Trigger" },
        { Name = "TriggeringDistance", Type = "float", Default = 4.0 },
        { Name = "TriggerDuration", Type = "float", Default = 10.0 }
    }
}

function COMP_DEACTIVATED_PARTICLE_EMITTER:create()
    self.DataDelivered = false
    self.triggerPos = nil
    self.emitterCompList = {}
    self.sequence = 0
    self.timer = 0
end

function COMP_DEACTIVATED_PARTICLE_EMITTER:addToEmitterCompList(entry)
    table.insert(self.emitterCompList, entry)
end

function COMP_DEACTIVATED_PARTICLE_EMITTER:setTriggeredParticleEmitterData(buildingFunctionData)
    self.EmitterNodeName = buildingFunctionData.EmitterNodeName
    self.TriggerNodeName = buildingFunctionData.TriggerNodeName
    self.TriggeringDistance = buildingFunctionData.TriggeringDistance
    self.TriggerDuration = buildingFunctionData.TriggerDuration

    self:getOwner():forEachChild(
        function(child)
            if starts_with(child.Name, self.TriggerNodeName) then
                self.triggerPos = child:getGlobalPosition()
            elseif starts_with(child.Name, self.EmitterNodeName) then
                local compEmitter = child:getComponent("COMP_PARTICLE_EMITTER")
                if compEmitter ~= nil then
                    self:addToEmitterCompList(compEmitter)
                end
            end
        end
    )

    self.DataDelivered = true
end

function COMP_DEACTIVATED_PARTICLE_EMITTER:update()
    if self.DataDelivered == true then
        self:getLevel():getComponentManager("COMP_AGENT"):getAllComponent():forEach(
            function(agent)
                local agentPos = agent:getOwner():getGlobalPosition()

                local distance = math.sqrt( (self.triggerPos.x - agentPos.x)^2 + (self.triggerPos.y - agentPos.y)^2 + (self.triggerPos.z - agentPos.z)^2 )

                if distance <= self.TriggeringDistance then
                    self.timer = self.TriggerDuration
                    for i, compEmitter in ipairs(self.emitterCompList) do
                        if compEmitter.IsEmitting == true then
                            compEmitter.IsEmitting = false
                        end
                    end
                end
            end
        )

        if self.timer > 0 then
            local dt = self:getLevel():getDeltaTime()
            self.timer = self.timer - dt
        else
            for i, compEmitter in ipairs(self.emitterCompList) do
                if compEmitter.IsEmitting == false then
                    compEmitter.IsEmitting = true
                end
            end
        end
    end
end

EBF:registerClass(COMP_DEACTIVATED_PARTICLE_EMITTER)