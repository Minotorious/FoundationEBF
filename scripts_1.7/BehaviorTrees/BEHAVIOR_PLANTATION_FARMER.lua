--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                  PLANTATION FARMER                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[------------------------------ BEHAVIOR TREE ------------------------------]]--

EBF:registerBehaviorTree({
	Id = "BEHAVIOR_PLANTATION_FARMER",
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
				Animation = AGENT_ANIMATION.IDLE,
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
			Name = "ShouldLookAtResourcePosition",
			DataType = "BEHAVIOR_TREE_DATA_BOOL",
			IsPublic = false,
			InitialValue = {
				Value = true
			}
		},
        {
			Name = "ShouldUseWorkplaceAnim",
			DataType = "BEHAVIOR_TREE_DATA_BOOL",
			IsPublic = false,
			InitialValue = {
				Value = false
			}
		},
        {
			Name = "ShouldReceiveXp",
			DataType = "BEHAVIOR_TREE_DATA_BOOL",
			IsPublic = false,
			InitialValue = {
				Value = true
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
                    Name = "DisablePaths",
                    Type = "DISABLE_PATH_TRACING",
                    AgentData = "AgentData"
                },
                {
                    Name = "StartProduction",
                    Type = "START_PRODUCTION",
                    AgentData = "AgentData"
                },
                {
                    Name = "WorkSelector",
                    Type = "SELECTOR",
                    Children = {
                        {
                            Name = "GatherSequencer",
                            Type = "SEQUENCER",
                            Children = {
                                {
                                    Name = "SetupWork",
                                    Type = "SETUP_WORK",
                                    AgentData = "AgentData",
                                    TimeToWait = "DoJobTimer",
                                    WorkPosition = "WorkplacePosition"
                                },
                                {
                                    Name = "SetupGatheringWork",
                                    Type = "PLANTATION_SETUP_GATHER",
                                    AgentData = "AgentData",
                                    PotPosition = "ResourcePosition",
                                    GatherWaitData = "DoJobTimer"
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
                                    Name = "ProduceResource",
                                    Type = "PRODUCE_RESOURCE",
                                    AgentData = "AgentData",
                                    TimeToWait = "DoJobTimer"
                                },
                                {
                                    Name = "GatherResource",
                                    Type = "PLANTATION_GATHER",
                                    AgentData = "AgentData"
                                },
                                {
                                    Name = "GoToWorkplaceFinGather",
                                    Type = "GO_TO",
                                    AgentData = "AgentData",
                                    Destination = "WorkplacePosition",
                                    BuildingPathType = "",
                                    AnimationData = "",
                                    AnimationSpeedMultiplier = ""
                                },
                                {
                                    Name = "GiveXp",
                                    Type = "GIVE_JOB_XP",
                                    AgentData = "AgentData",
                                    ShouldReceiveXp = "ShouldReceiveXp"
                                }
                            }
                        },
                        {
                            Name = "PlantSequencer",
                            Type = "SEQUENCER",
                            Children = {
                                {
                                    Name = "SetupPlantingWork",
                                    Type = "PLANTATION_SETUP_PLANT",
                                    AgentData = "AgentData",
                                    PotPosition = "ResourcePosition",
                                    PlantWaitData = "DoJobTimer"
                                },
                                {
                                    Name = "GoToPot",
                                    Type = "GO_TO",
                                    AgentData = "AgentData",
                                    Destination = "ResourcePosition",
                                    BuildingPathType = "",
                                    AnimationData = "",
                                    AnimationSpeedMultiplier = ""
                                },
                                {
                                    Name = "LookAtPot",
                                    Type = "LOOK_AT",
                                    AgentData = "AgentData",
                                    Destination = "ResourcePosition"
                                },
                                {
                                    Name = "PlantWaitTime",
                                    Type = "WAIT",
                                    AgentData = "AgentData",
                                    TimeToWait = "DoJobTimer",
                                    OptionalUseWorkstationAnim = "ShouldUseWorkplaceAnim"
                                },
                                {
                                    Name = "PlantPot",
                                    Type = "PLANTATION_PLANT",
                                    AgentData = "AgentData"
                                },
                                {
                                    Name = "GoToWorkplaceFinPlant",
                                    Type = "GO_TO",
                                    AgentData = "AgentData",
                                    Destination = "WorkplacePosition",
                                    BuildingPathType = "",
                                    AnimationData = "",
                                    AnimationSpeedMultiplier = ""
                                }
                            }
                        }
                    }
                },
                {
                    Name = "FinishProduction",
                    Type = "FINISH_PRODUCTION",
                    AgentData = "AgentData"
                },
                {
                    Name = "EnablePaths",
                    Type = "ENABLE_PATH_TRACING",
                    AgentData = "AgentData"
                }
            }
        }
	}
})