--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                 UPS OBJECT SETUP LIST                | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------------- ASSETS ----------------------------------]]--

local UPS_OBJECT_SETUP_LIST = {
    TypeName = "UPS_OBJECT_SETUP_LIST",
    ParentType = "ASSET",
    Properties = {
        { Name = "ObjectSetupList", Type = "list<UPS_OBJECT_SETUP>", Default = {} }
    }
}

EBF:registerClass(UPS_OBJECT_SETUP_LIST)

--[[----------------------------- DEFAULT ASSET -------------------------------]]--

EBF:registerAsset({
    DataType = "UPS_OBJECT_SETUP_LIST",
    Id = "UPS_OBJECT_SETUP_LIST_DEFAULT"
})