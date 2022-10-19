--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                    SUN CONTROLLER                    | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- CUSTOM COMPONENT ----------------------------]]--

local COMP_SUN_CONTROLLER = {
    TypeName = "COMP_SUN_CONTROLLER",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "Sun", Type = "GAME_OBJECT", Default = nil, Flags = { "SAVE_GAME" } },
        { Name = "SunOrigOrient", Type = "quaternion", Default = { 0, 0, 0, 1 }, Flags = { "SAVE_GAME" } }
    }
}

function COMP_SUN_CONTROLLER:init()
    if self.Sun == nil then
        self.Sun = self:getLevel():find("Sun")
        self.SunOrigOrient = self.Sun:getGlobalOrientation()
    end
end

function COMP_SUN_CONTROLLER:resetSun()
    self.Sun:setGlobalOrientation(self.SunOrigOrient)
end

function COMP_SUN_CONTROLLER:getSun()
    return self.Sun
end

EBF:registerClass(COMP_SUN_CONTROLLER)