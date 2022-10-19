--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                     UPS MANDATE                      | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[------------------------------ MANDATE TYPE -------------------------------]]--

local UPS_MANDATE_TYPE = {
    TypeName = "UPS_MANDATE_TYPE",
    ParentType = "MANDATE_TYPE",
    Properties = {
        { Name = "MandateStateText", Type = "string", Default = "UPS_MANDATE_CURRENT_STATE_TEXT" },
        { Name = "SpawnMode", Type = "string", Default = "Map" }, -- Radial, Rectangular, Hexagon
        { Name = "SpawnType", Type = "string", Default = "Count" }, -- Fill, Targeted
        { Name = "UPSObjectId", Type = "string", Default = "" },
        { Name = "SpawnCount", Type = "integer", Default = 10 },
        { Name = "AttemptCount", Type = "integer", Default = 10 },
        { Name = "Center", Type = "vec3f", Default = { 0, 0, 0 } },
        { Name = "Radius", Type = "float", Default = 0 },
        { Name = "Orientation", Type = "quaternion", Default = { 0, 0, 0, 1 } },
        { Name = "Rectangle", Type = "vec2f", Default = { 0, 0 } }
    }
}

function UPS_MANDATE_TYPE:updatePossibleMandateList(inOutMandateList, mandateOffice)
    --EBF:log("Generating Mandate List")
    local UPSComponent = mandateOffice:getLevel():find("COMP_UNIFIED_PREFAB_SPAWNER")

    local spawnCheck = true
    if UPSComponent ~= nil then
        local spawnedObjects = UPSComponent:getSpawnedObjects()
        for i,sObject in pairs(spawnedObjects) do
            if sObject.ObjectSetup ~= nil then
                if sObject.ObjectSetup.ObjectId == self.UPSObjectId then
                    if sObject.Object ~= nil then
                        spawnCheck = false
                        break
                    end
                end
            end
        end
    end

    if spawnCheck == true then
        local newInstance = foundation.createData({ DataType = "UPS_MANDATE_INSTANCE" })

        newInstance.MandateStateText = self.MandateStateText
        newInstance.SpawnMode = self.SpawnMode
        newInstance.SpawnType = self.SpawnType
        newInstance.UPSObjectId = self.UPSObjectId
        newInstance.SpawnCount = self.SpawnCount
        newInstance.AttemptCount = self.AttemptCount
        newInstance.Center = self.Center
        newInstance.Radius = self.Radius
        newInstance.Orientation = self.Orientation
        newInstance.Rectangle = self.Rectangle
        newInstance.UPSComponent = self.UPSComponent
        newInstance.Duration = self.DurationInSec

        table.insert(inOutMandateList, newInstance)
    end
end

EBF:registerClass(UPS_MANDATE_TYPE)

--[[----------------------------- MANDATE INSTANCE ----------------------------]]--

local UPS_MANDATE_INSTANCE = {
    TypeName = "UPS_MANDATE_INSTANCE",
    ParentType = "MANDATE",
    Properties = {
        { Name = "MandateStateText", Type = "string", Default = "UPS_MANDATE_CURRENT_STATE_TEXT" },
        { Name = "SpawnMode", Type = "string", Default = "Map" }, -- Radial, Rectangular, Hexagon
        { Name = "SpawnType", Type = "string", Default = "Count" }, -- Fill, Targeted
        { Name = "UPSObjectId", Type = "string", Default = "" },
        { Name = "SpawnCount", Type = "integer", Default = 10 },
        { Name = "AttemptCount", Type = "integer", Default = 10 },
        { Name = "Center", Type = "vec3f", Default = { 0, 0, 0 } },
        { Name = "Radius", Type = "float", Default = 0 },
        { Name = "Orientation", Type = "quaternion", Default = { 0, 0, 0, 1 } },
        { Name = "Rectangle", Type = "vec2f", Default = { 0, 0 } },
        { Name = "UPSComponent", Type = "COMPONENT", Default = nil },
        { Name = "Duration", Type = "float", Default = 0.0 }
    }
}

function UPS_MANDATE_INSTANCE:finalizeClone(_source)
    self.MandateStateText = _source.MandateStateText
    self.SpawnMode = _source.SpawnMode
    self.SpawnType = _source.SpawnType
    self.UPSObjectId = _source.UPSObjectId
    self.SpawnCount = _source.SpawnCount
    self.AttemptCount = _source.AttemptCount
    self.Center = _source.Center
    self.Radius = _source.Radius
    self.Orientation = _source.Orientation
    self.Rectangle = _source.Rectangle
    self.UPSComponent = _source.UPSComponent
    self.Duration = _source.Duration
end

function UPS_MANDATE_INSTANCE:getCurrentStateText()
    return self.MandateStateText
end

--[[
function UPS_MANDATE_INSTANCE:isRequiringBailiff()
    return true
end

function UPS_MANDATE_INSTANCE:setAssignedVillager(assignedVillager)
    assignedVillager = 
end]]--

function UPS_MANDATE_INSTANCE:cancelMandate()

end

function UPS_MANDATE_INSTANCE:completeMandate()
    --EBF:log("MANDATE COMPLETE!")

    if self.UPSComponent ~= nil then
        if self.SpawnMode == "Map" and self.SpawnType == "Count" then
            local gameObjects = self.UPSComponent:mapCountSpawn(self.UPSObjectId, self.SpawnCount, self.AttemptCount)
            for i, object in ipairs(gameObjects) do
                --object:destroy()
            end
        end
    end
end

EBF:registerClass(UPS_MANDATE_INSTANCE)

--[[----------------------- MANDATE BEHAVIOUR TREE NODES ------------------------]]--

EBF:registerBehaviorTreeNode({
    Name = "SETUP_UPS_MANDATE",
    VariableList = {
        Agent = "BEHAVIOR_TREE_DATA_AGENT",
        TimeNeeded = "BEHAVIOR_TREE_DATA_WAIT",
    },
    Update = function(self, level, instance)
        local agent = self.Agent.Agent
        local villager = agent:getOwner():getComponent("COMP_VILLAGER")
        local jobInstance = villager:getJobInstance()
        local bailiffOffice = jobInstance.Workplace
        local mandateInstance = bailiffOffice:getSelectedMandate()

        if not mandateInstance:is("UPS_MANDATE_INSTANCE") then
            return BEHAVIOR_TREE_NODE_RESULT.ERROR
        end

        self.TimeNeeded.TimeToWait = mandateInstance.Duration

        --EBF:log("Finished custom mandate setup")
        return BEHAVIOR_TREE_NODE_RESULT.TRUE
    end
})

EBF:registerBehaviorTreeNode({
    Name = "EXECUTE_UPS_MANDATE",
    VariableList = {
        Agent = "BEHAVIOR_TREE_DATA_AGENT",
        TimeNeeded = "BEHAVIOR_TREE_DATA_WAIT",
        TimeLeft = "BEHAVIOR_TREE_DATA_FLOAT",
    },
    Init = function(self, instance)
        self.TimeLeft.FloatValue = self.TimeNeeded.TimeToWait
    end,
    Update = function(self, level, instance)
        self.TimeLeft.FloatValue = self.TimeLeft.FloatValue - level:getDeltaTime()
        if (self.TimeLeft.FloatValue < 0.0) then
            --EBF:log("Wait is finally over!")
            return BEHAVIOR_TREE_NODE_RESULT.TRUE
        else
            --EBF:log("Waiting " .. tostring(self.TimeLeft.FloatValue) .. " more seconds")
            return BEHAVIOR_TREE_NODE_RESULT.PROCESSING
        end
    end
})

EBF:registerBehaviorTreeNode({
    Name = "FINISH_UPS_MANDATE",
    VariableList = {
        Agent = "BEHAVIOR_TREE_DATA_AGENT",
    },
    Update = function(self, level, instance)
        local agent = self.Agent.Agent
        local villager = agent:getOwner():getComponent("COMP_VILLAGER")
        local jobInstance = villager:getJobInstance()
        local bailiffOffice = jobInstance.Workplace
        local mandate = bailiffOffice:getSelectedMandate()

        if mandate ~= nil and mandate:isValid() then
            bailiffOffice:completeMandate()
            --EBF:log("Finished custom mandate!")
            return BEHAVIOR_TREE_NODE_RESULT.TRUE
        else
            return BEHAVIOR_TREE_NODE_RESULT.ERROR
        end
    end
})

--[[-------------------------- MANDATE BEHAVIOUR TREE ---------------------------]]--

EBF:registerBehaviorTree({
    Id = "UPS_MANDATE_BEHAVIOR_TREE",
    VariableList = {
        {
            Name = "AgentData",
            DataType = "BEHAVIOR_TREE_DATA_AGENT"
        },
        {
            Name = "WaitData",
            DataType = "BEHAVIOR_TREE_DATA_WAIT"
        },
        {
            Name = "WaitTimeLeftData",
            DataType = "BEHAVIOR_TREE_DATA_FLOAT"
        },
        {
            Name = "WorkplacePosition",
            DataType = "BEHAVIOR_TREE_DATA_LOCATION",
            IsPublic = false,
            InitialValue = {
                CanNavigateOnGround = true,
                CanNavigateOnWater = false,
                IsSetOrientationOnDestination = true
            }
        }
    },
    Root = {
        Name = "GlobalSequencer",
        Type = "SEQUENCER",
        Children = {
            {
                Name = "HasWorkplace",
                Type = "IS_WORKPLACE_AVAILABLE",
                AgentData = "AgentData"
            },
            {
                Name = "SetWorkplaceDestination",
                Type = "SET_WORKPLACE_AS_DESTINATION",
                AgentData = "AgentData",
                WorkplacePosition = "WorkplacePosition",
            },
            {
                Name = "GoToWorkplace",
                Type = "GO_TO",
                AgentData = "AgentData",
                Destination = "WorkplacePosition",
                BuildingPathType = "",
                AnimationData = "",
                AnimationSpeedMultiplier = ""
            },
            {
                Name = "Setup Mandate",
                Type = "SETUP_UPS_MANDATE",
                Agent = "AgentData",
                TimeNeeded = "WaitData"
            },
            {
                Name = "Execute Mandate",
                Type = "EXECUTE_UPS_MANDATE",
                Agent = "AgentData",
                TimeNeeded = "WaitData",
                TimeLeft = "WaitTimeLeftData"
            },
            {
                Name = "Finish Mandate",
                Type = "FINISH_UPS_MANDATE",
                Agent = "AgentData"
            }
        }
    }
})