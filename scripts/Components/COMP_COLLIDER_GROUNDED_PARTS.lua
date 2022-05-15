--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                COLLIDER GROUNDED PARTS               | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\--------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------------- CUSTOM COMPONENT ----------------------------]]--

local COMP_COLLIDER_GROUNDED_PARTS = {
	TypeName = "COMP_COLLIDER_GROUNDED_PARTS",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "PartNodeName", Type = "string", Default = "Ground" }
    }
}

function COMP_COLLIDER_GROUNDED_PARTS:groundPart(part)
    local position = part:getGlobalPosition()
    local raycastResultCollider = {}
    local fromPosition = { position[1], position[2]+100, position[3] }
    local toPosition = { position[1], position[2]-100, position[3] }
    local flagCollider = bit.bor(bit.lshift(1, OBJECT_FLAG.PLATFORM:toNumber()))

    local hasResult = self:getLevel():rayCast(fromPosition, toPosition, raycastResultCollider, flagCollider)
    if hasResult == true then
        part:setGlobalPosition(raycastResultCollider.Position)
    end
end

function COMP_COLLIDER_GROUNDED_PARTS:onEnabled()
    local building = self:getOwner():findFirstObjectWithComponentUp("COMP_BUILDING")
    --[[
    local parts = building:getBuildingPartList()
    for i=1,#parts do
        if contains(parts[i]:getOwner().Name, self.PartNodeName) then
            self:groundPart(parts[i]:getOwner())
        end
    end

    event.register(self, building.ON_PREVIEW_PART_PLACED,
        function(compBuildingPart, isOnCursor)
            if isOnCursor == true then
                local partObj = compBuildingPart:getOwner()
                if partObj ~= nil and contains(partObj.Name, self.PartNodeName) then
                    self:groundPart(partObj)
                end
            end
        end
    )
    ]]--
    event.register(self, building.ON_BUILDING_CHANGED,
    function()
        local parts = building:getBuildingPartList()
        for i=1,#parts do
            if contains(parts[i]:getOwner().Name, self.PartNodeName) then
                self:groundPart(parts[i]:getOwner())
            end
        end
    end
)
end

EBF:registerClass(COMP_COLLIDER_GROUNDED_PARTS)