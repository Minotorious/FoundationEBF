--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                    ENFORCE RADIUS                    | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- CUSTOM COMPONENT ----------------------------]]--

local COMP_ENFORCE_RADIUS = {
    TypeName = "COMP_ENFORCE_RADIUS",
    ParentType = "COMPONENT",
    Properties = {
        { Name = "Radius", Type = "float", Default = 1 },
        { Name = "Enforcer", Type = "GAME_OBJECT", Default = nil, Flags = { "SAVE_GAME" } }
    }
}

function COMP_ENFORCE_RADIUS:setEnforcer(gameObject)
    self.Enforcer = gameObject
end

function COMP_ENFORCE_RADIUS:getPosition()
    if self.Enforcer ~= nil then
        local r = self.Radius * math.sqrt(math.random())
        local theta =  math.random() * 2 * math.pi

        local enforcerPos = self.Enforcer:getGlobalPosition()

        local pos = { enforcerPos.x + r * math.cos(theta), enforcerPos.y, enforcerPos.z + r * math.sin(theta) }

        return pos
    else
        return nil
    end
end

EBF:registerClass(COMP_ENFORCE_RADIUS)