--[[---------------------------------------------------------------------------\
| ||\\    //||       /|¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯\ |
| || \\  // ||  (o_ / |                  SUPPLEMENTARY FILE                  | |
| ||  \\//  ||  //\/  |                         ----                         | |
| ||   \/   ||  V_/_  |                      PARTICLES                       | |
| ||        ||        |‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗‗/ |
\---------------------------------------------------------------------------]]--

local EBF = ...

--[[------------------------------- PREFIX LIST -------------------------------]]--

local particlesList = {
    { "dotBlue", "DOT_BLUE" }, { "dotCyan", "DOT_CYAN" }, { "dotGold", "DOT_GOLD" },
    { "dotGreen", "DOT_GREEN" }, { "dotGrey", "DOT_GREY" }, { "dotOrange", "DOT_ORANGE" },
    { "dotPurple", "DOT_PURPLE" }, { "dotRed", "DOT_RED" }, { "dotYellow", "DOT_YELLOW" },

    { "rayBlue", "RAY_BLUE" }, { "rayPurple", "RAY_PURPLE" }, { "rayRed", "RAY_RED" }, { "rayYellow", "RAY_YELLOW" },

    { "star4Blue", "STAR4_BLUE" }, { "star4Purple", "STAR4_PURPLE" }, { "star4Red", "STAR4_RED" }, { "star4Yellow", "STAR4_YELLOW" },

    { "smokeRed", "SMOKE_RED" }, { "smokeWhite", "SMOKE_WHITE" },

    { "smoke2Grey", "SMOKE2_GREY" },

    { "snowflakeBlue", "SNOWFLAKE_BLUE" }, { "snowflakeWhite", "SNOWFLAKE_WHITE" }
 }

--[[--------------------------- TEXTURES & MATERIALS --------------------------]]--

local function registerParticles(particle)
    EBF:registerAssetId("textures/particles/" .. particle[1] .. ".png", "PARTICLE_" .. particle[2] .. "_TEXTURE")
    EBF:registerAsset({
        DataType = "MATERIAL",
        Id = "MATERIAL_PARTICLE_" .. particle[2],
        AlbedoTexture = "PARTICLE_" .. particle[2] .. "_TEXTURE",
        HasShadow = false
    })
end

for i, particle in ipairs(particlesList) do
    registerParticles(particle)
end