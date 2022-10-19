--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                    NUMBER DISPLAY                    | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[----------------------- DEFAULT PREFABS & MATERIALS -----------------------]]--

local function registerDefaulDigit(digit)
    EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/Default" .. digit, "PREFAB_" .. string.upper(digit) .. "_DEFAULT")
    EBF:registerAssetId("textures/numberDisplay/Default" .. digit .. ".png", "DEFAULT_" .. string.upper(digit) .. "_TEXTURE")

    EBF:registerAssetId("models/FoundationEBF.fbx/Materials/Material." .. digit, "MATERIAL_" .. string.upper(digit))
    EBF:overrideAsset({
        Id = "MATERIAL_" .. string.upper(digit),
        AlbedoTexture = "DEFAULT_" .. string.upper(digit) .. "_TEXTURE",
        HasAlphaTest = true,
        HasShadow = false,
        BackFaceVisible = true,
        RenderMode = "UNLIT"
    })
end

local digitList = { "Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Plus", "Minus", "Decimal", "Unit" }

for i, digit in ipairs(digitList) do
    registerDefaulDigit(digit)
end

--[[---------------------------- BUILDING FUNCTION ----------------------------]]--

local BUILDING_FUNCTION_NUMBER_DISPLAY = {
    TypeName = "BUILDING_FUNCTION_NUMBER_DISPLAY",
    ParentType = "BUILDING_FUNCTION",
    Properties = {
        { Name = "NumberDisplayPrefab", Type = "PREFAB", Default = nil },
        { Name = "NumberDisplayNodeName", Type = "string", Default = "Node.NumberDisplay" },
        { Name = "DigitNodeNames", Type = "list<string>", Default = { "Node.Thousand", "Node.Hundred", "Node.Ten", "Node.One", "Node.Decimal" } },
        { Name = "DecimalNodeName", Type = "string", Default = "Node.DecimalPoint" },
        { Name = "SignNodeName", Type = "string", Default = "Node.Sign" },
        { Name = "UnitNodeName", Type = "string", Default = "Node.Unit" },
        { Name = "ZeroPrefab", Type = "PREFAB", Default = nil },
        { Name = "OnePrefab", Type = "PREFAB", Default = nil },
        { Name = "TwoPrefab", Type = "PREFAB", Default = nil },
        { Name = "ThreePrefab", Type = "PREFAB", Default = nil },
        { Name = "FourPrefab", Type = "PREFAB", Default = nil },
        { Name = "FivePrefab", Type = "PREFAB", Default = nil },
        { Name = "SixPrefab", Type = "PREFAB", Default = nil },
        { Name = "SevenPrefab", Type = "PREFAB", Default = nil },
        { Name = "EightPrefab", Type = "PREFAB", Default = nil },
        { Name = "NinePrefab", Type = "PREFAB", Default = nil },
        { Name = "PlusPrefab", Type = "PREFAB", Default = nil },
        { Name = "MinusPrefab", Type = "PREFAB", Default = nil },
        { Name = "DecimalPrefab", Type = "PREFAB", Default = nil },
        { Name = "UnitPrefab", Type = "PREFAB", Default = nil }
    }
}

function BUILDING_FUNCTION_NUMBER_DISPLAY:activateBuilding(gameObject)
    --EBF:log("Building Function Activate Building")
    gameObject:forEachChild(
        function(child)
            if child.Name == self.NumberDisplayNodeName then
                local compCheck = child:findFirstObjectWithComponentDown("COMP_NUMBER_DISPLAY")
                if compCheck == nil then
                    local displayObject = child:getLevel():createObject(self.NumberDisplayPrefab, child:getGlobalPosition(), child:getGlobalOrientation())
                    displayObject:setParent(child, true)
                    local comp = displayObject:getOrCreateComponent("COMP_NUMBER_DISPLAY")
                    comp:setNumberDisplayData(self)
                else
                    compCheck:setNumberDisplayData(self)
                end
            end
        end
    )
    
    return true
end

function BUILDING_FUNCTION_NUMBER_DISPLAY:reloadBuildingFunction(gameObject)
    --EBF:log("Building Function Reload")
    self:activateBuilding(gameObject)
end

EBF:registerClass(BUILDING_FUNCTION_NUMBER_DISPLAY)

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

local COMP_NUMBER_DISPLAY = {
	TypeName = "COMP_NUMBER_DISPLAY",
	ParentType = "COMPONENT",
	Properties = {
        { Name = "DigitNodeNames", Type = "list<string>", Default = { "Node.Thousand", "Node.Hundred", "Node.Ten", "Node.One", "Node.Decimal" } },
        { Name = "DecimalNodeName", Type = "string", Default = "Node.DecimalPoint" },
        { Name = "SignNodeName", Type = "string", Default = "Node.Sign" },
        { Name = "UnitNodeName", Type = "string", Default = "Node.Unit" },
        { Name = "ZeroPrefab", Type = "PREFAB", Default = nil },
        { Name = "OnePrefab", Type = "PREFAB", Default = nil },
        { Name = "TwoPrefab", Type = "PREFAB", Default = nil },
        { Name = "ThreePrefab", Type = "PREFAB", Default = nil },
        { Name = "FourPrefab", Type = "PREFAB", Default = nil },
        { Name = "FivePrefab", Type = "PREFAB", Default = nil },
        { Name = "SixPrefab", Type = "PREFAB", Default = nil },
        { Name = "SevenPrefab", Type = "PREFAB", Default = nil },
        { Name = "EightPrefab", Type = "PREFAB", Default = nil },
        { Name = "NinePrefab", Type = "PREFAB", Default = nil },
        { Name = "PlusPrefab", Type = "PREFAB", Default = nil },
        { Name = "MinusPrefab", Type = "PREFAB", Default = nil },
        { Name = "DecimalPrefab", Type = "PREFAB", Default = nil },
        { Name = "UnitPrefab", Type = "PREFAB", Default = nil },
        { Name = "IsInitialised", Type = "boolean", Default = false, Flags = { "SAVE_GAME" } },
        { Name = "CurrentValue", Type = "string", Default = "0", Flags = { "SAVE_GAME" } },
        { Name = "CurrentSign", Type = "string", Default = "+", Flags = { "SAVE_GAME" } }
    }
}

function COMP_NUMBER_DISPLAY:create()
    self.valueChanged = false
    
    self.digitList = {}
    self.signNode = nil
    --self.decimalNode = nil
    --self.unitNode = nil
    
    self.zeroPrefabName = ""
    self.onePrefabName = ""
    self.twoPrefabName = ""
    self.threePrefabName = ""
    self.fourPrefabName = ""
    self.fivePrefabName = ""
    self.sixPrefabName = ""
    self.sevenPrefabName = ""
    self.eightPrefabName = ""
    self.ninePrefabName = ""
    self.plusPrefabName = ""
    self.minusPrefabName = ""
end

function COMP_NUMBER_DISPLAY:setNumberDisplayData(buildingFunctionData)
    for i, nodeName in ipairs(self.DigitNodeNames) do
        self.DigitNodeNames[i]=nil
    end

    for i, nodeName in ipairs(buildingFunctionData.DigitNodeNames) do
        table.insert(self.DigitNodeNames, nodeName)
    end

    self.DecimalNodeName = buildingFunctionData.DecimalNodeName
    self.SignNodeName = buildingFunctionData.SignNodeName
    self.UnitNodeName = buildingFunctionData.UnitNodeName
    self.ZeroPrefab = buildingFunctionData.ZeroPrefab
    self.OnePrefab = buildingFunctionData.OnePrefab
    self.TwoPrefab = buildingFunctionData.TwoPrefab
    self.ThreePrefab = buildingFunctionData.ThreePrefab
    self.FourPrefab = buildingFunctionData.FourPrefab
    self.FivePrefab = buildingFunctionData.FivePrefab
    self.SixPrefab = buildingFunctionData.SixPrefab
    self.SevenPrefab = buildingFunctionData.SevenPrefab
    self.EightPrefab = buildingFunctionData.EightPrefab
    self.NinePrefab = buildingFunctionData.NinePrefab
    self.PlusPrefab = buildingFunctionData.PlusPrefab
    self.MinusPrefab = buildingFunctionData.MinusPrefab
    self.DecimalPrefab = buildingFunctionData.DecimalPrefab
    self.UnitPrefab = buildingFunctionData.UnitPrefab

    self:initDisplay()
end

function COMP_NUMBER_DISPLAY:createDisplayGameObject(prefab, parent, scale)
    local gameObject = self:getLevel():createObject(prefab, parent:getGlobalPosition(), parent:getGlobalOrientation())
    
    if parent ~= nil then
        gameObject:setParent(parent, true)
    end
    
    if scale then
        gameObject:setScale(0)
    end
    
    return gameObject.Name
end

function COMP_NUMBER_DISPLAY:setDisplayPrefabName(prefab)
    local gameObject = self:getLevel():createObject(prefab, { 0, 0, 0 })
    local name = gameObject.Name
    gameObject:destroy()
    
    return name
end

function COMP_NUMBER_DISPLAY:initDisplay()
    self:getOwner():forEachChild(
        function(child)
            for i, digitNode in ipairs(self.DigitNodeNames) do
                if child.Name == digitNode then
                    self.digitList[i] = child
                    if not self.IsInitialised then
                        self.zeroPrefabName = self:createDisplayGameObject(self.ZeroPrefab, child, false)
                        self.onePrefabName = self:createDisplayGameObject(self.OnePrefab, child, true)
                        self.twoPrefabName = self:createDisplayGameObject(self.TwoPrefab, child, true)
                        self.threePrefabName = self:createDisplayGameObject(self.ThreePrefab, child, true)
                        self.fourPrefabName = self:createDisplayGameObject(self.FourPrefab, child, true)
                        self.fivePrefabName = self:createDisplayGameObject(self.FivePrefab, child, true)
                        self.sixPrefabName = self:createDisplayGameObject(self.SixPrefab, child, true)
                        self.sevenPrefabName = self:createDisplayGameObject(self.SevenPrefab, child, true)
                        self.eightPrefabName = self:createDisplayGameObject(self.EightPrefab, child, true)
                        self.ninePrefabName = self:createDisplayGameObject(self.NinePrefab, child, true)
                    else
                        self.zeroPrefabName = self:setDisplayPrefabName(self.ZeroPrefab)
                        self.onePrefabName = self:setDisplayPrefabName(self.OnePrefab)
                        self.twoPrefabName = self:setDisplayPrefabName(self.TwoPrefab)
                        self.threePrefabName = self:setDisplayPrefabName(self.ThreePrefab)
                        self.fourPrefabName = self:setDisplayPrefabName(self.FourPrefab)
                        self.fivePrefabName = self:setDisplayPrefabName(self.FivePrefab)
                        self.sixPrefabName = self:setDisplayPrefabName(self.SixPrefab)
                        self.sevenPrefabName = self:setDisplayPrefabName(self.SevenPrefab)
                        self.eightPrefabName = self:setDisplayPrefabName(self.EightPrefab)
                        self.ninePrefabName = self:setDisplayPrefabName(self.NinePrefab)
                    end
                end
            end
            
            if child.Name == self.DecimalNodeName then
                --self.decimalNode = child
                if not self.IsInitialised then
                    self:createDisplayGameObject(self.DecimalPrefab, child, false)
                end
            elseif child.Name == self.SignNodeName then
                self.signNode = child
                if not self.IsInitialised then
                    self.plusPrefabName = self:createDisplayGameObject(self.PlusPrefab, child, false)
                    self.minusPrefabName = self:createDisplayGameObject(self.MinusPrefab, child, true)
                else
                    self.plusPrefabName  = self:setDisplayPrefabName(self.PlusPrefab)
                    self.minusPrefabName = self:setDisplayPrefabName(self.MinusPrefab)
                end
            elseif child.Name == self.UnitNodeName then
                --self.unitNode = child
                if not self.IsInitialised then
                    self:createDisplayGameObject(self.UnitPrefab, child, false)
                end
            end
        end
    )
    
    if not self.IsInitialised then
        self.IsInitialised = true
        self:setValue(0)
    else
        self:setValue(tonumber(self.CurrentSign .. self.CurrentValue))
    end
end

function COMP_NUMBER_DISPLAY:setValue(value)
    if self.IsInitialised then
        local numberstr = ""
        if value < 0 then
            local unsignedValue = -1*value
            numberstr = string.format("%0" .. tostring(#self.DigitNodeNames) .. "d", unsignedValue)
        else
            numberstr = string.format("%0" .. tostring(#self.DigitNodeNames) .. "d", value)
        end
        
        if string.len(numberstr) <= #self.DigitNodeNames and numberstr ~= self.CurrentValue then
            if value < 0 then
                self.CurrentSign = "-"
            else
                self.CurrentSign = "+"
            end
            self.CurrentValue = numberstr
            self.valueChanged = true
        end
    end
end

function COMP_NUMBER_DISPLAY:update()
    self:getOwner():globalLookAt(self:getLevel():find("Camera"):getGlobalPosition(), false)
    if self.valueChanged then
        if self.signNode ~= nil then
            if self.CurrentSign == "+" then
                self.signNode:forEachChild(
                    function(child)
                        if child.Name == self.plusPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif self.CurrentSign == "-" then
                self.signNode:forEachChild(
                    function(child)
                        if child.Name == self.minusPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            end
        end
        
        for i, digit in ipairs(self.digitList) do
            if string.sub(self.CurrentValue, i, i) == "0" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.zeroPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "1" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.onePrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "2" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.twoPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "3" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.threePrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "4" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.fourPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "5" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.fivePrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "6" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.sixPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "7" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.sevenPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "8" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.eightPrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            elseif string.sub(self.CurrentValue, i, i) == "9" then
                digit:forEachChild(
                    function(child)
                        if child.Name == self.ninePrefabName then
                            child:setScale(1)
                        else
                            child:setScale(0)
                        end
                    end
                )
            end
        end
        self.valueChanged = false
    end
end

EBF:registerClass(COMP_NUMBER_DISPLAY)