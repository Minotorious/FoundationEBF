--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |              RECTANGULAR CONFINED AGENT              | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[------------------------------ BEHAVIOR TREE ------------------------------]]--

EBF:registerBehaviorTree({
    Id = "BEHAVIOR_RECTANGULAR_CONFINED_AGENT",
    VariableList = {
        {
            Name = "AgentData",
            DataType = "BEHAVIOR_TREE_DATA_AGENT",
            IsPublic = false,
            InitialValue = {}
        },
        {
            Name = "MovePosition",
            DataType = "BEHAVIOR_TREE_DATA_LOCATION",
            IsPublic = false,
            InitialValue = {
                CanNavigateOnGround = true,
                CanNavigateOnWater = false,
                IsSetOrientationOnDestination = false
            }
        },
        {
            Name = "TimeToWait",
            DataType = "BEHAVIOR_TREE_DATA_WAIT",
            IsPublic = false,
            InitialValue = {
                TimeToWait = 6
            }
        },
        {
            Name = "MinWaitTime",
            DataType = "BEHAVIOR_TREE_DATA_FLOAT",
            IsPublic = false,
            InitialValue = {
                FloatValue = 2
            }
        },
        {
            Name = "MaxWaitTime",
            DataType = "BEHAVIOR_TREE_DATA_FLOAT",
            IsPublic = false,
            InitialValue = {
                FloatValue = 10
            }
        }
    },
    Root = {
        Name = "AgentGlobalSequencer",
        Type = "SEQUENCER",
        Children = {
            {
                Name = "MovePositionSetter",
                Type = "SETUP_RECTANGULAR_ENFORCED_MOVE_POSITION",
                AgentData = "AgentData",
                MovePosition = "MovePosition"
            },
            {
                Name = "GoToPosition",
                Type = "GO_TO",
                AgentData = "AgentData",
                Destination = "MovePosition",
                BuildingPathType = "",
                AnimationData = "",
                AnimationSpeedMultiplier = ""
            },
            {
                Name = "WaitTimeSetter",
                Type = "SETUP_RANDOM_WAIT_TIME",
                TimeToWait = "TimeToWait",
                MinWaitTime = "MinWaitTime",
                MaxWaitTime = "MaxWaitTime"
            },
            {
                Name = "WaitBeforeNextMove",
                Type = "WAIT",
                AgentData = "AgentData",
                TimeToWait = "TimeToWait",
                OptionalUseWorkstationAnim = ""
            }
        }
    }
})