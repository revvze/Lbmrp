-- Schema info
Schema.name = "BLACK MESA ROLEPLAY"
Schema.author = "Larry"
Schema.description = "Brought to you by Larry."

-- Schema includes
ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")
ix.util.IncludeDir("hooks")
ix.util.IncludeDir("meta")
ix.util.IncludeDir("voices")

-- Schema Configuration
ix.currency.plural = "dollars"
ix.currency.singular = "dollar"
ix.currency.symbol = "$"

ix.config.SetDefault("color", Color(255, 136, 0))
ix.config.SetDefault("communityText", "Discord")
ix.config.SetDefault("communityURL", "")
ix.config.SetDefault("music", "bms_music/bms/bms - gamestartup 1.mp3")
ix.config.SetDefault("allowVoice", true)
ix.config.SetDefault("scoreboardRecognition", true)
ix.config.SetDefault("vignette", false)
ix.config.SetDefault("weaponRaiseTime", 0.2)
ix.config.SetDefault("year", 2000)
ix.config.SetDefault("defaultMoney", 100)
ix.config.SetDefault("walkSpeed", 100)
ix.config.SetDefault("runSpeed", 200)
ix.config.SetDefault("allowPush", true)
ix.config.SetDefault("loocDelay", 2)
ix.config.SetDefault("oocDelay", 5)
ix.config.SetDefault("staminaCrouchRegeneration", 10)
ix.config.SetDefault("staminaDrain", 0)
ix.config.SetDefault("staminaRegeneration", 10)
ix.config.SetDefault("inventoryHeight", 6)
ix.config.SetDefault("inventoryWidth", 7)
ix.config.SetDefault("intro", false)

ix.config.Set("color", Color(255, 136, 0))
ix.config.Set("communityText", "Discord")
ix.config.Set("communityURL", "")
ix.config.Set("music", "bms_music/bms/bms - gamestartup 1.mp3")
ix.config.Set("allowVoice", true)
ix.config.Set("scoreboardRecognition", true)
ix.config.Set("vignette", false)
ix.config.Set("weaponRaiseTime", 0.2)
ix.config.Set("year", 2000)
ix.config.Set("defaultMoney", 100)
ix.config.Set("walkSpeed", 100)
ix.config.Set("runSpeed", 200)
ix.config.Set("allowPush", true)
ix.config.Set("loocDelay", 2)
ix.config.Set("oocDelay", 5)
ix.config.Set("staminaCrouchRegeneration", 10)
ix.config.Set("staminaDrain", 0)
ix.config.Set("staminaRegeneration", 10)
ix.config.Set("inventoryHeight", 6)
ix.config.Set("inventoryWidth", 7)
ix.config.Set("intro", false)

-- Faction C_Arms
player_manager.AddValidModel("Visitor", "models/sirgibs/ragdolls/bms_citizens/male_citizen_player.mdl")
player_manager.AddValidHands("Visitor", "models/weapons/c_arms_citizen.mdl", 0, "00000000")

player_manager.AddValidModel("Maintenance - Custodian", "models/humans/pbmrp/custodian_pm.mdl")
player_manager.AddValidHands("Maintenance - Custodian", "models/humans/pbmrp/c_arms/c_custodian_male_arms.mdl", 0, "00000000")

player_manager.AddValidModel("Researcher", "models/humans/pbmrp/scientist_pm.mdl")
player_manager.AddValidHands("Researcher", "models/humans/pbmrp/c_arms/c_scientist_male_arms.mdl", 0, "00000000")

player_manager.AddValidModel("Bio-Worker", "models/humans/pbmrp/scientist_cleansuit_pm.mdl")
player_manager.AddValidHands("Bio-Worker", "models/humans/pbmrp/c_arms/c_hazmat_arms.mdl", 0, "00000000")

player_manager.AddValidModel("Survey", "models/humans/pbmrp/extra/bms_hev.mdl")
player_manager.AddValidModel("Survey", "models/paynamia/bms/gordon_survivor_player.mdl")
player_manager.AddValidHands("Survey", "models/humans/pbmrp/c_arms/extra/c_arms_hev.mdl", 0, "00000000")

player_manager.AddValidModel("Security", "models/humans/pbmrp/guard_pm.mdl")
player_manager.AddValidHands("Security", "models/humans/pbmrp/c_arms/c_secguard_arms.mdl", 0, "00000000")

player_manager.AddValidModel("HECU", "models/humans/pbmrp/marine_02_pm.mdl")
player_manager.AddValidHands("HECU", "models/humans/pbmrp/c_arms/c_marine_arms.mdl", 0, "00000000")

player_manager.AddValidModel("Black Ops - Marine", "models/humans/pbmrp/black_ops_02_pm.mdl")
player_manager.AddValidHands("Black Ops - Marine", "models/humans/pbmrp/c_arms/c_blkops_arms.mdl", 0, "00000000")
player_manager.AddValidModel("Black Ops - Assassin", "models/humans/pbmrp/black_ops_fem_pm.mdl")
player_manager.AddValidHands("Black Ops - Assassin", "models/humans/pbmrp/c_arms/c_blkops_fem_arms.mdl", 0, "00000000")

player_manager.AddValidModel("Vortigaunt", "models/ultrashacklesvort/vortigaunt_injured.mdl")
player_manager.AddValidModel("Vortigaunt", "models/vortigaunt_slava.mdl")
player_manager.AddValidModel("Vortigaunt", "models/xenians/revamped/vortigaunt_slave.mdl")
player_manager.AddValidHands("Vortigaunt", "models/hands_vortigaunt_free.mdl", 0, "00000000")

player_manager.AddValidModel("", "")
player_manager.AddValidHands("", "", 0, "00000000")

ALWAYS_RAISED["swep_construction_kit"] = true

function ix.util.angleToBearing(ang)
    return math.Round(360 - (ang.y % 360))
end

function Schema:ZeroNumber(number, length)
    local amount = math.max(0, length - string.len(number))
    return string.rep("0", amount)..tostring(number)
end

-- taken from DarkRP
local ent = FindMetaTable("Entity")
function ent:IsInRoom(target)
    local tracedata = {}
    tracedata.start = self:GetPos()
    tracedata.endpos = target:GetPos()
    local trace = util.TraceLine(tracedata)

    return not trace.HitWorld
end
