--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                BUILDING UNLOCKER LIST                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------------- ASSETS ----------------------------------]]--

local BUILDING_UNLOCKER_LIST = {
    TypeName = "BUILDING_UNLOCKER_LIST",
    ParentType = "ASSET",
    Properties = {
        { Name = "Buildings", Type = "list<BUILDING>", Default = {} }
    }
}

EBF:registerClass(BUILDING_UNLOCKER_LIST)

--[[----------------------------- DEFAULT ASSET -------------------------------]]--

EBF:registerAsset({
    DataType = "BUILDING_UNLOCKER_LIST",
    Id = "BUILDING_UNLOCKER_LIST_DEFAULT"
})