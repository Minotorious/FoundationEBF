--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                SETUP RANDOM WAIT TIME                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[---------------------------- BEHAVIOUR TREE NODE ----------------------------]]--

EBF:registerBehaviorTreeNode({
    Name = "SETUP_RANDOM_WAIT_TIME",

    VariableList = {
        TimeToWait = "BEHAVIOR_TREE_DATA_WAIT",
        MinWaitTime = "BEHAVIOR_TREE_DATA_FLOAT",
        MaxWaitTime = "BEHAVIOR_TREE_DATA_FLOAT"
    },

    Update = function(self, level, instance)
        local waitTime = nil
        local minTime = nil
        local maxTime = nil
        waitTime = self.TimeToWait
        minTime = self.MinWaitTime
        maxTime = self.MaxWaitTime

        waitTime.TimeToWait = minTime.FloatValue + math.random()*(maxTime.FloatValue - minTime.FloatValue)

        return BEHAVIOR_TREE_NODE_RESULT.TRUE
    end
})