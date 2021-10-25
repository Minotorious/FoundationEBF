--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                NUMBER DISPLAY EXAMPLE                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------- PREFABS & MATERIALS ---------------------------]]--

EBF:registerAssetId("models/FoundationEBF.fbx/Prefab/NumberDisplayPart", "PREFAB_NUMBER_DISPLAY_PART")

--[[---------------------------- CUSTOM COMPONENTS ----------------------------]]--

--[[ 
    Defining a Component to set the value on our Number Display:
    
    The Number Display's value can be set using the :setValue(value) function
    The value provided should be a positive or negative integer number.
    The individual digits of number provided will be displayed in the nodes in order.
    That means that to display the value 123.45:
        1. You need to include 5 digit nodes in the list
        2. Before using the :setValue(value) function multiply your number by 100
        3. Set the Number Display by using :setValue(12345)
    The sign will only be displayed if you have included a node for it!
    The decimal point node should have also been included separately!
]]--

local COMP_SET_NUMBER_DISPLAY_VALUE = {
	TypeName = "COMP_SET_NUMBER_DISPLAY_VALUE",
	ParentType = "COMPONENT",
	Properties = {}
}

function COMP_SET_NUMBER_DISPLAY_VALUE:create()
    self.timer = 0
end

function COMP_SET_NUMBER_DISPLAY_VALUE:update()
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
            EBF:log(tostring(value))
        end
        self.timer = 10
    else
        local dt = self:getLevel():getDeltaTime()
        self.timer = self.timer - dt
    end
end

EBF:registerClass(COMP_SET_NUMBER_DISPLAY_VALUE)

--[[--------------------- ASSET PROCESSOR & NODE HANDLING ---------------------]]--
--[[--------------------------- COMPONENT ASSIGNMENT --------------------------]]--
--[[-------------------------------- COLLIDERS --------------------------------]]--

EBF:registerPrefabComponent("PREFAB_NUMBER_DISPLAY_PART", { DataType = "COMP_SET_NUMBER_DISPLAY_VALUE", Enabled = true })

--[[------------------------ BUILDINGS & BUILDING PARTS -----------------------]]--

EBF:registerAsset({
	DataType = "BUILDING_PART",
	Id = "NUMBER_DISPLAY_PART",
    Name = "NUMBER_DISPLAY_PART_NAME",
	--Description = "NUMBER_DISPLAY_PART_DESC",
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
    AssetBuildingFunction = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE"
})

--[[------------------------- JOBS & BUILDING FUNCTIONS -----------------------]]--

--[[
    Here we override the default and set a Number Display with only 3 digits.
    Make sure you list the digit nodes in descending order!
    Important Note: It is necessary to set at minimum the prefabs here!
    Default number prefabs are provided with the EBF and are named as below.
]]--
EBF:registerAsset({
    DataType = "BUILDING_FUNCTION_NUMBER_DISPLAY",
    Id = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE",
    Name = "BUILDING_FUNCTION_NUMBER_DISPLAY_EXAMPLE_NAME",
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