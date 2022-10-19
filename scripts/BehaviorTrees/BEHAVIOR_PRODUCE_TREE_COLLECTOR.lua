--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                PRODUCE TREE COLLECTOR                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[------------------------------ BEHAVIOR TREE ------------------------------]]--

EBF:registerBehaviorTree({
    Id = "BEHAVIOR_PRODUCE_TREE_COLLECTOR",
    VariableList = {
        {
            Name = "AgentData",
            DataType = "BEHAVIOR_TREE_DATA_AGENT",
            IsPublic = true,
            InitialValue = {}
        },
        {
            Name = "GatheringData",
            DataType = "BEHAVIOR_TREE_DATA_GATHERING",
            IsPublic = false,
            InitialValue = {}
        },
        {
            Name = "DoJobTimer",
            DataType = "BEHAVIOR_TREE_DATA_WAIT",
            IsPublic = false,
            InitialValue = {
                TimeToWait = 0,
                Animation = AGENT_ANIMATION.GATHER,
                SetIdleAfterWait = false
            }
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
        },
        {
            Name = "ResourcePosition",
            DataType = "BEHAVIOR_TREE_DATA_LOCATION",
            IsPublic = false,
            InitialValue = {
                CanNavigateOnGround = true,
                CanNavigateOnWater = false,
                IsSetOrientationOnDestination = true
            }
        },
        {
            Name = "AroundResourcePosition",
            DataType = "BEHAVIOR_TREE_DATA_LOCATION",
            IsPublic = false,
            InitialValue = {
                CanNavigateOnGround = true,
                CanNavigateOnWater = false,
                IsSetOrientationOnDestination = true
            }
        },
        {
            Name = "ShouldLookAtResourcePosition",
            DataType = "BEHAVIOR_TREE_DATA_BOOL",
            IsPublic = false,
            InitialValue = {
                Value = true
            }
        },
        {
            Name = "ShouldReceiveXp",
            DataType = "BEHAVIOR_TREE_DATA_BOOL",
            IsPublic = false,
            InitialValue = {
                Value = false
            }
        },
        {
            Name = "WorkLoop",
            DataType = "BEHAVIOR_TREE_DATA_LOOP",
            IsPublic = true,
            InitialValue = {
                LoopCount = 1,
                Duration = 0,
                IsInfinite = false,
                IsDuration = false
            }
        }
    },
    Root = {
        Name = "WorkLoopRepeater",
        Type = "REPEAT",
        RepeatData = "WorkLoop",
        Child = {
            Name = "WorkLoopSequencer",
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
                    Name = "SetupGatheringWork",
                    Type = "SETUP_GATHERING_WORK",
                    AgentData = "AgentData",
                    GatheringData = "GatheringData",
                    StepsCountLoopData = "WorkLoop",
                    GatherWaitData = "DoJobTimer"
                },
                {
                    Name = "GatherRequest",
                    Type = "GATHER_REQUEST",
                    AgentData = "AgentData",
                    GatheringData = "GatheringData",
                    GatherInOneStepLoopData = "WorkLoop"
                },
                {
                    Name = "FetchProduce",
                    Type = "FETCH_NEXT_GATHERABLE",
                    AgentData = "AgentData",
                    GatheringData = "GatheringData",
                    TimeToWait = "DoJobTimer",
                    ResourcePosition = "ResourcePosition",
                    AroundResourcePosition = "AroundResourcePosition",
                    ShouldLookAtResourcePosition = "ShouldLookAtResourcePosition"
                },
                {
                    Name = "DisablePaths",
                    Type = "DISABLE_PATH_TRACING",
                    AgentData = "AgentData"
                },
                {
                    Name = "GoToGatherable",
                    Type = "GO_TO",
                    AgentData = "AgentData",
                    Destination = "ResourcePosition",
                    BuildingPathType = "",
                    AnimationData = "",
                    AnimationSpeedMultiplier = ""
                },
                {
                    Name = "LookAtGatherable",
                    Type = "LOOK_AT",
                    AgentData = "AgentData",
                    Destination = "ResourcePosition"
                },
                {
                    Name = "GatherResource",
                    Type = "GATHER_RESOURCE",
                    AgentData = "AgentData",
                    TimeToWait = "DoJobTimer",
                    Gather = "GatheringData",
                    ShouldReceiveXp = "ShouldReceiveXp"
                },
                {
                    Name = "GoToWorkplaceFin",
                    Type = "GO_TO",
                    AgentData = "AgentData",
                    Destination = "WorkplacePosition",
                    BuildingPathType = "",
                    AnimationData = "",
                    AnimationSpeedMultiplier = ""
                },
                {
                    Name = "EnablePaths",
                    Type = "ENABLE_PATH_TRACING",
                    AgentData = "AgentData"
                },
                {
                    Name = "AddToInventory",
                    Type = "ADD_TO_INVENTORY",
                    AgentData = "AgentData",
                    GatheringData = "GatheringData"
                },
                {
                    Name = "GiveXp",
                    Type = "GIVE_JOB_XP",
                    AgentData = "AgentData",
                    ShouldReceiveXp = "ShouldReceiveXp"
                }
            }
        }
    }
})