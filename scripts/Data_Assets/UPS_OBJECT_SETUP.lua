--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                   UPS OBJECT SETUP                   | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[--------------------------------- ASSETS ----------------------------------]]--

local UPS_OBJECT_SETUP = {
    TypeName = "UPS_OBJECT_SETUP",
    ParentType = "ASSET",
    Properties = {
        { Name = "ObjectId", Type = "string", Default = "" },
        { Name = "ObjectPrefab", Type = "PREFAB", Default = nil },
        { Name = "ObjectArea", Type = "vec2f", Default = { 1, 1 } },
        { Name = "EdgeCheckResoluton", Type = "vec2i", Default = { 0, 0 } },
        { Name = "AreaCheckMode", Type = "string", Default = "Hourglass" }, -- Cross, Combined
        { Name = "AreaCheckResolution", Type = "integer", Default = 0 },
        { Name = "OnTerrain", Type = "boolean", Default = true },
        { Name = "OnWater", Type = "boolean", Default = false },
        { Name = "MinAllowedSlope", Type = "float", Default = 60.0 }, -- 0 to 90
        { Name = "AllowedAngles", Type = "vec2f", Default = { -180, 180 } },
        { Name = "ExclusionRadius", Type = "float", Default = 50.0 }
    }
}

EBF:registerClass(UPS_OBJECT_SETUP)