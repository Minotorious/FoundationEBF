--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                  ENFORCE RECTANGLE                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- CUSTOM COMPONENT ----------------------------]]--

local COMP_ENFORCE_RECTANGLE = {
    TypeName = "COMP_ENFORCE_RECTANGLE",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "Rectangle", Type = "vec2f", Default = { 1, 1 } },
        { Name = "Enforcer", Type = "GAME_OBJECT", Default = nil, Flags = { "SAVE_GAME" } }
    }
}

function COMP_ENFORCE_RECTANGLE:setEnforcer(gameObject)
    self.Enforcer = gameObject
end

function COMP_ENFORCE_RECTANGLE:getPosition()
    if self.Enforcer ~= nil then
        local x = ( math.random() * self.Rectangle.x ) - self.Rectangle.x/2
        local y = ( math.random() * self.Rectangle.y ) - self.Rectangle.y/2

        local enforcerPos = self.Enforcer:getGlobalPosition()
        local enforcerOrient = self.Enforcer:getGlobalOrientation()

        local theta = quaternion.getEulerAngles(enforcerOrient)

        local rotatedX = x*math.sin(theta.y) + y*math.cos(theta.y);
        local rotatedY = x*math.cos(theta.y) - y*math.sin(theta.y);

        return { enforcerPos.x + rotatedX, enforcerPos.y, enforcerPos.z + rotatedY }
    else
        return nil
    end
end

EBF:registerClass(COMP_ENFORCE_RECTANGLE)