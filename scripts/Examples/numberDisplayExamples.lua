--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |               NUMBER DISPLAY EXAMPLES                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/NumberDisplayPart", "PREFAB_NUMBER_DISPLAY_PART")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/NumberDisplayExample1", "PREFAB_NUMBER_DISPLAY_EXAMPLE_1")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/NumberDisplayExample2", "PREFAB_NUMBER_DISPLAY_EXAMPLE_2")
EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/NumberDisplayExample3", "PREFAB_NUMBER_DISPLAY_EXAMPLE_3")

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

--[[ 
    Defining a Component to set the value on our Number Display:
    
    The Number Display's value can be set using the :setValue(value) function
    The value provided should be a positive or negative integer number.
    The individual digits of number provided will be displayed in the nodes in order.
    That means that to for example display the value 123.45:
        1. You need to include 5 digit nodes in the list
        2. Before using the :setValue(value) function convert your number to an integer by multiplying it by 100
        3. Set the Number Display by using :setValue(12345)
    The +/- sign will only be displayed if you have included a node for it!
    The decimal point node should have also been included separately!
]]--

local COMP_SET_NUMBER_DISPLAY_EXAMPLE_1_VALUE = {
    TypeName = "COMP_SET_NUMBER_DISPLAY_EXAMPLE_1_VALUE",
    ParentType = "COMPONENT",
    Properties = {}
}

function COMP_SET_NUMBER_DISPLAY_EXAMPLE_1_VALUE:create()
    self.timer = 0
end

function COMP_SET_NUMBER_DISPLAY_EXAMPLE_1_VALUE:update()
    if self.timer < 0 then
        local compDisplay = self:getOwner():getEnabledComponent("COMP_NUMBER_DISPLAY")
        if compDisplay ~= nil then
            local value = 0
            if math.random() > 0.5 then
                value = math.random(0,999)
            else
                value = -1*math.random(0,999)
            end
            compDisplay:setValue(value)
            --EBF:log(tostring(value))
        end
        self.timer = 10
    else
        local dt = self:getLevel():getDeltaTime()
        self.timer = self.timer - dt
    end
end

EBF:registerClass(COMP_SET_NUMBER_DISPLAY_EXAMPLE_1_VALUE)

local COMP_SET_NUMBER_DISPLAY_EXAMPLE_2_VALUE = {
    TypeName = "COMP_SET_NUMBER_DISPLAY_EXAMPLE_2_VALUE",
    ParentType = "COMPONENT",
    Properties = {}
}

function COMP_SET_NUMBER_DISPLAY_EXAMPLE_2_VALUE:create()
    self.timer = 0
end

function COMP_SET_NUMBER_DISPLAY_EXAMPLE_2_VALUE:update()
    if self.timer < 0 then
        local compDisplay = self:getOwner():getEnabledComponent("COMP_NUMBER_DISPLAY")
        if compDisplay ~= nil then
            local value = math.random(0,9)
            compDisplay:setValue(value)
            --EBF:log(tostring(value))
        end
        self.timer = 10
    else
        local dt = self:getLevel():getDeltaTime()
        self.timer = self.timer - dt
    end
end

EBF:registerClass(COMP_SET_NUMBER_DISPLAY_EXAMPLE_2_VALUE)

local COMP_SET_NUMBER_DISPLAY_EXAMPLE_3_VALUE = {
    TypeName = "COMP_SET_NUMBER_DISPLAY_EXAMPLE_3_VALUE",
    ParentType = "COMPONENT",
    Properties = {}
}

function COMP_SET_NUMBER_DISPLAY_EXAMPLE_3_VALUE:create()
    self.timer = 0
end

function COMP_SET_NUMBER_DISPLAY_EXAMPLE_3_VALUE:update()
    if self.timer < 0 then
        local compDisplay = self:getOwner():getEnabledComponent("COMP_NUMBER_DISPLAY")
        if compDisplay ~= nil then
            local value = math.random(0,99)
            compDisplay:setValue(value)
        end
        self.timer = 10
    else
        local dt = self:getLevel():getDeltaTime()
        self.timer = self.timer - dt
    end
end

EBF:registerClass(COMP_SET_NUMBER_DISPLAY_EXAMPLE_3_VALUE)

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:registerPrefabComponent("PREFAB_NUMBER_DISPLAY_EXAMPLE_1", { DataType = "COMP_SET_NUMBER_DISPLAY_EXAMPLE_1_VALUE", Enabled = true })
EBF:registerPrefabComponent("PREFAB_NUMBER_DISPLAY_EXAMPLE_2", { DataType = "COMP_SET_NUMBER_DISPLAY_EXAMPLE_2_VALUE", Enabled = true })
EBF:registerPrefabComponent("PREFAB_NUMBER_DISPLAY_EXAMPLE_3", { DataType = "COMP_SET_NUMBER_DISPLAY_EXAMPLE_3_VALUE", Enabled = true })

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "NUMBER_DISPLAY_EXAMPLE_1_PART",
    Name = "NUMBER_DISPLAY_EXAMPLE_1_PART_NAME",
    Description = "NUMBER_DISPLAY_EXAMPLE_1_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_NUMBER_DISPLAY_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.5, 0.5 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_1"
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "NUMBER_DISPLAY_EXAMPLE_2_PART",
    Name = "NUMBER_DISPLAY_EXAMPLE_2_PART_NAME",
    Description = "NUMBER_DISPLAY_EXAMPLE_2_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_NUMBER_DISPLAY_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.5, 0.5 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_2"
})

EBF:registerAsset({
    DataType = "BUILDING_PART",
    Id = "NUMBER_DISPLAY_EXAMPLE_3_PART",
    Name = "NUMBER_DISPLAY_EXAMPLE_3_PART_NAME",
    Description = "NUMBER_DISPLAY_EXAMPLE_3_PART_DESC",
    Category = "CORE",
    ConstructorData = {
        DataType = "BUILDING_CONSTRUCTOR_DEFAULT",
        CoreObjectPrefab = "PREFAB_NUMBER_DISPLAY_PART"
    },
    BuildingZone = {
        ZoneEntryList = {
            {
                Polygon = polygon.createRectangle( { 0.5, 0.5 }, { 0, 0 } ),
                Type = { DEFAULT = true, NAVIGABLE = false }
            }
        }
    },
    AssetBuildingFunction = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_3"
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

--[[
    Here we override the default and set a Number Display with only 3 digits.
    Make sure you list the digit nodes in descending order!
    Important Note: It is necessary to set at minimum the number prefabs here!
    Default number prefabs are provided with the EBF and are named as below.
]]--
EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_NUMBER_DISPLAY",
    Id = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_1",
    Name = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_1_NAME",
    Description = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_1_DESC",
    NumberDisplayPrefab = "PREFAB_NUMBER_DISPLAY_EXAMPLE_1",
    DigitNodeNames = { "Node.Ten", "Node.One", "Node.Decimal" },
    ZeroPrefab = "PREFAB_ZERO_DEFAULT",
    OnePrefab = "PREFAB_ONE_DEFAULT",
    TwoPrefab = "PREFAB_TWO_DEFAULT",
    ThreePrefab = "PREFAB_THREE_DEFAULT",
    FourPrefab = "PREFAB_FOUR_DEFAULT",
    FivePrefab = "PREFAB_FIVE_DEFAULT",
    SixPrefab = "PREFAB_SIX_DEFAULT",
    SevenPrefab = "PREFAB_SEVEN_DEFAULT",
    EightPrefab = "PREFAB_EIGHT_DEFAULT",
    NinePrefab = "PREFAB_NINE_DEFAULT",
    PlusPrefab = "PREFAB_PLUS_DEFAULT",
    MinusPrefab = "PREFAB_MINUS_DEFAULT",
    DecimalPrefab = "PREFAB_DECIMAL_DEFAULT",
    UnitPrefab = "PREFAB_UNIT_DEFAULT"
})

--[[
    Here we override the default and set a Number Display with only 1 digit.
    Make sure you list the digit nodes in descending order!
    Important Note: It is necessary to set at minimum the number prefabs here!
    Default number prefabs are provided with the EBF and are named as below.
]]--
EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_NUMBER_DISPLAY",
    Id = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_2",
    Name = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_2_NAME",
    Description = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_2_DESC",
    NumberDisplayPrefab = "PREFAB_NUMBER_DISPLAY_EXAMPLE_2",
    DigitNodeNames = { "Node.One.001" },
    ZeroPrefab = "PREFAB_ZERO_DEFAULT",
    OnePrefab = "PREFAB_ONE_DEFAULT",
    TwoPrefab = "PREFAB_TWO_DEFAULT",
    ThreePrefab = "PREFAB_THREE_DEFAULT",
    FourPrefab = "PREFAB_FOUR_DEFAULT",
    FivePrefab = "PREFAB_FIVE_DEFAULT",
    SixPrefab = "PREFAB_SIX_DEFAULT",
    SevenPrefab = "PREFAB_SEVEN_DEFAULT",
    EightPrefab = "PREFAB_EIGHT_DEFAULT",
    NinePrefab = "PREFAB_NINE_DEFAULT",
    PlusPrefab = "PREFAB_PLUS_DEFAULT",
    MinusPrefab = "PREFAB_MINUS_DEFAULT",
    DecimalPrefab = "PREFAB_DECIMAL_DEFAULT",
    UnitPrefab = "PREFAB_UNIT_DEFAULT"
})

--[[
    Here we override the default and set a Number Display with only 2 digits.
    Make sure you list the digit nodes in descending order!
    Important Note: It is necessary to set at minimum the number prefabs here!
    Default number prefabs are provided with the EBF and are named as below.
]]--
EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_NUMBER_DISPLAY",
    Id = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_3",
    Name = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_3_NAME",
    Description = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_3_DESC",
    NumberDisplayPrefab = "PREFAB_NUMBER_DISPLAY_EXAMPLE_3",
    DigitNodeNames = { "Node.One.002", "Node.Decimal.002" },
    DecimalNodeName = "Node.DecimalPoint.002",
    UnitNodeName = "Node.Unit.002",
    ZeroPrefab = "PREFAB_ZERO_DEFAULT",
    OnePrefab = "PREFAB_ONE_DEFAULT",
    TwoPrefab = "PREFAB_TWO_DEFAULT",
    ThreePrefab = "PREFAB_THREE_DEFAULT",
    FourPrefab = "PREFAB_FOUR_DEFAULT",
    FivePrefab = "PREFAB_FIVE_DEFAULT",
    SixPrefab = "PREFAB_SIX_DEFAULT",
    SevenPrefab = "PREFAB_SEVEN_DEFAULT",
    EightPrefab = "PREFAB_EIGHT_DEFAULT",
    NinePrefab = "PREFAB_NINE_DEFAULT",
    PlusPrefab = "PREFAB_PLUS_DEFAULT",
    MinusPrefab = "PREFAB_MINUS_DEFAULT",
    DecimalPrefab = "PREFAB_DECIMAL_DEFAULT",
    UnitPrefab = "PREFAB_UNIT_DEFAULT"
})